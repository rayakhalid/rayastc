//
//  ViewController.swift
//  stc challenge
//
//  Created by Raya Khalid on 14/11/2021.
//

import UIKit

struct User {
    var Username:String
    var followersnum:Int
    var reponum:Int
}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var UsersArray = [User]()

    @IBOutlet weak var UsersTableView: UITableView!
    var count = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.UsersTableView.delegate = self
        self.UsersTableView.dataSource = self
        UsersTableView.isUserInteractionEnabled = true
        UsersTableView.allowsSelection = true

        loadData()
           }
   
    func loadData(){
        let urlString = "https://api.github.com/users"
        guard let url = URL(string: urlString)
        else { return  }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"

       URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async{
                if  error != nil {
                    print("Error: \(String(describing: error))")
                }
                else if let data = data {
                    do{
                        let decoder = JSONDecoder()
                        do {
                           let response = try decoder.decode([WelcomeElement].self, from: data)
                            for item in response {
                                self.countfollowers(item)
                            }

                        } catch let error  {
                            print("Parsing Failed \(error.localizedDescription)")
                        }}} }
       }.resume()
        

    }
    
    func countfollowers(_ username: WelcomeElement){
        print("in count")
        let urlString = "https://api.github.com/users/\(username.login)"
        guard let url = URL(string: urlString)
                else { return  }
                var request = URLRequest(url: url)
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpMethod = "GET"
                URLSession.shared.dataTask(with: request) { (data, response, error) in
                    DispatchQueue.main.async{
                        if  error != nil {
                            print("Error: \(String(describing: error))")
                        }
                        else if let data = data {

                            do{
                                let json = try JSONDecoder().decode(userc.self, from: data)
                                let followersnum = json.followers
                                let reponum = json.publicRepos
//                                print(followersnum)
//                                print(reponum)
                                let exp = User(Username: username.login as! String, followersnum: json.followers as! Int, reponum: json.publicRepos as! Int)

                                self.UsersArray.append(exp)
                                print(self.UsersArray)
                                self.UsersTableView.reloadData()

                            } catch{
                                print(error)
                            }}}
                }.resume()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
                return 1
            }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UsersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsersTableViewCell") as! UsersTableViewCell
        cell.usernameGithub.text = UsersArray[indexPath.row].Username
        cell.reponumber.text = "\(UsersArray[indexPath.row].reponum)"
        cell.followersnumber.text = "\(UsersArray[indexPath.row].followersnum)"
        
        
        cell.usernameGithub.isEnabled = false
        cell.reponumber.isEnabled = false
        cell.followersnumber.isEnabled = false

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "ViewExperiance") as? ViewController
//        vc?.expTitle = experienceArray[indexPath.row].expTitle
        // testing print
        
//        print(experienceArray[indexPath.row].expID ,"   ##########################")

        
        self.navigationController?.pushViewController(vc!, animated: true)
        
        
        
        print("selected cell \(indexPath.row)")
    }

    
    @IBAction func unwindToViewControllerA(segue: UIStoryboardSegue) {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.UsersTableView.reloadData()
            }
        }



        }}

// MARK: - WelcomeElement
struct WelcomeElement: Codable {
    let login: String
    let id: Int
    let nodeID: String
    let avatarURL: String
    let gravatarID: String
    let url, htmlURL, followersURL: String
    let followingURL, gistsURL, starredURL: String
    let subscriptionsURL, organizationsURL, reposURL: String
    let eventsURL: String
    let receivedEventsURL: String
    let type: TypeEnum
    let siteAdmin: Bool

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
    }
}

enum TypeEnum: String, Codable {
    case organization = "Organization"
    case user = "User"
}

typealias Welcome = [WelcomeElement]



// MARK: - Welcome
struct userc: Codable {
    let login: String
    let id: Int?
    let nodeID: String?
    let avatarURL: String?
    let gravatarID: String?
    let url, htmlURL, followersURL: String?
    let followingURL, gistsURL, starredURL: String?
    let subscriptionsURL, organizationsURL, reposURL: String?
    let eventsURL: String?
    let receivedEventsURL: String?
    let type: String?
    let siteAdmin: Bool?
    let name, company: String?
    let blog: String?
    let location, email: String?
    let hireable: Bool?
    let bio, twitterUsername: String?
    let publicRepos, publicGists, followers, following: Int

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
        case name, company, blog, location, email, hireable, bio
        case twitterUsername = "twitter_username"
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers, following
      
    }
}

