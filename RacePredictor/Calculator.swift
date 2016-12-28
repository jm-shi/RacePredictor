import UIKit

class Calculator: UIViewController {

    //MARK: Properties
    @IBOutlet weak var dist: UITextField!
    
    @IBOutlet weak var hours: UITextField!
    @IBOutlet weak var mins: UITextField!
    @IBOutlet weak var secs: UITextField!
    
    @IBOutlet weak var projected_distance: UITextField!
    @IBOutlet weak var projected_time_hours: UITextField!
    @IBOutlet weak var projected_time_mins: UITextField!
    @IBOutlet weak var projected_time_secs: UITextField!
    
    @IBOutlet weak var projected_mile_hours: UITextField!
    @IBOutlet weak var projected_mile_mins: UITextField!
    @IBOutlet weak var projected_mile_secs: UITextField!
    
    @IBOutlet weak var projected_5k_hours: UITextField!
    @IBOutlet weak var projected_5k_mins: UITextField!
    @IBOutlet weak var projected_5k_secs: UITextField!
    
    @IBOutlet weak var projected_10k_hours: UITextField!
    @IBOutlet weak var projected_10k_mins: UITextField!
    @IBOutlet weak var projected_10k_secs: UITextField!
    
    @IBOutlet weak var projected_half_hours: UITextField!
    @IBOutlet weak var projected_half_mins: UITextField!
    @IBOutlet weak var projected_half_secs: UITextField!
    
    @IBOutlet weak var projected_marathon_hours: UITextField!
    @IBOutlet weak var projected_marathon_mins: UITextField!
    @IBOutlet weak var projected_marathon_secs: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showChanges(hours: UITextField, mins: UITextField, secs: UITextField, distance_run: Double, total_min_run: Double, projected_distance: Double) {
        
        var est_total_min = (Double)(0)
        
        if distance_run != 0 {
            est_total_min = total_min_run * pow(projected_distance/distance_run, 1.06)
        }
        
        let est_hours = (Int)(est_total_min/60)
        let est_mins = (Int)(est_total_min) - est_hours*60
        let est_secs = (Int)(est_total_min*60) - (Int)(est_total_min)*60
        
        hours.text = "\(est_hours)"
        mins.text = "\(est_mins)"
        secs.text = "\(est_secs)"
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calculate(_ sender: AnyObject) {
        
        let distance_run = Double(dist.text!) ?? 0
        let hours_run = Double(hours.text!) ?? 0
        let mins_run = Double(mins.text!) ?? 0
        let secs_run = Double(secs.text!) ?? 0

        let total_min_run = hours_run*60 + mins_run + secs_run/60
        
        let proj_dist = Double(projected_distance.text!) ?? 0
        
        showChanges(hours: projected_time_hours, mins: projected_time_mins, secs: projected_time_secs, distance_run: distance_run, total_min_run: total_min_run, projected_distance: proj_dist)
        
        showChanges(hours: projected_mile_hours, mins: projected_mile_mins, secs: projected_mile_secs, distance_run: distance_run, total_min_run: total_min_run, projected_distance: 1)
        
        showChanges(hours: projected_5k_hours, mins: projected_5k_mins, secs: projected_5k_secs, distance_run: distance_run, total_min_run: total_min_run, projected_distance: 3.1)
        
        showChanges(hours: projected_10k_hours, mins: projected_10k_mins, secs: projected_10k_secs, distance_run: distance_run, total_min_run: total_min_run, projected_distance: 6.2)
        
        showChanges(hours: projected_half_hours, mins: projected_half_mins, secs: projected_half_secs, distance_run: distance_run, total_min_run: total_min_run, projected_distance: 13.1)
        
        showChanges(hours: projected_marathon_hours, mins: projected_marathon_mins, secs: projected_marathon_secs, distance_run: distance_run, total_min_run: total_min_run, projected_distance: 26.2)
    }

}

