import UIKit

class NameViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set("", forKey: "nameLabel")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func updateNameLabel(_ sender: Any) {
        var name:String = UserDefaults.standard.string(forKey: "nameLabel") ?? ""
        name = nameTextField.text!
        UserDefaults.standard.set(name, forKey: "nameLabel")
        UserDefaults.standard.synchronize()
    }
    
}
