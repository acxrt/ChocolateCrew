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
    @IBOutlet weak var headerTitleLabel: UILabel!
    
    var oompaLoompaList = Array<Any>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        OompaLoompaService.allOompaLoompa(success: { list in
            self.oompaLoompaList = list
            self.tableView.reloadData()
        }, failure: {_ in 
            
        })
        
        headerTitleLabel.text = localizedString("oompa_loompa_table_title")
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return oompaLoompaList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : OompaLoompaTableViewCell = tableView.dequeueReusableCell(withIdentifier: "oompaLoompaCell", for: indexPath) as! OompaLoompaTableViewCell
        
        let oompaLoompa: OompaLoopma  = oompaLoompaList[indexPath.row] as! OompaLoopma
        
        cell.oLNameLabel.text = "\(oompaLoompa.first_name) \(oompaLoompa.last_name)"
        cell.imageView?.downloadedFrom(link: oompaLoompa.image)
        cell.oLId = oompaLoompa.id
        
        return cell

    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    
}
