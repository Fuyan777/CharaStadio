//
//  UserDefaultsClient.swift
//  CharaStadio
//
//  Created by 山田楓也 on 2021/02/22.
//

import Foundation

final class UserDefaultsClient {
    private let userDefaults = UserDefaults.standard
    
    func removeAll() {
        self.userDefaults.dictionaryRepresentation().keys.forEach { self.userDefaults.removeObject(forKey: $0)
        }
    }
}

extension UserDefaultsClient {
    
    func loadChara(key: String) -> CharaEntity? {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let data = self.userDefaults.data(forKey: key),
              let chara = try? jsonDecoder.decode(CharaEntity.self, from: data) else {
            return nil
        }
        return chara
    }
    
    func saveChara(_ chara: CharaEntity, forkey key: String) {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
        
        if userDefaults.object(forKey: key) != nil { return }
        
        guard let data = try? jsonEncoder.encode(chara) else {
            return
        }
        self.userDefaults.set(data, forKey: key)
    }
}
