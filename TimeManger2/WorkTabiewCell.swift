//
//  WorkTabiewCell.swift
//  TimeManger2
//
//  Created by Nimit on 03/04/21.
//

import UIKit

class WorkTabiewCell: UITableViewCell {

    
    
    @IBOutlet weak var wotkDone: UILabel!
    
    @IBOutlet weak var workDoneAt: UILabel!
    
    @IBOutlet weak var timeconsumed: UILabel!
    
    @IBOutlet weak var name: UILabel!
    
    struct workstuc{
        
        var hoursWorked : String!
        var taskDesc : String!
        var when : String!
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupCell(work :  String , taskDes :  String ,  at :  String , name2 : String ) {
        
        wotkDone.text = "Hours worked :: \(work)"
        workDoneAt.text = "Task descrption::  \(taskDes)"
        timeconsumed.text = "at:: \(at) "
        name.text = "Done by:: \(name2)"
       
        
    }

}
