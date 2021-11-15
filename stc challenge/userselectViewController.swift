//
//  userselectViewController.swift
//  stc challenge
//
//  Created by Raya Khalid on 15/11/2021.
//

import UIKit
struct Userdetails {
    var namea:String
    var descreption:String
}
class userselectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var repoArray = [Userdetails]()

    var loginname = ""
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var descreption: UITextField!
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.delegate = self
        self.tableview.dataSource = self
        tableview.isUserInteractionEnabled = true
        tableview.allowsSelection = true
print(loginname)
        print("IIII")
        countfollowers()
        // Do any additional setup after loading the view.
    }
    
    func countfollowers(){
        print("in count")
        let urlString = "https://api.github.com/users/\(self.loginname)/repos"
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
                            let response = try decoder.decode([userdetails].self, from: data)
                             for item in response {
                                 print("yjfopykkfhkh")
                                let name1 = item.name
                                 let desc = item.welcomeDescription
                                 print(name1)
                                 print(desc)
                                 let exp = Userdetails(namea: item.name as! String, descreption: item.welcomeDescription as! String)
                                 self.repoArray.append(exp)
                                 print(self.repoArray)
                                 self.tableview.reloadData()
                                
                             }

                         } catch let error  {
                             print("Parsing Failed \(error.localizedDescription)")
                         }}} }
        }.resume()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
                return 1
            }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoArray.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reposTableViewCell") as! reposTableViewCell
        cell.reponame.text = repoArray[indexPath.row].namea
        cell.repodesc.text = repoArray[indexPath.row].descreption
        
        
        cell.reponame.isEnabled = false
        cell.repodesc.isEnabled = false

        return cell
    }
}

// MARK: - WelcomeElement
struct userdetails: Codable {
    let id: Int
    let nodeID, name, fullName, welcomeDescription: String

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case welcomeDescription = "description"
    }
}


