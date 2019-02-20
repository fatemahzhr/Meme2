//  MemeInfoViewController.swift
//  MemeMe_version2.0
//
//  Created by Fatima Abdulraheem on 31/12/2018.
//

import UIKit

class MemeInfoViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!

    var meme: MStruct! = nil
    var Image_rec: UIImage!
    var Index_rec: NSIndexPath!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = Image_rec
    }
}
