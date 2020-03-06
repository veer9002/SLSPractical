//
//  UIAlertController+Extensions.swift
//  SLSPractical
//
//  Created by Manish Sharma on 06/03/20.
//  Copyright © 2020 Manish Sharma. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
  func alert(message: String, title: String = "") {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion: nil)
  }
}
