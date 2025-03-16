//
//  String+.swift
//  Portfolio
//
//  Created by 홍정민 on 3/16/25.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }

    var isValidID: Bool {
         let idRegex = "^[A-Za-z]{7,}$"
         let idPredicate = NSPredicate(format: "SELF MATCHES %@", idRegex)
         return idPredicate.evaluate(with: self)
     }
     
     var isValidPassword: Bool {
         let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$%^&*])[A-Za-z\\d!@#$%^&*]{10,}$"
         let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
         return passwordPredicate.evaluate(with: self)
     }
     
     var isValidPhoneNumber: Bool {
         let phoneRegex = "^010-\\d{4}-\\d{4}$"
         let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
         return phonePredicate.evaluate(with: self)
     }
}
