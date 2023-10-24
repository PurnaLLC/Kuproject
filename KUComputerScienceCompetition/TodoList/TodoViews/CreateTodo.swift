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
    
    @AppStorage("streak") var streak: Int = 0
    @State private var lastCheckedDate: Date?
    
    @AppStorage("theme") var darkMode = false

    
    
    var body: some View {
        
        VStack{
            HStack {
        
                VStack{
                    
                    TextField("Todo Name", text: $checkin.name)
                        .textFieldStyle(.roundedBorder)
                    
                    
                    Text("Started Date: \(checkin.formattedDate())")
                    
                    
                        .onAppear{
                            print(checkin.date)
                            print("\(Date())")
                        }
                    
            
                   if checkin.iscreated == true {
                        
                        VStack(alignment: .center){
                            
                            
                            
                            
                            
                            
                       
                                
                                
                                Button {
                                    
                                    
                                    checkin.iscompleted.toggle()
                                    
                                    
                                    if checkin.tododate > Date(){
                                        
                                        checkin.ontime = true
                                        
                                   

                                    }else{
                                        checkin.ontime = false
                                        
                                        
                                    }
                                    
                                    if checkin.iscompleted == true {
                                        checkin.completedDate = Date()
                                    }
                                    
                               
                         
                                    
                                    
                                } label: {
                                    
                                    HStack{
                                        
                                        if checkin.iscompleted{
                                            Text("Done")
                                                .foregroundColor(darkMode ? Color.white : Color.black)

                                        }else{
                                            Text("Mark As Done")
                                                .foregroundColor(darkMode ? Color.white : Color.black)

                                        }
                                        
                                    VStack{
                                        Image(systemName: "checkmark.circle")
                                        
                                            .font(.title2)
                                        
                                            .foregroundColor(checkin.iscompleted ? Color.green : Color.red)
                                            .padding(.horizontal, 18)
                                            .padding(.vertical, 8)
                                            .frame(width: 30, height: 30)
                                        
                                        
                                    }
                                    
                                }
                                
                                
                                
                            }
                            
                            
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                        }
                        
                        
                        
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                        
                    }
                    
                    
                    
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
                
                
                 
                
                if checkin.iscreated == false  {
                    
                
                    checkin.iscreated = true
                    
                    save(checkin)
                    
                        
                    
                    
                    
                }else{
                    
                    
                    
              
                    
                    save(checkin)
                    
                        
                    
                    if checkin.iscompleted{
                        performCheckIn(checkin)
                    }
                    
                }
                
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
            
            .preferredColorScheme(darkMode ? .dark : .light)

            
            
        }
        .padding()
        .preferredColorScheme(darkMode ? .dark : .light)

        
    }
    
    private func performCheckIn(_ checkin : CheckIn) {
        
        if checkin.iscompleted{
            
            if checkin.ontime == true{
                
                streak += 1
            }else{
                
                streak = 0
                
            }
            print(streak)
        }
        
        
        
    }
    

    
    









    




    
}
