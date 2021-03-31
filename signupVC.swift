//
//  signupVC.swift
//  TimeManger2
//
//  Created by Nimit on 28/03/21.
//

import UIKit
import Firebase
class signupVC: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var mangerID: UITextField!
   
    
    let db = Firestore.firestore()
    var empType: String = ""
    var currentUser : User!
    var mID  = 0
    

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        empType = "manager"
        mangerID.isHidden = true
        // Add a new document with a generated ID
        
       // let userRef = db.collection("users")
     //   print(userRef.)
        
    
        setMID()
        
        
        
    }
    

    @IBAction func Signup(_ sender: Any) {
        
      print("singup")
        
        if (empType == "manager"){
            Register(email: email.text!, pass: password.text!, emptype: empType, name: name.text!, managerid: String(mID + 1))
        }else {
            Register(email: email.text!, pass: password.text!, emptype: empType, name: name.text!, managerid: mangerID.text!)
        }
    
    }
    
    @IBAction func finish(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
   
   
    @IBAction func userType(_ sender: UISegmentedControl) {
    
        let type = sender.selectedSegmentIndex
        if(type == 0){
            
         empType = "manager"
            mangerID.isHidden = true
            
            
        }else {
            
            empType = "emp"
            
            mangerID.isHidden = false
        }
    }
    
    
    private func Register(email : String , pass : String , emptype : String, name: String , managerid : String ){
        
        print("hitted reg \(email) +\(pass) +\(email)) + \(emptype) + \(name) ")
        
        Auth.auth().createUser(withEmail: email, password: pass) { [self] authResult, error in
 
            if(error == nil){
                
                
                if(emptype == "manager"){
 
                    let Data: [String: Any] = [
                        "name": name,
                        "email": email,
                        "emptype": emptype,
                        "managerid":managerid
                        ]
                    
                    
                    self.db.collection("users").document((authResult?.user.uid)!).setData(Data)
                    
                }else {
                    
                    
                    let Data: [String: Any] = [
                        "name": name,
                        "email": email,
                        "emptype": emptype,
                        "AssignedMangerId":managerid
                        ]

                    self.db.collection("users").document((authResult?.user.uid)!).setData(Data)
                }
             
             self.navigationController?.popViewController(animated: true)

            }else{
               
                print(error?.localizedDescription)
                
            }
        }
        
    }
    
  
    
    
    //MARK: - Helper functions
    
    
    func setMID()  {
        db.collection("users").getDocuments() { [self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                print(querySnapshot!.count)
                
                for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.get("emptype")!)"
                    var type =  document.get("emptype")
                    
                    if(type as! String == "manager"){
                        
                        self.mID += 1
                    
                    }
                }
            }
        }
    }
    
}
