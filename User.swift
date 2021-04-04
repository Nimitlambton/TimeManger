//
//  User.swift
//  TimeManger2
//
//  Created by Nimit on 28/03/21.
//

import Foundation

//class User {
//
//    var name : String
//    var  hoursWorked :String
//    var  taskDesc : String
//    var when : String
//
//
//    init(name: String ,hoursWorked: String ,  taskDesc: String ,when :String )  {
//
//        self.name = name
//        self.hoursWorked = hoursWorked
//        self.taskDesc = taskDesc
//        self.when = taskDesc
//
//        }
//
//
//
//
//}


struct User  : Codable{
    
    var AssignedMangerId :String
    let name : String
    let email : String
    let emptype : String
    var workDone : [[String : String]]

}






