//
//  CharaPostModel.swift
//  CharaStadio
//
//  Created by 山田楓也 on 2021/03/02.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class CharaPostModel {
    enum FormType: Int, CaseIterable {
        case image, text, button
    }
    
    let firebaseModel = FirebaseRepository()
    let tableSection = FormType.allCases
    private(set) var parameter: CharaPostParameter = CharaPostParameter()
    
    func updateNameParameter(name: String) {
        self.parameter.name = name
    }
    
    func updateDescriptionParameter(description: String) {
        self.parameter.description = description
    }
    
    func updateImageParameter(image: UIImage) {
        self.parameter.image = image
    }
    
    func postChara(parameter: CharaPostParameter, completion: @escaping (Result<Void, Error>) -> Void) {
        firebaseModel.postChara(parameter: parameter) { result in
            switch result {
            case .success:
                completion(.success(()))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
