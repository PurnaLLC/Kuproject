//
//  NCCheckins.swift
//  KUComputerScienceCompetition
//
//  Created by Maxwell Meyer on 10/12/23.
//

import Foundation
import FirebaseFirestoreSwift


struct NCCheckIn: Identifiable, Codable {
    var id = UUID()
    var date = Date()
    var name = ""
    var userId = ""
    var documentId: String?
    var iscompleted = false
    var description = ""
    var tododate = Date()
    var ontime = false
    var iscreated = false 
    
    
    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        return dateFormatter.string(from: date)
    }

    func formattedTodoDate() -> String {
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        return dateFormatter.string(from: tododate)
    }

    
    
    func formattedDateComaring(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
    

    
    
    
    
}


