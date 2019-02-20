//  MemeTableViewController.swift
//  MemeMe_version2.0
//
//  Created by Fatima Abdulraheem on 31/12/2018.
//

//Helpful Code for creating tableviews: https://www.youtube.com/watch?v=FtO5QT2D_H8
import Foundation
import UIKit

class MemeTableViewController: UITableViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var meme: [MStruct] {
        return (UIApplication.shared.delegate as! AppDelegate).meme
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData() //This function to reload the data when the table view will appear at the first time
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meme.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTCell", for: indexPath) as! TableViewCell
        let meme = self.meme[indexPath.row]
        cell.tableImageView.image = meme.memedImage
        cell.lableTableView.text = meme.topText
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //When Selecting an item from the TableView:
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let image = meme[indexPath.item].memedImage
        let ViewC = self.storyboard?.instantiateViewController(withIdentifier: "MemeInfoViewController") as! MemeInfoViewController
        ViewC.Image_rec = image
        ViewC.Index_rec = indexPath as NSIndexPath
        self.navigationController?.pushViewController(ViewC, animated: true)
    }
} // end of Class MemeTableViewController
