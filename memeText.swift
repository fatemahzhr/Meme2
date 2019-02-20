//
//  meme.swift
//  MemeMe_version1
//
//  Created by Fatimah Abdulraheem on 22/11/2018.
//

import Foundation
import UIKit

//Source code:https://classroom.udacity.com/nanodegrees/nd003-connect/parts/e030daf6-4190-4303-a1a9-8dd3bf643f1d/modules/c32ed5ce-e093-43e1-8b7d-88ee7fce1a6b/lessons/4798201455/concepts/37669185700923
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
    NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeColor.rawValue):
        UIColor.black,
    NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue):
        UIColor.white,
    NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
    NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeWidth.rawValue): -5]


//The ViewController class will conform these protocols:
//IViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate
class memeText: ViewController{
   
} // end of class meme
