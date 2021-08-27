//
//  CharaListInteractor.swift
//  CharaStadio
//
//  Created by 山田楓也 on 2021/08/19.
//

import Foundation

protocol CharaListInteractorInterface: AnyObject {
    func fetchCharaList(_ completion: @escaping ((Result<[CharaEntity], Error>) -> Void))
    func saveSpotlightChara(selectedChara: CharaEntity)
    func saveUserDefaultsChara(selectedChara: CharaEntity)
}

final class CharaListInteractor: CharaListInteractorInterface {
    private let firebaseRepository: FirebaseRepositoryProtocol
    private let spotlight: SpotlightRepositoryProtocol
    
    init(firebaseRepository: FirebaseRepositoryProtocol, spotlight: SpotlightRepositoryProtocol) {
        self.firebaseRepository = firebaseRepository
        self.spotlight = spotlight
    }
    
    func fetchCharaList(_ completion: @escaping ((Result<[CharaEntity], Error>) -> Void)) {
        firebaseRepository.getChara { completion($0) }
    }
    
    func saveSpotlightChara(selectedChara: CharaEntity) {
        spotlight.saveChara(charaInfo: selectedChara)
    }
    
    func saveUserDefaultsChara(selectedChara: CharaEntity) {
        UserDefaultsClient().saveChara(
            selectedChara,
            forkey: "chara://detail?id=\(selectedChara.id)"
        )
    }
}
