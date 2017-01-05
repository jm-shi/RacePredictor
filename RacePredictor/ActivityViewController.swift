import UIKit

class ActivityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    
    var activities:[Activity] = [Activity(name: "XC Meet", date: "11/4/15, 10:42 AM", distance: "3.1 mi", duration: "15:53", pace: "5:07/mi", mile: "Projected Mile: 4:47", fiveK: "Projected 5K: 15:53", tenK: "Projected 10K: 33:06", half: "Projected Half: 1:13:10", marathon: "Projected Marathon: 2:32:34"), Activity(name: "Tempo Run", date: "1/2/17, 2:12 PM", distance: "10.4 mi", duration: "1:02:42", pace: "6:01/mi", mile: "Projected Mile: 5:14", fiveK: "Projected 5K: 17:22", tenK: "Projected 10K: 36:14", half: "Projected Half: 1:20:04", marathon: "Projected Marathon: 2:46:57")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: tableView features
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
        
        if let titleLabel = cell.viewWithTag(99) as? UILabel {
            titleLabel.text = activity.name
        }
        
        if let dateLabel = cell.viewWithTag(100) as? UILabel {
            dateLabel.text = activity.date
        }
        
        if let durationLabel = cell.viewWithTag(101) as? UILabel {
            durationLabel.text = activity.duration
        }
        
        if let distanceLabel = cell.viewWithTag(102) as? UILabel {
            distanceLabel.text = activity.distance
        }
        
        if let paceLabel = cell.viewWithTag(103) as? UILabel {
            paceLabel.text = activity.pace
        }
        
        if let mileLabel = cell.viewWithTag(104) as? UILabel {
            mileLabel.text = activity.mile
        }
        
        if let mileLabel = cell.viewWithTag(104) as? UILabel {
            mileLabel.text = activity.mile
        }
        
        if let fiveKLabel = cell.viewWithTag(105) as? UILabel {
            fiveKLabel.text = activity.fiveK
        }
        
        if let tenKLabel = cell.viewWithTag(106) as? UILabel {
            tenKLabel.text = activity.tenK
        }
        
        if let halfLabel = cell.viewWithTag(107) as? UILabel {
            halfLabel.text = activity.half
        }
        
        if let marathonLabel = cell.viewWithTag(108) as? UILabel {
            marathonLabel.text = activity.marathon
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
    
    //MARK: Actions
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
