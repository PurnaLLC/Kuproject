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
    
    
  
    @StateObject var vmView = CheckInViewModel(ds: FirebaseDataService())

    
    
    
    var body: some View {
        
        VStack{
            
          
      
            
            
            
            NavigationStack {
                
                
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
                .navigationTitle("Check Ins")
                .toolbar {
              
                    
                }
            }
        }
    }
    

}


