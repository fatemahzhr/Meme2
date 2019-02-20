//
//  ViewController.swift
//  MemeMe_version1
//
//  Created by Fatimah Abdulraheem on 23/11/2018.
//  Project Name: MemeMe 1.0
//  Project Discription: this project will make the user able to select an image from the album or Camera then edit it by writing a tob and bottom text then share it at the end.
//

import UIKit
import Foundation

//The ViewController class will conform these protocols:
//IViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate
class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    //Create an outlet for the image view picker, toolbars, and buttons:
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var shareBar: UIToolbar!
    @IBOutlet weak var SelectBar: UIToolbar!
    @IBOutlet weak var chooseImgBtn: UIButton!
    @IBOutlet weak var cameraBtnn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    
    //create memeTextAttributes for formatting the textboxes:
    //Source code:https://classroom.udacity.com/nanodegrees/nd003-connect/parts/e030daf6-4190-4303-a1a9-8dd3bf643f1d/modules/c32ed5ce-e093-43e1-8b7d-88ee7fce1a6b/lessons/4798201455/concepts/37669185700923
    let memeTextAttributes: [NSAttributedString.Key : Any] = [
        NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeColor.rawValue):
            UIColor.black,
        NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue):
            UIColor.white,
        NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeWidth.rawValue): -5]

    //variables for counting the text length:
    var cBottom = 0
    var cTop = 0
    
    //Create an object from the struct(MStruct):
    var meme: MStruct?

    //******************************
    // MARK: ViewDidLoad:
    override func viewDidLoad() {
        super.viewDidLoad()
        shareBtn.isEnabled = false
        //if camera is available then it will be enabled
        cameraBtnn.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)

        //Call a function to set the textboxes:
        SetTextFun(txtBtn: topText, t: "TOP")
        SetTextFun(txtBtn: bottomText, t: "BOTTOM")
        //change the view background color to grey:
        view.backgroundColor = UIColor.gray
      
    } //End of func viewDidLoad
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //to hide the keyboard:
        unsubscribeFromKeyboardNotifications()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        
    }
    
    //Source Code: https://github.com/carlosdelamora/MemeMe1.0/blob/master/MemeMe%201.0/MemeEditorViewController.swift
    func subscribeToKeyboardNotifications() {
        //Add the observer:
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func unsubscribeFromKeyboardNotifications() {
        //Remove the observer:
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //Set a function to edit the textboxes:
    func SetTextFun(txtBtn: UITextField, t: String){
        txtBtn.delegate = self  //Set the text delegate
        txtBtn.text = t //set the textboxes when the view did load:
        txtBtn.defaultTextAttributes = memeTextAttributes   //set the textFields to the text attributes:
        txtBtn.borderStyle = .none  //remove the boarder style
        txtBtn.textAlignment = NSTextAlignment.center   //alignment for the textboxes to be center:
    }// end of SetTextFun func
    
    //when the user press on return button:
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // resignFirstResponder will resign from the textfield when the return button is pressed
        textField.resignFirstResponder()
        return true
    }
    
    //clear the text when beging typing.
    //Source Code: https://github.com/carlosdelamora/MemeMe1.0/blob/master/MemeMe%201.0/MemeEditorViewController.swift
    func textFieldDidBeginEditing(_ textField: UITextField){
        //the text will be cleared at the begining only:
        if cTop == 0 && topText.isFirstResponder {
            textField.text = ""
            cTop += 1
        }
        //We clear bottom field textbox at the first time
        if cBottom == 0 && bottomText.isFirstResponder {
            textField.text = ""
            cBottom += 1
        }
    }
    
    //******************************
    //Perform pickAnImageCamera and pickAnImageAlbum functions for the buttons:
    @IBAction func takeCamerafun(_ sender: Any) {
        displayImage(source: .camera)
    }//end of takeCamerafun function
    
    @IBAction func chooseAlbumBtn(_ sender: Any) {
        displayImage(source: .photoLibrary)
    }//end of chooseAlbumBtn function
    
    //Display Image function:
    func displayImage(source: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        self.present(imagePicker, animated: true, completion: nil)
    } //end of displayImage func
    
    //Func after selecting an image:
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imagePickerView.image = image
        picker.dismiss(animated: true, completion: nil)
        //enable the share button after the image was selected by the user
        shareBtn.isEnabled = true
    }//end of imagePickerController func
    
    //Func after canceling the image choose
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //******************************
    // MARK: Share Process
    @IBAction func ShareProcessFunc(_ sender: Any) {
        let MImage = generateMemedImage()
        let c = UIActivityViewController(activityItems: [MImage], applicationActivities: nil)
        
        //Check the saving process:
        //Source code: https://github.com/carlosdelamora/MemeMe1.0/blob/master/MemeMe%201.0/MemeEditorViewController.swift
        c.completionWithItemsHandler = {
            (_,finiish: Bool,_,_)->Void
            //check if the saving process finished then it will be saved, otherwise an error message will be shown to the user
            in if finiish{
                self.save()
            } else{
                print("Sorry, the image was not saved!")
            }
        }
        
        self.present(c, animated: true, completion: nil)
    } //End of ShareProcessFunc
    
    func save(){
        meme = MStruct(memedImage: generateMemedImage(), originalImage: imagePickerView.image!, topText: topText.text!, bottomText: bottomText.text!)
        print("The memed picture was saved successfully :)")
    }
    
    func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //Method to generate the Meme image
    func generateMemedImage() -> UIImage
    {
        //Hide toolBars
        toolBarStatusFunc(x: true)
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        //Show toolBars
        toolBarStatusFunc(x: false)
        return memedImage
    }
    
    //function to hide and show the toolbars:
    func toolBarStatusFunc(x: Bool){
        SelectBar.isHidden = x
        shareBar.isHidden = x
    }
    //******************************
    // MARK: Keyboard    
    //Source Code for the following functions is: https://classroom.udacity.com/nanodegrees/nd003-connect/parts/e030daf6-4190-4303-a1a9-8dd3bf643f1d/modules/c32ed5ce-e093-43e1-8b7d-88ee7fce1a6b/lessons/4798201455/concepts/36746285400923
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let u = notification.userInfo
        let kSize = u![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return kSize.cgRectValue.height
    }
    
    //selector for the notification to Hide
    @objc func keyboardWillShow(notification: NSNotification) {
        let x = view.frame.origin.y
        if x == 0 && bottomText.isFirstResponder {
            view.frame.origin.y -= getKeyboardHeight(notification as Notification)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let y = view.frame.origin.y
        if y != 0 {
            view.frame.origin.y = 0
        }
    }
    
    //Source Code: https://grokswift.com/dismissing-the-ios-keyboard-when-user-taps-off-of-it/
    func dismissKeyboard(sender: AnyObject) {
        topText?.resignFirstResponder()
        bottomText?.resignFirstResponder()
    }
    
}//End of class ViewController

