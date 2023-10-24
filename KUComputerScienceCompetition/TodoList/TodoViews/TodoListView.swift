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
        case last30days = "Last 30 days"
    }
    
    
    
    let thirtyDaysAgo = Calendar.current.date(byAdding: .day, value: -30, to: Date())!
    
    
    var sortedCheckins: [CheckIn] {
        switch sortingOption {
        case .newestFirst:
            return vm.checkins.sorted { $0.date > $1.date }
        case .nameAZ:
            return vm.checkins.sorted { $0.name < $1.name }
        case .duedate:

            return vm.checkins.sorted { $0.tododate < $1.tododate }
        case .last30days:
            return vm.checkins.filter { checkIn in
                if let completedDate = checkIn.completedDate {
                    return completedDate >= thirtyDaysAgo
                }
                return false
            }
        
        }
        
        
    }
    
    
    
    
    
  //  @AppStorage("theme") var darkMode = false
    
    
    
    
    
    
    @StateObject var vmView = CheckInViewModel(ds: FirebaseDataService())
    
    
    
    
    
    
    
    @State private var isEmpty: Bool = true
    @State private var isEmpty2: Bool = true
    
    
    @StateObject var newtworkManager = NetworkManager()
    
    
    @AppStorage("theme") var darkMode = false


    
    @ObservedObject var vmNC: NCCheckInViewModel

    
    
    @State private var isPresentingSheet = false

    
    @State private var isPresentingSheet2 = false

    
    
    
    var body: some View {
   
        
        
            
            
            
            
            VStack {
                
                Text("Sort")
                    .foregroundColor(darkMode ? Color.white : Color.black)
                    .font(.custom("Lora-Regular", size: 20))
                    .bold()
                
                
                
                
                VStack {
                    Picker("Sort By", selection: $sortingOption) {
                        ForEach(SortingOption.allCases, id: \.self) { option in
                            Text(option.rawValue)
                                .foregroundColor(darkMode ? Color.white : Color.black)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .preferredColorScheme(darkMode ? .dark : .light)

                }

                
                
                .padding()
                
                
                
                VStack() {

                    ScrollView{
                        
                        VStack(alignment: .leading) {
                            Text("To Do" )
                                .foregroundColor(darkMode ? Color.white : Color.black)
                                .font(.custom("Lora-Regular", size: 25))
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 5)


                            
                        }
                        
                        
                        if isEmpty == true{
                            Text("NO Todo")
                              .foregroundColor(darkMode ? Color.white : Color.black)
                            .font(.custom("Lora-Regular", size: 20))

                            
                            
                        }
                        
                        
                        
                        
                        ForEach(sortedCheckins) { checkin in
                            
                       
                                
                                
                            if checkin.iscompleted == true{
                                
                            }else{
                                
                                
                                HStack{
                                    
                                    HStack{
                                        NavigationLink {
                                            
                                            
                                            CreateTodo(checkin: checkin) { returnedCheckIn in
                                                vm.update(checkin: returnedCheckIn)
                                            }
                                            
                                            
                                        } label: {
                                            
                                            HStack{
                                                Text("\(checkin.name) ")
                                                    .font(.custom("Lora-Regular", size: 20))
                                                    .bold()
                                                    .foregroundColor(.black)
                                                
                                                
                                                
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
                                                    Text("Delete To Do")
                                                    
                                                    
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
                                    
                                    .scaledToFill()
                                    
                                    
                                    
                                    .cornerRadius(10)
                                    
                                }
                                .shadow(color: Color.gray, radius: 3, x: 3, y: 4)
                                
                                .padding(.bottom, 5)
                                
                                
                                
                                
                                
                                .onAppear{
                                    isEmpty = false
                                }
                                
                                
                            
                            }
                        }
                        
                                
                        
                        VStack{
                            Text("Done")
                            
                                .foregroundColor(darkMode ? Color.white : Color.black)
                                .font(.custom("Lora-Regular", size: 25))
                                .bold()
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 5)
                            
                            
                            
                        }
                        
                        
                        if isEmpty2 == true{
                            Text("NO Todo")
                                .foregroundColor(darkMode ? Color.white : Color.black)
                                .font(.custom("Lora-Regular", size: 20))
                            
                        }
                        
                        
                        ForEach(sortedCheckins) { checkin in
                            if checkin.iscompleted == false{
                                
                            }else{
                                
                                HStack{
                                    HStack{
                                        NavigationLink {
                                       
                                            
                                            CreateTodo(checkin: checkin) { returnedCheckIn in
                                                vm.update(checkin: returnedCheckIn)
                                            }

                                        } label: {
                                            
                                            HStack{
                                                Text("\(checkin.name) ")
                                                    .font(.custom("Lora-Regular", size: 20))
                                                    .bold()

                                                    .foregroundColor(.black)

                                                
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
                                                    Text("Delete To Do")
                                                    
                                                    
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
                                    
                                }
                                .shadow(color: Color.gray, radius: 3, x: 3, y: 4)

                                .padding(.bottom, 5)

                            
                    
                        
                        
                        
                                        .onAppear{
                                            isEmpty2 = false
                                        }
                                    
                                    
                                    
                                    
                          
                                
                                
                                
                                
                                
                                
                            }
                            
                        }
                        
                        
                        
                        
                        
                        ForEach(vmNC.ncCheckins) { checkinz in
                            
                            Text("")
                                .onAppear{
                                    
                                    let returnedCheckIn = convertToCheckIn(checkinz)
                                         vm.add(checkin: returnedCheckIn)
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                        
                                        vmNC.delete(checkin: checkinz)
                                    }
                                        
                                }
                        }
                        
                        
                    }
                    
                }
                
                HStack{
                    
                    Button {
                        
                        
                        isShowingSheet = true
                        
                        
                        
                        
                    } label: {
                        
                        HStack{
                            Text("Add")
                                .font(.custom("Lora-Regular", size: 25))
                                .fontWeight(.medium)
                                .foregroundColor(darkMode ? Color.white : Color.black)
                              

                                
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
                        
                        CreateTodo(checkin: CheckIn()) { returnedCheckIn in
                            vm.add(checkin: returnedCheckIn)
                            
                            
                            
                        }
                        .navigationTitle("Add To Do")
                    }
                }
                
            }
            

            .frame(
                  minWidth: 0,
                  maxWidth: .infinity,
                  minHeight: 0,
                  maxHeight: .infinity,
                  alignment: .topLeading
                )

            
            
            .background(darkMode ? Color.black : Color.white)
        
        }
        

            
        


    func convertToCheckIn(_ ncCheckin: NCCheckIn) -> CheckIn {
        return CheckIn(date: ncCheckin.date, name: ncCheckin.name, userId: ncCheckin.userId, documentId: ncCheckin.documentId, iscompleted: ncCheckin.iscompleted, description: ncCheckin.description, tododate: ncCheckin.tododate, ontime: ncCheckin.ontime)
    }
}

