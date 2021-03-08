//
//  CharaPostParameter.swift
//  CharaStadio
//
//  Created by 山田楓也 on 2021/03/05.
//

import Foundation
import UIKit

struct CharaPostParameter {
    var name: String = ""
    var description: String = ""
    var image: UIImage
    
    init() {
        self.name = ""
        self.description = ""
        self.image = Asset.noImage.image
    }
}
