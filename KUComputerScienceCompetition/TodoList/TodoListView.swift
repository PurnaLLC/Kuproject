//
//  TodoListView.swift
//  KUComputerScienceCompetition
//
//  Created by Maxwell Meyer on 9/5/23.
//

import SwiftUI
import Charts
import Combine

struct TodoListView: View {
    
    
    @ObservedObject var vm: CheckInViewModel
    @State private var isShowingSheet = false
    
    @State private var streak: Int = 0
    @State private var lastCheckedDate: Date?
    
  
    @State private var sortingOption: SortingOption = .newestFirst

    enum SortingOption: String, CaseIterable {
        case newestFirst = "First Add"
        case nameAZ = "A-Z"
        case duedate = "Coming Up"
    }

    var sortedCheckins: [CheckIn] {
        switch sortingOption {
        case .newestFirst:
            return vm.checkins.sorted { $0.date > $1.date }
        case .nameAZ:
            return vm.checkins.sorted { $0.name < $1.name }
        case .duedate:
            // Assuming "duedate" is a property of CheckIn, sort by duedate
            return vm.checkins.sorted { $0.tododate < $1.tododate }
        }
    }
    
    @StateObject var messageVm = FirebaseMessagesViewModel(ds: FirebaseMessageDataService())

    
    

    var body: some View {
        
        VStack{
            
            
            NavigationStack {
                
                
                
                VStack{
                    Text("Todo" )
                }
                
                Picker("Sort By", selection: $sortingOption) {
                        ForEach(SortingOption.allCases, id: \.self) { option in
                            Text(option.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                
                
                
                VStack{
                   
                ScrollView{
                    
                    

                        ForEach(sortedCheckins) { checkin in
                            HStack{
                                NavigationLink {
                                    CheckInEditView(checkin: checkin) { returnedCheckIn in
                                        vm.update(checkin: returnedCheckIn)
                                    }
                                } label: {
                                    
                                    HStack{
                                        Text("\(checkin.name) \(checkin.formattedDate())")
                                            .foregroundColor(.black)
                                            .bold()
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.00000000001)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                
                                    }
                                    .padding(.leading, 5)
                                    
                                    
                                }
                                
                                HStack{
                                    
                                    Menu {
                                        Button(role: .destructive) {
                                            
                                            vm.delete(checkin: checkin)
                                            
                                            
                                        } label: {
                                            Image(systemName: "trash")
                                                .resizable()
                                                .frame(width: 24, height: 24)
                                                .foregroundColor(.red)
                                                .cornerRadius(10)
                                                .multilineTextAlignment(.center)
                                            Text("Delete Todo")
                                            
                                            
                                        }
                                        
                                        
                                        
                                        
                                        
                                    } label: {
                                        Image(systemName: "trash")
                                            .resizable()
                                            .frame(width: 24, height: 24)
                                            .foregroundColor(.black)
                                            .cornerRadius(10)
                                            .multilineTextAlignment(.center)
                                        
                                        
                                    }
                                }
                                .frame(maxWidth: 120, alignment: .trailing)
                                .padding(.trailing, 10)

                                
                                
                                
                            }
                            .frame(width: 350, height: 50)
                            .background(checkin.iscompleted ? Color.green : Color.red)
                          
                            
                            .cornerRadius(10)
                            
                            
           
                  
                            
                            
                        }
                    }
                    
                }
                
                HStack{
                    
                    Button {
                        
                        
                        isShowingSheet = true
                        
                        
                    } label: {
                        Text("Add")
                    }
                    
                    
                    NavigationLink {
                        
                        
                        AIChatView( vm: messageVm)
                        
                        
                    } label: {
                        
                        Text("AI")
                    }

                }
                
                
                
                .sheet(isPresented: $isShowingSheet) {
                    NavigationStack {
                        CreateTodo(checkin: CheckIn()) { returnedCheckIn in
                            vm.add(checkin: returnedCheckIn)
                        }
                        .navigationTitle("Add Checkin")
                    }
                }
            }
        }
    }
    /// Custom Button View
   
}


    


