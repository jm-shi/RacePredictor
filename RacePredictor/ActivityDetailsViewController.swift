import UIKit

class ActivityDetailsViewController: UITableViewController, UIPickerViewDataSource,UIPickerViewDelegate, UITextFieldDelegate {
    
    //MARK: Properties
    @IBOutlet weak var titleDetailLabel: UILabel!
    @IBOutlet weak var titleButton: UIButton!
    
    @IBOutlet weak var dateDetailLabel: UILabel!
    @IBOutlet weak var dateText: UITextField!
    
    @IBOutlet weak var distanceDetailLabel: UILabel!
    @IBOutlet weak var distanceText: UITextField!
    
    @IBOutlet weak var durationDetailLabel: UILabel!
    @IBOutlet weak var durationText: UITextField!
    
    var distPickerData = [[String](), [String](), [String](), [".0", ".1", ".2", ".3", ".4", ".5", ".6", ".7", ".8", ".9"], ["mi", "km"]]
    let hundredsDistComponent = 0
    let tensDistComponent = 1
    let onesDistComponent = 2
    let tenthsDistComponent = 3
    let distTypeComponent = 4
    
    var durationPickerData = [[String](), [String](), [String]()]
    let hoursComponent = 0
    let minsComponent = 1
    let secsComponent = 2
    
    var activity:Activity?
    var distanceRun = String()
    var timeTaken = [String](repeating: "", count: 3)
    var newActivity = true
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for index in 0 ..< 9 {
            distPickerData[hundredsDistComponent].append(String(index))
            distPickerData[tensDistComponent].append(String(index))
            distPickerData[onesDistComponent].append(String(index))
        }
        
        for index in 0 ..< 24 {
            durationPickerData[hoursComponent].append((String(index) + "h"))
        }
        for index in 0 ..< 60 {
            durationPickerData[minsComponent].append(String(index) + "m")
            durationPickerData[secsComponent].append(String(index) + "s")
        }
        
        UserDefaults.standard.set("Untitled Run", forKey: "nameLabel")
        
        let datePickerView = UIDatePicker()
        dateText.inputView = datePickerView
        dateText.tintColor = UIColor.clear
        dateText.delegate = self
        datePickerView.addTarget(self, action: #selector(ActivityDetailsViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)

        // Current date is default date
        dateDetailLabel.text = DateFormatter.localizedString(from: datePickerView.date, dateStyle: .short, timeStyle: .short)
        
        let distPickerView = UIPickerView()
        distPickerView.tag = 1
        distPickerView.delegate = self
        distanceText.inputView = distPickerView
        distanceText.tintColor = UIColor.clear
        distanceText.delegate = self
        
        let durationPickerView = UIPickerView()
        durationPickerView.tag = 2
        durationPickerView.delegate = self
        durationText.inputView = durationPickerView
        durationText.tintColor = UIColor.clear
        durationText.delegate = self
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var name:String = UserDefaults.standard.string(forKey: "nameLabel") ?? "Untitled Run"
        if name == "" {
            name = "Untitled Run"
        }
        titleDetailLabel.text = name
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        view.endEditing(true)
    }
    
