//
//  ChatInListModel.swift
//  KUComputerScienceCompetition
//
//  Created by Maxwell Meyer on 9/6/23.
//


import Foundation
import FirebaseFirestoreSwift


struct CheckIn: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var date = Date()
    var name = ""
    var userId = ""
    var documentId: String?
    var iscompleted = false
    var description = ""
    var tododate = Date()
    var ontime = false
    
    
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

    
}
