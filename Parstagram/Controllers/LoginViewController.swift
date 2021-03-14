//
//  ViewController.swift
//  Parstagram
//
//  Created by Mikayla Orange on 3/2/21.
//

import UIKit
import Parse


class LoginViewController: UIViewController, UITextFieldDelegate {

 
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordField.delegate = self
        usernameField.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func onLogin(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        PFUser.logInWithUsername(inBackground: username, password: password) {
            (user, error) in
            if (user != nil) {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            else {
                print("oh no! \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        var user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        user.signUpInBackground{(success,error) in
            if (success) {
                                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                                }
            else {
                print("oh no! \(String(describing: error?.localizedDescription))")
            }
        }
    }
    func textFieldShouldReturn(_ passwordField: UITextField) -> Bool {
        passwordField.resignFirstResponder() // dismiss keyboard

        return true;
    }
}

