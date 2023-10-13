//
//  CheckinSortedListView3.swift
//  KUComputerScienceCompetition
//
//  Created by Maxwell Meyer on 10/3/23.
//

import SwiftUI

struct CheckinSortedListView3: View {
    
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
                        Text("Next 3 days")
                            .foregroundColor(Color .black)
                        Image(systemName: "chevron.right")
                        
                    }
                }

            }else{
                
                Button {
                    isShowingMenu.toggle()
                    
                } label: {
                    HStack{
                        Text("Next 3 days")
                            .foregroundColor(Color .black)
                        
                        Image(systemName: "chevron.down")
                        
                        
                        
                        
                    }
                }
                
                
                
                
                if isEmpty == true{
                    
                    
                    
                        Text("NO checkin")
                        
                            }
                
                
                ForEach(vm.checkins.sorted { $0.tododate > $1.tododate }) { checkin in
                    
                    let currentDate = Date()
                    
                    
                    
                    let threedays = Calendar.current.date(byAdding: .day, value: +3, to: Date()) ?? Date()
                    
                    let chechindate = checkin.tododate
                    
                    
                    
                    
                    if currentDate < chechindate && chechindate < threedays {
                        
                        
                        if checkin.iscompleted == false {
                            
                            
                            TodoFormatedView(checkin: checkin, vm: vmView)
                            
                            
                                .onAppear{
                                    isEmpty = false
                                }
                            
                            
                            
                            
                        }
                    }
                }
                
                
                
                
                Text("Done Todos 3 days")
                
                if isEmpty2 == true{
                    Text("NO checkin")
                }
                
                
                ForEach(vm.checkins.sorted { $0.tododate > $1.tododate }) { checkin in
                    
                    let threedays = Calendar.current.date(byAdding: .day, value: +3, to: Date()) ?? Date()
                    
                    
                    let currentDate = Date()
                    
                    let chechindate = checkin.tododate
                    
                    if currentDate < chechindate && chechindate < threedays {
                        
                        
                        
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

