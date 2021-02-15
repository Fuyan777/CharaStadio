//
//  CharaCollectionViewCell.swift
//  CharaStadio
//
//  Created by 山田楓也 on 2021/02/16.
//

import UIKit

class CharaCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var baseView: UIView! {
        didSet {
            baseView.backgroundColor = .white
            baseView.defaultMaskCorner()
        }
    }
    
    @IBOutlet weak var charaImageView: UIImageView! {
        didSet { charaImageView.image = UIImage(systemName: "star") }
    }
    
    @IBOutlet weak var charaNameLabel: UILabel! {
        didSet { charaNameLabel.text = "ギャング" }
    }
    
    struct Component {
        var charaInfo: CharaEntiry
    }
    
    private var component: Component?
    
    func setupCell(component: Component) {
        self.component = component
        charaNameLabel.text = component.charaInfo.name
    }
}
