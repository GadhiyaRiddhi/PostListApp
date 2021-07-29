//
//  Extention.swift
//  PostApp
//
//  Created by Riddhi  on 01/05/21.
//

import Foundation
import UIKit

extension UIViewController {
    func popupAlert(message: String, title: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
           alertController.addAction(OKAction)
           self.present(alertController, animated: true, completion: nil)
    }
}
