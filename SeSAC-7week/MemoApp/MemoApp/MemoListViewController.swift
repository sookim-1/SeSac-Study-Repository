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
        
        setNavigationBar()

        configureSearchController()

        guard let data = UserDefaults.standard.value(forKey: "memos") as? Data else { return }
        Memo.memoList = try! PropertyListDecoder().decode([Memo].self, from: data)
        memos.sorted { $0.title < $1.title }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        countMemo()
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(Memo.memoList), forKey: "memos")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let firstLaunch = FirstLaunch(userDefaults: .standard, key: "firstLaunchKey")
        if firstLaunch.isFirstLaunch {
            presentPopUpViewController(mainTitle: "처음 오셨군요!\n환영합니다 :)", subTitle: "당신만의 메모를 작성하고 관리해보세요!")
        }
    }
    
    func setNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .systemOrange
        navigationController?.navigationBar.backgroundColor = .darkGray
    }
    
    func countMemo() {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        var memoCount: Int
        isFiltering() ? (memoCount = filteredMemos.count) : (memoCount = fixMemos.count + Memo.memoList.count)
        guard let result = numberFormatter.string(for: memoCount) else { return }
        title = "\(result)개의 메모"
    }
    
    func presentPopUpViewController(mainTitle: String, subTitle: String) {
        let popUpStoryboard = UIStoryboard(name: "PopUp", bundle: nil)
        guard let popUpViewController = popUpStoryboard.instantiateViewController(withIdentifier: "PopUpViewController") as? PopUpViewController else { return }
        
        popUpViewController.modalTransitionStyle = .crossDissolve
        popUpViewController.modalPresentationStyle = .overFullScreen
        popUpViewController.mainTitle = mainTitle
        popUpViewController.subTitle = subTitle
        
        self.present(popUpViewController, animated: true)
    }
    
    @IBAction func presentEditViewController(_ sender: UIBarButtonItem) {
        let editStoryboard = UIStoryboard(name: "Edit", bundle: nil)
        guard let editViewController = editStoryboard.instantiateViewController(withIdentifier: "EditViewController") as? EditViewController else { return }
        editViewController.titleText = ""
        
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
        return isFiltering() ? filteredMemos.count : Memo.memoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MemoListCell", for: indexPath) as? MemoListCell else { return UITableViewCell() }

        let memo: Memo
        
        if indexPath.section == 0 {
            memo = fixMemos[indexPath.row]
        }
        else {
            isFiltering() ? (memo = filteredMemos[indexPath.row]) : (memo = Memo.memoList[indexPath.row])
        }
        cell.titleLabel.text = memo.title
        cell.bodyLabel.text = memo.body
        cell.dateLabel.text = getDateFormmater(writeDate: memo.writeDate)
        
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
            if isFiltering() {
                memo = filteredMemos[indexPath.row]

                let backBarButtonItem = UIBarButtonItem(title: "검색", style: .plain, target: self, action: nil)
                self.navigationItem.backBarButtonItem = backBarButtonItem
            } else {
                memo = Memo.memoList[indexPath.row]
                let backBarButtonItem = UIBarButtonItem(title: "메모", style: .plain, target: self, action: nil)
                self.navigationItem.backBarButtonItem = backBarButtonItem
            }
        }
        editViewController.titleText = "\(memo.title)\n\n\(memo.body)"
        
        self.navigationController?.pushViewController(editViewController, animated: true)
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "삭제") { (action, view, completionHandler ) in
            let defaultAction = UIAlertAction(title: "삭제",
                                              style: .destructive) { (action) in
                indexPath.section == 0 ? self.fixMemos.remove(at: indexPath.row) : Memo.memoList.remove(at: indexPath.row)
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
        action.image = UIImage(systemName: "trash.fill")

        return UISwipeActionsConfiguration(actions: [action])
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: nil) { (action, view, completionHandler ) in
            
            if indexPath.section == 0 {
                Memo.memoList.append(self.fixMemos[indexPath.row])
                self.fixMemos.remove(at: indexPath.row)
            }
            else {
                if self.fixMemos.count >= 5 {
                    self.presentPopUpViewController(mainTitle: "최대 고정갯수는 5개입니다", subTitle: "확인해주세요!")
                }
                else {
                    self.fixMemos.append(Memo.memoList[indexPath.row])
                    Memo.memoList.remove(at: indexPath.row)
                }
            }
            tableView.reloadData()
            completionHandler(true)
        }
        
        action.backgroundColor = .systemOrange
        
        if indexPath.section == 0 {
            action.image = UIImage(systemName: "pin.slash.fill")
        } else {
            action.image = UIImage(systemName: "pin.fill")
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 20, y: 8, width: 320, height: 20)
        myLabel.font = UIFont.boldSystemFont(ofSize: 30)
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)

        let headerView = UIView()
        headerView.addSubview(myLabel)

        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func getDateFormmater(writeDate: Date) -> String {
        let dateFormatter = DateFormatter()
        let now = writeDate
        dateFormatter.locale = Locale(identifier: "ko_KR")
        switch now {
        case ..<Date(timeInterval: 86400, since: now):
            dateFormatter.dateFormat = "a HH:mm"
        case Date(timeInterval: 86400, since: now)..<Date(timeInterval: 604800, since: now):
            dateFormatter.dateFormat = "EEE"
        default:
            dateFormatter.dateFormat = "yyyy. MM. dd. a HH:mm"
        }
        
        return dateFormatter.string(from: writeDate)
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
      filteredMemos = Memo.memoList.filter({( memo : Memo) -> Bool in
          if memo.title.lowercased().contains(searchText.lowercased()) || memo.body.lowercased().contains(searchText.lowercased()) {
              return true
          }
          else {
              return false
          }
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
