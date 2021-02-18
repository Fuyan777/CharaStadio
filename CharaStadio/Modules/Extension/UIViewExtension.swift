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
    
    // 影をつける
    func setupShadow(opacity: Float = 0.1, radius: CGFloat = 2.0) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
    }
}
