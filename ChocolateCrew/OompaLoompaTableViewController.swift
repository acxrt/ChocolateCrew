//
//  OompaLoompaTableViewController.swift
//  ChocolateCrew
//
//  Created by Aina Cuxart on 24/4/17.
//  Copyright © 2017 Aina Cuxart. All rights reserved.
//

import UIKit
import Alamofire

class OompaLoompaTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var oompaLoompaList = Array<Any>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        OompaLoompaService.allOompaLoompa(success: {
            print("DONE")
        }, failure: {_ in 
            
        })
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return oompaLoompaList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : OompaLoompaTableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "oompaLoompaCell") as! OompaLoompaTableViewCell
        
//        cell.oLNameLabel.text = "\() \()"
//        cell.imageView
//        cell.oLId = 
        
        return cell

    }
    
    
    
}
