//
//  SettingViewController.swift
//  CharaStadio
//
//  Created by 山田楓也 on 2021/02/17.
//

import UIKit

class SettingViewController: UIViewController {
    @IBOutlet weak var settingTableView: UITableView! {
        didSet {
            settingTableView.delegate = self
            settingTableView.dataSource = self
            settingTableView.registerNib(cellType: SettingTableViewCell.self)
            settingTableView.backgroundColor = .lightGray
            settingTableView.tableFooterView = UIView()
        }
    }
    
    private var model: SettingModelProtocol = SettingModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SettingViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        model.tableSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.tableSection[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingType = model.tableSection[indexPath.section]
        let cell = tableView.dequeueReusableCell(for: indexPath) as SettingTableViewCell
        let component = SettingTableViewCell.Component(
            title: settingType.rowTitle(rowIndex: indexPath.row),
            iconImage: settingType.rowIconImage(rowIndex: indexPath.row)
        )
        cell.setupCell(component: component)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerViewFrame = CGRect(origin: .zero, size: CGSize(width: tableView.bounds.width, height: 48))
        let tableViewHeaderView = UIView(frame: headerViewFrame)
        tableViewHeaderView.backgroundColor = .gray
        
        let headerLabelFrame = CGRect(origin: .zero, size: CGSize(width: 200, height: 20))
        let headerLabel = UILabel(frame: headerLabelFrame)
        headerLabel.center = CGPoint(x: 116, y: tableViewHeaderView.center.y)
        headerLabel.text = model.tableSection[section].title
        headerLabel.textColor = .black
        headerLabel.font = UIFont.boldSystemFont(ofSize: 17)
        
        tableViewHeaderView.addSubview(headerLabel)
        
        return tableViewHeaderView
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let settingType = model.tableSection[indexPath.section]
        switch settingType {
        case .app:
            let appRow = settingType.appRows[indexPath.row]
            switch appRow {
            case .request:
                print("request")
            case .appShare:
                print("appShare")
            case .appReview:
                print("appReview")
            }
        case .other:
            let ohterRow = settingType.otherRows[indexPath.row]
            switch ohterRow {
            case .privacyPolicy:
                print("privacyPolicy")
            case .version: break
            }
        }
    }
}
