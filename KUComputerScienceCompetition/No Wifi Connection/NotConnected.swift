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
    
    
    @StateObject var vm = CheckInViewModel(ds: FirebaseDataService())

    


    var body: some View {
        NavigationView{
            
            VStack{
                Image(systemName: newtworkManager.imageName)
                
                    .font(.system(size: 75))
                    .fontWeight(.medium)

                    .padding(15)
                
                
                Text(newtworkManager.connectionDescripiton)
                    .fontWeight(.medium)

                    .font(.system(size: 20))
                
                    .padding(15)
                
                NavigationLink {
                    
                    if newtworkManager.isConnected{
                        Home( messageInt: vm)
                        
                        
                    }else{

                    }
                    
                    
                    
                } label: {
                    
                    
                    Text("Retry")
                        .font(.system(size: 25))
                        .foregroundColor(Color .black)
                        .fontWeight(.medium)

                    
                }
                .navigationBarBackButtonHidden(true) // Hides the back button

                
                Text("or")
                    .font(.system(size: 20))
                    .foregroundColor(Color .black)
                
                
                    
                NavigationLink {
                    
                    
                    
                    
                    Home( messageInt: vm)
                    
                    
                    
                } label: {
                    Text("Sign in as guest")
                        .font(.system(size: 25))
                        .foregroundColor(Color .black)
                        .fontWeight(.medium)

                    
                    
                }
                
                
                
                
                
                
            }
            
            
            
            
            
            
            
        }
    }
    
    
}

