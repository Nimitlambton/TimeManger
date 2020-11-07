//
//  managerCheckVC.swift
//  TimeManger2
//
//  Created by Nimit on 30/03/21.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class managerCheckVC: UIViewController  {
    
    
    let db = Firestore.firestore()
    
    var mID :String = ""
    
    var hoursWorked = " "
    var taskDesc  =  ""
    var when  = ""
    

    struct workstuc{
        
        var hoursWorked : String!
        var taskDesc : String!
        var when : String!
        var name : String?
  }
    

    var work = [workstuc]()
    var updatedwork = [workstuc]()
    
    
    @IBOutlet weak var mytable: UITableView!
    
    
    var workdone: [QueryDocumentSnapshot] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mytable.delegate = self
        mytable.dataSource = self
        
        let uid = Auth.auth().currentUser?.uid
        let docRef = db.collection("users").document(uid!)
       
        
        docRef.getDocument(source: .server) { [self] (Document, Err) in
            var mid = Document?.get("managerid")
        
            FetchMangerId(mID: mid as! String)
          
        }
        
       
        
        
    }
   
    
    
    
 
    @IBAction func goback(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    
    
    func FetchMangerId(mID: String) {
        
      
       //
        self.db.collection("users").getDocuments() { [self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
           
            } else {
                
                work.removeAll()
                for document in querySnapshot!.documents  {
                    
                    var type =  document.get("emptype") as! String
                    
                    if(type  == "emp"){
                        
                        var assisngeId = document.get("AssignedMangerId") as! String
                        
                        if(mID == assisngeId){
                            

            let ref = db.collection("users").document(document.documentID)
            
                            ref.getDocument { (doc, Err) in
                                let result = Result {
                                    
                                    try document.data(as: User.self)
                                    
                                }
                                
                                switch result {
                                case .success(let city):
                                    if let city = city {
                                        
                                        city.workDone.map { (hello : [String : String])  in

                                            
                                            let hour2 = hello["hoursWorked"]
                                            let taskDesc2 = hello["taskDesc"]
                                            let when2 = hello["when"]
      
                            
                                            work.append(workstuc(hoursWorked: hour2 ,taskDesc : taskDesc2 , when : when2 , name:city.name ))
        
        
                                            self.mytable.reloadData()
                                            
                                           
                                                                       
                                            
                                            
                                            
                                          //  self.mytable.reloadData()
                                           
                                        }

                                    } else {
                                        print("Document does not exist")
                                    }
                                case .failure(let error):
                                    print("Error decoding city: \(error)")
  
                                }
                                
                                
                            }
                            
                            
                            
                            
                        }
                        
                        
                    }
                    
                }
                
                
                
            }
            
            
            
        }
        
          
    }
    
    
}


extension managerCheckVC : UITableViewDataSource , UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        work.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    

    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let  name = objectArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "workcell") as! WorkTabiewCell
        
        guard let hourworked =    work[indexPath.row].hoursWorked else { return cell }
        
        guard let taskDesc =    work[indexPath.row].taskDesc else { return cell }
        
        guard let when =    work[indexPath.row].when else { return cell }
        
        guard let name =    work[indexPath.row].name else { return cell }
        
        cell.setupCell(work: hourworked , taskDes :  taskDesc , at :when , name2:name )
        
        return cell
    }
    
    
    
//    func listenChangeandUpdate(mID: String){
//
//
//        db.collection("users").addSnapshotListener(includeMetadataChanges: true) { [self] (QuerySnapshot, Err) in
//
//
//            if let Err = Err {
//                print("Error getting documents: \(Err)")
//            } else {
//
//                print("listenChangeandUpdate called")
//
//                self.db.collection("users").getDocuments() { [self] (querySnapshot, err) in
//                            if let err = err {
//                                print("Error getting documents: \(err)")
//                            } else {
//
//                                for document in querySnapshot!.documents  {
//
//                                    var type =  document.get("emptype") as! String
//                                    if(type  == "emp"){
//
//                                        var assisngeId = document.get("AssignedMangerId") as! String
//
//                                        if(mID == assisngeId){
//
//                        let ref = db.collection("users").document(document.documentID)
//
//
//                var assisngeId = document.get("AssignedMangerId") as! String
//
//                if(mID == assisngeId){
//
//
//                let ref = db.collection("users").document(document.documentID)
//
//
//
//                    ref.getDocument { (doc, Err) in
//                                    let result = Result {
//                                    try document.data(as: User.self)
//                                    }
//
//                        switch result {
//                        case .success(let city):
//                            if let city = city {
//
//                                city.workDone.map { (hello : [String : String])  in
//
//                                    print("doneby\(city.name) " )
//
//
//                                    let hour2 = hello["hoursWorked"]
//                                    let taskDesc2 = hello["taskDesc"]
//                                    let when2 = hello["when"]
//
//                                    work.append(workstuc(hoursWorked: hour2 ,taskDesc : taskDesc2 , when : when2 , name:city.name ))
//
//
//                                    self.mytable.reloadData()
//
//                                }
//
//                            } else {
//                                // A nil value was successfully initialized from the DocumentSnapshot,
//                                // or the DocumentSnapshot was nil.
//                                print("Document does not exist")
//                            }
//                        case .failure(let error):
//                            // A `City` value could not be initialized from the DocumentSnapshot.
//                            print("Error decoding city: \(error)")
//
//
//
//
//                        }
//
//
//
//
//                    }
//
//
//                }
//
//
//
//
//
//
//
//
//                                        }
//                                    }
//                                }
//                            }
//                }
//
//            }
//
//
//
//
//        }
//
//}
}

extension UIViewController{

func showToast(message : String, seconds: Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .black
        alert.view.alpha = 0.5
        alert.view.layer.cornerRadius = 15
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
 }
 
