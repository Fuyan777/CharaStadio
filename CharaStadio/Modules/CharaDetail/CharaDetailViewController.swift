//
//  CharaDetailViewController.swift
//  CharaStadio
//
//  Created by 山田楓也 on 2021/02/16.
//

import UIKit
import Firebase
import FirebaseUI

class CharaDetailViewController: UIViewController {
    @IBOutlet weak var shareButton: UIButton! {
        didSet { shareButton.addTarget(self, action: #selector(shareSns), for: .touchUpInside) }
    }
    
    @IBOutlet weak var charaImageView: UIImageView!
    
    @IBOutlet weak var charaDescriptionLabel: UILabel!
    
    var charaDetail: CharaEntity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChara()
    }
    
    private func setupChara() {
        navigationItem.title = charaDetail.name
        charaDescriptionLabel.text = charaDetail.description
        getImage(imageRef: charaDetail.imageRef, imageView: charaImageView)
    }
    
    @objc func shareSns() {
        let items = ["text"]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
    
    func getImage(imageRef: String, imageView: UIImageView) {
        let storageRef = Storage.storage().reference(forURL: "gs://charastadio-8cd04.appspot.com/")
        let ref = storageRef.child("\(imageRef).png")
        imageView.sd_setImage(with: ref, placeholderImage: UIImage(systemName: "star"))
    }
}
