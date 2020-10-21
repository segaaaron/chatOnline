//
//  ProfileViewController.swift
//  chatOnline
//
//  Created by Miguel Angel Saravia Belmonte on 9/16/20.
//  Copyright © 2020 chatOnline. All rights reserved.
//

import UIKit
import FirebaseAuth
import JGProgressHUD
import Kingfisher

class ProfileViewController: UIViewController {
    //outlets
    @IBOutlet weak var tableVC: UITableView!
    
    private let viewFooter : UIView = {
       let view = UIView()
        return view
    }()
    
    private let logoutBtn : UIButton = {
        let button  = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColorFromHex(0x7EABC4)
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.white, for: .normal)

        button.sizeToFit()
    
        return button
    }()
    
    private let profileImage: UIImageView = {
       let image = UIImageView()
        return image
    }()
    
    var staticArraySections = ["Image","Name", "LastName", "Number Contact", "Email"]
    
    let alert = AlertService()
    private let spinner = JGProgressHUD(style: .dark)
    let groupDispatch = DispatchGroup()
    let dispatch = DispatchQueue.main
    var profile = Profile()
    override func viewDidLoad() {
        super.viewDidLoad()
        getProfileUser()
        tableVCsetUp()
        tabbarEditButton()
        spinner.show(in: view)
        groupDispatch.notify(queue: .main) {
            self.spinner.dismiss()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
            navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    
    func tabbarEditButton() {
        let editButton = UIButton()
        editButton.setImage(UIImage(named: "edit_profile_icon"), for: .normal)
        editButton.setImageTintColor(.white)
        editButton.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
        
        let rightButton = UIBarButtonItem()
        rightButton.customView = editButton
        navigationController?.navigationBar.barTintColor = loginNavigationColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = rightButton
    }
    
    func getProfileUser() {
        groupDispatch.enter()
        ProfilePresenter().getProfile(userID: Auth.auth().currentUser!.uid, success: { (profile) in
            self.profile = profile
            self.spinner.dismiss()
            self.dispatch.async {
                self.tableVC.reloadData()
            }
            self.groupDispatch.leave()
            
        }) { (error) in
            let alertVC = self.alert.alert(message: "\(error!.userInfo["msg"]!)", buttonlabel: btnContinue, img: warning_icon)
            self.present(alertVC, animated: true, completion: nil)
            self.groupDispatch.leave()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == goEditSegue) {
            let vc = segue.destination as! EditProfileViewController
            vc.dataProfile = self.profile
        }
    }
    
    func tableVCsetUp() {
        viewFooter.frame = CGRect(x: 0, y: 0, width: view.frame.width + 16, height: 40)
        viewFooter.addSubview(logoutBtn)
        
        logoutBtn.layer.cornerRadius = 20
        logoutBtn.leadingAnchor.constraint(equalTo: viewFooter.leadingAnchor, constant: 10).isActive = true
        logoutBtn.trailingAnchor.constraint(equalTo: viewFooter.trailingAnchor, constant: -10).isActive = true
        logoutBtn.topAnchor.constraint(equalTo: viewFooter.topAnchor, constant: 10).isActive = true
        logoutBtn.bottomAnchor.constraint(equalTo: viewFooter.bottomAnchor, constant: 10).isActive = true
        
        logoutBtn.addTarget(self, action: #selector(logoutAction), for: .touchUpInside)
        
        tableVC.delegate = self
        tableVC.dataSource = self
        tableVC.tableFooterView = viewFooter
        tableVC.separatorStyle = .singleLine
        let register = UINib(nibName: kcustomCell, bundle: .main)
        let registerDeafult = UINib(nibName: "DefaultCell", bundle: .main)
        tableVC.register(register, forCellReuseIdentifier: kcustomCell)
        tableVC.register(registerDeafult, forCellReuseIdentifier: "DefaultCell")
    }

}
extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
}
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return staticArraySections.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 4:
            return 40
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return staticArraySections[section]
        case 2:
            return staticArraySections[section]
        case 3:
            return staticArraySections[section]
        case 4:
            return staticArraySections[section]
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        case 1...4:
            return 40
        default:
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell") as! DefaultCell
        defaultCell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        let cell = tableView.dequeueReusableCell(withIdentifier: kcustomCell) as! CustomProfileCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        switch indexPath.section {
        case 0:
            cell.nameLabel.text = (profile.name?.uppercased() ?? "") + " " + (profile.lastName?.uppercased() ?? "")
            cell.photoImage.addTarget(self, action: #selector(handleCamera), for: .touchUpInside)
            cell.imageProfile.image = profile.photoImage == nil ? UIImage(named: "user_default") : profile.photoImage
            return cell
        case 1:
            defaultCell.nameTextField.text = profile.name
            return defaultCell
        case 2:
            defaultCell.nameTextField.text = profile.lastName
            return defaultCell
        case 3:
            defaultCell.nameTextField.text = profile.contactNumber
            return defaultCell
        case 4:
            defaultCell.nameTextField.text = profile.email
            return defaultCell
        default:
            defaultCell.nameTextField.text = "deafult"
            return defaultCell
        }
    }
    
    @objc func logoutAction(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "",
                                      message: "Are you sure to Logout?",
                                      preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Log out",
                                      style: .destructive,
                                      handler: { [weak self] _ in
                                        guard let strongSelf = self else {
                                            return
                                        }
                                        do {
                                            try FirebaseAuth.Auth.auth().signOut()

                                                let logginVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "LoginVC")
                                                let navController = UINavigationController(rootViewController: logginVC)
                                            
                                                strongSelf.view.window?.rootViewController = navController
                                        }
                                        catch {
                                            let alertVC = self?.alert.alert(message: ERROR_UNEXPECTED, buttonlabel: btnContinue, img: error_icon)
                                            strongSelf.present(alertVC!, animated: true, completion: nil)
                                        }

        }))

        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))

        self.present(actionSheet, animated: true)
    }
    
    @objc func editProfile() {
        performSegue(withIdentifier: goEditSegue, sender: self)
    }
    
    @objc func handleCamera() {
        cameraImage()
        
    }
    
    private func cameraImage() {
        let actionSheet = UIAlertController(title: "Profile Picture", message: "Select a picture", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let takePhotoAction = UIAlertAction(title: "Photo", style: .default, handler: {[weak self] _ in self?.takePhoto()})
        let libraryAction = UIAlertAction(title: "Library", style: .default, handler: {[weak self] _ in self?.libraryPhoto()})
        
        actionSheet.addAction(cancelAction)
        actionSheet.addAction(takePhotoAction)
        actionSheet.addAction(libraryAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    private func takePhoto() {
        let cameraVC = UIImagePickerController()
        cameraVC.sourceType = .camera
        cameraVC.delegate = self
        cameraVC.allowsEditing = true
        present(cameraVC, animated: true, completion: nil)
    }
    
    private func libraryPhoto() {
        let libraryVC = UIImagePickerController()
        libraryVC.sourceType = .photoLibrary
        libraryVC.delegate = self
        libraryVC.allowsEditing = true
        present(libraryVC, animated: true, completion: nil)
    }
}
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        profile.photoImage = selectedImage
        tableVC.reloadData()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
