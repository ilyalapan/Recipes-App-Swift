//
//  LogInViewController.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 30/09/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class LogInViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var facebookLogInButton: UIButton!
    
    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet weak var leftArmImageView: UIImageView!
    @IBOutlet weak var rightArmImageView: UIImageView!
    
    private var armsInitialPosition: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logInButton.layer.masksToBounds = false
        logInButton.layer.shadowRadius = 9
        logInButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        logInButton.layer.shadowColor = UIColor.black.cgColor
        logInButton.layer.shadowOpacity = 0.3

        //TODO: Text background view shadow
        
        //register for keyboard notifications
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self,action: #selector(self.dismissKeyboard)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true //Hide navigation bar
    }
    
    
    //Animation is started from this method because here the sizes of the views are correct after AutoLayout finished its work
    override func viewDidLayoutSubviews() {
        self.armsInitialPosition = self.leftArmImageView.center.y
        print("Initial position:", self.armsInitialPosition)
        Timer.scheduledTimer(timeInterval: 6.0, target: self, selector: #selector(animateLogo), userInfo: nil, repeats: true)
    }
    
    func animateLogo() {
        UIView.animate(withDuration: 0.3, delay: 1, options: .curveEaseInOut, animations: {
            self.leftArmImageView.center.y -= 15
        }, completion: { finished in
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
                    self.leftArmImageView.center.y = self.armsInitialPosition
                }, completion: nil )
        })
        
        UIView.animate(withDuration: 0.3, delay: 1.1, options: .curveEaseInOut, animations: {
            self.rightArmImageView.center.y -= 15
        }, completion: {finished in
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
                    self.rightArmImageView.center.y = self.armsInitialPosition
                    }, completion: nil )
        })
        
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func keyboardWillHide(notification: NSNotification){
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func keyboardWillShow(notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue{
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height //TODO: adjust for button
            }
        }
            
    }
    
    @IBAction func signInButtonAction(_ sender: AnyObject) {
        if let email = self.emailField.text, let pwd = self.passwordField.text{
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user,error) in
                if error == nil {
                    print("Email user signed in to Firebase")
                    UIApplication.shared.delegate?.window??.rootViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController() //TODO: Figure out why I have two ?? here
                    
                } else {
                    //handle errors
                }
            })
            
        }
    }
    
    @IBAction func facebookLogInButton(_ sender: AnyObject) {
        
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logOut()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self){(result, error) in
            if error != nil {
                print("Unable to authenticate with FB \(error)") //Error 308, enabled keychain sharing
            } else if result?.isCancelled == true {
                print("User cancelled")
            }
            else {
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
                
                UIApplication.shared.delegate?.window??.rootViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController() //TODO: Figure out why I have two ?? here
            }
        }
        
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential){
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("Unable to authenticate with Firebase \(error)")
            } else {
                print("Succesfully authenticated with Firebase")
            }
        })
    }

    
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.navigationController?.navigationBar.isHidden = false
    }

}
