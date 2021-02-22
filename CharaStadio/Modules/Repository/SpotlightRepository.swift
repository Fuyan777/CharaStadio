//
//  SpotlightRepository.swift
//  CharaStadio
//
//  Created by 山田楓也 on 2021/02/21.
//

import UIKit
import Firebase
import CoreSpotlight
import MobileCoreServices

protocol SpotlightRepositoryProtocol: AnyObject {
    func saveChara(charaInfo: CharaEntity)
}

final class SpotlightRepository: SpotlightRepositoryProtocol {
    func saveChara(charaInfo: CharaEntity) {
        let attributeSet: CSSearchableItemAttributeSet
        
        if #available(iOS 14.0, *) {
            attributeSet = .init(contentType: .data)
        } else {
            attributeSet = .init(itemContentType: kUTTypeData as String)
        }
        
        let storageRef = Storage.storage().reference(forURL: "gs://charastadio-8cd04.appspot.com/")
        let ref = storageRef.child("\(charaInfo.imageRef).png")
        ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil {
                print("Uh-oh, an error occurred!")
            }
            
            guard let data = data else { return }
            
            attributeSet.title = charaInfo.name
            attributeSet.contentDescription = charaInfo.description
            attributeSet.thumbnailData = data
            attributeSet.keywords = [charaInfo.name, "アイコン"]
            
            let item = CSSearchableItem(
                uniqueIdentifier: "chara://detail?id=\(charaInfo.id)",
                domainIdentifier: "chara",
                attributeSet: attributeSet
            )
            CSSearchableIndex.default().indexSearchableItems([item], completionHandler: nil)
        }
    }
}
