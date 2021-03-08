//
//  UIViewControllerExtension+Alert.swift
//  CharaStadio
//
//  Created by 山田楓也 on 2021/02/20.
//

import UIKit
import SVProgressHUD

extension UIViewController {
    func alertMessage(_ message: String, delay: TimeInterval = 2.0) {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.showInfo(withStatus: message)
        SVProgressHUD.dismiss(withDelay: delay)
    }
    
    func alertError(error: Error) {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.showInfo(withStatus: error.localizedDescription)
        SVProgressHUD.dismiss(withDelay: 2.0)
    }
    
    func startLoad() {
        SVProgressHUD.showInfo(withStatus: "Loading ...")
    }
    
    func finishLoad() {
        SVProgressHUD.dismiss()
    }
    
    func doneMessage(msg: String = "完了しました。") {
        SVProgressHUD.showSuccess(withStatus: msg)
    }
}
