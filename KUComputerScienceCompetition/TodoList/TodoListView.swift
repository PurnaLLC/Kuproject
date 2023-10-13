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
    
    
    
    
    @AppStorage("theme") var darkMode = false
    
    
    
    
    
    
    @StateObject var vmView = CheckInViewModel(ds: FirebaseDataService())
    
    @StateObject var vmView2 = CheckInViewModel(ds: UserDefaultDataService())
    
    
    
    
    
    
    @State private var isEmpty: Bool = true
    @State private var isEmpty2: Bool = true
    
    
    @StateObject var newtworkManager = NetworkManager()
    
    
    var body: some View {
   

              
            
        NavigationStack {
            
            VStack {
                
                
                Picker("Sort By", selection: $sortingOption) {
                    ForEach(SortingOption.allCases, id: \.self) { option in
                        Text(option.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                
                
                VStack{
                    
                    ScrollView{
                        
                        VStack{
                            Text("Todo" )
                                .foregroundColor(darkMode ? Color.white : Color.black)
                            
                            
                        }
                        
                        if isEmpty == true{
                            Text("NO checkin")
                                .foregroundColor(darkMode ? Color.white : Color.black)
                            
                            
                        }
                        
                        
                        
                        
                        ForEach(sortedCheckins) { checkin in
                            if checkin.iscompleted == true{
                                
                            }else{
                                
                                TodoFormatedView(checkin: checkin, vm: vmView)
                                        .onAppear{
                                            isEmpty = false
                                        }
                                    
                                    
                                
                            }
                        }
                        
                        
                        Text("Done")
                        
                            .foregroundColor(darkMode ? Color.white : Color.black)
                        
                        if isEmpty2 == true{
                            Text("NO checkin")
                                .foregroundColor(darkMode ? Color.white : Color.black)
                            
                        }
                        
                        
                        ForEach(sortedCheckins) { checkin in
                            if checkin.iscompleted == false{
                                
                            }else{
                                
                                    FormatedTodoCompleteView(vm: vmView, checkin: checkin)
                                        .onAppear{
                                            isEmpty2 = false
                                        }
                                    
                                    
                                    
                                    
                          
                                
                                
                                
                                
                                
                                
                            }
                            
                        }
                        
                        
                        
                    }
                    
                }
                
                HStack{
                    
                    Button {
                        
                        
                        isShowingSheet = true
                        
                        
                        
                        
                    } label: {
                        
                        
                        
                        Text("Add")
                            .foregroundColor(darkMode ? Color.white : Color.black)
                        
                        
                    }
                    
                    
                    
                    let lastTenCheckins = Array(vm.checkins.sorted { $0.tododate > $1.tododate }.prefix(10))
                    
                    
                    NavigationLink {
                        
                        
                        if newtworkManager.isConnected{
                            
                            
                            
                            AIChatView( vm: messageVm , lastTenCheckins: lastTenCheckins)
                            
                        }else{
                            NotConnectedAI()
                        }
                        
                        
                    } label: {
                        
                        Text("AI")
                            .foregroundColor(darkMode ? Color.white : Color.black)

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
            .background(darkMode ? Color.black : Color.white) // Set background color based on darkMode
            
            
        }
            
        

        
    }
}


