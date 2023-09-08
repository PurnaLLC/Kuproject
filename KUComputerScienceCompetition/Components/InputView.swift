//
//  InputView.swift
//  KUComputerScienceCompetition
//
//  Created by Maxwell Meyer on 9/5/23.
//

import SwiftUI

struct InputView: View {
    @Binding var text:String
    let title: String
    let placeholder: String
    var isSecureField = false
    
    var body: some View {
        VStack (alignment: .leading, spacing: 12){
            Text(title)
                .font(.system(size: 18))
                .foregroundColor(Color(.black))
                .fontWeight(.semibold)
                .font(.footnote)
                .textContentType(.username)
                
            
            if isSecureField{
                SecureField(placeholder, text: $text)
                    .font(.system(size: 16))
                    .textContentType(.username)
                   
            }else{
                TextField(placeholder, text: $text)
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .textContentType(.username)
                    
            }
            
            Divider()
            
        }
    }
}

