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
    
    var details: Array<[String: String]> = Array()
    var oompaLoompaImageLink: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        oompaLoompaImageView.image = #imageLiteral(resourceName: "Placeholder")
        oompaLoompaImageView.downloadedFrom(link: oompaLoompaImageLink)
        
        oompaLoompaImageView.clipsToBounds = true
        oompaLoompaImageView.layer.cornerRadius = oompaLoompaImageView.frame.size.width / 2
        oompaLoompaImageView.layer.borderWidth = 1.0
        oompaLoompaImageView.layer.borderColor = UIColor(colorLiteralRed: 128.0/255.0, green: 111.0/255.0, blue: 77.0/255.0, alpha: 1).cgColor

    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: OompaLoompaDetailCell = tableView.dequeueReusableCell(withIdentifier: "oompaLoompaDetailCell", for: indexPath) as! OompaLoompaDetailCell
        
        if let key = details[indexPath.row].keys.first {
            cell.titleDetail.text = localizedString(key)
            
            if let value = details[indexPath.row][key] {
                cell.contentDetail?.text = value
            }
        }
        

        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    
    
    
}
