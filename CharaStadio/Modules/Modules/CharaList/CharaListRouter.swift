//
//  CharaListRouter.swift
//  CharaStadio
//
//  Created by 山田楓也 on 2021/08/19.
//

import UIKit

protocol CharaListRouterInterface: AnyObject {
    func pushCharaDetail(chara: CharaEntity)
    func presentCharaPost()
}

final class CharaListRouter {
    private let viewController: CharaListViewController
    
    init(viewController: CharaListViewController) {
        self.viewController = viewController
    }
    
    static func assembleModule() -> CharaListViewController {
        let storyboard = UIStoryboard(name: "CharaList", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "list") as! CharaListViewController
        let interactor = CharaListInteractor(firebaseRepository: FirebaseRepository())
        let router = CharaListRouter(viewController: viewController)
        
        let presenter = CharaListPresenter(
            view: viewController,
            interactor: interactor,
            router: router
        )
        
        viewController.presenter = presenter
        return viewController
    }
}

extension CharaListRouter: CharaListRouterInterface {
    func pushCharaDetail(chara: CharaEntity) {
        let storyboard = UIStoryboard(name: "CharaDetail", bundle: nil)
        let nextView = storyboard.instantiateViewController(withIdentifier: "detail") as! CharaDetailViewController
        nextView.charaDetail = chara
        if let tmp = UserDefaultsClient().loadChara(key: "favo=\(chara.id)") {
            nextView.charaDetail.isFavorite = tmp.isFavorite
        }
        viewController.navigationController?.pushViewController(nextView, animated: true)
    }
    
    func presentCharaPost() {
        let storyboard = UIStoryboard(name: "CharaPost", bundle: nil)
        let nextView = storyboard.instantiateViewController(withIdentifier: "post") as! CharaPostViewController
        viewController.present(nextView, animated: true)
    }
}
