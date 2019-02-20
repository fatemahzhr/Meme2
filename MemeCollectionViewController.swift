//  MemeCollectionViewController.swift
//  MemeMe_version2.0
//
//  Created by Fatima Abdulraheem on 31/12/2018.
//

import UIKit
import Foundation

private let reuseIdentifier = "MemeCCell"

class MemeCollectionViewController: UICollectionViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var meme: [MStruct] {
        return (UIApplication.shared.delegate as! AppDelegate).meme
    }
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewWillAppear(_ animated: Bool) {
        //Helpful website to load data in the collectionview for the first time: http://www.benmeline.com/ios-empty-table-view-with-swift/
        super.viewWillAppear(animated)
        collectionView?.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView?.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //Arrange the cells in the collectionViews:
        let sizee:CGFloat = 3.0
        let dimin = (view.frame.size.width - (2 * sizee)) / 3.0
        //set the spacing between the cells in the collectionView:
        flowLayout.minimumInteritemSpacing = sizee
        flowLayout.minimumLineSpacing = sizee
        flowLayout.itemSize = CGSize(width: dimin, height: dimin)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appDelegate.meme.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCCell", for: indexPath) as! MemeCollectionViewCell
        let meme = self.appDelegate.meme[indexPath.row]
        cell.CollectionImageView.image = meme.memedImage
        cell.CollectionImageView.contentMode = .scaleAspectFill
        return cell
    }

    //When Selecting an item from the CollectionView:
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = meme[indexPath.item].memedImage
        let ViewC = self.storyboard?.instantiateViewController(withIdentifier: "MemeInfoViewController") as! MemeInfoViewController
        ViewC.Image_rec = image
        ViewC.Index_rec = indexPath as NSIndexPath
        self.navigationController?.pushViewController(ViewC, animated: true)
    }
}//End of Class MemeCollectionViewController
