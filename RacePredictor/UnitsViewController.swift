import UIKit

class UnitsViewController: UIViewController {
    
    @IBOutlet weak var distUnits: UISegmentedControl!
    @IBOutlet weak var projectedDistUnits: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        let distUnitsIndex = defaults.integer(forKey: "distUnitsIndex")
        distUnits.selectedSegmentIndex = distUnitsIndex;
        
        let projectedDistUnitsIndex = defaults.integer(forKey: "projectedDistUnitsIndex")
        projectedDistUnits.selectedSegmentIndex = projectedDistUnitsIndex
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func updateDistUnits(_ sender: Any) {
        let defaults = UserDefaults.standard
        let unitsIndex = distUnits.selectedSegmentIndex
        defaults.set(unitsIndex, forKey: "distUnitsIndex")
        
        if unitsIndex == 0 {
            defaults.set("miles", forKey: "distUnits")
        }
        else {
            defaults.set("km", forKey: "distUnits")
        }
        
        defaults.synchronize()
    }
    
    @IBAction func updateProjectedDistUnits(_ sender: Any) {
        let defaults = UserDefaults.standard
        let unitsIndex = projectedDistUnits.selectedSegmentIndex
        defaults.set(unitsIndex, forKey: "projectedDistUnitsIndex")
        
        if unitsIndex == 0 {
            defaults.set("miles", forKey: "projectedDistUnits")
        }
        else {
            defaults.set("km", forKey: "projectedDistUnits")
        }
        
        defaults.synchronize()
    }
    
  }
