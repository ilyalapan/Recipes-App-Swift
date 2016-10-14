//
//  PostViewController.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 13/10/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import UIKit
import Firebase
import Alamofire


class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var recipeImageView: UIImageView!

    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    var photo: UIImage?
    var recipe: Recipe = Recipe()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let URL = NSURL(string: recipe.thumbnailImageURLString)
        self.recipeImageView.sd_setImage(with: URL as URL!)
        self.recipeNameLabel.text = self.recipe.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    //MARK: Post request
    @IBAction func postButtonPressed(_ sender: AnyObject) {
        //TODO: Make it go to feed
        if self.photo != nil {
            let currentUser = FIRAuth.auth()?.currentUser
            currentUser?.getTokenForcingRefresh(true) {idToken, error in
                if let error = error {
                    // Handle error
                    return
                }
                let headers = ["Authorization": "Bearer " + idToken!,]
                print(headers)
                let url :String = "http://topmeal-142219.appspot.com/post_to_feed"
                Alamofire.upload(
                    multipartFormData: {data in
                        data.append(UIImageJPEGRepresentation(self.photo!, 0.6)!, withName: "image_data", fileName: "image.jpg", mimeType: "image/jpg")
                        data.append(String(self.recipe.id).data(using: String.Encoding.utf8)!,withName: "recipe_id")
                    },
                    usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold,
                    to: url,
                    method: HTTPMethod.post,
                    headers: headers,
                    encodingCompletion: {encodingResult in
                        self.navigationController?.popViewController(animated: true)
                })
            }
        }
        else {
            //TODO: Implemnt recipe sharing
        }
    }
    
    //MARK: Image Picker 
    
    //Present a choice of image sources and call the method to present picker with appropriate source
    @IBAction func photoButtonPressed(_ sender: AnyObject){
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.presentPicker(source: .camera)
        })
        let cameraRollAction = UIAlertAction(title: "Camera Roll", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.presentPicker(source: .photoLibrary)

        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        optionMenu.addAction(cameraRollAction)
        optionMenu.addAction(cameraAction)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
        
        
    }
    
    
    //present picker with given source
    func presentPicker(source: UIImagePickerControllerSourceType) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)

    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        photo = (info[UIImagePickerControllerEditedImage] as! UIImage)
        photoImageView.image = photo
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
