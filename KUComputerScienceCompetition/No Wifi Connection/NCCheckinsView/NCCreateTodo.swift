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
        
    @AppStorage("streak") var streak: Int = 0

    
    @AppStorage("theme") var darkMode = false

    
        var body: some View {
            
            VStack{
                HStack {
            
                    VStack{
                        
                        TextField("To Do Name", text: $checkin.name)
                            .textFieldStyle(.roundedBorder)
                
                        
                        Text("Started Date: \(checkin.formattedDate())")
                        
                        
                        
                       if  checkin.iscreated == true {
                            
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
                    
                    TextField("Description of To Do", text: $checkin.description, axis: .vertical)
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
                
                
            }
            .padding()
        }
        
    
    private func performCheckIn(_ checkin : NCCheckIn) {
        

            
            if checkin.ontime == true{
                
                streak += 1
            }else{
                
                streak = 0
                
            }
            print(streak)
        
        
    }
    
        
    }


