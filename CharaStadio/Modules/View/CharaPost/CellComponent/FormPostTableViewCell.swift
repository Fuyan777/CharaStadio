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
        
        var event: (Event) -> Void
    }
    
    private var component: Component?
    
    func setupCell(component: Component) {
        self.component = component
    }
    
    @objc private func postChara() {
        component?.event(.tap)
    }
}
