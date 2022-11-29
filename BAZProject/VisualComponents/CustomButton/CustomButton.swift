//
//  CustomButton.swift
//  BAZProject
//
//  Created by victor manzanero on 09/11/22.
//

import UIKit

class CustomButton: UIButton {
    
    @IBInspectable public var buttonStyle: Int = 0 {
        didSet {
            style = CustomButtonStyle(rawValue: buttonStyle) ?? .none
        }
    }
    
    public var style: CustomButtonStyle = CustomButtonStyle.none {
        didSet {
            loadStyle()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        loadStyle()
    }
    
    func loadStyle() {
        self.layer.cornerRadius = 10
        self.setTitleColor(.white, for: .normal)
        switch style {
        case .none:
            break
        case .primary:
            self.backgroundColor = .blue
        case .secundary:
            self.backgroundColor = .red
        case .optional:
            self.backgroundColor = .green
        case .other:
            self.backgroundColor = .yellow
        }
    }
}
