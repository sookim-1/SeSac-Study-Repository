//
//  SettingTableViewController.swift
//  iOS-TableViewController
//
//  Created by sookim on 2021/11/08.
//

import UIKit

class SettingTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "전체 설정"
        } else if section == 1 {
            return "개인 설정"
        } else {
            return "기타"
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else if section == 1 {
            return 4
        } else {
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell") else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "공지사항"
            case 1:
                cell.textLabel?.text = "실험실"
            case 2:
                cell.textLabel?.text = "버전정보"
            default:
                cell.textLabel?.text = "데이터 없음"
            }
        } else if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "개인/보안"
            case 1:
                cell.textLabel?.text = "알림"
            case 2:
                cell.textLabel?.text = "채팅"
            case 3:
                cell.textLabel?.text = "멀티프로필"
            default:
                cell.textLabel?.text = "데이터 없음"
            }
        } else if indexPath.section == 2 {
            cell.textLabel?.text = "고객센터/도움말"
        }
        
        return cell
    }
    

}
