import UIKit

class NameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let previousText = UserDefaults.standard.string(forKey: "nameLabel") ?? ""
        if previousText == "Untitled Run" {
            nameTextField.text = ""
        }
        else {
            nameTextField.text = previousText
        }
        nameTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        _ = navigationController?.popViewController(animated: true)
        return true
    }
    
    @IBAction func updateNameLabel(_ sender: Any) {
        var name:String = UserDefaults.standard.string(forKey: "nameLabel") ?? ""
        name = nameTextField.text!
        UserDefaults.standard.set(name, forKey: "nameLabel")
        UserDefaults.standard.synchronize()
    }
    
}
