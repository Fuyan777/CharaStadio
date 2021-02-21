//
//  IconVisualTableViewCell.swift
//  CharaStadio
//
//  Created by 山田楓也 on 2021/02/21.
//

import UIKit

class IconVisualTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView! {
        didSet {
            iconImageView.image = Asset.noImageNostroke.image
            iconImageView.layer.cornerRadius = 28
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    struct Component {
    }
    
    private var component: Component?
    
    func setupCell(component: Component) {
        self.component = component
        nameLabel.text = "Fuya"
        messageLabel.text = "ヤッホー！"
    }
}

