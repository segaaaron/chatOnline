//
//  ManageFirebaseApi.swift
//  chatOnline
//
//  Created by Miguel Angel Saravia Belmonte on 9/15/20.
//  Copyright © 2020 chatOnline. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
class ManageFirebaseApi {
    
    fileprivate let auth = Auth.auth()
    fileprivate let ref = Database.database().reference()
    private let storage = Storage.storage().reference()
    public typealias UploadPictureCompletion = (Result<String, Error>) -> Void
    let currentProfile = Profile()
    
    fileprivate func manageError(_ error: NSError?, failure: FailureResponseType) {
        print(error!)
        if let e = error {
            switch e.code {
            case NSURLErrorTimedOut:
                failure(NSError(domain: "", code: -1001, userInfo: ["msg": "Time exceeded error"]))
            case NSURLErrorNetworkConnectionLost:
                failure(NSError(domain: "", code: -1005, userInfo: ["msg": "You do not have an Internet connection"]))
            case NSURLErrorNotConnectedToInternet:
                failure(NSError(domain: "", code: -1009, userInfo: ["msg": "You do not have an Internet connection"]))
            case 17009:
                failure(NSError(domain: "", code: 17009, userInfo: ["msg": "Wrong Password"]))
            case 17011:
                failure(NSError(domain: "", code: 17011, userInfo: ["msg": ERROR_LOGIN]))
            default:
                failure(NSError(domain: "", code: 500, userInfo: ["msg": "Unexpected error"]))
            }
        } else {
            failure(NSError(domain: "", code: 500, userInfo: ["msg": "Unexpected error"]))
        }
    }
    
    func saveUserFirebase(email: String, password: String, name: String, lastName: String, contactNumber: String, success: SuccessResponseUser?, failure: FailureResponseType?) {
        auth.createUser(withEmail: email, password: password) { (result, error) in
            let userObject = User()
            if let user = result?.user {
                userObject.email = user.email
                userObject.name = name
                userObject.userId = user.uid
                userObject.contactNumber = contactNumber
                let body = ["email": email, "userId": user.uid, "name": name, "lastName": lastName, "contactNumber": contactNumber]
                UserDefaults.standard.set(["userId": user.uid], forKey: "userUID")
                UserDefaults.standard.set(email, forKey: "email")
                UserDefaults.standard.set(name, forKey: "name")
                UserDefaults.standard.set(lastName, forKey: "lastName")
                UserDefaults.standard.set(contactNumber, forKey: "number")
                self.create(keyName: user.uid, param: body, collectionName: "loginUsers")
                let chatUser = ChatAppUser(firstName: name,
                                           lastName: lastName,
                                           emailAddress: email)
                DatabaseManager.shared.insertUser(with: chatUser) { (result) in
                    print(result)
                }
                success?(userObject)
            } else {
                self.manageError(error as NSError?, failure: failure!)
            }
        }
    }
    
    func forgotPassword(email: String, failure: FailureResponseType?) {
        auth.sendPasswordReset(withEmail: email) { (error) in
            if (error == nil) {
                failure!(nil)
            } else {
                self.manageError(error as NSError?, failure: failure!)
            }
        }
    }
    
    func loginChat(email: String, password: String, success: SuccessResponseUser?, failure: FailureResponseType?) {
        auth.signIn(withEmail: email, password: password) { (result, error) in
            print(result as Any)
            if ((result?.user.uid) != nil) {
                let user = User()
                user.email = email
                user.userId = result?.user.uid ?? ""
                let defaultObj = UserDefaults.standard
                defaultObj.set(["userId": result?.user.uid ?? ""], forKey: "userUID")
                success?(user)
            } else {
                self.manageError(error as NSError?, failure: failure!)
            }
        }
    }
    
    func getProfile(userId: String, success: SuccessResponseProfile?, failure: FailureResponseType?) {
        ref.child("loginUsers").child(userId).observe(.value) { (snapshot) in
            guard let value = snapshot.value as? NSDictionary else {return }
            self.currentProfile.email = value["email"] as? String ?? ""
            self.currentProfile.contactNumber = value["contactNumber"] as? String ?? ""
            self.currentProfile.lastName = value["lastName"] as? String ?? ""
            self.currentProfile.name = value["name"] as? String ?? ""
            self.currentProfile.userId = value["userId"] as? String ?? ""
            success?(self.currentProfile)
        }
    }
    
    func updateProfile(userId: String, name: String, lastName: String, contacNumber: String, success: SuccessResponseProfile?, failure: FailureResponseType?) {
        let body = ["name": name, "lastName": lastName, "contactNumber": contacNumber]
        let currentProfile = Profile()
        ref.child("loginUsers").child(userId).updateChildValues(body) { (error, data) in
            if(error != nil) {
                self.manageError(error as NSError?, failure: failure!)
            } else {
                currentProfile.userId = data.key
                success?(currentProfile)
            }
        }
    }
    
    /// Upload image that will be sent in a conversation message
    public func uploadMessagePhoto(with data: Data, fileName: String, completion: @escaping UploadPictureCompletion) {
        storage.child("message_images/\(fileName)").putData(data, metadata: nil, completion: { [weak self] metadata, error in
            guard error == nil else {
                // failed
                print("failed to upload data to firebase for picture")
                completion(.failure(StorageErrors.failedToUpload))
                return
            }

            self?.storage.child("message_images/\(fileName)").downloadURL(completion: { url, error in
                guard let url = url else {
                    print("Failed to get download url")
                    completion(.failure(StorageErrors.failedToGetDownloadUrl))
                    return
                }

                let urlString = url.absoluteString
                print("download url returned: \(urlString)")
                completion(.success(urlString))
            })
        })
    }

    /// Upload video that will be sent in a conversation message
    public func uploadMessageVideo(with fileUrl: URL, fileName: String, completion: @escaping UploadPictureCompletion) {
        storage.child("message_videos/\(fileName)").putFile(from: fileUrl, metadata: nil, completion: { [weak self] metadata, error in
            guard error == nil else {
                // failed
                print("failed to upload video file to firebase for picture")
                completion(.failure(StorageErrors.failedToUpload))
                return
            }

            self?.storage.child("message_videos/\(fileName)").downloadURL(completion: { url, error in
                guard let url = url else {
                    print("Failed to get download url")
                    completion(.failure(StorageErrors.failedToGetDownloadUrl))
                    return
                }

                let urlString = url.absoluteString
                print("download url returned: \(urlString)")
                completion(.success(urlString))
            })
        })
    }

    public enum StorageErrors: Error {
        case failedToUpload
        case failedToGetDownloadUrl
    }

    public func downloadURL(for path: String, completion: @escaping (Result<URL, Error>) -> Void) {
        let reference = storage.child(path)

        reference.downloadURL(completion: { url, error in
            guard let url = url, error == nil else {
                completion(.failure(StorageErrors.failedToGetDownloadUrl))
                return
            }

            completion(.success(url))
        })
    }
    
    
    
    
    // CRUD FIREBASE
    func create(keyName: String, param: [String: Any], collectionName: String) {
        ref.child(collectionName).child(keyName).setValue(param)
    }
    
}
