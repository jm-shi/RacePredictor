import UIKit

class ActivityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var activities:[Activity] = [Activity(date: "11/4/14, 10:42 AM", distance: "3.1 mi", duration: "15:53"), Activity(date: "1/2/17, 2:12 PM", distance: "10.4 mi", duration: "1:02:42")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as! CustomCell
        
        // Dark bottom border
        let border = CALayer()
        let width = CGFloat(2.0)
        let darkBlue = UIColor(red: 9/255, green: 19/255, blue: 34/255, alpha: 1)
        border.borderColor = darkBlue.cgColor
        border.frame = CGRect(x: 0, y: cell.frame.size.height - width, width: cell.frame.size.width, height: 1)
        border.borderWidth = width
        cell.layer.addSublayer(border)
        cell.layer.masksToBounds = true
        // Selected background color is beige
        let bgView = UIView()
        bgView.backgroundColor = UIColor(red: 236/255, green: 228/255, blue: 211/255, alpha: 1)
        cell.selectedBackgroundView = bgView
        
        let activity = activities[indexPath.row] as Activity
        
        if let dateLabel = cell.viewWithTag(100) as? UILabel {
            dateLabel.text = activity.date
        }
        
        if let durationLabel = cell.viewWithTag(101) as? UILabel {
            durationLabel.text = activity.duration
        }
        
        if let distanceLabel = cell.viewWithTag(102) as? UILabel {
            distanceLabel.text = activity.distance
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Reorder cells
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedActivity = self.activities[sourceIndexPath.row]
        activities.remove(at: sourceIndexPath.row)
        activities.insert(movedActivity, at: destinationIndexPath.row)
    }
    
    // Swipe to delete cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            activities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    // Edit button serves to delete/reorder cells
    @IBAction func editCells(_ sender: Any) {
        self.tableView.isEditing = !self.tableView.isEditing
    }
    
    @IBAction func cancelActivity(segue: UIStoryboardSegue) {
    }
    
    @IBAction func saveActivity(segue: UIStoryboardSegue) {
        if let activityDetailsViewController = segue.source as? ActivityDetailsViewController {
            
            if let activity = activityDetailsViewController.activity {
                activities.append(activity)
                
                let indexPath = NSIndexPath(row: activities.count-1, section: 0)
                tableView.insertRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
            }
        }
    }
    
}
