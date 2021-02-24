//
//  CharaCollectionViewCell.swift
//  CharaStadio
//
//  Created by 山田楓也 on 2021/02/16.
//

import UIKit
import Firebase
import FirebaseUI

class CharaCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var baseView: UIView! {
        didSet {
            baseView.backgroundColor = Asset.cellBgColor.color
            baseView.defaultMaskCorner()
            baseView.setupShadow()
        }
    }
    
    @IBOutlet weak var charaImageView: UIImageView!
    @IBOutlet weak var charaNameLabel: UILabel!
    
    struct Component {
        var charaInfo: CharaEntity
    }
    
    private var component: Component?
    
    func setupCell(component: Component) {
        self.component = component
        charaNameLabel.text = component.charaInfo.name
        getImage(imageRef: component.charaInfo.imageRef, imageView: charaImageView)
    }
    
    func getImage(imageRef: String, imageView: UIImageView) {
        let storageRef = Storage.storage().reference(forURL: "gs://charastadio-8cd04.appspot.com/")
        let ref = storageRef.child("\(imageRef).png")
        imageView.sd_setImage(with: ref, placeholderImage: Asset.noImage.image)
    }
}
