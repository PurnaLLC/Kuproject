//
//  TodoFormatedView.swift
//  KUComputerScienceCompetition
//
//  Created by Maxwell Meyer on 10/2/23.
//

import SwiftUI

struct TodoFormatedView: View {
    
    @State var checkin: CheckIn

    
    @ObservedObject var vm: CheckInViewModel
    
    
    @AppStorage("theme") var darkMode = false

    @State var isPresentingCheckInEditView = false

    
    
    @State private var isPresentingSheet = false

    
    
    var body: some View {
        
        
        VStack{
            
        }
        
        
    }
}




