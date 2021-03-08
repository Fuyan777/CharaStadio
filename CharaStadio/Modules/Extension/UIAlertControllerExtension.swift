//
//  UIAlertControllerExtension.swift
//  CharaStadio
//
//  Created by 山田楓也 on 2021/03/08.
//

import UIKit

extension UIAlertController {
    
    static func confirm(
        title: String? = nil,
        message: String? = nil,
        type: UIAlertController.Style = .alert,
        actions: [UIAlertAction],
        hasCancel: Bool = true
    ) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: type)
        actions.forEach {
            alertController.addAction($0)
        }
        if hasCancel {
            alertController.addAction(cancelAlertAction())
        }
        return alertController
    }
    
    static func cancelAlertAction() -> UIAlertAction {
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel)
        return cancelAction
    }
    
    static func confirmByActionSheet(
        view: UIView,
        title: String? = nil,
        message: String? = nil,
        actions: [UIAlertAction],
        hasCancel: Bool = true
    ) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actions.forEach {
            alertController.addAction($0)
        }
        if hasCancel {
            alertController.addAction(cancelAlertAction())
        }
        return alertController
    }
    
}
