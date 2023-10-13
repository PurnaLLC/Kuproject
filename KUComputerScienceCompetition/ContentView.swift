//
//  ContentView.swift
//  KUComputerScienceCompetition
//
//  Created by Maxwell Meyer on 8/30/23.
//

import SwiftUI

struct ContentsView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    let getUserDataTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @StateObject var newtworkManager = NetworkManager()

    var body: some View {
        Group {
            if newtworkManager.isConnected{
                
                if viewModel.userSession != nil {
                    
                    Home()
                    
                } else {
                    LoginView()
                }
            }else{
                
                
                NotConnected()
                
                
            }
            
            
            
        }
      
    }
}


//currentUser
//userSession

struct ContentsView_Previews: PreviewProvider {
        static var previews: some View {
            ContentsView().environmentObject(AuthViewModel())
        }
    }

