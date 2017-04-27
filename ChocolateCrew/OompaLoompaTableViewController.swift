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
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    
    
    var oompaLoompaList = Array<Any>()
    var oompaLoompaOriginalList = Array<Any>()
    
    let searchBarHeight: CGFloat = 44.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        OompaLoompaService.allOompaLoompa(success: { list in
            self.oompaLoompaList = list
            self.oompaLoompaOriginalList = list
            self.tableView.reloadData()
        }, failure: {_ in 
            
        })
        
        self.navigationItem.title = localizedString("oompa_loompa_table_title")
        
        // Search Bar
        searchBar.delegate = self
        searchBarHeightConstraint.constant = 0
        
        // Segmented Control
        genderSegmentedControl.setTitle(localizedString("filter_gender_both"), forSegmentAt: 0)
        genderSegmentedControl.setTitle(localizedString("filter_gender_male"), forSegmentAt: 1)
        genderSegmentedControl.setTitle(localizedString("filter_gender_female"), forSegmentAt: 2)
        
        genderSegmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        registerForKeyboardNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        deregisterFromKeyboardNotifications()
    }
    
    
    // MARK: - TableView Delegate and DataSource methods
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
        
        self.oompaLoompaList = self.oompaLoompaOriginalList
        
        tableView.reloadData()
        
        hideSearchBar(AndDeleteSearch: true)
        
        // Show gender filter
        genderSegmentedControl.isHidden = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let search = searchBar.text {
            var newList: Array<OompaLoopma> = Array()
            
            for oompa in oompaLoompaList {
                
                if let oompaLoompa: OompaLoopma = oompa as! OompaLoopma, oompaLoompa.first_name.contains(search) || oompaLoompa.last_name.contains(search) {
                    newList.append(oompaLoompa)
                }
            }
            self.oompaLoompaList = newList
            
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
        
        // Hide gender filter
        genderSegmentedControl.isHidden = true
        self.oompaLoompaList = self.oompaLoompaOriginalList
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
    
    // MARK: - Filter by gender
    func selectionDidChange(_ sender: UISegmentedControl) {
        
        var gender: String = ""
        
        switch sender.selectedSegmentIndex {
        case 0:
            gender = ""
            
        case 1:
            gender = "M"
            
        case 2:
            gender = "F"
            
        default:
            gender = ""
        }
        
        if gender != "" {
            var newList: Array<OompaLoopma> = Array()
            
            for oompa in oompaLoompaOriginalList {
                
                if let oompaLoompa: OompaLoopma = oompa as! OompaLoopma, oompaLoompa.gender == gender {
                    newList.append(oompaLoompa)
                }
            }
            self.oompaLoompaList = newList
            
        }else {
            self.oompaLoompaList = self.oompaLoompaOriginalList
        }
        
        tableView.reloadData()
    }
    
    
    // MARK: - Scroll when keyboard was shown/hiden
    func registerForKeyboardNotifications(){
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func deregisterFromKeyboardNotifications(){
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    
    func keyboardWasShown(notification: NSNotification){
        
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        
        self.tableView.frame.size.height = self.tableView.frame.size.height - (keyboardSize?.height)!
    
    }
    
    func keyboardWillBeHidden(notification: NSNotification){
        
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        
        self.tableView.frame.size.height = self.tableView.frame.size.height + (keyboardSize?.height)!

    }

}
