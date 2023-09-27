//
//  FirebaseMessageModel\.swift
//  KUComputerScienceCompetition
//
//  Created by Maxwell Meyer on 9/27/23.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase
import FirebaseFirestore



struct FirebaseMessage: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var role = ""
    var content = ""
    var createdAt = Date()
    var userId = ""
    var documentId: String? 

     
    
}
