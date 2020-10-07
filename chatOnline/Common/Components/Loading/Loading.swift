//
//  Loading.swift
//  chatOnline
//
//  Created by Miguel Angel Saravia Belmonte on 9/15/20.
//  Copyright © 2020 chatOnline. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 13.0, *)
class Loading {
    
    var onView : UIView!
    
    func showLoading(onView : UIView) {
        let loadingView = UIView.init(frame: onView.bounds)
        loadingView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView(style: .large)
        ai.startAnimating()
        ai.center = loadingView.center
        
        let dispatch = DispatchQueue.main
        dispatch.async {
            loadingView.addSubview(ai)
            onView.addSubview(loadingView)
        }
        
        self.onView = loadingView
    }
    
    func removeLoading() {
        DispatchQueue.main.async {
            self.onView?.removeFromSuperview()
            self.onView = nil
        }
    }
}
