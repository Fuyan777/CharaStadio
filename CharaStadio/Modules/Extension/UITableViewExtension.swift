//
//  UITableViewExtension.swift
//  CharaStadio
//
//  Created by 山田楓也 on 2021/02/18.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type) {
        let className = cellType.className
        register(cellType, forCellReuseIdentifier: className)
    }

    func register<T: UITableViewCell>(cellTypes: [T.Type]) {
        cellTypes.forEach { register(cellType: $0) }
    }

    func registerNib<T: UITableViewCell>(cellType: T.Type) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forCellReuseIdentifier: className)
    }

    func registerNib<T: UITableViewCell>(cellTypes: [T.Type]) {
        cellTypes.forEach { registerNib(cellType: $0) }
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.className, for: indexPath) as? T else {
            return T()
        }
        return cell
    }

    func dequeueReusableCell<T: UITableViewCell>() -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.className) as? T else {
            return T()
        }
        return cell
    }

    func dequeueReusableView<T: UITableViewHeaderFooterView>() -> T {
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: T.className) as? T else {
            return T()
        }
        return cell
    }

    public func scrollToTop(animated: Bool = true) {
        setContentOffset(CGPoint.zero, animated: animated)
    }

    public func scrollToBottom(animated: Bool = true) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        setContentOffset(bottomOffset, animated: animated)
    }
}
