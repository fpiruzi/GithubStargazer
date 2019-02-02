//
//  UIHelper.swift
//  GithubStargazer
//
//  Created by Fabrizio Piruzi on 01/02/2019.
//  Copyright © 2019 fpiruzi. All rights reserved.
//

import Foundation
import MBProgressHUD

class UIHelper{
    static let sharedInstance = UIHelper()
}

//ProgressHUD
extension UIHelper{
    func showHUDInView(view: UIView){
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    func hideHUDInView(view: UIView){
        MBProgressHUD.hide(for: view, animated: true)
    }
}

//Alert controller
extension UIHelper{
    func showAlertWithOkButton(viewController:UIViewController, title:String, message:String){
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alertController.addAction(
            UIAlertAction(
                title: NSLocalizedString(Constants.Strings.ok, comment: ""),
                style: .cancel
            )
        )
        viewController.present(alertController, animated: true, completion: nil)
    }
}
