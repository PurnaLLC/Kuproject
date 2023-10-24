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
        
        @Environment (\.dismiss) var dismiss
        
        
        @State private  var isFetchingData = false
    
    
        @ObservedObject var vm : FirebaseMessagesViewModel
    
    
        @State var lastTenCheckins: [CheckIn]
    
                                                        
    @AppStorage("theme") var darkMode = false

    
        var body: some View {
            VStack {
                
                
             
                ScrollViewReader { scrollView in
                    ScrollView {
                        
                        
                        ForEach(vm.firebaseMessages.filter({$0.role != "system"}), id: \.id) { message in
                            
                            
                            messageView(message: message)
                            
                              
                            
                        }
                    }
                    
                    .onAppear {
                          withAnimation {
                              scrollView.scrollTo(vm.firebaseMessages.last?.id)
                          }
                      }
                  
                }

            
                
             
                HStack {
                    TextField("Talk with your AI assistant", text: $viewModel.currentInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.custom("Lora-Regular", size: 20))
                        .foregroundColor(Color.black)
                        

               
                    Button {
                        
                        
                        
                        viewModel.sendMessage(lastTenCheckins)
                        
                        
                        
                    } label: {
                        Text("Send")
                            .foregroundColor(darkMode ? Color.white : Color.black)
                            .font(.custom("Lora-Regular", size: 20))
                            .fontWeight(.bold)

                        
                    }
                    
                    .onAppear{
                        
                        print(lastTenCheckins)
                    }
                    

                    

                }

                
                
                
            
            }
            .padding()
            
            
            .frame(
                  minWidth: 0,
                  maxWidth: .infinity,
                  minHeight: 0,
                  maxHeight: .infinity,
                  alignment: .topLeading
                )

            
            
            .background(darkMode ? Color.black : Color.white)
        
        
            
            
 
            
            
            
            
            
            
            
        }
    
    func messageView(message: FirebaseMessage) -> some View {
        HStack {
            
            let messageRole = message.role
            if messageRole == "user" { Spacer()}
            Text(message.content)
                .padding()
                .foregroundColor(darkMode ? Color.white : Color.black)
                .font(.custom("Lora-Regular", size: 20))
                .background(message.role == "user" ? Color.blue : Color.gray.opacity(0.2))
                .cornerRadius(10)
             if message.role == "assistant" { Spacer() }
        }
    }
        
     
    }




