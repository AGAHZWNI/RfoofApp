//
//  Activity.swift
//  Rfoof
//
//  Created by Abdulrahman Gazwani on 28/12/2021.
//

import UIKit

struct Activity {
    
    static func showIndicator(parentView:UIView,childView activityIndicator:UIActivityIndicatorView) {
        parentView.addSubview(activityIndicator)
        activityIndicator.center = parentView.center
        activityIndicator.startAnimating()
        parentView.isUserInteractionEnabled = false
    }
    static func removeIndicator(parentView:UIView,childView activityIndicator:UIActivityIndicatorView) {
        activityIndicator.removeFromSuperview()
        activityIndicator.stopAnimating()
        parentView.isUserInteractionEnabled = true
    }
}

    

