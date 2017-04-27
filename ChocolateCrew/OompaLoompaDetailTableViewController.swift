//
//  OompaLoompaDetailTableViewController.swift
//  ChocolateCrew
//
//  Created by Aina Cuxart on 27/4/17.
//  Copyright © 2017 Aina Cuxart. All rights reserved.
//

import Foundation
import UIKit

class OompaLoompaDetailTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var oompaLoompaImageView: UIImageView!
    
    
    var details: Array<[String: Any]> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: OompaLoompaDetailCell = tableView.dequeueReusableCell(withIdentifier: "oompaLoompaDetailCell", for: indexPath) as! OompaLoompaDetailCell
        
//        if let key = details[indexPath.row]
//        cell.titleDetail = localizedString(<#T##key: String##String#>)
        
        return cell
        
    }
    
    
    
    
    
}
