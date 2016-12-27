import UIKit

class ViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var dist: UITextField!
    
    @IBOutlet weak var hours: UITextField!
    @IBOutlet weak var mins: UITextField!
    @IBOutlet weak var secs: UITextField!
    
    @IBOutlet weak var predict_5k_hours: UITextField!
    @IBOutlet weak var predict_5k_mins: UITextField!
    @IBOutlet weak var predict_5k_secs: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func calculate(_ sender: AnyObject) {
        
        let distance_run = Double(dist.text!) ?? 0
        let hours_run = Double(hours.text!) ?? 0
        let mins_run = Double(mins.text!) ?? 0
        let secs_run = Double(secs.text!) ?? 0

        let total_min_run = hours_run*60 + mins_run + secs_run/60
        
        var est_5k_total_min = (Double)(0)
        if distance_run != 0 {
            est_5k_total_min = total_min_run * pow(3.1/distance_run, 1.06)
        }
        
        let est_5k_hours = (Int)(est_5k_total_min/60)
        let est_5k_mins = (Int)(est_5k_total_min) - est_5k_hours*60
        let est_5k_secs = (Int)(est_5k_total_min*60) - (Int)(est_5k_total_min)*60
        
        predict_5k_hours.text = "\(est_5k_hours)"
        predict_5k_mins.text = "\(est_5k_mins)"
        predict_5k_secs.text = "\(est_5k_secs)"
    }

}

