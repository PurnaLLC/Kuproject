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
                
                
                Button {
                    
                    
                     
                  

                    save(checkin)
                    
                    dismiss()
                    
                    
                    
                    
                    
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
        









        




        
    }


