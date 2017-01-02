import UIKit

class ActivityDetailsViewController: UITableViewController {
    
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var activityDatePicker: UIDatePicker!
    
    var activity:Activity?
    var datePickerHidden = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeDatePicker()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func changeDatePicker() {
        detailLabel.text = DateFormatter.localizedString(from: activityDatePicker.date, dateStyle: .short, timeStyle: .short)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            toggleDatePicker()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if datePickerHidden && indexPath.section == 0 && indexPath.row == 1 {
            return 0
        }
        else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    func toggleDatePicker() {
        datePickerHidden = !datePickerHidden
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveActivity" {
            activity = Activity(date: detailLabel.text, distance: "temp distance", time: "temp time")
           // activity = Activity(date: activity?.date, distance: activity?.distance, time: activity?.time)
        }
    }
    
    
    @IBAction func datePickerValue(_ sender: Any) {
        changeDatePicker()
    }
    
}
