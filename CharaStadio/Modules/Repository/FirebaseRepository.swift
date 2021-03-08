//
//  FirebaseRepository.swift
//  CharaStadio
//
//  Created by 山田楓也 on 2021/02/16.
//

import FirebaseFirestore
import FirebaseStorage
import FirebaseUI
import UIKit

protocol FirebaseRepositoryProtocol {
    func getChara(_ completion: @escaping (Result<[CharaEntity], Error>) -> Void)
    func postChara(parameter: CharaPostParameter, completion: @escaping (Result<Void, Error>) -> Void)
}

class FirebaseRepository: FirebaseRepositoryProtocol {
    private let charaRef = Firestore.firestore().collection("Chara")
    private let storageRef = Storage.storage().reference(forURL: "gs://charastadio-8cd04.appspot.com/")
    
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
                guard let id = charaInfo["id"] as? Int,
                      let name = charaInfo["name"] as? String,
                      let description = charaInfo["description"] as? String,
                      let imageRef = charaInfo["image_ref"] as? String else {
                    continue
                }
                
                charaList.append(CharaEntity(id: id, name: name, description: description, imageRef: imageRef, order: Date()))
            }
            
            completion(.success(charaList))
        }
    }
    
    func postChara(parameter: CharaPostParameter, completion: @escaping (Result<Void, Error>) -> Void) {
        let imageRef = storageRef.child("\(parameter.name).png")
        let data: [String: Any] = [
            "id": 50,
            "name": parameter.name,
            "description": parameter.description,
            "image_ref": parameter.name,
            "order": Date()
        ]
        
        guard let imageData = parameter.image.pngData() else { return }
        let meta = StorageMetadata()
        meta.contentType = "image/png"
        imageRef.putData(imageData, metadata: meta) { metadata, error in
            if let error = error {
                print("Error putData: \(error)")
            }
            guard let metadata = metadata else { return }
            
            self.charaRef.addDocument(data: data) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                    completion(.failure(err))
                } else {
                    print("success")
                    completion(.success(()))
                }
            }
        }
    }
    
}
