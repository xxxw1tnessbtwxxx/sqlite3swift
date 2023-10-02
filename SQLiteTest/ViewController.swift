//
//  ViewController.swift
//  SQLiteTest
//
//  Created by Алексей Суровцев on 30.09.2023.
//

import UIKit
import SQLite
import SQLite3

class ViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var authdata_path: String = "/Users/w1tnessbtw/Dev/Swift/SQLiteTest/AuthData.db"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            let db = try Connection(self.authdata_path)
            
            let table = Table("users")
            let nameColumn = Expression<String>("username")
            let passwordColumn = Expression<String>("password")
            
            let completion = table.create { t in
                t.column(nameColumn, primaryKey: false)
                t.column(passwordColumn, primaryKey: false)
            }
            
            try db.run(completion)
        }
        catch {
            print(error)
        }
        
    }
    
    @IBAction func didTapRegisterButton(_ sender: Any) {
        
        var list: [String] = []
        
        let db = try? Connection(self.authdata_path)
        let stmt = try? db!.prepare("SELECT username FROM users")
        for row in stmt! {
            list.append(row[0] as! String)
        }

        if (list.contains(self.loginTextField.text!)) {
            MakeAlert.shared.MakePrimitiveAlert(vc: self, title: "Error", message: "This login exists.", buttonTitle: "Retry")
            return
        }
        else {
            let userstable = Table("users")
            let username = Expression<String>("username")
            let password = Expression<String>("password")
            let stmt = userstable.insert(username <- self.loginTextField.text!, password <- self.passwordTextField.text!)
            try? db?.run(stmt)
            MakeAlert.shared.MakePrimitiveAlert(vc: self, title: "Registered", message: "Now, u are member!", buttonTitle: "Thank you!")
        }
        
    }
    @IBAction func didTapSignIn(_ sender: Any) {
        MakeAlert.shared.MakePrimitiveAlert(vc: self, title: "Pressed", message: "Asdf", buttonTitle: "asdasd")
    }
    
    
    @IBAction func didTapEnterSign(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginView") as! LoginView
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
