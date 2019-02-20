//
//  TableViewController.swift
//  MemeMe_version1
//
//  Created by Fatima Abdulraheem on 01/12/2018.
//

import UIKit

//we need to add additional delegates for TableView such as: UITableViewDataSource, UITableViewDelegate
class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}//end of TableViewController Class
