//
//  ClosedIssueTableViewContoller.swift
//  You've Got Issues!
//
//  Created by Jaswitha Reddy G on 2/10/23.
//

import UIKit

class ClosedIssueTableViewController: UITableViewController {
    var closedIssues = [Issue]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let closedNavBar = self.navigationController!.navigationBar
        let closedIssueAppearance = UINavigationBarAppearance()
        closedIssueAppearance.backgroundColor = UIColor.systemGreen
        closedNavBar.scrollEdgeAppearance = closedIssueAppearance
        closedNavBar.prefersLargeTitles = true
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateFormatterDisplay = DateFormatter()
        dateFormatterDisplay.dateFormat = "MMMM dd, yyyy"

        GitHubClient.fetchIssues(
            state: "closed",
            completion: {(issues, error) in
                guard let issues = issues, error == nil else {
                    print(error!)
                    return
                }
                for issue in issues {
                    if let title = issue.title, let date = dateFormatter.date(from: issue.createdAt),
                       let body = issue.body {
                        self.closedIssues.append(Issue(title: title, createdAt: dateFormatterDisplay.string(from: date), body: body, user: "@"+issue.user.login))
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
                        self.closedIssues.append(Issue(title: title, createdAt: dateFormatterDisplay.string(from: date), body: body, user: "@"+issue.user.login))
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
        return closedIssues.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClosedCell", for: indexPath) as! IssueTableViewCell
        cell.ClosedIssueTitle.text = closedIssues[indexPath.row].title
        cell.ClosedIssueUser.text =  closedIssues[indexPath.row].user
        cell.ClosedIssueTitle.font = UIFont(name:"Georgia", size: 16.0)
        cell.ClosedIssueUser.textColor = UIColor.gray

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let detailViewController = segue.destination as! IssueDetailViewController
            detailViewController.passInData = closedIssues[indexPath.row]
            detailViewController.issueType = "closed"
        }
    }
}
