//
//  SettingTableViewCell.swift
//  CharaStadio
//
//  Created by 山田楓也 on 2021/02/18.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    struct Component {
        var title: String
        var iconImage: UIImage?
    }
    
    private var component: Component?
    
    func setupCell(component: Component) {
        self.component = component
        titleLabel.text = component.title
        
        guard let iconImage = component.iconImage else { return }
        iconImageView.image = iconImage
    }
}
