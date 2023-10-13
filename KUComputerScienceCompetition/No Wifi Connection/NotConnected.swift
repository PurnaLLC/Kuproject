//
//  NotConnected.swift
//  KUComputerScienceCompetition
//
//  Created by Maxwell Meyer on 10/3/23.
//

import SwiftUI

struct NotConnected: View {
    
    @ObservedObject var newtworkManager = NetworkManager()
    
    @State private var isShowingLoading = false


    var body: some View {
        NavigationView{
            
            VStack{
                Image(systemName: newtworkManager.imageName)
                
                
                
                
                
                
                Text(newtworkManager.connectionDescripiton)
                
                
                
                
                
                Button {
                    isShowingLoading = true
                } label: {
                    
                    
                    Text("Retry")
                    
                    
                }
                
                Text("or")
                
                
                NavigationLink {
                    Home()
                } label: {
                    Text("Sign in as guest")
                }
                
                
                
                
                
            }
            
            
            
            
            
            
            
        }
    }
    
    
}

