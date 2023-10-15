//
//  CheckInListView.swift
//  KUComputerScienceCompetition
//
//  Created by Maxwell Meyer on 9/5/23.
//

import SwiftUI
import Combine
import Charts

struct CheckInListView: View {
    @ObservedObject var vm: CheckInViewModel
    @State private var isShowingSheet = false
    
    @State private var streak: Int = 0
    @State private var lastCheckedDate: Date?
    
    @AppStorage("theme") var darkMode = false

  
    @StateObject var vmView = CheckInViewModel(ds: FirebaseDataService())

    
    
    
    var body: some View {
        
        VStack{
            
                
                Text("Check Ins")
                    .foregroundColor(darkMode ? Color.white : Color.black)
                    .font(.custom("Lora-Regular", size: 30))
                    .padding(.top, 10)
                    .padding(.bottom, 5)
                    .fontWeight(.bold)
                    .padding(.top,60)
            
            
            ScrollView{
                    
                    
                    
                    CheckinSortedListView( vm: vmView)
                    
                        .padding()
                    
                    CheckinSortedListView2( vm: vmView)
                    
                        .padding()
                    
                    
                    
                    CheckinSortedListView3( vm: vmView)
                    
                        .padding()
                    
                    
                    
                    CheckinSortedListView4( vm: vmView)
                    
                        .padding()
                    
                    
                    
                    
                    
                }
                
                
                
                
                
                
                
            }
            
        
        .frame(
            minWidth: 400,
            maxWidth: 400,
            minHeight: 0,
            maxHeight: .infinity
                )

        
        
        .ignoresSafeArea()
            
     
        
        
        .background(darkMode ? Color.black : Color.white)

        
        
    }
    

}


