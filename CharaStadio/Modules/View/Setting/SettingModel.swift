//
//  SettingModel.swift
//  CharaStadio
//
//  Created by 山田楓也 on 2021/02/18.
//

import Foundation
import UIKit

protocol SettingModelProtocol {
    var tableSection: [SettingContentType] { get }
}

final class SettingModel: SettingModelProtocol {
    private(set) var tableSection = SettingContentType.allCases
    
}

enum SettingContentType: Int, CaseIterable {
    case app, other
    
    var title: String {
        switch self {
        case .app: return "アプリについて"
        case .other: return "その他"
        }
    }
    
    var appRows: [TableAppRow] { TableAppRow.allCases }
    var otherRows: [TableOtherRow] { TableOtherRow.allCases }
    
    var rowCount: Int {
        switch self {
        case .app: return appRows.count
        case .other: return otherRows.count
        }
    }
    
    func rowTitle(rowIndex: Int) -> String {
        switch self {
        case .app: return appRows[rowIndex].title
        case .other: return otherRows[rowIndex].title
        }
    }
    
    func rowIconImage(rowIndex: Int) -> UIImage? {
        switch self {
        case .app: return appRows[rowIndex].image
        case .other: return otherRows[rowIndex].image
        }
    }
    
    // MARK: Row
    
    enum TableAppRow: Int, CaseIterable {
        case request, appReview, appShare
        
        var title: String {
            switch self {
            case .request: return "お問い合わせ"
            case .appReview: return "アプリを評価"
            case .appShare: return "アプリをシェア"
            }
        }
        
        var image: UIImage? {
            switch self {
            case .request: return UIImage(systemName: "chevron.right")
            case .appReview: return UIImage(systemName: "chevron.right")
            case .appShare: return UIImage(systemName: "chevron.right")
            }
        }
    }
    
    enum TableOtherRow: Int, CaseIterable {
        case privacyPolicy, version
        
        var title: String {
            switch self {
            case .privacyPolicy: return "プライバシーポリシー"
            case .version: return "version \(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String)(\(Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String))"
            }
        }
        
        var image: UIImage? {
            switch self {
            case .privacyPolicy: return UIImage(systemName: "chevron.right")
            case .version: return nil
            }
        }
    }
}

