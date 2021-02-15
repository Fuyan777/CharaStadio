//
//  UIViewExtension.swift
//  CharaStadio
//
//  Created by 山田楓也 on 2021/02/16.
//

import UIKit

extension UIView {
    func defaultMaskCorner() {
        layer.cornerRadius = 6
        layer.masksToBounds = true
    }
    
}
