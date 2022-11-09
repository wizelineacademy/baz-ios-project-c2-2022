//
//  CustomAlertViewController.swift
//  BAZProject
//
//  Created by victor manzanero on 09/11/22.
//

import UIKit

class CustomAlertViewController: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var imgAlert: UIImageView!
    @IBOutlet weak var lblBody: UILabel!
    @IBOutlet weak var mainContent: UIView!
    
    var alertStyle: CustomStyle?
    weak var customAlertDelegate: CustomProtocol?
    var bodyText:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservablesAction()
        config()
    }
    
    func config() {
        self.mainContent.layer.cornerRadius = 10
        if let style = self.alertStyle, let body = self.bodyText {
            self.lblTitle.text = style.title
            self.lblBody.text = body
            switch style {
            case .error:
                self.imgAlert.image = UIImage(systemName: "person.fill.xmark")
                self.btnCancel.isHidden = true
            case .alert:
                self.imgAlert.image = UIImage(systemName: "exclamationmark.triangle.fill")
                self.btnCancel.isHidden = true
            case .confirm:
                self.imgAlert.image = UIImage(systemName: "person.crop.circle.badge.questionmark")
            }
        }
    }
    
    private func setupObservablesAction() {
        self.btnDone.reactive.tap.observeNext { [weak self] in
            if let delegate = self?.customAlertDelegate {
                delegate.doneClick()
            } else  {
                self?.dismiss(animated: true)
            }
        }.dispose(in: bag)
        
        self.btnCancel.reactive.tap.observeNext { [weak self] in
            if let delegate = self?.customAlertDelegate, let event = delegate.cancelClick {
                event()
            } else {
                self?.dismiss(animated: true)
            }
        }.dispose(in: bag)
    }
}
