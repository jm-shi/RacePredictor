import UIKit

class ActivityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var activities:[Activity] = [Activity(date: "11/4/14, 10:42 AM", distance: "3.1 mi", time: "15:53"), Activity(date: "1/2/17, 2:12 PM", distance: "10.4 mi", time: "1:02:42")]
    
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
        
        let activity = activities[indexPath.row] as Activity
        
        if let dateLabel = cell.viewWithTag(100) as? UILabel {
            dateLabel.text = activity.date
        }
        
        if let timeLabel = cell.viewWithTag(101) as? UILabel {
            timeLabel.text = activity.time
        }
        
        if let distanceLabel = cell.viewWithTag(102) as? UILabel {
            distanceLabel.text = activity.distance
        }
        
        return cell
    }
    
 /*   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as! CustomCell
        
        // Dark blue outline on bottom border
        let border = CALayer()
        let width = CGFloat(2.0)
        let darkBlue = UIColor(red: 9/255, green: 19/255, blue: 34/255, alpha: 1)
        border.borderColor = darkBlue.cgColor
        border.frame = CGRect(x: 0, y: cell.frame.size.height - width, width: cell.frame.size.width, height: 1)
        border.borderWidth = width
        cell.layer.addSublayer(border)
        cell.layer.masksToBounds = true
        // Make selected background color a lighter blue
        let bgView = UIView()
        bgView.backgroundColor = UIColor(red: 221/255, green: 233/255, blue: 255/255, alpha: 1)
        cell.selectedBackgroundView = bgView
        
     //   cell.mile.text = "Hey"
        
        
        return cell
    }*/
    
    // Swipe to delete cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            activities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
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
