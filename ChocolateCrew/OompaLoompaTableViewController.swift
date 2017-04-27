//
//  OompaLoompaTableViewController.swift
//  ChocolateCrew
//
//  Created by Aina Cuxart on 24/4/17.
//  Copyright © 2017 Aina Cuxart. All rights reserved.
//

import UIKit
import Alamofire

class OompaLoompaTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchBarHeightConstraint: NSLayoutConstraint!
    
    var oompaLoompaList = Array<Any>()
    var oompaLoompaAuxList = Array<Any>()
    let searchBarHeight: CGFloat = 44.0
    
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
        
        searchBar.delegate = self
        searchBarHeightConstraint.constant = 0
        
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
        
        let oompaLoompa: OompaLoopma = oompaLoompaList[indexPath.row] as! OompaLoopma
        let details: Array<[String: String]> = createDetailsForOompaLoompa(oompaLoompa:oompaLoompa)
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let detailViewController: OompaLoompaDetailTableViewController = storyBoard.instantiateViewController(withIdentifier: "OompaLoompaDetail") as! OompaLoompaDetailTableViewController
        
        detailViewController.details = details
        detailViewController.oompaLoompaImageLink = oompaLoompa.image
        
        navigationController?.pushViewController(detailViewController, animated: true)
        
        
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
    
    
    // MARK: - UISearchBarDelegate
    @IBAction func searchIconPressed(_ sender: Any) {
        
        if searchBarHeightConstraint.constant == searchBarHeight {
            hideSearchBar(AndDeleteSearch: false)
        } else {
            showSearchBar()
        }
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.oompaLoompaList = self.oompaLoompaAuxList
        self.oompaLoompaAuxList = Array()
        
        tableView.reloadData()
        
        hideSearchBar(AndDeleteSearch: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let search = searchBar.text {
            var newList: Array<OompaLoopma> = Array()
            
            for oompa in oompaLoompaList {
                
                if let oompaLoompa: OompaLoopma = oompa as! OompaLoopma, oompaLoompa.first_name.contains(search) || oompaLoompa.last_name.contains(search) {
                    newList.append(oompaLoompa)
                }
            }
            let auxList = self.oompaLoompaList
            self.oompaLoompaList = newList
            self.oompaLoompaAuxList = auxList
            self.tableView.reloadData()

        }
        
        hideSearchBar(AndDeleteSearch: false)
    }
    
    func showSearchBar() {
        
        for view in searchBar.subviews {
            for subview in view.subviews {
                if let button = subview as? UIButton {
                    button.isEnabled = true
                }
            }
        }
        
        searchBarHeightConstraint.constant = searchBarHeight
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
        searchBar.becomeFirstResponder()
    }
    
    func hideSearchBar(AndDeleteSearch delete: Bool) {
        
        view.endEditing(true)
        searchBarHeightConstraint.constant = 0
        if delete {
            searchBar.text = ""
        }
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
    }
    
    
}
