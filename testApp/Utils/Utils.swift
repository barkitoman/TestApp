//
//  utils.swift
//  testApp
//
//  Created by Doyle on 7/03/18.
//  Copyright © 2018 Doyle. All rights reserved.
//

import Foundation

public class Utils {
    
    class  func isValidEmail(string: String) -> Bool {
        let emailReg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailReg)
        return emailTest.evaluate(with: string)
    }

}

