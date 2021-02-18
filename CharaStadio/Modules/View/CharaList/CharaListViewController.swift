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
    
    @IBOutlet weak var settingButton: UIButton! {
        didSet { settingButton.addTarget(self, action: #selector(moveSetting), for: .touchUpInside) }
    }
    
    private let model: FirebaseModelProtocol = FirebaseModel()
    private var entity = [CharaEntity]()
    
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
        self.model.getChara { [weak self] result in
            switch result {
            case let .success(response):
                self?.entity = response
                self?.charaCollectionView.reloadData()
            case let .failure(error):
                print(error)
            }
        }
    }
    
    @objc func moveSetting() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Setting", bundle: nil)
        let nextView = storyboard.instantiateViewController(withIdentifier: "setting") as! SettingViewController
        self.navigationController?.pushViewController(nextView, animated: true)
    }
}

extension CharaListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return entity.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as CharaCollectionViewCell
        let component = CharaCollectionViewCell.Component(charaInfo: entity[indexPath.row])
        cell.setupCell(component: component)
        return cell
    }
}

extension CharaListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "CharaDetail", bundle: nil)
        let nextView = storyboard.instantiateViewController(withIdentifier: "detail") as! CharaDetailViewController
        nextView.charaDetail = entity[indexPath.row]
        self.navigationController?.pushViewController(nextView, animated: true)
    }
}

extension CharaListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.charaCollectionView.frame.width - 16.0 * 2, height: 116.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
}
