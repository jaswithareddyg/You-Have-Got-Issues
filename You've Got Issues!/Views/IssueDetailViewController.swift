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
        
        // formatting git title and passing data
        gitTitle.numberOfLines = 0
        gitTitle.lineBreakMode = NSLineBreakMode.byWordWrapping
        gitTitle.text = passInData?.title
        gitTitle.font = UIFont(name:"Georgia", size: 25.0)
        
        // image to display based on issuetype
        if let type = issueType {
            if type == "open" {
                gitImage.image = UIImage(systemName: "envelope.open.fill")
                gitImage.tintColor = UIColor.systemRed
            } else {
                gitImage.image = UIImage(systemName: "checkmark.square.fill")
                gitImage.tintColor = UIColor.systemGreen
            }
        }
        
        // formatting for author and date
        let fontSizeBold = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)]
        let fontSize = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]
        
        let boldText1 = "Author: "
        let finalString1 = NSMutableAttributedString(string: boldText1, attributes: fontSizeBold)
        let dataText1 = "\(passInData?.user ?? "")"
        let dataString1 = NSMutableAttributedString(string: dataText1, attributes: fontSize)
        finalString1.append(dataString1)
        gitAuthor.attributedText = finalString1
        //gitAuthor.font = UIFont(name:"Georgia", size: 18)
        
        let boldText2 = "Date: "
        let finalString2 = NSMutableAttributedString(string: boldText2, attributes: fontSizeBold)
        let dataText2 = "\(passInData?.createdAt ?? "")"
        let dataString2 = NSMutableAttributedString(string: dataText2, attributes: fontSize)
        finalString2.append(dataString2)
        gitDate.attributedText = finalString2
        //gitDate.font = UIFont(name:"Georgia", size: 18)
        
        // description
        gitDescription.text = passInData?.body
        
        
    }
}
