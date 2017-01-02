import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet var theDate: UILabel!
    @IBOutlet var theDistance: UILabel!
    @IBOutlet var theTime: UILabel!
    @IBOutlet var thePace: UILabel!
    
    @IBOutlet var mile: UILabel!
    @IBOutlet var fiveK: UILabel!
    @IBOutlet var tenK: UILabel!
    @IBOutlet var halfMarathon: UILabel!
    @IBOutlet var marathon: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
