import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var theTitle: UILabel!
    @IBOutlet weak var theDate: UILabel!
    @IBOutlet weak var theDistance: UILabel!
    @IBOutlet weak var theTime: UILabel!
    @IBOutlet weak var thePace: UILabel!
    
    @IBOutlet weak var mile: UILabel!
    @IBOutlet weak var fiveK: UILabel!
    @IBOutlet weak var tenK: UILabel!
    @IBOutlet weak var halfMarathon: UILabel!
    @IBOutlet weak var marathon: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
