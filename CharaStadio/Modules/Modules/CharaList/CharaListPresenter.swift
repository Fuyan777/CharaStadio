//
//  CharaListPresenter.swift
//  CharaStadio
//
//  Created by 山田楓也 on 2021/08/19.
//

import Foundation

protocol CharaListPresenterInterface: AnyObject {
    func viewDidLoad()
    func didSelectChara(selectedChara: CharaEntity)
    func didTapCharaPost()
}

final class CharaListPresenter {
    private let view: CharaListViewInterface
    private let interactor: CharaListInteractorInterface
    private let router: CharaListRouterInterface
    
    init(
        view: CharaListViewInterface,
        interactor: CharaListInteractorInterface,
        router: CharaListRouter
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension CharaListPresenter: CharaListPresenterInterface {
    func viewDidLoad() {
        self.view.displayLodingAlert()
        
        self.interactor.fetchCharaList { result in
            self.view.displayFinishLodingAlert()
            
            switch result {
            case let .success(characters):
                self.view.displayCharaList(characters)
            case let .failure(error):
                self.view.alertListError(error: error)
            }
        }
    }
    
    func didSelectChara(selectedChara: CharaEntity) {
        interactor.saveSpotlightChara(selectedChara: selectedChara)
        interactor.saveUserDefaultsChara(selectedChara: selectedChara)
        router.pushCharaDetail(chara: selectedChara)
    }
    
    func didTapCharaPost() {
        router.presentCharaPost()
    }
}
