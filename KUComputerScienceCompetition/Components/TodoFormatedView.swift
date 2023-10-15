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
    
        HStack{
            
            HStack{
                Button {
                    isPresentingSheet = true

                    
                } label: {
                    
                    HStack{
                        Text("\(checkin.name) \(checkin.formattedDate())")
                            .font(Font.headline.weight(.semibold))

                            .foregroundColor( Color.black)
                            .font(.custom("Lora-Regular", size: 20))
                            
                        
                        
                            .lineLimit(1)
                            .minimumScaleFactor(0.00000000001)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                        
                    }
                    .padding(.leading, 5)
                    
                    
                }
                
                HStack{
                    
                    Menu {
                        Button(role: .destructive) {
                            
                            vm.delete(checkin: checkin)
                            
                            
                        } label: {
                            Image(systemName: "trash")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.red)
                                .cornerRadius(10)
                                .multilineTextAlignment(.center)
                            Text("Delete Todo")
                            
                            
                        }
                        
                        
                        
                        
                        
                    } label: {
                        Image(systemName: "trash")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .shadow(color: .gray, radius: 2, x: 2, y: 1)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .multilineTextAlignment(.center)
                        
                        
                    }
                }
                .frame(maxWidth: 120, alignment: .trailing)
                .padding(.trailing, 10)
                
                
   
                
                
                .sheet(isPresented: $isPresentingSheet, content: {
                    CheckInEditView(checkin: checkin) { returnedCheckIn in
                        vm.update(checkin: returnedCheckIn)
                    }
                })
                
                
            }
            .frame(width: 350, height: 50)
            .background(Color.logoBlue)

                 .scaledToFill()
            
            
            
            .cornerRadius(10)
            
        }
        .shadow(color: Color.gray, radius: 3, x: 3, y: 4)

        .padding(.bottom, 5)

    }
}




