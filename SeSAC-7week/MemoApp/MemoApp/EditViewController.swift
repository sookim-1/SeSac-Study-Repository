//
//  EditViewController.swift
//  MemoApp
//
//  Created by sookim on 2021/11/10.
//

import UIKit

class EditViewController: UIViewController {

    @IBOutlet weak var memoTextView: UITextView!
    var titleText: String?
    var bodyText: String?
    var writeDateText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoTextView.text = "\(titleText) + \(bodyText) + \(writeDateText)"
    }

}
