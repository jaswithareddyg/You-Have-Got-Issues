# GitHub Issue Viewer - You've Got Issues (Swift)

You've Got Issues (Swift) is an iOS application that allows users to view both open and closed issues for a selected open-source project on GitHub. With a user-friendly interface, this app provides a convenient way to explore and track project issues.

## Project Overview

### Project Setup
- The app has a UITabBarController with two tabs: "Open" and "Closed."
- Utilized UINavigationController to embed UITableViewControllers for each tab.

### View Controllers

- #### Tab Bar Controller

- #### Navigation Controllers

- #### Issue View Controllers
  - `OpenIssueViewController` and `ClosedIssueViewController` to display open and closed issues.
  - Custom `IssueTableViewCell` for each issue's title, username, and issue state.

- #### Issue Detail View Controller
  - `IssueDetailViewController` displaying detailed information about a selected issue.
  - Includes title, username, creation date, issue body, and issue state.

### Fetching Data
- Utilizes URLSession to fetch open or closed issues from the GitHub API.
- Models: `GitHubIssue` and `GitHubUser` conforming to Codable.

### Load Cycle
- `viewDidLoad()` triggers the `fetchIssues` function based on the issue state.
- Data is parsed and loaded into the tables.

### Pull-to-Refresh
- Implements pull-to-refresh functionality to fetch updated data.

### Extra Credit
- Customized the UINavigationBar color based on issue state (red for open, green for closed).

## Getting Started

1. Clone the repository.
2. Open the project in Xcode.
3. Run the app on an iPhone simulator.

## Attribution

- Pull-To-Refresh:
  - [Apple Documentation](https://developer.apple.com/documentation/uikit/uirefreshcontrol)
  - [Stack Overflow](https://stackoverflow.com/questions/24475792/how-to-use-pull-to-refresh-in-swift)
  - [Cocoa Casts](https://cocoacasts.com/how-to-add-pull-to-refresh-to-a-table-view-or-collection-view)

## Additional Information

- This project was developed using Xcode and Swift.
- For issues or questions, contact [(Jas) Jaswitha](mailto:jaswithareddyguntaka@gmail.com).

Enjoy exploring GitHub issues with the GitHub Issue Viewer app! 🚀
