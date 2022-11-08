//
//  Storyboarded.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 07/11/22.
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self?
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self? {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: id) as? Self
    }
}
