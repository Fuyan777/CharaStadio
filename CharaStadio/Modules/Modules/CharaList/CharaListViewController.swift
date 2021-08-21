//
//  CharaListViewController.swift
//  CharaStadio
//
//  Created by 山田楓也 on 2021/02/16.
//

import UIKit

protocol CharaListViewInterface: AnyObject {
    func displayCharaList(_ chara: [CharaEntity])
    func displayLodingAlert()
    func displayFinishLodingAlert()
    func alertListError(error: Error)
}

final class CharaListViewController: UIViewController {
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
    
    @IBOutlet weak var postCharaButton: UIButton! {
        didSet {
            postCharaButton.allMaskCorner()
            postCharaButton.addTarget(self, action: #selector(movePost), for: .touchUpInside)
        }
    }
    
    var presenter: CharaListPresenterInterface!
    private var chara: [CharaEntity] = []
    private var searchResultChara: [CharaEntity] = []
    private var model: CharaListModelProtocol = CharaListModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.charaCollectionView.reloadData()
    }
}

// MARK: - private method

private extension CharaListViewController {
    @objc
    private func movePost() {
        presenter.didTapCharaPost()
    }
}

// MARK: - Interface

extension CharaListViewController: CharaListViewInterface {
    func displayCharaList(_ chara: [CharaEntity]) {
        self.chara = chara
        self.searchResultChara = chara
        DispatchQueue.main.async {
            self.charaCollectionView.reloadData()
        }
    }
    
    func displayLodingAlert() {
        self.startLoad()
    }
    
    func displayFinishLodingAlert() {
        self.doneMessage()
    }
    
    func alertListError(error: Error) {
        self.alertError(error: error)
    }
}

// MARK: - UICollection Delegate

extension CharaListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.searchResultChara.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as CharaCollectionViewCell
        let component = CharaCollectionViewCell.Component(charaInfo: self.searchResultChara[indexPath.row])
        cell.setupCell(component: component)
        return cell
    }
}

extension CharaListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter.didSelectChara(selectedChara: self.searchResultChara[indexPath.row])
    }
}

extension CharaListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.charaCollectionView.frame.width - 8.0 * 2, height: 116.0)
    }
}

// MARK: - UISearchBar Delegate

extension CharaListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResultChara.removeAll()
        
        if searchText.isEmpty {
            clearSearch()
        } else {
            self.chara.forEach {
                if $0.name.contains(searchText) { searchResultChara.append($0) }
            }
        }
        
        charaCollectionView.reloadData()
    }
    
    private func clearSearch() {
        searchResultChara.removeAll()
        searchResultChara = self.chara
        charaCollectionView.reloadData()
    }
}

// MARK: - CharaReload Delegate

extension CharaListViewController: CharaReloadDelegate {
    func reloadData() {
        charaCollectionView.reloadData()
    }
}
