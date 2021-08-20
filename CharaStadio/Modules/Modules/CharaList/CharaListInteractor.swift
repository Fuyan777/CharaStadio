//
//  CharaListInteractor.swift
//  CharaStadio
//
//  Created by 山田楓也 on 2021/08/19.
//

import Foundation

protocol CharaListInteractorInterface: AnyObject {
    func fetchCharaList(_ completion: @escaping ((Result<[CharaEntity], Error>) -> Void))
}

final class CharaListInteractor: CharaListInteractorInterface {
    private let firebaseRepository: FirebaseRepositoryProtocol
    
    init(firebaseRepository: FirebaseRepositoryProtocol) {
        self.firebaseRepository = firebaseRepository
    }
    
    func fetchCharaList(_ completion: @escaping ((Result<[CharaEntity], Error>) -> Void)) {
        firebaseRepository.getChara { completion($0) }
    }
}
