//
//  CharaPostViewController.swift
//  CharaStadio
//
//  Created by 山田楓也 on 2021/03/01.
//

import UIKit

protocol CharaReloadDelegate {
    func reloadData()
}

class CharaPostViewController: UIViewController {
    @IBOutlet weak var postFormTableView: UITableView! {
        didSet {
            postFormTableView.dataSource = self
            let nibs = [
                FormImageTableViewCell.self,
                FormTextTableViewCell.self,
                FormPostTableViewCell.self
            ]
            postFormTableView.registerNib(cellTypes: nibs)
        }
    }

    @IBOutlet weak var closeButton: UIButton! {
        didSet {
            closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        }
    }
    
    let model = CharaPostModel()
    var delegate: CharaReloadDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "投稿しよう"
    }
    
    func postChara(parameter: CharaPostParameter) {
        model.postChara(parameter: parameter) { result in
            switch result {
            case .success:
                self.delegate?.reloadData()
                self.finishLoad()
                self.dismiss(animated: true, completion: nil)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
}

extension CharaPostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.tableSection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch model.tableSection[indexPath.row] {
        case .image:
            let cell = tableView.dequeueReusableCell(for: indexPath) as FormImageTableViewCell
            let component = FormImageTableViewCell.Component(image: UIImage(systemName: "star")) { event in
                switch event {
                case .tap:
                    print("image")
                }
            }
            cell.setupCell(component: component)
            return cell
        case .text:
            let cell = tableView.dequeueReusableCell(for: indexPath) as FormTextTableViewCell
            let component = FormTextTableViewCell.Component { event in
                switch event {
                case let .editingNameChanged(name):
                    self.model.updateNameParameter(name: name)
                case let .editingDescriptionChanged(description):
                    self.model.updateDescriptionParameter(description: description)
                }
            }
            cell.setupCell(component: component)
            return cell
        case .button:
            let cell = tableView.dequeueReusableCell(for: indexPath) as FormPostTableViewCell
            let component = FormPostTableViewCell.Component { event in
                switch event {
                case .tap:
                    self.startLoad()
                    self.postChara(parameter: self.model.parameter)
                }
            }
            cell.setupCell(component: component)
            return cell
        }
    }
    
}
