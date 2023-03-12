//
//  GitHubClient.swift
//  You've Got Issues!
//
//  Created by Jaswitha Reddy G on 2/10/23.
//

import Foundation
import UIKit

struct GithubIssue: Codable {
    let title: String?
    let createdAt: String
    let body: String?
    let state: String
    let user: GithubUser
}

struct GithubUser: Codable {
    let login: String
}

struct Release: Decodable {
    let name: String
    let createdAt: String
    let author: Author
}

struct Author: Decodable {
    let login: String
}

class GitHubClient {
    // fetches releases
    static func fetchReleases(completion: @escaping ([Release]?, Error?) -> Void){
        let url = URL(string: "https://api.github.com/repos/google/python-fire/releases")!
        let task = URLSession.shared.dataTask(with: url){ data, _, error in
            guard let data = data, error == nil else{
                DispatchQueue.main.async{completion(nil, error)}
                return
            }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let releases = try decoder.decode([Release].self, from: data)
                DispatchQueue.main.async{completion(releases, nil)}
            }catch (let parsingError){
                DispatchQueue.main.async{completion(nil, parsingError)}
            }
        }
        task.resume()
    }
    
    // fetches issues
    static func fetchIssues(state: String, completion: @escaping ([GithubIssue]?, Error?) -> Void){
        let url = URL(string: "https://api.github.com/repos/bevyengine/bevy/issues?state=\(state)")!
        let task = URLSession.shared.dataTask(with: url){data, _, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async{completion(nil, error)}
                return
            }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let releases = try decoder.decode([GithubIssue].self, from: data)
                DispatchQueue.main.async {completion(releases, nil)}
            }catch (let parsingError){
                DispatchQueue.main.async{completion(nil, parsingError)}
            }
        }
        task.resume()
    }
}
