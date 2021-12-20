//
//  ViewController.swift
//  beerProject
//
//  Created by sookim on 2021/12/21.
//

import UIKit

class ViewController: UIViewController {

    let logoImageView = UIImageView()
    let beerNameTextField = SearchTextField()
    let callToActionButton = ShareBeerButton(backgroundColor: .systemMint, title: "검색하기")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func presentVC() {
        let beerInfoVC = BeerInformationViewController()
        beerInfoVC.beername = beerNameTextField.text
        beerInfoVC.title = beerNameTextField.text
        beerInfoVC.modalPresentationStyle = .fullScreen
        self.present(beerInfoVC, animated: true, completion: nil)
        
        self.view.endEditing(true)
    }
    
    
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(systemName: "paperplane.fill")
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextField() {
        view.addSubview(beerNameTextField)
        beerNameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            beerNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            beerNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            beerNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            beerNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureCallToActionButton() {
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(presentVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }


}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        presentVC()
        
        return true
    }
}
