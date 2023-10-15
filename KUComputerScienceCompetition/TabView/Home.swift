//
//  Home.swift
//  KUComputerScienceCompetition
//
//  Created by Maxwell Meyer on 9/6/23.
//

import SwiftUI



enum Tab: String, CaseIterable {
    
    case todolist = "TodoList"
    case checkinlist = "Daily Checkin"
    case ai = "AI"
    case profile = "Profile"
    
    
    
}




struct Home: View {
    
    @StateObject var vm = CheckInViewModel(ds: FirebaseDataService())
    
    
    
    @StateObject var newtworkManager = NetworkManager()

    
    
    
    @StateObject var ncVM = NCCheckInViewModel(ds: NCUserDefaultDataService())

    
    
    var lineWidth: CGFloat = 4

    var lineWidth2: CGFloat = 25
    
    
    
    @AppStorage("theme") var darkMode = false

    
    @StateObject var messageVm = FirebaseMessagesViewModel(ds: FirebaseMessageDataService())
    
    
    
    
    @ObservedObject var messageInt:  CheckInViewModel
    
    
    @State private var selectedTab: Tab = .todolist // Default tab

    
    
    @State private var isShowingNotConnectHome = false
    
    var body: some View {
        NavigationView{
            VStack{
              
                
                
                switch selectedTab {

                case .todolist:
                    
                    
                    
                    if newtworkManager.isConnected{
                        
                        
                        TodoListView(vm: vm, vmNC: ncVM )
                        
                        
         //           NCCheckinsView(vm: ncVM)

                        
                        
                    }else{
                        
                        
                        NCCheckinsView(vm: ncVM)
                        
                        
                        
                        
                    }
                    
                    
                case .checkinlist:
                    
                    if newtworkManager.isConnected{
                        
                       CheckInListView(vm: vm)
                        
             //           NotConnectedProfile()

                        
                    }else{
                        
                        
                        NotConnectedProfile()
                    }
                    
                    
                    
                case .ai:
                    
                    
                   let lastTenCheckins = Array(messageInt.checkins.sorted { $0.tododate > $1.tododate }.prefix(10))
                    
                    
     
                        
                        if newtworkManager.isConnected{
                            
                            
                            
                           AIChatView( vm: messageVm , lastTenCheckins: lastTenCheckins)
                            
              //            NotConnectedAI()

                            
                        }else{
                            NotConnectedAI()
                        }
                        
                        
                        
                        
                    case .profile:
                        
                        
                        if newtworkManager.isConnected{
                            
                            
                            
                            ProfileView()

                            
                        }else{
                            
                            
                            NotConnectedProfile()
                            
                            
                            
                        }
                        
                        
                    }
                    
                    
                
                
                
                
                Spacer()
                
                VStack{
                    
                    ZStack{
                        Divider()
                            .frame(height: lineWidth2)
             //               .overlay(Color("Logoblue"))
                        
                            .overlay(darkMode ? Color.black : Color.white)
                        
                        
                        Rectangle()
                            .frame(height: lineWidth)
                            .shadow(color: darkMode ? Color.white : Color.black, radius: 24, x: 0, y: 1)

                        
                          .overlay(darkMode ? Color.white : Color.black)
                        
                  
                        
                    }
                        .padding(.bottom, -20)
                    
                    
                    
                    
                    
                    
                    
                    
                    HStack{
                        Spacer()
                        
                        Button {
                            
                            
                            selectedTab = .todolist
                            
                        } label: {
                            
                            VStack{
                                Image(systemName: "house.fill")
                        //            .shadow(color: .gray, radius: 2, x: 2, y: 4)

                                
                                Text("Todos")
                                .foregroundColor(darkMode ? Color.white : Color.black)
                                .font(.custom("Lora-Regular", size: 15))
                                .fontWeight(.medium)

                                
                            }
                                .font(.system(size: selectedTab == .todolist ? 30 : 25))
                                .opacity(selectedTab == .todolist ? 1 : 0.9)
                                .animation(.easeIn(duration: 0.3))
                            
                                .foregroundColor(darkMode ? Color.white : Color.black)
                                .padding(.bottom, -3)

                            
                        }
                        
                        Spacer()
                        
                        
                        
                        
                        Button {
                            
                            
                            selectedTab = .checkinlist
                            
                        } label: {
                            VStack{
                                
                                Image(systemName: "calendar")
                                

                                
                                Text("Daily Check")
                                    .foregroundColor(darkMode ? Color.white : Color.black)
                                    .font(.custom("Lora-Regular", size: 15))
                                    .fontWeight(.medium)

                            }
                                .font(.system(size: selectedTab == .checkinlist ? 30 : 25))

                                .opacity(selectedTab == .checkinlist ? 1 : 0.9)
                                .animation(.easeIn(duration: 0.3))
                            
                                .foregroundColor(darkMode ? Color.white : Color.black)
                                .padding(.bottom, -3)

                        }
                        
                        
                        
                        
                        
                        
                        
                        Spacer()
                        
                        
                        Button{
                            
                            
                            selectedTab = .ai
                            
                            
                        } label: {
                            
                            
                            VStack{
                                Text("🤖")
                              //      .shadow(color: .gray, radius: 2, x: 2, y: 1)

                                
                                Text("AI Helper")
                                .foregroundColor(darkMode ? Color.white : Color.black)
                                .font(.custom("Lora-Regular", size: 15))
                                .fontWeight(.medium)

                                
                            }
                                .font(.system(size: selectedTab == .ai ? 35 : 30))
                                .opacity(selectedTab == .ai ? 1 : 0.9)
                                .animation(.easeIn(duration: 0.3))
                                .padding(.bottom, -3)

                            
                            
                            
                        }
                        
                        
                        
                        Spacer()
                        
                        Button {
                            
                            
                            selectedTab = .profile
                            
                        } label: {
                            
                            VStack{
                                
                                Image(systemName: "person.circle.fill")
                         //           .shadow(color: .gray, radius: 2, x: 2, y: 4)

                                
                                
                                Text("Profile")
                                .foregroundColor(darkMode ? Color.white : Color.black)
                                .font(.custom("Lora-Regular", size: 15))
                                .fontWeight(.medium)

                                
                            }
                                    .font(.system(size: selectedTab == .profile ? 30 : 25))
                                    .opacity(selectedTab == .profile ? 1 : 0.9)
                                    .animation(.easeIn(duration: 0.3))
                                    .foregroundColor(darkMode ? Color.white : Color.black)
                            
                            
                                    .padding(.bottom, -3)

                            
                            
            
                        }
                        
                        
                        
                        
                        Spacer()
                        
                        
                        
                        
                    }
                    .frame(height: 60)
                    .background(darkMode ? Color.black : Color.white)
                    
                    
                    
                }
                
                .padding(.top, -8)
                .padding(.bottom, -5)

            }
            
        }
        
    }
    
}


extension Color {
    static let logoBlue = Color("Logoblue")
}
