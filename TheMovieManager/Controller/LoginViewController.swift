//
//  LoginViewController.swift
//  TheMovieManager
//
//  Created by Mehmet Sahin on 5/15/19.
//  Copyright © 2019 Mehmet. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginViaWebsiteButton: UIButton!
    @IBOutlet weak var activityIndic: UIActivityIndicatorView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        setButtons(hide: true)
        activityIndic.startAnimating()
        TMDBClient.getRequestToken(completion: handleRequestTokenResponse(success:error:))
    }
    
    @IBAction func loginViaWebsiteTapped() {
        setButtons(hide: true)
        activityIndic.startAnimating()
        TMDBClient.getRequestToken { (success, error) in
            if success {
                UIApplication.shared.open(TMDBClient.Endpoints.webAuth.url, options: [:], completionHandler: nil)
                self.performSegue(withIdentifier: "completeLogin", sender: nil)
            } else {
                self.setButtons(hide: false)
                self.activityIndic.stopAnimating()
            }
        }
       
    }
    
    func handleRequestTokenResponse(success: Bool, error: Error?) {
        if success {
            print(TMDBClient.Auth.requestToken)
            TMDBClient.login(username: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "", completion: self.handleLoginResponse(success:error:))
        } else {
            self.setButtons(hide: false)
            self.activityIndic.stopAnimating()
            showLoginFailure(message: error?.localizedDescription ?? "")
        }
    }
    
    func handleLoginResponse(success: Bool, error: Error?) {
        print(TMDBClient.Auth.requestToken)
        if success {
            TMDBClient.createSessionId(completion: handleSessionResponse(success:error:))
        } else {
            self.setButtons(hide: false)
            self.activityIndic.stopAnimating()
            showLoginFailure(message: error?.localizedDescription ?? "")
        }
    }
    
    func handleSessionResponse(success: Bool, error: Error?) {
        setButtons(hide: false)
        self.activityIndic.stopAnimating()
        if success {
            self.performSegue(withIdentifier: "completeLogin", sender: nil)
        } else {
            showLoginFailure(message: error?.localizedDescription ?? "")
        }
    }
    
    func setButtons(hide: Bool) {
        if hide {
            self.loginButton.isEnabled = false
            self.loginViaWebsiteButton.isEnabled = false
        } else {
            self.loginButton.isEnabled = true
            self.loginViaWebsiteButton.isEnabled = true
        }
    }
    
    func showLoginFailure(message: String) {
        let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
    
}
