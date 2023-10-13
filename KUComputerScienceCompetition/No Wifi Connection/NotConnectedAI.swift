//
//  NotConnectedAI.swift
//  KUComputerScienceCompetition
//
//  Created by Maxwell Meyer on 10/3/23.
//

import SwiftUI

struct NotConnectedAI: View {
    @ObservedObject var newtworkManager = NetworkManager()
    
    @State private var isShowingLoading = false


    var body: some View {
        NavigationView{
            
            VStack{
                Image(systemName: newtworkManager.imageName)
                
                
                
                
                
                
                Text("Must have Wifi to use the AI")
                
                
     
                
                
                Button {
                    isShowingLoading = true
                } label: {
                    
                    
                    Text("Retry")
                    
                    
                }
                
           
              
                
                
                
                
                
            }
            
            
            
            
            
            
            
        }
    }
    
    
}
