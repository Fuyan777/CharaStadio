//
//  CharaFavoriteViewController.swift
//  CharaStadio
//
//  Created by 山田楓也 on 2021/02/24.
//

import UIKit

class CharaFavoriteViewController: UIViewController {
    @IBOutlet weak var favoriteCollectionView: UICollectionView! {
        didSet {
            favoriteCollectionView.dataSource = self
            favoriteCollectionView.delegate = self
            favoriteCollectionView.registerNib(cellType: CharaCollectionViewCell.self)
        }
    }
    
    let charaInfo = UserDefaultsClient().loadFavoriteAll()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = L10n.Navigation.favoriteTitle
    }
    
}

extension CharaFavoriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return charaInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as CharaCollectionViewCell
        let component = CharaCollectionViewCell.Component(charaInfo: charaInfo[indexPath.row])
        cell.setupCell(component: component)
        return cell
    }
}

extension CharaFavoriteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "CharaDetail", bundle: nil)
        let nextView = storyboard.instantiateViewController(withIdentifier: "detail") as! CharaDetailViewController
        nextView.charaDetail = charaInfo[indexPath.row]
        self.navigationController?.pushViewController(nextView, animated: true)
    }
}