    //MARK: pickerView delegate and data sources (for distance and duration)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == 1 {
            return 5
        }
        else {
            return 3
        }
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return distPickerData[component].count
        }
        else {
            return durationPickerData[component].count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return distPickerData[component][row]
        }
        else {
            return durationPickerData[component][row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            updateDistance(distPickerView: pickerView)
        }
        else {
            updateDuration(durationPickerView: pickerView)
        }
    }
    
    //MARK: Other functions
    func updateDistance(distPickerView: UIPickerView) {
        var hundreds = distPickerData[hundredsDistComponent][distPickerView.selectedRow(inComponent: hundredsDistComponent)]
        var tens = distPickerData[tensDistComponent][distPickerView.selectedRow(inComponent: tensDistComponent)]
        let ones = distPickerData[onesDistComponent][distPickerView.selectedRow(inComponent: onesDistComponent)]
        let tenths = distPickerData[tenthsDistComponent][distPickerView.selectedRow(inComponent: tenthsDistComponent)]
        
        // Save the distance
        distanceRun = hundreds + tens + ones + tenths
        
        let distType = distPickerData[distTypeComponent][distPickerView.selectedRow(inComponent: distTypeComponent)]
        
        if hundreds == "0" {
            if tens == "0" {
                tens = ""
            }
            hundreds = ""
        }
        
        distanceDetailLabel.text = hundreds + tens + ones + tenths + " " + distType
        

        // Save distance type (mi or km)
        let defaults = UserDefaults.standard
        defaults.set(distType, forKey: "distType")
        defaults.synchronize()
    }
    
    func updateDuration(durationPickerView: UIPickerView) {
        var hours = durationPickerData[hoursComponent][durationPickerView.selectedRow(inComponent: hoursComponent)]
        var mins = durationPickerData[minsComponent][durationPickerView.selectedRow(inComponent: minsComponent)]
        var secs = durationPickerData[secsComponent][durationPickerView.selectedRow(inComponent: secsComponent)]
        
        // Drop the last character
        hours = hours.substring(to: hours.index(before: hours.endIndex))
        mins = mins.substring(to: mins.index(before: mins.endIndex))
        secs = secs.substring(to: secs.index(before: secs.endIndex))
        
        // Save the time
        timeTaken[0] = hours
        timeTaken[1] = mins
        timeTaken[2] = secs
        
        // Add 0 if necessary
        if (Int(mins)! < 10 && Int(hours)! != 0) {
            mins = "0" + mins
        }
        if (Int(secs)! < 10) {
            secs = "0" + secs
        }
        
        if (Int(hours) == 0) {
            durationDetailLabel.text = mins + ":" + secs
        }
        else {
            durationDetailLabel.text = hours + ":" + mins + ":" + secs
        }
    }
    
    func dismissKeyboard() {
        dateText.resignFirstResponder()
        distanceText.resignFirstResponder()
        durationText.resignFirstResponder()
    }
    
    func datePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        dateDetailLabel.text = dateFormatter.string(from: sender.date)
    }
    
    // Don't save if user did not enter both distance and duration
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "saveActivity" {
            if (timeTaken[0] == "" && timeTaken[1] == "" && timeTaken[2] == "") || (distanceRun == "") {
                return false
            }
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if titleDetailLabel.text == "" {
            titleDetailLabel.text = "Untitled Run"
        }
        if segue.identifier == "enterName" {
            return
        }
        
        if segue.identifier == "cancelActivity" {
            return
        }
        
        let totalMinRun = calculateTotalMinRun(hours_run: Double(timeTaken[0])!, mins_run: Double(timeTaken[1])!, secs_run: Double(timeTaken[2])!)
        
        let paceArray:[Int] = calculatePace(total_min: totalMinRun, total_dist: Double(distanceRun)!)
        
        var thePace = String()
        if paceArray[0] != 0 {
            thePace = String(paceArray[0]) + ":" + twoDigits(number: paceArray[1]) + ":" + twoDigits(number: paceArray[2]) + "/mi"
        }
        else {
            thePace = String(paceArray[1]) + ":" + twoDigits(number: paceArray[2]) + "/mi"
        }
        
        let updatedMileLabel = updateLabels(distance_run: Double(distanceRun)!, total_min_run: totalMinRun, projected_distance: 1.0, distance_name: "Mile")
         let updated5KLabel = updateLabels(distance_run: Double(distanceRun)!, total_min_run: totalMinRun, projected_distance: 3.1, distance_name: "5K")
         let updated10KLabel = updateLabels(distance_run: Double(distanceRun)!, total_min_run: totalMinRun, projected_distance: 6.2, distance_name: "10K")
         let updatedHalfLabel = updateLabels(distance_run: Double(distanceRun)!, total_min_run: totalMinRun, projected_distance: 13.1, distance_name: "Half")
         let updatedMarathonLabel = updateLabels(distance_run: Double(distanceRun)!, total_min_run: totalMinRun, projected_distance: 26.2, distance_name: "Marathon")
        
        if segue.identifier == "saveActivity" {
            activity = Activity(name: titleDetailLabel.text!, date: dateDetailLabel.text!, distance: distanceDetailLabel.text!, duration: durationDetailLabel.text!, pace: thePace, mile: updatedMileLabel, fiveK: updated5KLabel, tenK: updated10KLabel, half: updatedHalfLabel, marathon: updatedMarathonLabel)
        }
    }
    
}
