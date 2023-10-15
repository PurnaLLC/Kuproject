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
                    
                    Text("Sort")
                        .foregroundColor(darkMode ? Color.white : Color.black)
                        .font(.custom("Lora-Regular", size: 20))
                        .bold()
                    


                    
                    Text("Not Connected")
                    
                    
                    
                    VStack{
                    
                    
                    Picker("Sort By", selection: $sortingOption) {
                        ForEach(SortingOption.allCases, id: \.self) { option in
                            Text(option.rawValue)
                        }
                    }
                    
                        
                        
                    .pickerStyle(SegmentedPickerStyle())
                              .foregroundColor(darkMode ? Color.white : Color.black)
                          }
                          .preferredColorScheme(darkMode ? .dark : .light)
                    
                    
                    VStack{
                        
                        ScrollView{
                            
                        
                            
                            VStack{
                                Text("Todo" )
                                    .foregroundColor(darkMode ? Color.white : Color.black)
                                   
                                    .font(.custom("Lora-Regular", size: 25))
                                    .bold()
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 5)

                                
                                
                            }
                            
                            if isEmpty == true{
                                Text("NO Todo")
                                    .foregroundColor(darkMode ? Color.white : Color.black)
                                    .font(.custom("Lora-Regular", size: 16))

                                
                            }
                            
                            
                                              
                            
                            
                            
                            ForEach(sortedNCCheckins) { checkin in
                                if checkin.iscompleted == false{
                                    
                                  
                                  
                                    HStack{
                                        
                                        
                                        HStack{
                                            NavigationLink {
                                                NCEditCheckinView(checkin: checkin) { returnedCheckIn in
                                                    vm.update(checkin: returnedCheckIn)
                                                    
                                                }
                                                
                                            } label: {
                                                
                                                HStack{
                                                    Text("\(checkin.name) \(checkin.formattedDate())")
                                                        .font(Font.headline.weight(.semibold))

                                                        .foregroundColor( Color.black)
                                                        .font(.custom("Lora-Regular", size: 20))
                                                        
                                                    
                                                    
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
                                                        .shadow(color: .gray, radius: 2, x: 2, y: 1)

                                                        .foregroundColor(.black)
                                                        .cornerRadius(10)
                                                        .multilineTextAlignment(.center)
                                                    
                                                    
                                                }
                                            }
                                            .frame(maxWidth: 120, alignment: .trailing)
                                            .padding(.trailing, 10)
                                            
                                                
                                            
                                    
                                        }
                                        .frame(width: 350, height: 50)
                                        .background(Color.logoBlue)
                                        
                                        
                                        .cornerRadius(10)
                                        
                                        
                                        .onAppear{
                                            isEmpty = false
                                        }
                                        
                                    }
                                    .shadow(color: Color.gray, radius: 3, x: 3, y: 4)

                                    .padding(.bottom, 5)

                                    
                                }
                            }
                            
                            
                            Text("Done")
                                .foregroundColor(darkMode ? Color.white : Color.black)
                               
                                .font(.custom("Lora-Regular", size: 25))
                                .bold()
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 5)

                            
                            if isEmpty2 == true{
                                Text("NO Todo")
                                    .foregroundColor(darkMode ? Color.white : Color.black)
                                    .font(.custom("Lora-Regular", size: 16))

                            }
                            
                            
                            ForEach(sortedNCCheckins) { checkin in
                                if checkin.iscompleted == true{
                                    
                                    HStack{
                                        HStack{
                                            NavigationLink {
                                                NCEditCheckinView(checkin: checkin) { returnedCheckIn in
                                                    vm.update(checkin: returnedCheckIn)
                                                }
                                                
                                                
                                            } label: {
                                                
                                                HStack{
                                                    Text("\(checkin.name) \(checkin.formattedDate())")
                                                        .font(Font.headline.weight(.semibold))

                                                        .foregroundColor(darkMode ? Color.white : Color.black)
                                                        .font(.custom("Lora-Regular", size: 20))
                                                        
                                                    
                                                    
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
                                                        .shadow(color: .gray, radius: 2, x: 2, y: 1)

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
                                        
                                        
                                        .onAppear{
                                            isEmpty2 = false
                                        }
                                        
                                    }
                                    

                                       
                                    .shadow(color: Color.gray, radius: 3, x: 3, y: 4)
                                    
                                    .padding(.bottom, 5)

                                    
                                    
                                    
                                    
                                    
                            }
                            
                            
                            
                        }
                        
                            
                            
                    }
                    
                    HStack{
                        
                        Button {
                            
                            
                            isShowingSheet = true
                            
                            
                            
                            
                        } label: {
                            
                            HStack{
                                Text("Add")
                                    .foregroundColor(darkMode ? Color.white : Color.black)
                                    .font(.custom("Lora-Regular", size: 25))
                                    .fontWeight(.medium)

                                
                            }
                            .frame(width: 80, height: 50)
                            
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(darkMode ? Color.white : Color.black, lineWidth: 2)
                            )
                            
                            
                            .padding(.bottom, 5)
                            
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





