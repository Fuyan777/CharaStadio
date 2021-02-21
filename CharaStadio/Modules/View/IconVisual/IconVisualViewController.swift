//
//  IconVisualViewController.swift
//  CharaStadio
//
//  Created by 山田楓也 on 2021/02/20.
//

import UIKit

class IconVisualViewController: UIViewController {
    @IBOutlet weak var iconVisualTableView: UITableView! {
        didSet {
            iconVisualTableView.dataSource = self
            iconVisualTableView.registerNib(cellType: IconVisualTableViewCell.self)
            iconVisualTableView.backgroundColor = Asset.viewBgColor.color
        }
    }
    
    @IBOutlet weak var imageBaseView: UIView! {
        didSet {
            imageBaseView.allMaskCorner()
        }
    }
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var iconSelectButton: UIButton! {
        didSet { iconSelectButton.addTarget(self, action: #selector(selectIcon), for: .touchUpInside) }
    }
    
    let name = ["ギャング", "ガール", "ぼうや", "ヒゲさん", "竹ぼうや", "パネンガ"]
    let message = ["おっす！", "こんにちは！", "やあ！", "どうもー", "やほー", "ふむふむ"]
    let image = [Asset.africa.image, Asset.girl.image, Asset.boya.image, Asset.hige.image, Asset.takebou.image, Asset.panenga.image]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "アイコンを確認しよう"
        navigationController?.navigationBar.titleTextAttributes = [ .foregroundColor: UIColor.white ]
    }
    
    @objc private func selectIcon() {
        let sourceType: UIImagePickerController.SourceType = UIImagePickerController.SourceType.photoLibrary
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.present(picker, animated: true)
        }
    }
}

extension IconVisualViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as IconVisualTableViewCell
        
        if indexPath.row == 0 {
            let component = IconVisualTableViewCell.Component(
                name: "あなたのアイコン",
                message: "テスト用です！",
                image: iconImageView.image ?? Asset.noImageNostroke.image
            )
            cell.setupCell(component: component)
        } else {
            let component = IconVisualTableViewCell.Component(
                name: name[indexPath.row - 1],
                message: message[indexPath.row - 1],
                image: image[indexPath.row - 1]
            )
            cell.setupCell(component: component)
        }
        return cell
    }
}

extension IconVisualViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        iconImageView.image = image
        iconVisualTableView.reloadData()
        self.dismiss(animated: true)
    }
}
