import UIKit

class CellViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var distLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var mileLabel: UILabel!
    @IBOutlet weak var fiveKLabel: UILabel!
    @IBOutlet weak var tenKLabel: UILabel!
    @IBOutlet weak var halfLabel: UILabel!
    @IBOutlet weak var marathonLabel: UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    
    var activities = [Activity]()
    
    var filePath: String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        return url!.appendingPathComponent("Activity").path
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let loadActivities = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Activity] {
            activities = loadActivities
        }
        
        let defaults = UserDefaults.standard
        let activityIndex = defaults.integer(forKey: "rowIndex")
        
        let theName = activities[activityIndex].name
        let theDate = activities[activityIndex].date
        let theDist = activities[activityIndex].distance
        let theDuration = activities[activityIndex].duration
        let thePace = activities[activityIndex].pace
        let theMile = activities[activityIndex].mile
        let theFiveK = activities[activityIndex].fiveK
        let theTenK = activities[activityIndex].tenK
        let theHalf = activities[activityIndex].half
        let theMarathon = activities[activityIndex].marathon
        let theNotes = activities[activityIndex].notes
        
        updateTheLabels(name: theName, date: theDate, dist: theDist, duration: theDuration, pace: thePace, mile: theMile, fiveK: theFiveK, tenK: theTenK, half: theHalf, marathon: theMarathon, notes: theNotes)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateTheLabels(name: String!, date: String!, dist: String!, duration: String!, pace: String!, mile: String!, fiveK: String!, tenK: String!, half: String!, marathon: String!, notes: String!) {
        nameLabel.text = name
        dateLabel.text = date
        distLabel.text = dist
        durationLabel.text = duration
        paceLabel.text = pace
        mileLabel.text = mile
        fiveKLabel.text = fiveK
        tenKLabel.text = tenK
        halfLabel.text = half
        marathonLabel.text = marathon
        notesTextView.text = notes
    }
    
}
