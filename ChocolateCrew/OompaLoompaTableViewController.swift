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
        
        self.navigationItem.title = localizedString("oompa_loompa_table_title")
        
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
        cell.oLImageView?.image = #imageLiteral(resourceName: "Placeholder")
        cell.oLImageView?.downloadedFrom(link: oompaLoompa.image)
        cell.oLId = oompaLoompa.id
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell: OompaLoompaTableViewCell = tableView.cellForRow(at: indexPath) as! OompaLoompaTableViewCell
        
        if cell.oLId - 1 > 0 {
            let oompaLoompa: OompaLoopma = oompaLoompaList[cell.oLId - 1] as! OompaLoopma
            let details: Array<[String: String]> = createDetailsForOompaLoompa(oompaLoompa:oompaLoompa)
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let detailViewController: OompaLoompaDetailTableViewController = storyBoard.instantiateViewController(withIdentifier: "OompaLoompaDetail") as! OompaLoompaDetailTableViewController
            
            detailViewController.details = details
            detailViewController.oompaLoompaImageLink = oompaLoompa.image
            
            navigationController?.pushViewController(detailViewController, animated: true)
        }
        
    }
    
    func createDetailsForOompaLoompa(oompaLoompa: OompaLoopma) -> Array<[String: String]> {
        
        var details: Array<[String: String]> = Array()
        
        let firstName: [String: String] = ["first_name": oompaLoompa.first_name]
        details.append(firstName)
        
        let lastName: [String: String] = ["last_name": oompaLoompa.last_name]
        details.append(lastName)
        
        let email: [String: String] = ["email": oompaLoompa.email]
        details.append(email)
        
        let gender: [String: String] = ["gender": oompaLoompa.gender]
        details.append(gender)
        
        let profession: [String: String] = ["profession": oompaLoompa.profession]
        details.append(profession)

        return details
    }
    
    
}
