//
//  ViewController.swift
//  gitHomeWork
//
//  Created by Rihards Zīverts on 20/05/2020.
//  Copyright © 2020 Rihards Zīverts. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func validateFields() -> String? {
        
        //Check that are fields are filled in
        if (usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            ((passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)) == nil)) {
            let alert = UIAlertController(title: "Empty text fields!", message: "Please enter your email and password to log in.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        return nil
        
    }

    @IBAction func login(_ sender: UIButton) {
        
        validateFields()
        
        let email = usernameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: password) {
            (result, error) in
            
            if error != nil {
                
                let alert = UIAlertController(title: "Wrong email or password!", message: "Make sure that you are using correct email and password.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
    
            } else {
                
                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
                
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
                
            }
        }
    }
    
}

