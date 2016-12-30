import UIKit

class Calculator: UIViewController {

    //MARK: Properties
    @IBOutlet weak var dist: UITextField!
    
    @IBOutlet weak var hours: UITextField!
    @IBOutlet weak var mins: UITextField!
    @IBOutlet weak var secs: UITextField!
    
    @IBOutlet weak var projected_distance: UITextField!
    @IBOutlet weak var projected_time: UITextField!
    
    @IBOutlet weak var projected_mile: UITextField!
    @IBOutlet weak var projected_5k: UITextField!
    @IBOutlet weak var projected_10k: UITextField!
    @IBOutlet weak var projected_half: UITextField!
    @IBOutlet weak var projected_marathon: UITextField!
    
    @IBOutlet weak var dist_label: UILabel!
    @IBOutlet weak var time_label: UILabel!
    @IBOutlet weak var proj_dist_label: UILabel!
    @IBOutlet weak var proj_time_label: UILabel!
    @IBOutlet weak var mile_label: UILabel!
    @IBOutlet weak var fivek_label: UILabel!
    @IBOutlet weak var tenk_label: UILabel!
    @IBOutlet weak var half_label: UILabel!
    @IBOutlet weak var marathon_label: UILabel!
    
    @IBOutlet weak var dark_blue_bg: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if dist.text == "" || (hours.text == "" && mins.text == "" && secs.text == "") {
            toDefaultScreen(time: 0.0)
        }
        else {
            showTimes()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func toDefaultScreen(time: Double) {
        let proj_dist = Int(self.projected_distance.text!) ?? 0
        
        UIView.animate(withDuration: time, animations: {
            if proj_dist == 0 || (self.hours.text == "" && self.mins.text == "" && self.secs.text == "") {
                self.proj_time_label.alpha = 0
                self.projected_time.alpha = 0
            }
            else {
                self.proj_time_label.alpha = 1
                self.projected_time.alpha = 1
            }
            
            self.mile_label.alpha = 0
            self.projected_mile.alpha = 0

            self.fivek_label.alpha = 0
            self.projected_5k.alpha = 0
       
            self.tenk_label.alpha = 0
            self.projected_10k.alpha = 0

            self.half_label.alpha = 0
            self.projected_half.alpha = 0
            
            self.marathon_label.alpha = 0
            self.projected_marathon.alpha = 0
        })
    }
    
    func showTimes() {
        UIView.animate(withDuration: 0.1, animations: {
            let proj_dist = Double(self.projected_distance.text!) ?? 0
            
            if proj_dist == 0 {
                self.proj_time_label.text = "Projected Time"
                self.projected_time.text = ""
            }
            else {
                self.proj_time_label.text = "Projected " + (self.projected_distance.text ?? "") + "-Miler"
            }
            
            self.proj_time_label.alpha = 1
            self.projected_time.alpha = 1
            
            self.mile_label.alpha = 1
            self.projected_mile.alpha = 1
            
            self.fivek_label.alpha = 1
            self.projected_5k.alpha = 1
            
            self.tenk_label.alpha = 1
            self.projected_10k.alpha = 1
            
            self.half_label.alpha = 1
            self.projected_half.alpha = 1
            
            self.marathon_label.alpha = 1
            self.projected_marathon.alpha = 1
        })
    }
    
    func showChanges(distance_run: Double, total_min_run: Double, projected_distance: Double, projected_time: UITextField) {
        
        var est_total_min = (Double)(0)
        
        if distance_run != 0 {
            est_total_min = total_min_run * pow(projected_distance/distance_run, 1.06)
        }
        
        let est_hours = (Int)(est_total_min/60)
        let est_mins = (Int)(est_total_min) - est_hours*60
        let est_secs = (Int)(est_total_min*60) - (Int)(est_total_min)*60
        
        projected_time.text = "\(est_hours):\(twoDigits(number: est_mins)):\(twoDigits(number: est_secs))"
    }
    
    func twoDigits(number: Int) -> String {
        if (number < 10) {
            return "0\(number)"
        }
        else {
            return "\(number)"
        }
    }
    
    //MARK: Actions
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calculate(_ sender: AnyObject) {
        
        let distance_run = Double(dist.text!) ?? 0
        let hours_run = Double(hours.text!) ?? 0
        let mins_run = Double(mins.text!) ?? 00
        let secs_run = Double(secs.text!) ?? 00
        
        let total_min_run = hours_run*60 + mins_run + secs_run/60
        
        let proj_dist = Double(projected_distance.text!) ?? 0
        
        if distance_run == 0 || total_min_run == 0 {
            toDefaultScreen(time: 0.1)
        }
        else {
            showTimes()
        }
        
        if proj_dist < Double(Int.max/100) && proj_dist != 0 {
        showChanges(distance_run: distance_run, total_min_run: total_min_run, projected_distance: proj_dist, projected_time: projected_time)
        }
        
        showChanges(distance_run: distance_run, total_min_run: total_min_run, projected_distance: 1, projected_time: projected_mile)
        
        showChanges(distance_run: distance_run, total_min_run: total_min_run, projected_distance: 3.1, projected_time: projected_5k)
        
        showChanges(distance_run: distance_run, total_min_run: total_min_run, projected_distance: 6.2, projected_time: projected_10k)
        
        showChanges(distance_run: distance_run, total_min_run: total_min_run, projected_distance: 13.1, projected_time: projected_half)
        
        showChanges(distance_run: distance_run, total_min_run: total_min_run, projected_distance: 26.2, projected_time: projected_marathon)
    }

}

