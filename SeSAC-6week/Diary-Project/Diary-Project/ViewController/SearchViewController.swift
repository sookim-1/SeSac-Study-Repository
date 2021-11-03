//
//  SearchViewController.swift
//  Diary-Project
//
//  Created by sookim on 2021/11/03.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = LocalizebleStrings.searchTitle.localized
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        cell.titleLabel.text = "제목"
        cell.dateLabel.text = "2021년 11월 1일"
        cell.contentLabel.text = "내용"
        cell.thumbnailImageView.image = UIImage(systemName: "xmark")
        return cell
    }

}
