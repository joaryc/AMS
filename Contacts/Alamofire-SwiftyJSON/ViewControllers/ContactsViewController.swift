import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD


class ContactsViewController: UIViewController {
    
    var contacts = [Contacts]()
    
    @IBOutlet weak var contactsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactsTableView.dataSource = self
        contactsTableView.delegate = self
        
        
        self.ContactsAPICalling {
            print("Contacts Downloaded")
            self.contactsTableView.reloadData()
        }
    }
    
    
    func ContactsAPICalling(completed: @escaping DownloadComplete){
        showLoadingHUD()
        Alamofire.request(API_CONTACTS, method: .get, encoding: JSONEncoding.default, headers: nil).responseJSON { (contactsResponse) in
            self.hideLoadingHUD()
            
            let result = contactsResponse.result
            let contactsJSON = JSON(result.value!)["contacts"]
            
            print(contactsJSON)
            
            for i in 0..<contactsJSON.count {
                
                let allContacts = Contacts(contactDict: contactsJSON[i])
                
                self.contacts.append(allContacts)
            }
            
            completed()
       
        }
        
    }
    private func showLoadingHUD() {
      let hud = MBProgressHUD.showAdded(to: contactsTableView, animated: true)
      hud.label.text = "Loading..."
    }

    private func hideLoadingHUD() {
      MBProgressHUD.hide(for: contactsTableView, animated: true)
    }

    

}


extension ContactsViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return contacts.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        var cell = contactsTableView.dequeueReusableCell(withIdentifier: "contactscell")
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "contactscell")
        }
        
        cell?.textLabel?.text = contacts[indexPath.row].name
        cell?.detailTextLabel?.text = contacts[indexPath.row].email
        
        return cell!
      
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toContactsView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationVC = segue.destination as? ContactDetailsViewController {
            destinationVC.contactDetails = contacts[(contactsTableView.indexPathForSelectedRow?.row)!]
            contactsTableView.deselectRow(at: contactsTableView.indexPathForSelectedRow!, animated: true)
            
        }
    }
    
    
 
}

