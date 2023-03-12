//
//  OpenIssueTableViewContoller.swift
//  You've Got Issues!
//
//  Created by Jaswitha Reddy G on 2/10/23.
//

import Foundation
import UIKit

struct Issue: Codable {
    let title: String
    let createdAt: String
    let body: String
    let user: String
}

class OpenIssueTableViewController: UITableViewController {
    var openIssues = [Issue]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let openNavBar = self.navigationController!.navigationBar
        let openNavBarAppearance = UINavigationBarAppearance()
        openNavBarAppearance.backgroundColor = UIColor.systemRed
        openNavBar.scrollEdgeAppearance = openNavBarAppearance
        openNavBar.prefersLargeTitles = true
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateFormatterDisplay = DateFormatter()
        dateFormatterDisplay.dateFormat = "MMMM dd, yyyy"
        
        GitHubClient.fetchIssues(
            state: "open",
            completion: {(issues, error) in
                guard let issues = issues, error == nil else {
                    print(error!)
                    return
                }
                for issue in issues {
                    if let title = issue.title, let date = dateFormatter.date(from: issue.createdAt),
                       let body = issue.body {
                        self.openIssues.append(Issue(title: title, createdAt: dateFormatterDisplay.string(from: date), body: body, user: "@"+issue.user.login))
                    }
                }
                self.tableView.reloadData()
            }
        )
    }
    

    @objc func refresh(sender: UIRefreshControl) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateFormatterDisplay = DateFormatter()
        dateFormatterDisplay.dateFormat = "MMMM dd, yyyy"
            
        GitHubClient.fetchIssues(
            state: "open",
            completion: {(issues, error) in
                guard let issues = issues, error == nil else {
                    print(error!)
                    return
                }
                for issue in issues {
                    if let title = issue.title, let date = dateFormatter.date(from: issue.createdAt),
                       let body = issue.body {
                        self.openIssues.append(Issue(title: title, createdAt: dateFormatterDisplay.string(from: date), body: body, user: "@"+issue.user.login))
                    }
                }
                self.tableView.reloadData()
            }
        )
        sender.endRefreshing()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return openIssues.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let openCell = tableView.dequeueReusableCell(withIdentifier: "OpenCell", for: indexPath) as! IssueTableViewCell
        openCell.OpenIssueTitle.text = openIssues[indexPath.row].title
        openCell.OpenIssueUser.text =  openIssues[indexPath.row].user
        openCell.OpenIssueTitle.font = UIFont(name:"Georgia", size: 16.0)
        openCell.OpenIssueUser.textColor = UIColor.gray
        return openCell
    }
            
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let detailViewController = segue.destination as! IssueDetailViewController
            detailViewController.issueType = "open"
            detailViewController.passInData = openIssues[indexPath.row]
        }
    }
}
