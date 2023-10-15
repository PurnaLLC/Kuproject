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
                            
                            Text("\(message.content)")
                                .foregroundColor(darkMode ? Color.white : Color.black)
                                .font(.custom("Lora-Regular", size: 20))
                            
                            
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
                        .foregroundColor(darkMode ? Color.black :  Color.black)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.custom("Lora-Regular", size: 20))

                    

               
                    Button {
                        
                        
                        
                        viewModel.sendMessage(lastTenCheckins)
                        
                        
                        
                    } label: {
                        Text("Send")
                            .foregroundColor(darkMode ? Color.white : Color.black)
                            .font(.custom("Lora-Regular", size: 20))
                            .fontWeight(.bold)

                        
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
        
     
    }




