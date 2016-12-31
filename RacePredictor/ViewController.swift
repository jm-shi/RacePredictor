//
//  Activities.swift
//  RacePredictor
//
//  Created by admin on 12/30/16.
//  Copyright © 2016 JS. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    let ls = ["clock", "calculator", "settings"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ls.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let myCell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath) as! CustomCell
     
        myCell.textLabel?.text = ls[indexPath.row]
        myCell.imageView?.image = UIImage(named: ls[indexPath.row])
        
        // Blue outline
        let darkBlue = UIColor(red: 9/255, green: 19/255, blue: 34/255, alpha: 1)
        myCell.layer.borderWidth = 2.0
        myCell.layer.borderColor = darkBlue.cgColor
        
        return myCell
        
    }

}
