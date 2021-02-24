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
    
    @IBOutlet weak var bookmarksButton: UIButton! {
        didSet { bookmarksButton.addTarget(self, action: #selector(moveBookmarks), for: .touchUpInside) }
    }
    
    @IBOutlet weak var settingButton: UIButton! {
        didSet { settingButton.addTarget(self, action: #selector(moveSetting), for: .touchUpInside) }
    }
    
    @IBOutlet weak var visualButtonBaseView: UIView! {
        didSet {
            visualButtonBaseView.allMaskCorner()
            visualButtonBaseView.backgroundColor = Asset.accentColor.color
        }
    }
    
    @IBOutlet weak var iconVisualButton: UIButton! {
        didSet {
            iconVisualButton.backgroundColor = .clear
            iconVisualButton.addTarget(self, action: #selector(moveIconVisual), for: .touchUpInside)
        }
    }
    
    private let model: CharaListModelProtocol = CharaListModel()
    private let spotlight: SpotlightRepositoryProtocol = SpotlightRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = Asset.accentColor.color
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func fetchData() {
        self.startLoad()
        model.fetchData(completion: { result in
            switch result {
            case .success:
                self.charaCollectionView.reloadData()
                self.finishLoad()
            case let .failure(error):
                self.alertError(error: error)
            }
        })
    }
    
    @objc private func moveSetting() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Setting", bundle: nil)
        let nextView = storyboard.instantiateViewController(withIdentifier: "setting") as! SettingViewController
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    
    @objc private func moveIconVisual() {
        let storyboard: UIStoryboard = UIStoryboard(name: "IconVisual", bundle: nil)
        let nextView = storyboard.instantiateViewController(withIdentifier: "iconVisual") as! IconVisualViewController
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    
    @objc private func moveBookmarks() {
        let storyboard: UIStoryboard = UIStoryboard(name: "CharaFavorite", bundle: nil)
        let nextView = storyboard.instantiateViewController(withIdentifier: "favorite") as! CharaFavoriteViewController
        self.navigationController?.pushViewController(nextView, animated: true)
    }
}

extension CharaListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.entity.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as CharaCollectionViewCell
        let component = CharaCollectionViewCell.Component(charaInfo: model.entity[indexPath.row])
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
