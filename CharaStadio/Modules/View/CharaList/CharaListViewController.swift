//
//  CharaListViewController.swift
//  CharaStadio
//
//  Created by 山田楓也 on 2021/02/16.
//

import UIKit

class CharaListViewController: UIViewController {
    @IBOutlet weak var charaCollectionView: UICollectionView! {
        didSet {
            charaCollectionView.dataSource = self
            charaCollectionView.delegate = self
            charaCollectionView.registerNib(cellType: CharaCollectionViewCell.self)
            charaCollectionView.backgroundColor = Asset.viewBgColor.color
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
            searchBar.barTintColor = Asset.viewBgColor.color
        }
    }
    
    private var model: CharaListModelProtocol = CharaListModel()
    private let spotlight: SpotlightRepositoryProtocol = SpotlightRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.charaCollectionView.reloadData()
    }
    
    private func fetchData() {
        self.startLoad()
        model.fetchData(completion: { result in
            switch result {
            case .success:
                self.model.searchResult = self.model.entity
                self.charaCollectionView.reloadData()
                self.doneMessage()
            case let .failure(error):
                self.alertError(error: error)
            }
        })
    }
    
    @objc private func movePost() {
        let storyboard: UIStoryboard = UIStoryboard(name: "CharaPost", bundle: nil)
        let nextView = storyboard.instantiateViewController(withIdentifier: "post") as! CharaPostViewController
        nextView.delegate = self
        // TODO: 後で修正
        //        nextView.modalPresentationStyle = .fullScreen
        self.present(nextView, animated: true)
    }
}

extension CharaListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.searchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as CharaCollectionViewCell
        let component = CharaCollectionViewCell.Component(charaInfo: model.searchResult[indexPath.row])
        cell.setupCell(component: component)
        return cell
    }
}

extension CharaListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        spotlight.saveChara(charaInfo: model.entity[indexPath.row])
        UserDefaultsClient().saveChara(
            model.entity[indexPath.row],
            forkey: "chara://detail?id=\(model.entity[indexPath.row].id)"
        )
        
        let storyboard: UIStoryboard = UIStoryboard(name: "CharaDetail", bundle: nil)
        let nextView = storyboard.instantiateViewController(withIdentifier: "detail") as! CharaDetailViewController
        
        nextView.charaDetail = model.entity[indexPath.row]
        if let tmp = UserDefaultsClient().loadChara(key: "favo=\(model.entity[indexPath.row].id)") {
            nextView.charaDetail.isFavorite = tmp.isFavorite
        }
        self.navigationController?.pushViewController(nextView, animated: true)
    }
}

extension CharaListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.charaCollectionView.frame.width - 8.0 * 2, height: 116.0)
    }
}

extension CharaListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        model.removeAll()

        if searchText.isEmpty {
            clearSearch()
        } else {
            model.entity.forEach {
                if $0.name.contains(searchText) {
                    model.searchResult.append($0)
                }
            }
        }
        
        charaCollectionView.reloadData()
    }
    
    private func clearSearch() {
        model.removeAll()
        model.searchResult = model.entity
        charaCollectionView.reloadData()
    }
}

extension CharaListViewController: CharaReloadDelegate {
    func reloadData() {
        fetchData()
        charaCollectionView.reloadData()
    }
}
