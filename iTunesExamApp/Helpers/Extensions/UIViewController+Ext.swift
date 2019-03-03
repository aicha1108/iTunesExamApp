//
//  UIViewController+Ext.swift
//  iTunesExamApp
//
//  Created by Aicha on 03/03/2019.
//  Copyright © 2019 Aiza Simbra. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    //MARK: present alert controller to view controller with optional handler
    func presentAlertControllerWithMessageAndHandler(_ message: String, title: String, buttonText: String, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonText, style: .default, handler: handler))
        self.present(alert, animated: true)
    }
}
