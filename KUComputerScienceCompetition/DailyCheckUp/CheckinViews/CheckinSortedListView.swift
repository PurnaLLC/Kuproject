//
//  CheckinSortedListView.swift
//  KUComputerScienceCompetition
//
//  Created by Maxwell Meyer on 10/2/23.
//

import SwiftUI

struct CheckinSortedListView: View {
    
    @StateObject var vmView = CheckInViewModel(ds: FirebaseDataService())
    
    @ObservedObject var vm: CheckInViewModel
    
    
    
    @State private var isShowingMenu = false
    
    @State private var isEmpty: Bool = true
    @State private var isEmpty2: Bool = true
    
    
    @AppStorage("theme") var darkMode = false

    
    @State private var isPresentingSheet = false

    
    @State private var isPresentingSheet2 = false

    
    
    
    
    var body: some View {
        

        VStack{
            
            if isShowingMenu == false {
                
                
                Button {
                    isShowingMenu.toggle()
                
                } label: {
                    
                    HStack{
                        Text("Today")
                            .foregroundColor(darkMode ? Color.white : Color.black)
                            .font(.custom("Lora-Regular", size: 25))
                            .fontWeight(.medium)
                        Image(systemName: "chevron.right")
                            .foregroundColor(darkMode ? Color.white : Color.black)

                        
                        
                    }
                }

            }else{
                
                Button {
                    isShowingMenu.toggle()
                
                } label: {
                    HStack{
                        Text("Today")
                            .foregroundColor(darkMode ? Color.white : Color.black)
                            .font(.custom("Lora-Regular", size: 25))
                            .fontWeight(.medium)

                        Image(systemName: "chevron.down")
                            .foregroundColor(darkMode ? Color.white : Color.black)


                        
                    }
                }
                
                
                
                if isEmpty == true{
                    Text("NO Todo")
                        .foregroundColor(darkMode ? Color.white : Color.black)
                        .font(.custom("Lora-Regular", size: 15))

                }

      
                
                ForEach(vm.checkins.sorted { $0.tododate > $1.tododate }) { checkin in
                    
                    
                    
                    if checkin.formattedDateComaring(date: checkin.tododate) == checkin.formattedDateComaring(date: Date()){
                        
                        
                        
                        
                        
                        
                        if checkin.iscompleted == false {
                            
                            
                            HStack{
                                
                                HStack{
                                    NavigationLink {
                                        
                                        
                                        CreateTodo(checkin: checkin) { returnedCheckIn in
                                            vm.update(checkin: returnedCheckIn)
                                        }
                                        
                                    } label: {
                                        
                                        HStack{
                                            Text("\(checkin.name)")
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
                
            }
                
                
                
                
                Text("Done Today")
                    .foregroundColor(darkMode ? Color.white : Color.black)
                    .font(.custom("Lora-Regular", size: 25))
                    .fontWeight(.medium)

                if isEmpty2 == true{
                    Text("NO Todo")
                        .foregroundColor(darkMode ? Color.white : Color.black)
                        .font(.custom("Lora-Regular", size: 15))
                    


                }

                
                          ForEach(vm.checkins.sorted { $0.tododate > $1.tododate }) { checkin in
                              
                              
                              if checkin.formattedDateComaring(date: checkin.tododate) == checkin.formattedDateComaring(date: Date()){
                                  
                                  
                                  
                                  if checkin.iscompleted == true {
                                      
                                      
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
                                          
                                      }
                                      .shadow(color: Color.gray, radius: 3, x: 3, y: 4)

                                      .padding(.bottom, 5)


                                      
                                          .onAppear{
                                              isEmpty2 = false
                                          }
                                  }
                                  
                                  
                                  
                              }
                            
                          
                    
                    
                }
                
                
                
            }
            
        }
        
    }
}
