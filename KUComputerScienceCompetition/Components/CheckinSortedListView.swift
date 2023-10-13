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

    var body: some View {
        

        VStack{
            
            if isShowingMenu == false {
                
                
                Button {
                    isShowingMenu.toggle()
                
                } label: {
                    
                    HStack{
                        Text("Today")
                            .foregroundColor(Color .black)
                        Image(systemName: "chevron.right")

                        
                        
                    }
                }

            }else{
                
                Button {
                    isShowingMenu.toggle()
                
                } label: {
                    HStack{
                        Text("Today")
                            .foregroundColor(Color .black)
                        
                        Image(systemName: "chevron.down")

                        
                    }
                }
                
                
                
                if isEmpty == true{
                    Text("NO checkin")
                }

      
                
                ForEach(vm.checkins.sorted { $0.tododate > $1.tododate }) { checkin in
                    
                    
                   if checkin.formattedDateComaring(date: checkin.tododate) == checkin.formattedDateComaring(date: Date()){
                        
                        
                       if checkin.iscompleted == false {
                           
                           
                           TodoFormatedView(checkin: checkin, vm: vmView)
                           
                               .onAppear{
                                   isEmpty = false
                               }
                       }
                     
                   }
                
            }
                
                
                
                
                Text("Done Today")
     
                if isEmpty2 == true{
                    Text("NO checkin")
                }

                
                          ForEach(vm.checkins.sorted { $0.tododate > $1.tododate }) { checkin in
                              
                              
                              if checkin.formattedDateComaring(date: checkin.tododate) == checkin.formattedDateComaring(date: Date()){
                                  
                                  
                                  
                                  if checkin.iscompleted == true {
                                      
                                      FormatedTodoCompleteView(vm: vmView, checkin: checkin)
                                      
                                      
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
