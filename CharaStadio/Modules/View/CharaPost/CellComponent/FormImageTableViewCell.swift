//
//  FormImageTableViewCell.swift
//  CharaStadio
//
//  Created by 山田楓也 on 2021/03/02.
//

import UIKit

class FormImageTableViewCell: UITableViewCell {
    @IBOutlet weak var charaImageView: UIImageView!
    @IBOutlet weak var selectCharaButton: UIButton! {
        didSet { selectCharaButton.addTarget(self, action: #selector(selectedCharaImage), for: .touchUpInside) }
    }
    
    struct Component {
        enum Event {
            case tap
        }
        
        var image: UIImage?
        var event: (Event) -> Void
    }
    
    private var component: Component?
    
    func setupCell(component: Component) {
        self.component = component
        charaImageView.image = component.image
    }
    
    @objc
    private func selectedCharaImage() {
        component?.event(.tap)
    }
}
