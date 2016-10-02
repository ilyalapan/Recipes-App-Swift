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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Add animation code here
        
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

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
