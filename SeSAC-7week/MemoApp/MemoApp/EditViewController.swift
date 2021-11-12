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
    var memos: [Memo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoTextView.text = "\(titleText!)"
        memoTextView.autocorrectionType = .no
        let editButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(editMemo))
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareMemo))
        self.navigationItem.rightBarButtonItems = [editButton, shareButton]
    }

    override func becomeFirstResponder() -> Bool {
        return memoTextView.becomeFirstResponder()
    }
    
    @objc func editMemo() {
        if memoTextView.text.contains("\n") {
            var memoText = memoTextView.text.components(separatedBy: "\n")
            
            for i in 1..<memoText.count {
                memoText[1] += memoText[i]
            }
            let memo = Memo(title: memoText[0], body: memoText[1], writeDate: Date())
            Memo.memoList.append(memo)
        }
        else {
            let memo = Memo(title: memoTextView.text, body: "", writeDate: Date())
            Memo.memoList.append(memo)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func shareMemo() {
        guard let shareButton = self.navigationItem.rightBarButtonItem else { return }
        detailActionSheet(shareButton)
    }
    
    private func detailActionSheet(_ sender: UIBarButtonItem) {
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let shareAction = UIAlertAction(title: "Share..", style: .default) { (action) in
            self.presentShareSheet(sender)
        }
             
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(shareAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }
    
    private func presentShareSheet(_ sender: UIBarButtonItem) {
        guard let sendText = self.memoTextView.text else { return }
        
        let shareSheetViewController = UIActivityViewController(activityItems: [sendText], applicationActivities: nil)
        
        present(shareSheetViewController, animated: true)
    }
}
