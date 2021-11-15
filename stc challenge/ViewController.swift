//
//  ViewController.swift
//  stc challenge
//
//  Created by Raya Khalid on 14/11/2021.
//

import UIKit

// for handling the array objects
struct User {
    var Username:String
    var followersnum:Int
    var reponum:Int
    var avatarimage: String
}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var UsersTableView: UITableView!
    var UsersArray = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.UsersTableView.delegate = self
        self.UsersTableView.dataSource = self
        UsersTableView.isUserInteractionEnabled = true
        UsersTableView.allowsSelection = true
        
        // to get the data from Github API
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
                            // for each elemnts count the number of followers and repos
                            for item in response {
                                self.countfollowers(item)
                            }

                        } catch let error  {
                            print("Parsing Failed \(error.localizedDescription)")
                        }}} }
       }.resume()
        

    }
    
    func countfollowers(_ username: WelcomeElement){
        // use the passed username from the response items
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
                                let json = try JSONDecoder().decode(userelemnts.self, from: data)
                                let followersnum = json.followers
                                let reponum = json.publicRepos
                                // create user object and add it to the array
                                let exp = User(Username: username.login as! String, followersnum: json.followers as! Int, reponum: json.publicRepos as! Int,avatarimage: json.avatarURL as! String)
                                self.UsersArray.append(exp)
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
        // display users cells with the requaired data
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsersTableViewCell") as! UsersTableViewCell
        cell.usernameGithub.text = UsersArray[indexPath.row].Username
        cell.reponumber.text = "\(UsersArray[indexPath.row].reponum)"
        cell.followersnumber.text = "\(UsersArray[indexPath.row].followersnum)"
        // Create URL
        let url = URL(string: UsersArray[indexPath.row].avatarimage)!
        // Create Data Task
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
            if let data = data {
                DispatchQueue.main.async {
                    // Create Image and Update Image View
                    cell.avatar.image = UIImage(data: data)}} }
        // Start Data Task
        dataTask.resume()
        cell.usernameGithub.isEnabled = false
        cell.reponumber.isEnabled = false
        cell.followersnumber.isEnabled = false
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // redirect the user to new page if select the user to see more information
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: userselectViewController = storyboard.instantiateViewController(withIdentifier: "ViewExperiance") as! userselectViewController
        vc.loginname = UsersArray[indexPath.row].Username
        self.present(vc, animated: true, completion: nil)
        print("selected cell \(indexPath.row)")
    }

    
    @IBAction func unwindToViewControllerA(segue: UIStoryboardSegue) {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.UsersTableView.reloadData()
            } }
        }}
// to conver json data to swift 
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
struct userelemnts: Codable {
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

