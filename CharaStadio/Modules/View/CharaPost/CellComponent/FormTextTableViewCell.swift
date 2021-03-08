//
//  FormTextTableViewCell.swift
//  CharaStadio
//
//  Created by 山田楓也 on 2021/03/02.
//

import UIKit

class FormTextTableViewCell: UITableViewCell {
    @IBOutlet weak var nameTextField: UITextField! {
        didSet { nameTextField.addTarget(self, action: #selector(editingNameText), for: .editingChanged) }
    }
    
    @IBOutlet weak var descriptionTextField: UITextField! {
        didSet { descriptionTextField.addTarget(self, action: #selector(editingDescriptionText), for: .editingChanged) }
    }
    
    struct Component {
        enum Event {
            case editingNameChanged(String), editingDescriptionChanged(String)
        }
        
        var event: (Event) -> Void
    }
    
    private var component: Component?
    
    func setupCell(component: Component) {
        self.component = component
    }
    
    @objc private func editingNameText(_ sender: UITextField) {
        guard let text = sender.text else { return }
        component?.event(.editingNameChanged(text))
    }
    
    @objc private func editingDescriptionText(_ sender: UITextField) {
        guard let text = sender.text else { return }
        component?.event(.editingDescriptionChanged(text))
    }
}

