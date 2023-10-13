//
//  CreateTodo.swift
//  KUComputerScienceCompetition
//
//  Created by Maxwell Meyer on 9/5/23.
//

import SwiftUI

struct CreateTodo: View {
    @State var checkin: CheckIn
    var save: (CheckIn)->()
    @Environment(\.dismiss) var dismiss
    
    @State private var streak: Int = 0
    @State private var lastCheckedDate: Date?
    
    
    
    
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
