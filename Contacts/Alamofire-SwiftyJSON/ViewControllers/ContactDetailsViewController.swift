import UIKit

class ContactDetailsViewController: UIViewController {
    
    var contactDetails:Contacts!
    
    @IBOutlet weak var FullNameLbl: UILabel!
    @IBOutlet weak var MobileNumberLbl: UILabel!
    @IBOutlet weak var AddressLbl: UILabel!
    @IBOutlet weak var EmailLbl: UILabel!
    @IBOutlet weak var GenderLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        FullNameLbl.text = contactDetails.name
        MobileNumberLbl.text = contactDetails.mobile
        AddressLbl.text = contactDetails.address
        EmailLbl.text = contactDetails.email
        GenderLbl.text = contactDetails.gender
    }

}
