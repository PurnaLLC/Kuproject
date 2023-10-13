//
//  NCCheckins.swift
//  KUComputerScienceCompetition
//
//  Created by Maxwell Meyer on 10/12/23.
//

import SwiftUI

struct NCCheckinsView: View {
  
        
        
        @ObservedObject var vm: NCCheckInViewModel
        @State private var isShowingSheet = false
        
        @State private var streak: Int = 0
        @State private var lastCheckedDate: Date?
        
        
        @State private var sortingOption: SortingOption = .newestFirst
        
    
    
        enum SortingOption: String, CaseIterable {
            
            case newestFirst = "First Add"
            case nameAZ = "A-Z"
            case duedate = "Coming Up"
            
        }
        
        var sortedNCCheckins: [NCCheckIn] {
            switch sortingOption {
            case .newestFirst:
                return vm.ncCheckins.sorted { $0.date > $1.date }
            case .nameAZ:
                return vm.ncCheckins.sorted { $0.name < $1.name }
            case .duedate:
                return vm.ncCheckins.sorted { $0.tododate < $1.tododate }
            }
        }
        
   
        
        
        
        @AppStorage("theme") var darkMode = false
        
        
        
        
        
        
        @StateObject var vmView = NCCheckInViewModel(ds: NCUserDefaultDataService())
        
        
        
        
        
        
        
        @State private var isEmpty: Bool = true
        @State private var isEmpty2: Bool = true
        
        
        @StateObject var newtworkManager = NetworkManager()
        
        
        var body: some View {
       

                  
                
            NavigationStack {
                
                
                
                VStack {
                    
                    Text("Not Connected")
                    
                    
                    
                    
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
                            
                            
                                              
                            
                            
                            
                            ForEach(sortedNCCheckins) { checkin in
                                if checkin.iscompleted == false{
                                  
                                
                                    
                                    
                                    NCTodoFormatedView(checkin: checkin, vm: vmView)
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
                            
                            
                            ForEach(sortedNCCheckins) { checkin in
                                if checkin.iscompleted == true{
                                    
                                    
                                        NCFormatedTodoCompleteView(vm: vmView, checkin: checkin)
                                            .onAppear{
                                                isEmpty2 = false
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
                        
                    
                        
                        
                        
                        
                        
                        NavigationLink {
                            
                            
                            if newtworkManager.isConnected{
                                
                                
                                
                                
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
                            
                            NCCreateTodo(checkin: NCCheckIn()) { returnedCheckIn in
                                vm.add(checkin: returnedCheckIn)
                                
                           }
                           .navigationTitle("Add Todo")
                        }
                    }
                    
                }
                .background(darkMode ? Color.black : Color.white) // Set background color based on darkMode
                
                
            }
                
            

            
        }
    }



    
    
}







struct NCTodoFormatedView: View {
    
    @State  var checkin: NCCheckIn
    
    
    @ObservedObject var vm: NCCheckInViewModel
    
    
    var body: some View {
        
        
        HStack{
            NavigationLink {
                NCEditCheckinView(checkin: checkin) { returnedCheckIn in
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
                        
                //        vm.delete()
                        
                        
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
        .background(Color.blue)
        
        
        .cornerRadius(10)
        
        
    }
}






struct NCFormatedTodoCompleteView: View {
    
    
    @ObservedObject var vm: NCCheckInViewModel

    
    
    @State var checkin: NCCheckIn
    var body: some View {

        HStack{
            NavigationLink {
                NCEditCheckinView(checkin: checkin) { returnedCheckIn in
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
                        
                      //      vm.delete()
                        
                        
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
        .background(checkin.ontime ? Color.green : Color.red)
        
        
        .cornerRadius(10)
        

    }
}



