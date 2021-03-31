//
//  empSubmitPortralVC.swift
//  TimeManger2
//
//  Created by Nimit on 30/03/21.
//

import UIKit
import Firebase
class empSubmitPortralVC: UIViewController {
    
    
    @IBOutlet weak var hoursWorked: UITextField!
    
    @IBOutlet weak var taskDesc: UITextField!
    
    
  

    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
  
       
        
        
        
        
        
        
    }
    

    @IBAction func goback(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
 
    }
    
    
    
    
    @IBAction func submitTask(_ sender: Any) {
        
  
        let uid = Auth.auth().currentUser?.uid
        
        let UserRef = db.collection("users").document(uid!)
        
        
        let when = Date()
        let data: [String: Any] = [
            "taskDesc" : taskDesc.text! ,
            "hoursWorked" : hoursWorked.text!,
            "when" : when,
        ]
        
        UserRef.updateData([
        "workDone": FieldValue.arrayUnion([data])
        ])
   
    }


}
