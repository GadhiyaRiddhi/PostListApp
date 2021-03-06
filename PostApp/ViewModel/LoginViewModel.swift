//
//  LoginViewModel.swift
//  PostApp
//
//  Created by Riddhi  on 01/05/21.
//

import Foundation
import RxCocoa
import RxSwift

class LoginViewModel {
    
    let emailText = PublishSubject<String>()
    let passwordText = PublishSubject<String>()
    
    func isValid() -> Observable<Bool> {
        return Observable.combineLatest(emailText.asObservable().startWith(""), passwordText.asObservable().startWith(""))
            .map { email, password in
                return self.isValidEmail(email) && self.isValidPassword(password)
        }.startWith(false)
    }
    
    fileprivate func isValidEmail(_ input: String) -> Bool {
        guard
            let regex = try? NSRegularExpression(
                pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}",
                options: [.caseInsensitive]
            )
            else {
                assertionFailure("Error while comparing with regex.")
                return false
        }
        
        let regexFirstMatch = regex
            .firstMatch(
                in: input,
                options: [],
                range: NSRange(location: 0, length: input.count)
        )
        
        return regexFirstMatch != nil
    }
    
    fileprivate func isValidPassword(_ input: String) -> Bool {
        return input.count >= 8 && input.count <= 15
    }
}
