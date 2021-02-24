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
    
    @IBOutlet weak var favoriteButton: UIButton! {
        didSet {
            favoriteButton.addTarget(self, action: #selector(tapFavorite), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var charaImageView: UIImageView!
    @IBOutlet weak var charaDescriptionLabel: UILabel!
    
    var charaDetail: CharaEntity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChara()
        view.backgroundColor = Asset.viewBgColor.color
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = charaDetail.name
        navigationController?.navigationBar.titleTextAttributes = [ .foregroundColor: UIColor.white ]
        setupFavoriteImage()
    }
    
    private func setupChara() {
        charaDescriptionLabel.text = charaDetail.description
        getImage(imageRef: charaDetail.imageRef, imageView: charaImageView)
    }
    
    @objc func shareSns() {
        guard let image = charaImageView.image else { return }
        
        let text = L10n.hashtag
        let items: [Any?] = [image, charaDetail.name, text]
        let activityVC = UIActivityViewController(activityItems: items as [Any], applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @objc func tapFavorite() {
        charaDetail.isFavorite.toggle()
        setupFavoriteImage()
        
        let tmpKey = "favo=\(charaDetail.id)"
        
        if charaDetail.isFavorite == true {
            UserDefaultsClient().saveChara(charaDetail, forkey: tmpKey)
        } else {
            UserDefaultsClient().removeChara(key: tmpKey)
        }
    }
    
    func setupFavoriteImage() {
        let image = charaDetail.isFavorite
            ? UIImage(systemName: "bookmark.fill")
            : UIImage(systemName: "bookmark")
        favoriteButton.setImage(image, for: .normal)
    }
    
    func getImage(imageRef: String, imageView: UIImageView) {
        let storageRef = Storage.storage().reference(forURL: "gs://charastadio-8cd04.appspot.com/")
        let ref = storageRef.child("\(imageRef).png")
        imageView.sd_setImage(with: ref, placeholderImage: Asset.noImage.image)
    }
}
