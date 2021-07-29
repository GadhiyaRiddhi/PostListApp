//
//  ViewController.swift
//  PostApp
//
//  Created by Riddhi  on 01/05/21.
//

import UIKit
import RxSwift
import RxCocoa

class LoginVC: UIViewController {
    
    //MARK: Variables
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var pwdTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    let loginObj = LoginViewModel()
    let disposeBag = DisposeBag()
    
    //MARK: View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addObserversToComponenets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTF.becomeFirstResponder()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: Helper Methods
    func addObserversToComponenets() {
        emailTF.rx.text
            .map { $0 ?? "" }
            .bind(to: loginObj.emailText)
            .disposed(by: disposeBag)
        
        pwdTF.rx.text
            .map { $0 ?? "" }
            .bind(to: loginObj.passwordText)
            .disposed(by: disposeBag)
        
        loginObj.isValid()
            .bind(to: loginBtn.rx.isEnabled)
            .disposed(by: disposeBag)
        
        loginObj.isValid()
            .map{ $0 ? 1 : 0.5 }
            .bind(to: loginBtn.rx.alpha)
            .disposed(by: disposeBag)
    }
    
    //MARK: Action Methods
    @IBAction func loginButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "ShowListOfPostVC", sender: self)
    }
    
}

