//
//  FormPostTableViewCell.swift
//  CharaStadio
//
//  Created by 山田楓也 on 2021/03/02.
//

import UIKit

class FormPostTableViewCell: UITableViewCell {
    @IBOutlet weak var postButton: UIButton! {
        didSet {
            postButton.defaultMaskCorner()
            postButton.addTarget(self, action: #selector(postChara), for: .touchUpInside)
        }
    }
    
    struct Component {
        enum Event {
            case tap
        }
        
        var isEnabled: Bool
        var event: (Event) -> Void
    }
    
    private var component: Component?
    
    func setupCell(component: Component) {
        self.component = component
        validate(isEnabled: component.isEnabled)
    }
    
    @objc private func postChara() {
        component?.event(.tap)
    }
    
    func validate(isEnabled: Bool) {
        self.postButton.isEnabled = isEnabled
        postButton.backgroundColor = isEnabled ? Asset.accentColor.color : .lightGray
    }
}
