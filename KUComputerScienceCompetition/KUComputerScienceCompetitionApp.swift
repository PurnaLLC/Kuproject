//
//  KUComputerScienceCompetitionApp.swift
//  KUComputerScienceCompetition
//
//  Created by Maxwell Meyer on 8/30/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore
import Combine




@main
struct KUComputerScienceCompetitionApp: App {
    
    
    @AppStorage("signIn") var isSignIn = false
    
    @AppStorage("log_status") var log_Status = false
    
    @StateObject var viewModel = AuthViewModel()


    
    init () {
        FirebaseApp.configure()
        let db = Firestore.firestore()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentsView()
                .environmentObject(viewModel)
            
        }
      
    }
  
}

