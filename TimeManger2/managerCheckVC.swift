//
//  managerCheckVC.swift
//  TimeManger2
//
//  Created by Nimit on 30/03/21.
//

import UIKit
import Firebase

class managerCheckVC: UIViewController {

    
    let db = Firestore.firestore()
    
    var mID = ""
    
    
    var workdone: [QueryDocumentSnapshot] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        let uid = Auth.auth().currentUser?.uid

        let docRef = db.collection("users").document(uid!)
        
        docRef.getDocument() { [self]  (document, error) in
          if let document = document {
           // print(document.get("managerid")! )

            var mID = document.get("managerid")! as! String
            
          
          }else {}
          
        }
                
        self.db.collection("users").getDocuments() { [self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                
                for document in querySnapshot!.documents {
                    var type =  document.get("emptype")
                 
                    if(type as! String == "emp"){

                        var assisngeId = document.get("AssignedMangerId") as! String
                        if(mID == assisngeId){
                            
                         
                            workdone.append(document)
                            print(workdone)
                        }
                }
            }
                
                
            }
            
        
        }
        

        
 
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    @IBAction func goback(_ sender: Any) {
    
    
        navigationController?.popViewController(animated: true)
    
    
    
        
    }


}
