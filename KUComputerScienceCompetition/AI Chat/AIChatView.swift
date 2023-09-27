//
//  AIChatView.swift
//  KUComputerScienceCompetition
//
//  Created by Maxwell Meyer on 9/27/23.
//

import SwiftUI

struct AIChatView: View {
   
        @ObservedObject var viewModel = AIChatViewModel()
        
        
        @EnvironmentObject var viewsModel: AuthViewModel
        
        
        
        //   @Bindable var datamodel: DataModel
        //    @Environment(\.modelContext) private var modelContext
        //    @Query var extractedDatas: [ExtractedData]
        @Environment (\.dismiss) var dismiss
        
        
        @State private  var isFetchingData = false
     
        
        
        @ObservedObject var vm : FirebaseMessagesViewModel
    
    
        
        
        var body: some View {
            VStack {
                ScrollView {
                    
        
                    
                    
                    
                    ForEach(vm.firebaseMessages.filter({$0.role != "system"}), id: \.id) { message in
                        
                        Text("\(message.content)")
                        
                    }
            
                }
                HStack {
                    TextField("Enter a message...", text: $viewModel.currentInput)
                        
                    Button {
                        viewModel.sendMessage()
                    } label: {
                        Text("Send")
                    }

                }
            }
            .padding()
        }
        
     
    }




