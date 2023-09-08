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

    var body: some View {
        Group {
            if viewModel.currentUser != nil {
                Home()
            } else {
                LoginView()
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

