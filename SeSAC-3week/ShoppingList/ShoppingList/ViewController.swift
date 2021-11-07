//
//  ViewController.swift
//  ShoppingList
//
//  Created by sookim on 2021/11/08.
//

import UIKit

class ViewController: UITableViewController {
    @IBOutlet weak var buyTextField: UITextField!
    
    var shoppingList: [String] = ["그립톡 구매하기", "사이다 구매", "아이패드 케이스 최저가 알아보기", "양말"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListCell", for: indexPath) as? ShoppingListCell else { return UITableViewCell() }
        
        cell.contentLabel.text = shoppingList[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            shoppingList.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    @IBAction func addShoppingList(_ sender: UIButton) {
        shoppingList.append(buyTextField.text!)
        tableView.reloadData()
    }
}

