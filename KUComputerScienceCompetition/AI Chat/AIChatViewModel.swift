//
//  AIChatViewModel.swift
//  KUComputerScienceCompetition
//
//  Created by Maxwell Meyer on 9/27/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore
import Combine



    
    
    class AIChatViewModel: ObservableObject {
        
        @Published var messages: [Message] = [Message(id: "first-message", role: .system, content: "", createdAt: Date())]
        
        
        
        @Published var currentInput: String = ""
        
        private let openAIService = OpenAIService()
        
        
 
        

        
        func sendMessage()  {
            let newMessage = Message(id: UUID().uuidString, role: .user, content: currentInput, createdAt: Date())
            messages.append(newMessage)
            currentInput = ""
            let firebaseUSerMessage = FirebaseMessage(role: newMessage.role.rawValue, content: newMessage.content)

            add(firebaseUSerMessage)
            //          let newMessage = Message(id: UUID().uuidString, role: .user, content: " I want 1 word. In this category: \(selectedPickerIndex3). I want this difficulty: \(selectedPickerIndex2). Do NOT give me any of these old words: \(oldWords)", createdAt: Date())
            
            
            
            //     messages.append(newMessage)
            
            print(" MAX LOOK HERE \(newMessage)")
            
            
            Task {
                let response = await openAIService.sendMessage(messages: messages)
                guard let receivedOpenAIMessage = response?.choices.first?.message else {
                    print("Had no received message")
                    return
                }
                let receivedMessage = Message(id: UUID().uuidString, role: receivedOpenAIMessage.role, content: receivedOpenAIMessage.content, createdAt: Date())
                
                
                let firebaseAIMessage = FirebaseMessage(role: receivedMessage.role.rawValue, content: receivedMessage.content)
                
                

        
                
                await MainActor.run {
                    messages.append(receivedMessage)
                    print("\(receivedMessage)")
  
                    add(firebaseAIMessage)
               
                }
             
                
         
                
            }
            
            
            
            
            
            
        }
        
        
        
        
        
        func parseStreamData(_ data: String) ->[ChatStreamCompletionResponse] {
            let responseStrings = data.split(separator: "data:").map({$0.trimmingCharacters(in: .whitespacesAndNewlines)}).filter({!$0.isEmpty})
            let jsonDecoder = JSONDecoder()
            
            return responseStrings.compactMap { jsonString in
                guard let jsonData = jsonString.data(using: .utf8), let streamResponse = try? jsonDecoder.decode(ChatStreamCompletionResponse.self, from: jsonData) else {
                    return nil
                }
                return streamResponse
            }
        }
        
        
        
        
        
 
        
        
        
        
    }
    

    
    
    func add(_ firebaseMessage: FirebaseMessage) {
        
        
         let db = Firestore.firestore()
         let collectionName = "firebaseMessages"
        
        
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User is not authenticated.")
            return
        }
        
        var checkinWithUserId = firebaseMessage
        checkinWithUserId.userId = userId

        do {
            let documentReference = try db.collection(collectionName).addDocument(from: checkinWithUserId)
            checkinWithUserId.documentId = documentReference.documentID
        } catch {
            print("Error adding checkin to Firestore: \(error)")
        }
    }


    
    

    
    
    
    

struct newCharacter: Identifiable{
    var id: String = UUID().uuidString
    var value: String
    var index: Int = 0
    var rect: CGRect = .zero
    var pusOffset: CGFloat = 0
    var isCurrent: Bool = false
    
}

struct Message: Decodable, Hashable {
    let id: String
    let role: SenderRole
    let content: String
    let createdAt: Date

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}



struct ChatStreamCompletionResponse: Decodable {
    let id: String
    let choices: [ChatStreamChoice]
}
struct ChatStreamChoice: Decodable {
    let delta: ChatStreamContent
}
struct ChatStreamContent: Decodable {
    let content: String
}

