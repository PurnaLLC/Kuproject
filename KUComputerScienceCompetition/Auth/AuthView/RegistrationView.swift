//
//  RegistrationView.swift
//  KUComputerScienceCompetition
//
//  Created by Maxwell Meyer on 9/6/23.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment (\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
        
        
        Color("Logoblue")
            .edgesIgnoringSafeArea(.all)
            .overlay(
                
                
                
        VStack{
       
            
            
            VStack(spacing: 24) {
                
                
                
                Text("Sign Up")
                    .font(.custom("Lora-Regular", size: 35))
                    .fontWeight(.medium)

                    .padding(.top, -10)


                Image("")
                
                
                
                    .frame(width:50, height: 100)
                
                
                
                InputView(text: $email,
                          title: "Email Address",
                          placeholder: "name@example.com")
                .autocapitalization(.none)
                
                
                InputView(text: $fullname,
                          title: "Full Name ",
                          placeholder: "Enter your name")
             
                
                //Password
                InputView(text: $password,
                          title: "Password",
                          placeholder: "Enter Your Password",
                          isSecureField: true)
                ZStack(alignment: .trailing){
                    //Confirm Password
                    InputView(text: $confirmPassword,
                              title: "Confirm Password",
                              placeholder: "Confirm Your Password",
                              isSecureField: true)
                    if !password.isEmpty && !confirmPassword.isEmpty{
                        if password == confirmPassword {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGreen))
                        }else {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemRed))

                            
                        }
                    }
                }
                
            }
            .padding(.horizontal)
            .padding (.top,12)
            
            Button {
                Task{
                    try await viewModel.createUser(withEmail: email, password: password, fullname: fullname)
                }
            } label: {
                HStack{
                    Text("SIGN UP")
                        .fontWeight(.semibold)
                        .font(.custom("Lora-Regular", size: 20))

                    Image(systemName:"arrow.right")
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }
            .background(Color(.systemBlue))
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
            .cornerRadius(10)
            .padding(.top, 25)
            
            Spacer()
            
            Button {
                dismiss()
            } label: {HStack(spacing: 3){
                Text("Already have an account?")
                    .foregroundColor(.white)
                    .font(.custom("Lora-Regular", size: 18))
                    .fontWeight(.medium)

                Text("Sign In")
                    .foregroundColor(.white)
                    .foregroundColor(.white)
                    .font(.custom("Lora-Regular", size: 18))
                  
                    .fontWeight(.bold)
            }
      
                
                
                }
            }
        )
    }
}

extension RegistrationView: AuthenticationFormProtocol{
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count>5
        && confirmPassword == password
        && !fullname.isEmpty
        
    }
}



struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView().environmentObject(AuthViewModel())
    }
}

