//
//  AuthViewModel.swift
//  KUComputerScienceCompetition
//
//  Created by Maxwell Meyer on 9/6/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import SwiftUI
import CryptoKit
import FirebaseFirestore
import AuthenticationServices



protocol AuthenticationFormProtocol {
    var formIsValid: Bool {get}
}


@MainActor
class AuthViewModel: ObservableObject{
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    

    
    
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task{
            await fetchUser()
        }
    }
    
    
    
    
    
    
    func signIn(withEmail email: String, password: String) async throws {
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        }catch{
            print("DEBUG: Failed to logo in with error \(error.localizedDescription)")
        }
        
    }
    
    
    
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
           do {
               let result = try await Auth.auth().createUser(withEmail: email, password: password)
               self.userSession = result.user
               let user = User(id: result.user.uid, fullname: fullname, email: email)
               let encodedUser = try Firestore.Encoder().encode(user)
               try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
               
               await fetchUser()
           } catch {
               print("DEBUG: Failed to create user with error \(error.localizedDescription)")
           }
       }
       
    
    
    
    
    
    func createGmailUser(fullname: String) async throws {
        guard let currentUser = Auth.auth().currentUser else {
            print("DEBUG: User not logged in.")
            return
        }
        
        let uid = currentUser.uid
        let email = currentUser.email ?? ""
        
        self.userSession = Auth.auth().currentUser
        
        let newUser = User(id: uid, fullname: fullname, email: email)
        let encodedUser = try Firestore.Encoder().encode(newUser)
        try await Firestore.firestore().collection("users").document(uid).setData(encodedUser)
        
        
        userSession = currentUser
        
        await fetchUser()
        
        
    }
    
    
    func deleteUser(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let userId = userSession?.uid else {
            print("DEBUG: User not logged in.")
            return
        }

        Task {
            do {
                // Delete user document from Firestore
                let userDocumentRef = Firestore.firestore().collection("users").document(userId)
                
               
                try await userDocumentRef.delete()
                
                // Delete user account from Firebase Auth
                try await Auth.auth().currentUser?.delete()
                
        

                // Clear user session
                userSession = nil
        
                print("User deleted successfully.")
                completion(.success(()))
            } catch {
                print("DEBUG: Failed to delete user with error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }

    
    
    func signOut(){
        do{
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print ("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    

    func fetchUser() async{
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}
        self.currentUser = try? snapshot.data(as:User.self)
        
        
    }
 
    
}
