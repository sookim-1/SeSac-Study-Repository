//
//  ViewController.swift
//  MemoApp
//
//  Created by sookim on 2021/11/08.
//

import UIKit

class MemoListViewController: UITableViewController {
    var memos = [Memo]()
    var fixMemos = [Memo]()
    var filteredMemos = [Memo]()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        configureSearchController()
        memos = [
                    Memo(title: "1", body: "a", writeDate: "q"),
                    Memo(title: "2", body: "b", writeDate: "q"),
                    Memo(title: "3", body: "c", writeDate: "q"),
                    Memo(title: "4", body: "d", writeDate: "q"),
                    Memo(title: "5", body: "e", writeDate: "q")
                ]
        countMemo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let firstLaunch = FirstLaunch(userDefaults: .standard, key: "firstLaunchKey")
        if firstLaunch.isFirstLaunch {
            presentPopUpViewController()
        }
    }
    
    func countMemo() {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        var memoCount: Int
        isFiltering() ? (memoCount = filteredMemos.count) : (memoCount = fixMemos.count + memos.count)
        guard let result = numberFormatter.string(for: memoCount) else { return }
        title = "\(result)개의 메모"
    }
    
    func presentPopUpViewController() {
        let popUpStoryboard = UIStoryboard(name: "PopUp", bundle: nil)
        let popUpViewController = popUpStoryboard.instantiateViewController(withIdentifier: "PopUpViewController")
        
        popUpViewController.modalTransitionStyle = .crossDissolve
        popUpViewController.modalPresentationStyle = .overFullScreen
        
        self.present(popUpViewController, animated: true)
    }
    
    @IBAction func presentEditViewController(_ sender: UIBarButtonItem) {
        let editStoryboard = UIStoryboard(name: "Edit", bundle: nil)
        let editViewController = editStoryboard.instantiateViewController(withIdentifier: "EditViewController")
        
        self.navigationController?.pushViewController(editViewController, animated: true)
    }
    
}

//MARK: - 테이블뷰 코드
extension MemoListViewController {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "고정된 메모" : "메모"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return fixMemos.count
        }
        return isFiltering() ? filteredMemos.count : memos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MemoListCell", for: indexPath) as? MemoListCell else { return UITableViewCell() }

        let memo: Memo
        
        if indexPath.section == 0 {
            memo = fixMemos[indexPath.row]
        }
        else {
            isFiltering() ? (memo = filteredMemos[indexPath.row]) : (memo = memos[indexPath.row])
        }
        cell.titleLabel.text = memo.title
        cell.bodyLabel.text = memo.body
        cell.dateLabel.text = memo.writeDate
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editStoryboard = UIStoryboard(name: "Edit", bundle: nil)
        guard let editViewController = editStoryboard.instantiateViewController(withIdentifier: "EditViewController") as? EditViewController else { return }
        let memo: Memo
        if indexPath.section == 0 {
            memo = fixMemos[indexPath.row]
        }
        else {
            isFiltering() ? (memo = filteredMemos[indexPath.row]) : (memo = memos[indexPath.row])
        }
        editViewController.titleText = memo.title
        editViewController.bodyText = memo.body
        editViewController.writeDateText = memo.writeDate
        
        self.navigationController?.pushViewController(editViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "삭제") { (action, view, completionHandler ) in
            let defaultAction = UIAlertAction(title: "삭제",
                                              style: .destructive) { (action) in
                self.memos.remove(at: indexPath.row)
                self.tableView.reloadData()
            }
            let cancelAction = UIAlertAction(title: "취소",
                                             style: .cancel) { (action) in
            }

            let alert = UIAlertController(title: "진짜요?",
                  message: "정말로 삭제하시겠어요?",
                  preferredStyle: .alert)
            alert.addAction(defaultAction)
            alert.addAction(cancelAction)

            self.present(alert, animated: true, completion: nil)
            completionHandler(true)
        }

        return UISwipeActionsConfiguration(actions: [action])
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "고정") { (action, view, completionHandler ) in
            
            if indexPath.section == 0 {
                self.memos.append(self.fixMemos[indexPath.row])
                self.fixMemos.remove(at: indexPath.row)
            }
            else {
                self.fixMemos.append(self.memos[indexPath.row])
                self.memos.remove(at: indexPath.row)
            }
            tableView.reloadData()
            completionHandler(true)
        }

        return UISwipeActionsConfiguration(actions: [action])
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

//MARK: - 검색기능 코드
extension MemoListViewController: UISearchResultsUpdating {
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
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
