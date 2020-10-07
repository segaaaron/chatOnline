//
//  Extension.swift
//  chatOnline
//
//  Created by Miguel Angel Saravia Belmonte on 10/7/20.
//  Copyright © 2020 chatOnline. All rights reserved.
//

import Foundation
import UIKit
extension UIImage
{
    public func imageByApplyingAlpha(_ alpha: CGFloat) -> UIImage?
    {
        //Swift 3
//        UIGraphicsBeginImageContextWithOptions(size, false, scale)
//        draw(at: CGPoint.zero, blendMode: .normal, alpha: alpha)
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return newImage!
        
        //Swift 2
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        
        if let ctx = UIGraphicsGetCurrentContext()
        {
            let area = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height);
        
            ctx.scaleBy(x: 1, y: -1);
            ctx.translateBy(x: 0, y: -area.size.height);
            ctx.setBlendMode(CGBlendMode.multiply);
            ctx.setAlpha(alpha);
            ctx.draw(self.cgImage!, in: area);
        }
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        return newImage;
    }
    
    
    
    /**
     Rotate image by degress
     
     - parameter degrees: degrees of rotation in the image
     - parameter flip: true = flip the image horizontally
     
     - returns: UIImage rotated
     */
    
    public func imageRotatedByDegrees(_ degrees: CGFloat, flip: Bool, image: UIImage) -> UIImage? {
        
        let degreesToRadians: (CGFloat) -> CGFloat = {
            return $0 / 180.0 * CGFloat.pi
        }
        
        // calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox = UIView(frame: CGRect(origin: CGPoint.zero, size: image.size))
        let t = CGAffineTransform(rotationAngle: degreesToRadians(degrees));
        rotatedViewBox.transform = t
        let rotatedSize = rotatedViewBox.frame.size
        
        // Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap = UIGraphicsGetCurrentContext()
        
        // Move the origin to the middle of the image so we will rotate and scale around the center.
        bitmap!.translateBy(x: rotatedSize.width / 2.0, y: rotatedSize.height / 2.0);
        
        // Rotate the image context
        bitmap!.rotate(by: degreesToRadians(degrees));
        
        // Now, draw the rotated/scaled image into the context
        var yFlip: CGFloat
        
        if(flip){
            yFlip = CGFloat(-1.0)
        } else {
            yFlip = CGFloat(1.0)
        }
        
        bitmap!.scaleBy(x: yFlip, y: -1.0)
        bitmap!.draw(image.cgImage!, in: CGRect(x: -image.size.width / 2, y: -image.size.height / 2, width: image.size.width, height: image.size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
    /**
     Replace a color in image with another color
     
     - parameter color: color to be replaced
     - parameter newColor: color will replaced old color
     - parameter scale: The scale factor to assume when interpreting the image data
     
     - returns: UIImage with color replaced
     */
    
    public func replace(_ color: UIColor, byColor newColor: UIColor, scale: CGFloat = 1.0) -> UIImage {
        let imageSize: CGSize = self.size
        let imageScale: CGFloat = self.scale
        let contextBounds: CGRect = CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height)
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, imageScale)
        color.setFill()
        UIRectFill(contextBounds)
        self.draw(at: CGPoint.zero)
        let imageOverBlack: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        newColor.setFill()
        UIRectFill(contextBounds)
        
        imageOverBlack.draw(at: CGPoint.zero, blendMode: .multiply, alpha: 1)
        self.draw(at: CGPoint.zero, blendMode: .destinationIn, alpha: 1)
        
        var finalImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        if scale != 1.0 {
            finalImage = UIImage(cgImage: finalImage.cgImage!, scale: scale, orientation: UIImage.Orientation.up)
        }
        
        return finalImage
    }
    
    
    /**
     comment
     
     - parameter oldColor:  Color to be replaced in the pin
     - parameter newColor:  Color that will replaced old color
     - parameter scale:     The scale factor to assume when interpreting the image data
     - parameter icon:      Icon that will be shown in the pin
     
     - returns: description_value_returned
     */
    
    public func pinIconWithColor(_ oldColor: UIColor, byColor newColor: UIColor, scale: CGFloat = 1.0, icon: UIImage?) -> UIImage {
        let pin = self.replace(oldColor, byColor: newColor, scale: scale)
        if let icon = icon {
            let iconPadding = CGFloat(10)
            let iconTopPadding = CGFloat(5)
            let size = pin.size
            UIGraphicsBeginImageContextWithOptions(size, false, 2.0)
            let areaSize = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            pin.draw(in: areaSize)
            let iconAreaSize = CGRect(x: (size.width - (size.width-iconPadding))/2, y: iconTopPadding, width: size.width-iconPadding, height: size.width-iconPadding)
            let circularIcon = self.circularIcon(icon, withSize: CGSize(width: size.width, height: size.width))
            circularIcon.draw(in: iconAreaSize, blendMode: .normal, alpha: 1)
            let pinIcon:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            return pinIcon
        }
        
        return pin
    }
    
    
    fileprivate func circularIcon(_ icon: UIImage, withSize size: CGSize) -> UIImage  {
        let viewContainer = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.width))
        let iconPadding = CGFloat(4)
        viewContainer.backgroundColor = UIColor.white
        viewContainer.layer.borderWidth = 0.5
        viewContainer.layer.masksToBounds = false
        viewContainer.layer.borderColor = UIColor.white.cgColor
        viewContainer.layer.cornerRadius = viewContainer.frame.height/2
        viewContainer.clipsToBounds = true
        let imageView = UIImageView(frame: CGRect(x: (size.width - (size.width-iconPadding))/2, y: (size.width - (size.width-iconPadding))/2, width: size.width-iconPadding, height: size.width-iconPadding))
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.gray
        imageView.image = icon
        viewContainer.addSubview(imageView)
        UIGraphicsBeginImageContextWithOptions(size, false, 2.0)
        viewContainer.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image ?? UIImage()
    }
    
    /**
     Convert string base64 format to UIImage
     
     - parameter base64: String with base64 format
     
     - returns: UIImage
     */
    public func fromBase64String(_ base64: String) -> UIImage? {
        if !base64.isEmpty {
            //search for string ";base64,", because after this must be the image data
            if let base64Range = base64.range(of: ";base64,", options: .literal)
            {
                //swift3
                //let base64HeaderRemoved = base64.substring(from: base64Range.upperBound)
                //swift4
                let base64HeaderRemoved = String(base64[base64Range.upperBound...])
                if let base64Decoded = Data(base64Encoded: base64HeaderRemoved, options:   NSData.Base64DecodingOptions(rawValue: 0)) {
                    return UIImage(data: base64Decoded)
                }
            }
            
        }
        return nil
    }
    
    
    public func toData() -> Data? {
        if let imageData: Data = self.jpegData(compressionQuality: 0.6) {
            return imageData
        }
        return nil
    }
    
}
