//
//  ViewController.swift
//  MemoApp
//
//  Created by sookim on 2021/11/08.
//

import UIKit

class MemoListViewController: UITableViewController {
    var memos = [Memo]()
    var filteredMemos = [Memo]()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "메모갯수"
        navigationController?.navigationBar.prefersLargeTitles = true
        configureSearchController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let firstLaunch = FirstLaunch(userDefaults: .standard, key: "firstLaunchKey")
        if firstLaunch.isFirstLaunch {
            presentPopUpViewController()
        }
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "검색"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func searchBarIsEmpty() -> Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
      
    func filterContentForSearchText(_ searchText: String) {
      filteredMemos = memos.filter({( memo : Memo) -> Bool in
        return memo.title.lowercased().contains(searchText.lowercased())
      })

      tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
      return searchController.isActive && !searchBarIsEmpty()
    }
    
    func presentPopUpViewController() {
        let popUpStoryboard = UIStoryboard(name: "PopUp", bundle: nil)
        let popUpViewController = popUpStoryboard.instantiateViewController(withIdentifier: "PopUpViewController")
        
        popUpViewController.modalTransitionStyle = .crossDissolve
        popUpViewController.modalPresentationStyle = .overFullScreen
        
        self.present(popUpViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "고정된 메모" : "메모"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering() ? filteredMemos.count : memos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MemoListCell", for: indexPath) as? MemoListCell else { return UITableViewCell() }
        let memo: Memo
        isFiltering() ? (memo = filteredMemos[indexPath.row]) : (memo = memos[indexPath.row])
        
        cell.titleLabel.text = memo.title
        cell.bodyLabel.text = memo.body
        cell.dateLabel.text = memo.writeDate
        
        return cell
    }
    
    @IBAction func presentEditViewController(_ sender: UIBarButtonItem) {
        let editStoryboard = UIStoryboard(name: "Edit", bundle: nil)
        let editViewController = editStoryboard.instantiateViewController(withIdentifier: "EditViewController")
        
        self.navigationController?.pushViewController(editViewController, animated: true)
    }
    
}

extension MemoListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
