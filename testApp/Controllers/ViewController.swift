//
//  ViewController.swift
//  testApp
//
//  Created by Doyle on 6/03/18.
//  Copyright © 2018 Doyle. All rights reserved.
//

import UIKit
import TTGSnackbar

class ViewController: UIViewController {

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnLogin.layer.cornerRadius = 5
        self.btnLogin.layer.borderWidth = 1
        #if DEBUG
            self.txtEmail.text = "barcoleon1990@gmail.com"
            self.txtPassword.text = "123456789"
        #endif

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func login(_ sender: Any) {
        
        let username = self.txtEmail.text
        let password = self.txtPassword.text
        
        if (username?.count)! < 5
        {
            let snackbar = TTGSnackbar(message: "Username must be greater than 5 characters.", duration: .long)
            snackbar.leftMargin = 8
            snackbar.bottomMargin = 8
            snackbar.rightMargin = 8
            snackbar.contentInset = UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
            snackbar.show()
        } else if (password?.count)! < 8 {
            let snackbar = TTGSnackbar(message: "Password must be greater than 8 characters.", duration: .long)
            snackbar.leftMargin = 8
            snackbar.bottomMargin = 8
            snackbar.rightMargin = 8
            snackbar.contentInset = UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
            snackbar.show()
            
        } else {
            if Utils.isValidEmail(string: username!){
                
                let userDefaults = UserDefaults.standard
                userDefaults.set(self.txtEmail.text, forKey: "email")
                self.txtEmail.text = ""
                self.txtPassword.text = ""
                performSegue(withIdentifier: "showHome", sender: self)
            }else{
                let snackbar = TTGSnackbar(message: "Username is not  mail valid.", duration: .long)
                snackbar.leftMargin = 8
                snackbar.bottomMargin = 8
                snackbar.rightMargin = 8
                snackbar.contentInset = UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
                snackbar.show()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showHome" {
            //aca iba  a pasar el mail 
        }
    }
    
}

