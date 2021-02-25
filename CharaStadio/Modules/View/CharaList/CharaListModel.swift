//
//  CharaListModel.swift
//  CharaStadio
//
//  Created by 山田楓也 on 2021/02/19.
//

import Foundation

protocol CharaListModelProtocol {
    var entity: [CharaEntity] { get }
    var searchResult: [CharaEntity] { get set }
    func loadChara()
    func removeAll()
    func fetchData(completion: @escaping ((Result<Void, Error>) -> Void))
}

class CharaListModel: CharaListModelProtocol {
    private let repository: FirebaseRepositoryProtocol = FirebaseRepository()
    var entity = [CharaEntity]()
    var searchResult = [CharaEntity]()
    
    func loadChara() {
        searchResult = entity
    }
    
    func removeAll() {
        searchResult.removeAll()
    }
    
    func fetchData(completion: @escaping ((Result<Void, Error>) -> Void)) {
        repository.getChara { result in
            switch result {
            case let .success(response):
                self.entity = response
                completion(.success(()))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
