//
//  LoginViewController.swift
//  SQLiteTest
//
//  Created by Алексей Суровцев on 02.10.2023.
//

import Foundation
import UIKit
import SQLite

class LoginView: UIViewController {
    
    private var authdata_path: String = "/Users/w1tnessbtw/Dev/Swift/SQLiteTest/AuthData.db"
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func didTapLoginButton(_ sender: Any) {

        
        var logined: Bool {
            var password: String = ""
            var login: String = ""
            var db = try? Connection(self.authdata_path)
            let stmt = try? db!.prepare("SELECT username FROM users WHERE username = '\(self.loginTextField.text!)'")
            for row in stmt! {
                login = row[0] as! String
            }
            let stmt2 = try? db!.prepare("SELECT password FROM users WHERE username = '\(self.loginTextField.text!)'")
            for row in stmt2! {
                password = row[0] as! String
            }
            if login == self.loginTextField.text! {
                if password == self.passwordTextField.text! {
                    return true
                }
            }
            
            return false
            
        }
        
        if logined == true {
            let storyboard = UIStoryboard(name: "MainApp", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MainApp")
            navigationController?.pushViewController(vc, animated: true)
            MakeAlert.shared.MakePrimitiveAlert(vc: self, title: "Logined in!", message: "Successfull logined in!", buttonTitle: "GO ––>")
        }
        else {
            MakeAlert.shared.MakePrimitiveAlert(vc: self, title: "Oops...", message: "Something went wrong...", buttonTitle: "Retry")
        }
    }
    
    
}
