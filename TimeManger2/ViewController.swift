//
//  ViewController.swift
//  TimeManger2
//
//  Created by Nimit on 26/03/21.
//

import UIKit
import Firebase
class ViewController: UIViewController {

    var handel : NSObjectProtocol!
    let db = Firestore.firestore()
    let sb = UIStoryboard(name: "Main", bundle: nil)
    var empType: String = ""
    
//gnfsjk
    
    @IBOutlet weak var empActivity: UIButton!
    
    @IBOutlet weak var empName: UILabel!
    @IBOutlet weak var typeTitle: UILabel!
    @IBOutlet weak var ID: UILabel!
    
    
    override  func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .systemIndigo
       
           // print("gotcha?\(String(describing: Auth.auth().currentUser?.uid))!")
        
            
            let uid = Auth.auth().currentUser?.uid
        //   print("id\(uid!)" )
            
            let docRef = db.collection("users").document(uid!)

            docRef.getDocument() {  (document, error) in
              if let document = document {
                self.empType =  document.get("emptype") as! String
                print(self.empType)
    self.empName.text = "Welcome \(document.get("name")!)"
                
        self.typeTitle.text = "Employee type \(document.get("emptype")!)"
                
                
                if(document.get("emptype") as! String == "manager"){
                    
                    self.ID.text =   "Your ID \(document.get("managerid")!)"
               
                    
                    self.empActivity.setTitle("Check work 👀", for: .normal)
                    
                    
                }else {
                    
                self.ID.text =   "Your ID \(document.get("AssignedMangerId")!)"
                    
                    
                    self.empActivity.setTitle("Submit work📄 ", for: .normal)
                    
                }
                
              } else {
                print("Document does not exist in cache")
              }
            }
            
  
        }
    
//    override func viewWillDisappear(_ animated: Bool) {
//
//        Auth.auth().removeStateDidChangeListener(handel)
//    }
   

    @IBAction func logout(_ sender: Any) {
        
        
        do { try Auth.auth().signOut() }
           catch { print("already logged out") }
           
      
        let secondVC = self.sb.instantiateViewController(identifier: "login")
       
        
       
        
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
   
   

    
    
    @IBAction func empActivity(_ sender: Any) {
        
        
    
        
        if(self.empType == "manager"){
            
          
            
            let secondVC = sb.instantiateViewController(identifier: "Managercheck")
       
            navigationController?.pushViewController(secondVC, animated: true)
            
        }else {
            
            let secondVC = sb.instantiateViewController(identifier: "empCheck")
       
            navigationController?.pushViewController(secondVC, animated: true)
            
        }
        
        
        
    }
    
    
    
    
}

