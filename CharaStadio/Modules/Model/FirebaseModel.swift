//
//  FirebaseModel.swift
//  CharaStadio
//
//  Created by 山田楓也 on 2021/02/16.
//

import Firebase
import FirebaseUI

protocol FirebaseModelProtocol {
    func getChara(_ completion: @escaping (Result<[CharaEntity], Error>) -> Void)
}

class FirebaseModel: FirebaseModelProtocol {
    let charaRef = Firestore.firestore().collection("Chara")
    func getChara(_ completion: @escaping (Result<[CharaEntity], Error>) -> Void) {
        charaRef.getDocuments { querySnapshot, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let querySnapshot = querySnapshot else {
                fatalError("Fail to unwrap `querySnapshot`.")
            }

            var charaList: [CharaEntity] = []
            for document in querySnapshot.documents {
                let charaInfo = document.data()
                guard let name = charaInfo["name"] as? String,
                      let description = charaInfo["description"] as? String,
                      let imageRef = charaInfo["image_ref"] as? String else {
                    continue
                }
                
                charaList.append(CharaEntity(name: name, description: description, imageRef: imageRef, order: Date()))
            }
            
            completion(.success(charaList))
        }
    }
}
