//
//  userselectViewController.swift
//  stc challenge
//
//  Created by Raya Khalid on 15/11/2021.
//

import UIKit

// for handling the array objects
struct Userdetails {
    var namea:String?
    var descreption:String?
    var licenseName:String?

}
class userselectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var repoArray = [Userdetails]()
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)

    @IBOutlet weak var ownername: UITextField!
    var loginname = ""
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var descreption: UITextView!
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.delegate = self
        self.tableview.dataSource = self
        tableview.isUserInteractionEnabled = true
        tableview.allowsSelection = true
        ownername.text = loginname
        ownername.isEnabled = false
    
        indicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.bringSubviewToFront(view)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        indicator.startAnimating()
        getrepositories()

        // Do any additional setup after loading the view.
    }
    
    func getrepositories(){
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
                             // for each elemnts get the name and descreption and license
                             for item in response {
                                let name1 = item.name
                                 let desc = item.welcomeDescription
                                 // create Userdetails object and add it to the array
                                 let exp = Userdetails(namea: item.name as? String, descreption: item.welcomeDescription as? String, licenseName: item.license?.name as? String)
                                 self.repoArray.append(exp)
                                 self.tableview.reloadData()}
                         } catch let error  {
                             print("Parsing Failed \(error.localizedDescription)")
                         }}} } }.resume()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
                return 1
            }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoArray.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         // display user repos cells with the requaired data
        let cell = tableView.dequeueReusableCell(withIdentifier: "reposTableViewCell") as! reposTableViewCell
        cell.reponame.text = repoArray[indexPath.row].namea
        cell.descreption.text = repoArray[indexPath.row].descreption
         cell.licensename.text = repoArray[indexPath.row].licenseName
        cell.reponame.isEnabled = false
        cell.descreption.isEditable = false
         cell.licensename.isEnabled = false
         self.indicator.stopAnimating()
        return cell
    }
}
// to conver json data to swift
// MARK: - WelcomeElement
struct userdetails: Codable {
    let id: Int
    let nodeID, name, fullName, welcomeDescription: String?
    let license: License?

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case license
        case fullName = "full_name"
        case welcomeDescription = "description"
    }
}

// MARK: - License
struct License: Codable {
    let key, name: String?
    enum CodingKeys: String, CodingKey {
        case key, name
    }}



