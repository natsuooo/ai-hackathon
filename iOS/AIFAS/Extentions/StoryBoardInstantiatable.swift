//
//  StoryBoardInstantiatable.swift
//  AIFAS
//
//  Created by 冨平準喜 on 2021/06/14.
//

import Foundation
import UIKit

protocol Instantiatable {
    static var storyboardName: String { get }
}

extension Instantiatable where Self: UIViewController {
    static var storyboardName: String {
        return ""
    }

    private static var _storyboardName: String {
        if storyboardName.isEmpty {
            return className
        } else {
            return storyboardName
        }
    }

    private static var storyboard: UIStoryboard {
        return UIStoryboard.init(name: _storyboardName, bundle: nil)
    }

    private static var className: String {
        return String(describing: Self.self)
    }

    static func instantiateFromStoryboard() -> Self {
        guard let vc = storyboard.instantiateInitialViewController() as? Self else {
            fatalError("Can no instantiate \(Self.className) from \(storyboardName).storyboard")
        }
        return vc
    }

    static func instantiateFromStoryboard(withIdentifier id: String) -> Self {
        guard let vc = storyboard.instantiateViewController(withIdentifier: id) as? Self else {
            fatalError("Can no instantiate \(Self.className) from \(storyboardName).storyboard with id: \(id)")
        }
        return vc
    }
}
