//
//  CustomProtocol.swift
//  BAZProject
//
//  Created by victor manzanero on 09/11/22.
//

import Foundation

@objc protocol CustomProtocol: AnyObject {
    func doneClick()
    @objc optional func cancelClick()
}
