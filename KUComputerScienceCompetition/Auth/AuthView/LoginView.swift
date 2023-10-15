//
//  LoginView.swift
//  KUComputerScienceCompetition
//
//  Created by Maxwell Meyer on 9/6/23.
//

import SwiftUI
import CryptoKit
import FirebaseAuth
import AuthenticationServices
import Firebase



struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var fullname = ""
    @State private var messageContent = ""
    @State private var navigationSelection: String?
    


   
    
    let getUserDataTimerz = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    
    
    var body: some View {
        
        NavigationStack{
            Color("Logoblue")
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    VStack{
                       
                        
                        
                        Text("Sign In")
                            .font(.custom("Lora-Regular", size: 35))

                            .fontWeight(.medium)

                           
                        Image("")
                        
                        
                        
                            .frame(width:50, height: 100)
                        
                        
                        
                        
                        
                            .padding(.bottom, 10)
                        
                        //form fields
                        //email
                        VStack(spacing: 0) {
                            InputView(text: $email,
                                      title: "Email Address",
                                      placeholder: "name@example.com")
                            .autocapitalization(.none)
                            
                            .padding(.horizontal)
                            .padding(.bottom )
                            
                            //Password
                            InputView(text: $password,
                                      title: "Password",
                                      placeholder: "Enter Your Password",
                                      isSecureField: true)
                            .padding(.horizontal)
                            
                            
                            
                            NavigationLink {
                                PasswordResetView()
                                    .navigationBarBackButtonHidden(true)
                                
                            } label: {HStack(spacing: 3){
                                
                                Spacer()
                                Text("Forgot Password?")
                                    .foregroundColor(.blue)
                                    .font(.custom("Lora-Regular", size: 18))
                                    .fontWeight(.bold)
                                
                            }
                            .padding(.top, 25)
                            .padding(.trailing, 15)
                                
                            }
                            
                            
                        }
                        .padding(.top,2)
                        
                        //forgot passwrod
                        // NavigationLink
                        //  {}  label: {HStack{
                        //     Text("Forgot Password?")
                        //.frame(width:300,height:25)
                        //        .offset(x: 110, y:0)
                        //        .font(.system(size:15))
                        //      .fontWeight(.semibold)
                        
                        //  }
                        //    }
                        //sign in button
                        .padding(.bottom,25)
                        
                        Button {
                            Task{
                                try await viewModel.signIn(withEmail: email, password: password)
                            }
                        } label: {
                            HStack{
                                Text("SIGN IN")
                                    .fontWeight(.semibold)
                                    .font(.custom("Lora-Regular", size: 20))

                                Image(systemName:"arrow.right")
                            }
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                            .background(Color(.systemBlue))
                            .disabled(!formIsValid)
                            .opacity(formIsValid ? 1.0 : 0.5)
                            .cornerRadius(10)
                        }
                        
            
                        
                        Spacer()
                        //sign up button
                        
                        NavigationLink {
                            RegistrationView()
                                .navigationBarBackButtonHidden(true)
                            
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
    
    
    

    
    
    
    
    
}

extension LoginView: AuthenticationFormProtocol{
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count>5
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(AuthViewModel())
    }
}

