//
//  IssueDetailViewContoller.swift
//  You've Got Issues!
//
//  Created by Jaswitha Reddy G on 2/10/23.
//

import UIKit

class IssueDetailViewController: UIViewController {
    
    var passInData: Issue?
    var issueType: String?
    @IBOutlet var gitTitle: UILabel!
    @IBOutlet var gitImage: UIImageView!
    @IBOutlet var gitAuthor: UILabel!
    @IBOutlet var gitDate: UILabel!
    @IBOutlet var gitDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gitTitle.numberOfLines = 0
        gitTitle.lineBreakMode = NSLineBreakMode.byWordWrapping
        gitTitle.text = passInData?.title
        gitTitle.font = UIFont(name:"Georgia", size: 25.0)
        
        let font1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)]
        let font2 = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]
        
        let boldText = "Author: "
        let attributedString = NSMutableAttributedString(string: boldText, attributes: font1)
        let normalText = "\(passInData?.user ?? "")"
        let normalString = NSMutableAttributedString(string: normalText, attributes: font2)
        attributedString.append(normalString)
        gitAuthor.attributedText = attributedString
        
        let boldText2 = "Date: "
        let attributedString2 = NSMutableAttributedString(string: boldText2, attributes: font1)
        let normalText2 = "\(passInData?.createdAt ?? "")"
        let normalString2 = NSMutableAttributedString(string: normalText2, attributes: font2)
        attributedString2.append(normalString2)
        gitDate.attributedText = attributedString2
        
        gitDescription.text = passInData?.body
        
        if let type = issueType {
            if type == "open" {
                gitImage.image = UIImage(systemName: "envelope.open.fill")
                gitImage.tintColor = UIColor.systemRed
            } else {
                gitImage.image = UIImage(systemName: "checkmark.square.fill")
                gitImage.tintColor = UIColor.systemGreen
            }
        }
    }
}
