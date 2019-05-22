//
//  UIViewController+Extension.swift
//  TheMovieManager
//
//  Created by Mehmet Sahin on 5/15/19.
//  Copyright © 2019 Mehmet. All rights reserved.
//

import UIKit

extension UIViewController {
    
    @IBAction func logoutTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        TMDBClient.logout()
    }
    
}
