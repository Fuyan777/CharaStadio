//
//  UICollectionViewExtension.swift
//  CharaStadio
//
//  Created by 山田楓也 on 2021/02/16.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(cellType: T.Type) {
        let className = cellType.className
        register(cellType, forCellWithReuseIdentifier: className)
    }

    func register<T: UICollectionViewCell>(cellTypes: [T.Type]) {
        cellTypes.forEach { register(cellType: $0) }
    }

    func registerNib<T: UICollectionViewCell>(cellType: T.Type) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forCellWithReuseIdentifier: className)
    }

    func registerNib<T: UICollectionViewCell>(cellTypes: [T.Type]) {
        cellTypes.forEach { registerNib(cellType: $0) }
    }

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.className, for: indexPath) as? T else {
            return T()
        }
        return cell
    }

    func dequeueReusableView<T: UICollectionReusableView>(for indexPath: IndexPath, of kind: String = UICollectionView.elementKindSectionHeader) -> T {
        guard let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.className, for: indexPath) as? T else {
            return T()
        }
        return view
    }
}
