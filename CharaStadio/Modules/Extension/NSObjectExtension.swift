//
//  NSObjectExtension.swift
//  CharaStadio
//
//  Created by 山田楓也 on 2021/02/16.
//

import Foundation

extension NSObject {
    @nonobjc static var className: String {
        String(describing: self)
    }

    var className: String {
        type(of: self).className
    }
}
