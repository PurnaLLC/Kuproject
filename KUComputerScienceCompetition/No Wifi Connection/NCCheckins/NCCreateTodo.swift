//
//  NCCreateTodo.swift
//  KUComputerScienceCompetition
//
//  Created by Maxwell Meyer on 10/12/23.
//

import SwiftUI

struct NCCreateTodo: View {
    
    
    
        @State var checkin: NCCheckIn
        var save: (NCCheckIn)->()
        @Environment(\.dismiss) var dismiss
        
    
    @AppStorage("theme") var darkMode = false

    
        var body: some View {
            
            VStack{
                HStack {
            
                    VStack{
                        
                        TextField("Todo Name", text: $checkin.name)
                            .textFieldStyle(.roundedBorder)
                
                        
                        Text("Started Date: \(checkin.formattedDate())")
                        
                        
                        VStack {
                            DatePicker("Finished By", selection: $checkin.tododate, in: Date()..., displayedComponents: .date)
                            
                        }
                        VStack {
                            DatePicker("", selection: $checkin.tododate, in: Date()..., displayedComponents: .hourAndMinute)
                            
                        }
                        
                    }
        
                    
                }
                
                
           
                
                VStack(alignment: .center){
                    
                    TextField("Description of todo", text: $checkin.description, axis: .vertical)
                               .lineLimit(2)
                               .textFieldStyle(.roundedBorder)
                               .padding()

                }
                
                
                .padding()

                
                
                Button {
                    
                    
                     
                  

                    save(checkin)
                    
                    dismiss()
                    
                    
                    
                    
                    
                } label: {
                    HStack{
                        Text("Save")
                            .foregroundColor(darkMode ? Color.white : Color.black)
                            .font(.custom("Lora-Regular", size: 25))

                        
                    }
                    .frame(width: 80, height: 50)
                    
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(darkMode ? Color.white : Color.black, lineWidth: 2)
                    )
                    
                    
                    .padding(.bottom, 5)
                }
                
                
            }
            .padding()
        }
        









        




        
    }


