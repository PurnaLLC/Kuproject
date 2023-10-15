//
//  NotConnectedProfilie.swift
//  KUComputerScienceCompetition
//
//  Created by Maxwell Meyer on 10/14/23.
//

import SwiftUI

struct NotConnectedProfile: View {
    @ObservedObject var newtworkManager = NetworkManager()
    
    @State private var isShowingLoading = false
    
    
    @StateObject var vm = CheckInViewModel(ds: FirebaseDataService())

    

    @AppStorage("theme") var darkMode = false
    

    
    var body: some View {

         
            VStack{
                Image(systemName: newtworkManager.imageName)
                
                
                    .foregroundColor(darkMode ? Color.white : Color.black)
                    .fontWeight(.medium)

                    .font(.system(size: 75))
                
                
                
                    .padding(10)

                Text("You must have internet connection")
                
                
                    .foregroundColor(darkMode ? Color.white : Color.black)
                
                    .fontWeight(.medium)

                
                    .font(.custom("Lora-Regular", size: 25))
                
                
                
                    .padding(10)
           
                
          
                
                
                
                
                
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

