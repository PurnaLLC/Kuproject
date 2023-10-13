//
//  NCEditCheckinView.swift
//  KUComputerScienceCompetition
//
//  Created by Maxwell Meyer on 10/12/23.
//

import SwiftUI

struct NCEditCheckinView: View {
  

        @State var checkin: NCCheckIn
        var save: (NCCheckIn)->()
        @Environment(\.dismiss) var dismiss
        

        
        
        @AppStorage("streak") var streak = 0

        var body: some View {
            
            VStack{
                HStack {
                    
                    
                    VStack{
                        
                        
                        TextField("Todo Name", text: $checkin.name)
                            .textFieldStyle(.roundedBorder)
                        
                 
                        
                        Text("Started Date: \(checkin.formattedDate())")
                        
                        
                        
                        VStack(alignment: .center){
                        
                            
                            
                            Button {
                                
                                
                                checkin.iscompleted.toggle()
                                
                                
                                if checkin.tododate > Date(){
                                    
                                    checkin.ontime = true
                                }else{
                                    checkin.ontime = false
                                    
                                }
                                
                                
                                
                                
                                
                            } label: {
                              
                                VStack{
                                    Image(systemName: "checkmark.circle")
                                }
                                
                                .background(checkin.iscompleted ? Color.green : Color.red)
                            }
                            
                        }
                        VStack {
                            DatePicker("Finished By", selection: $checkin.tododate, in: Date()..., displayedComponents: .date)
                            
                              }
                        
                        VStack {
                            DatePicker("", selection: $checkin.tododate, in: Date()..., displayedComponents: .hourAndMinute)
                                  
                                    }
                        
                        
                    }
                    
                    
                    
                    
                }
                
                
                
                Button {
                    save(checkin)
                    dismiss()
                
                    
                    print("\(streak)")
                    
                    

                } label: {
                    Text("Save")
                }
                
                VStack(alignment: .center){
                    
                    TextField("Description of todo", text: $checkin.description, axis: .vertical)
                               .lineLimit(2)
                               .textFieldStyle(.roundedBorder)
                               .padding()

                }
                
                
            }
            .padding()
        }
        
       
        
        private func performCheckIn(_ checkin : CheckIn) {
            
            if checkin.ontime == true{
                
                streak += 1
            }else{
                
                streak = 0

            }
            print(streak)
        }
        
      
        
        
        
    }
