//
//  MakeAlert.swift
//  SQLiteTest
//
//  Created by Алексей Суровцев on 30.09.2023.
//

import Foundation
import UIKit

final class MakeAlert {
    static let shared = MakeAlert()
    
    func MakePrimitiveAlert(vc: UIViewController, title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default))
        vc.present(alert, animated: true)
    }
    
}
