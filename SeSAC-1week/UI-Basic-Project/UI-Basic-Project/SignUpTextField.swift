//
//  SignUpTextField.swift
//  UI-Basic-Project
//
//  Created by sookim on 2021/10/30.
//

import UIKit

class SignUpTextField: UITextField {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configure()
    }

    private func configure() {
        textColor = .white

        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [.foregroundColor : UIColor.white])
        backgroundColor = .systemGray
    }

}


