//
//  FormatedTodoCompleteView.swift
//  KUComputerScienceCompetition
//
//  Created by Maxwell Meyer on 10/2/23.
//

import SwiftUI

struct FormatedTodoCompleteView: View {
    
    
    @ObservedObject var vm: CheckInViewModel

    
    
    @State var checkin: CheckIn
    var body: some View {

        HStack{
            NavigationLink {
                CheckInEditView(checkin: checkin) { returnedCheckIn in
                    vm.update(checkin: returnedCheckIn)
                }
            } label: {
                
                HStack{
                    Text("\(checkin.name) \(checkin.formattedDate())")
                        .foregroundColor(.black)
                        .bold()
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
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .multilineTextAlignment(.center)
                    
                    
                }
            }
            .frame(maxWidth: 120, alignment: .trailing)
            .padding(.trailing, 10)
            
            
            
            
        }
        .frame(width: 350, height: 50)
        .background(checkin.ontime ? Color.green : Color.red)
        
        
        .cornerRadius(10)
        

    }
}

