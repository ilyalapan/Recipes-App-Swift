//
//  RegistrationViewController.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 02/10/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func registerButtonAction(_ sender: AnyObject) {
        //Register user
        self.view.isUserInteractionEnabled = false
        let email = self.emailTextField.text
        let password = self.passwordTextField.text
        FIRAuth.auth()?.createUser(withEmail: email!, password: password!) { (user, error) in
            self.view.isUserInteractionEnabled = true
            if error == nil {
                print("Email user registered in to Firebase")
                UIApplication.shared.delegate?.window??.rootViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController() //TODO: Figure out why I have two ?? here
                
            }
        }
        
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
