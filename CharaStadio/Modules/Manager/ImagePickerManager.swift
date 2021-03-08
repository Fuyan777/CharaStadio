//
//  ImagePickerManager.swift
//  CharaStadio
//
//  Created by 山田楓也 on 2021/03/08.
//

import UIKit

protocol ImagePickerManagerDelegate: AnyObject {
    func didSelectedImage(image: UIImage)
}

class ImagePickerManager: NSObject {
    static let shared = ImagePickerManager()
    
    weak var delegate: ImagePickerManagerDelegate?
    
    private let imagePicker: UIImagePickerController
    
    override init() {
        imagePicker = UIImagePickerController()
        super.init()
        imagePicker.delegate = self
        imagePicker.setNeedsStatusBarAppearanceUpdate()
    }
    
    func presentImagePicker(
        viewController: UIViewController,
        types: [UIImagePickerController.SourceType]
    ) {
        delegate = viewController as? ImagePickerManagerDelegate
        switch types.count {
        case 0:
            return
        case 1:
            imagePicker.sourceType = types[0]
            viewController.present(
                imagePicker,
                animated: true,
                completion: nil
            )
        default:
            selectAction(viewController: viewController, types: types)
        }
    }
    
    private func selectAction(
        viewController: UIViewController,
        types: [UIImagePickerController.SourceType]
    ) {
        var actions: [UIAlertAction] = []
        
        if types.contains(.photoLibrary) {
            let galleryAction = UIAlertAction(
                title: "カメラロールを選択する",
                style: .default,
                handler: { [weak self] _ in
                    guard let self = self else { return }
                    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                        self.imagePicker.sourceType = .photoLibrary
                        viewController.present(
                            self.imagePicker,
                            animated: true,
                            completion: nil
                        )
                    }
                }
            )
            actions.append(galleryAction)
        }
        
        let actionSheet = UIAlertController.confirmByActionSheet(view: viewController.view, actions: actions)
        viewController.present(actionSheet, animated: true, completion: nil)
    }
    
}

extension ImagePickerManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        guard let image = info[.originalImage] as? UIImage else { return }
        delegate?.didSelectedImage(image: image)
        imagePicker.dismiss(animated: true)
    }
}
