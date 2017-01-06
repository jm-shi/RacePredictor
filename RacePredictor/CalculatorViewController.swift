import UIKit

class CalculatorViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var dist: UITextField!
    
    @IBOutlet weak var hours: UITextField!
    @IBOutlet weak var mins: UITextField!
    @IBOutlet weak var secs: UITextField!
    
    @IBOutlet weak var pace: UITextField!
    
    @IBOutlet weak var projected_distance: UITextField!
    @IBOutlet weak var projected_time: UITextField!
    
    @IBOutlet weak var projected_mile: UITextField!
    @IBOutlet weak var projected_5k: UITextField!
    @IBOutlet weak var projected_10k: UITextField!
    @IBOutlet weak var projected_half: UITextField!
    @IBOutlet weak var projected_marathon: UITextField!
    
    @IBOutlet weak var proj_time_label: UILabel!
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        if dist.text == "" || (hours.text == "" && mins.text == "" && secs.text == "") {
            toDefaultScreen(time: 0.0)
        }
        else {
            showTimeTextFields()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let distUnitsIndex = UserDefaults.standard.integer(forKey: ("distUnitsIndex"))
        if distUnitsIndex == 0 {
            dist.placeholder = "miles"
        }
        else {
            dist.placeholder = "kilometers"
        }
        
        let projectedDistUnitsIndex = UserDefaults.standard.integer(forKey: ("projectedDistUnitsIndex"))
        if projectedDistUnitsIndex == 0 {
            projected_distance.placeholder = "miles"
        }
        else {
            projected_distance.placeholder = "kilometers"
        }
        
        calculateAndUpdate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        view.endEditing(true)
    }
    
    //MARK: Other functions
    func toDefaultScreen(time: Double) {
        let proj_dist = Int(self.projected_distance.text!) ?? 0
        
        UIView.animate(withDuration: time, animations: {
            if proj_dist == 0 || (self.hours.text == "" && self.mins.text == "" && self.secs.text == "") {
                self.projected_time.alpha = 0
            }
            else {
                self.projected_time.alpha = 1
            }
            
            self.pace.alpha = 0
            self.projected_mile.alpha = 0
            self.projected_5k.alpha = 0
            self.projected_10k.alpha = 0
            self.projected_half.alpha = 0
            self.projected_marathon.alpha = 0
        })
    }
    
    func showTimeTextFields() {
        UIView.animate(withDuration: 0.1, animations: {
            let proj_dist = Double(self.projected_distance.text!) ?? 0
            
            if proj_dist == 0 {
                self.proj_time_label.text = "Projected Time"
                self.projected_time.alpha = 0
            }
            else {
                if UserDefaults.standard.string(forKey: "projectedDistUnits") == "km" {
                    self.proj_time_label.text = "Projected " + (self.projected_distance.text ?? "") + "K"
                }
                else {
                    self.proj_time_label.text = "Projected " + (self.projected_distance.text ?? "") + "-Miler"
                }
                self.projected_time.alpha = 1
            }
            
            self.pace.alpha = 1
            self.projected_mile.alpha = 1
            self.projected_5k.alpha = 1
            self.projected_10k.alpha = 1
            self.projected_half.alpha = 1
            self.projected_marathon.alpha = 1
        })
    }
    
    func showProjectedTimes(distance_run: Double, total_min_run: Double, projected_distance: Double, projected_time: UITextField) {
        let time:[Int] = predictTime(distance_run: distance_run, total_min_run: total_min_run, projected_distance: projected_distance, adding_activity: false)
 
        projected_time.text = "\(time[0]):\(twoDigits(number: time[1])):\(twoDigits(number: time[2]))"
    }
    
    func showPace(total_min: Double, total_dist: Double) {
        let paceTime:[Int] = calculatePace(total_min: total_min, total_dist: total_dist)
        if paceTime[0] != 0 {
            pace.text = "\(paceTime[0]):\(twoDigits(number: paceTime[1])):\(twoDigits(number: paceTime[2]))"
        }
        else {
            pace.text = "\(paceTime[1]):\(twoDigits(number: paceTime[2]))"
        }
    }
    
    // Calculate pace and projected times, then modify textfields
    func calculateAndUpdate() {
        let distance_run = Double(dist.text!) ?? 0
        let hours_run = Double(hours.text!) ?? 0
        let mins_run = Double(mins.text!) ?? 00
        let secs_run = Double(secs.text!) ?? 00
        
        let total_min_run = calculateTotalMinRun(hours_run: hours_run, mins_run: mins_run, secs_run: secs_run)
        
        let proj_dist = Double(projected_distance.text!) ?? 0
        
        if distance_run == 0 || total_min_run == 0 {
            toDefaultScreen(time: 0.1)
        }
        else {
            showPace(total_min: total_min_run, total_dist: distance_run)
            showTimeTextFields()
        }
        
        if proj_dist < Double(Int.max/100) && proj_dist != 0 {
            showProjectedTimes(distance_run: distance_run, total_min_run: total_min_run, projected_distance: proj_dist, projected_time: projected_time)
        }
        
        showProjectedTimes(distance_run: distance_run, total_min_run: total_min_run, projected_distance: 1, projected_time: projected_mile)
        
        showProjectedTimes(distance_run: distance_run, total_min_run: total_min_run, projected_distance: 3.10686, projected_time: projected_5k)
        
        showProjectedTimes(distance_run: distance_run, total_min_run: total_min_run, projected_distance: 6.21371, projected_time: projected_10k)
        
        showProjectedTimes(distance_run: distance_run, total_min_run: total_min_run, projected_distance: 13.1094, projected_time: projected_half)
        
        showProjectedTimes(distance_run: distance_run, total_min_run: total_min_run, projected_distance: 26.2188, projected_time: projected_marathon)
    }
    
    //MARK: Actions
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    // Calculate pace and projected times, then show results onscreen
    @IBAction func calculate(_ sender: AnyObject) {
        calculateAndUpdate()
    }

}

