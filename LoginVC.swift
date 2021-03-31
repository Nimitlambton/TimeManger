//
//  LoginVC.swift
//  TimeManger2
//
//  Created by Nimit on 28/03/21.
//

import UIKit
import Firebase
class LoginVC: UIViewController {

    
    
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var password: UITextField!
    

    let sb = UIStoryboard(name: "Main", bundle: nil)
    var handel : NSObjectProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    @IBAction func Login(_ sender: Any) {
        var email = Email.text!
        var pass = password.text!
        login(email: email, password: pass)
    }
    

    
    
    func login(email :String , password : String){
        
        
        print(email)
        print(password)
        
        Auth.auth().signIn(withEmail: email, password: password) {
            [weak self] authResult, error in
          
          //  print(authResult.)
          
            if(error == nil){
                
                
                print("succeslogin")
                
            
                self?.navigationController?.popViewController(animated: true)
                let secondVC = self?.sb.instantiateViewController(identifier: "main")
               
                self?.navigationController?.pushViewController(secondVC!, animated: true)
                
                
            }else {
                
               print( error?.localizedDescription)
                
            }

            
        }
        
 
    
    }
    
    
    
    
    @IBAction func createAccount(_ sender: Any) {
        
       
        let secondVC = sb.instantiateViewController(identifier: "SecondVC")
        navigationController?.pushViewController(secondVC,  animated: true)
        
        
    }
    


}
