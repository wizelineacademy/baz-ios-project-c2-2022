//
//  CustomProtocol.swift
//  BAZProject
//
//  Created by victor manzanero on 09/11/22.
//

import Foundation

protocol DoneCustomAlertProtocol: AnyObject {
    func doneClick()
}

protocol CancelCustomAlertProtocol: AnyObject {
    func cancelClick()
}
