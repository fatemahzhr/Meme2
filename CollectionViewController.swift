//
//  CollectionViewController.swift
//  MemeMe_version1
//
//  Created by Fatima Abdulraheem on 01/12/2018.
//

import UIKit

//we need to add additional delegates for CollectionView such as: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
} //end of CollectionViewController Class
