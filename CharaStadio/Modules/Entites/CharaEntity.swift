//
//  CharaEntity.swift
//  CharaStadio
//
//  Created by 山田楓也 on 2021/02/16.
//

import Foundation

struct CharaEntity: Codable {
    var id: Int
    var name: String
    var description: String
    var imageRef: String
    let order: Date
}
