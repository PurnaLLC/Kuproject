//
//  User.swift
//  KUComputerScienceCompetition
//
//  Created by Maxwell Meyer on 9/6/23.
//

import Foundation
import Firebase
import FirebaseStorage


struct User: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
    
}
