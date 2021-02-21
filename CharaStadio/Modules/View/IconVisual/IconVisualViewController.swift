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
    @IBOutlet weak var iconSelectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "アイコンを確認しよう"
        navigationController?.navigationBar.titleTextAttributes = [ .foregroundColor: UIColor.white ]
    }
}

extension IconVisualViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as IconVisualTableViewCell
        let component = IconVisualTableViewCell.Component()
        cell.setupCell(component: component)
        return cell
    }
}
