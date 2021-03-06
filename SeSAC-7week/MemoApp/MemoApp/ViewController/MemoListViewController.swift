//
//  ViewController.swift
//  MemoApp
//
//  Created by sookim on 2021/11/08.
//

import UIKit

class MemoListViewController: UITableViewController {
    private var filteredMemos = [Memo]()
    private let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()

        configureSearchController()

        guard let data = UserDefaults.standard.value(forKey: "memos") as? Data else { return }
        Memo.memoList = try! PropertyListDecoder().decode([Memo].self, from: data)
        guard let fixData = UserDefaults.standard.value(forKey: "fixmemos") as? Data else { return }
        Memo.fixMemoList = try! PropertyListDecoder().decode([Memo].self, from: fixData)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        countMemo()
        Memo.memoList = Memo.memoList.sorted { $0.writeDate > $1.writeDate }
        Memo.fixMemoList = Memo.fixMemoList.sorted { $0.writeDate > $1.writeDate }
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(Memo.memoList), forKey: "memos")
        UserDefaults.standard.set(try? PropertyListEncoder().encode(Memo.fixMemoList), forKey: "fixmemos")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let firstLaunch = FirstLaunch(userDefaults: .standard, key: "firstLaunchKey")
        if firstLaunch.isFirstLaunch {
            presentPopUpViewController(mainTitle: "처음 오셨군요!\n환영합니다 :)", subTitle: "당신만의 메모를 작성하고 관리해보세요!")
        }
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .systemOrange
        navigationController?.navigationBar.backgroundColor = .darkGray
    }
    
    private func countMemo() {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        var memoCount: Int
        isFiltering() ? (memoCount = filteredMemos.count) : (memoCount = Memo.fixMemoList.count + Memo.memoList.count)
        guard let result = numberFormatter.string(for: memoCount) else { return }
        title = "\(result)개의 메모"
    }
    
    private func presentPopUpViewController(mainTitle: String, subTitle: String) {
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
        if isFiltering() {
            return "\(filteredMemos.count)개 찾음"
        }
        else {
            return section == 0 ? "고정된 메모" : "메모"
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return isFiltering() ? 1 : 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredMemos.count
        }
        else {
            return section == 0 ? Memo.fixMemoList.count : Memo.memoList.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MemoListCell", for: indexPath) as? MemoListCell else { return UITableViewCell() }

        let memo: Memo
        if isFiltering() {
            memo = filteredMemos[indexPath.row]
        }
        else {
            indexPath.section == 0 ? (memo = Memo.fixMemoList[indexPath.row]) : (memo = Memo.memoList[indexPath.row])
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
        
        if isFiltering() {
            memo = filteredMemos[indexPath.row]

            let backBarButtonItem = UIBarButtonItem(title: "검색", style: .plain, target: self, action: nil)
            self.navigationItem.backBarButtonItem = backBarButtonItem
        } else {
            indexPath.section == 0 ? (memo = Memo.fixMemoList[indexPath.row]) : (memo = Memo.memoList[indexPath.row])
        }
        
        let backBarButtonItem = UIBarButtonItem(title: "메모", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        
        editViewController.titleText = "\(memo.title)\n\n\(memo.body)"
        editViewController.indexPathRow = indexPath
        
        self.navigationController?.pushViewController(editViewController, animated: true)
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "삭제") { (action, view, completionHandler ) in
            let defaultAction = UIAlertAction(title: "삭제",
                                              style: .destructive) { (action) in
                indexPath.section == 0 ? Memo.fixMemoList.remove(at: indexPath.row) : Memo.memoList.remove(at: indexPath.row)
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
                Memo.memoList.append(Memo.fixMemoList[indexPath.row])
                Memo.fixMemoList.remove(at: indexPath.row)
            }
            else {
                if Memo.fixMemoList.count >= 5 {
                    self.presentPopUpViewController(mainTitle: "최대 고정갯수는 5개입니다", subTitle: "확인해주세요!")
                }
                else {
                    Memo.fixMemoList.append(Memo.memoList[indexPath.row])
                    Memo.memoList.remove(at: indexPath.row)
                }
            }
            
            Memo.memoList = Memo.memoList.sorted { $0.writeDate > $1.writeDate }
            Memo.fixMemoList = Memo.fixMemoList.sorted { $0.writeDate > $1.writeDate }
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
        myLabel.font = UIFont.boldSystemFont(ofSize: 20)
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)

        let headerView = UIView()
        headerView.addSubview(myLabel)

        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    private func getDateFormmater(writeDate: Date) -> String {
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
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "검색"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func searchBarIsEmpty() -> Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
      
    private func filterContentForSearchText(_ searchText: String) {
        let tempFilterMemos = Memo.fixMemoList + Memo.memoList
      filteredMemos = tempFilterMemos.filter({( memo : Memo) -> Bool in
          if memo.title.lowercased().contains(searchText.lowercased()) || memo.body.lowercased().contains(searchText.lowercased()) {
              

              
              return true
          }
          else {
              return false
          }
      })
    
      tableView.reloadData()
    }
    
    private func isFiltering() -> Bool {
      return searchController.isActive && !searchBarIsEmpty()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
