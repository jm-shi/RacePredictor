import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath) as! CustomCell
          
        // Dark blue outline on bottom border
        let border = CALayer()
        let width = CGFloat(2.0)
        let darkBlue = UIColor(red: 9/255, green: 19/255, blue: 34/255, alpha: 1)
        border.borderColor = darkBlue.cgColor
        border.frame = CGRect(x: 0, y: cell.frame.size.height - width, width: cell.frame.size.width, height: cell.frame.size.height)
        border.borderWidth = width
        cell.layer.addSublayer(border)
        cell.layer.masksToBounds = true
        // Make selected background color a lighter blue
        let bgView = UIView()
        bgView.backgroundColor = UIColor(red: 221/255, green: 233/255, blue: 255/255, alpha: 1)
        cell.selectedBackgroundView = bgView
        
        return cell
        
    }

}
