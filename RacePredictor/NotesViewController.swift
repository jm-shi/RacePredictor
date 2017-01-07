import UIKit

class NotesViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var notesTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesTextView.delegate = self
        
        let previousText = UserDefaults.standard.string(forKey: "notesLabel") ?? ""
        if previousText == "How was the run?" || previousText == "\n" {
            notesTextView.text = ""
        }
        else {
            notesTextView.text = previousText
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        notesTextView.resignFirstResponder()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        var notes:String = UserDefaults.standard.string(forKey: "notesLabel") ?? ""
       
        notes = notesTextView.text!
        UserDefaults.standard.set(notes, forKey: "notesLabel")
        UserDefaults.standard.synchronize()
        
        if (text == "\n") {
            textView.resignFirstResponder()
            _ = navigationController?.popViewController(animated: true)
        }
        
        return true
    }
    
    // Make text in UITextView start from top
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        notesTextView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        notesTextView.setContentOffset(CGPoint.zero, animated: false)
    }
    
}
