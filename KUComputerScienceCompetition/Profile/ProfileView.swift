//
//  ProfileView.swift
//  KUComputerScienceCompetition
//
//  Created by Maxwell Meyer on 9/6/23.
//


import SwiftUI


struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    
    
    @AppStorage("theme") var darkMode = false
    
    let fire = "🔥"

    @AppStorage("streak") var streak = 0
    

    
    
    var body: some View {
        
        
        
        
        if let user = viewModel.currentUser{
            
            
            VStack{
                
                HStack {
                    HStack{
                        Image(systemName: "person.circle.fill")
                            .foregroundColor(darkMode ? Color.white : Color.black)
                            .font(.system(size: 50))
                        
                        
                        
                        
                        VStack (alignment: .leading, spacing:4){
                            Text(user.email)
                                .foregroundColor(darkMode ? Color.white : Color.black)
                                .font(.custom("Lora-Regular", size: 15))
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top,4)
                            
                            
                            
                        }
                        
                    }
                    .padding()
                    .padding(.leading)
                    
                    Menu {
                        
                        
                        
                        Button {
                            
                            viewModel.signOut()
                            
                            
                            
                        } label: {
                            
                            
                            Label("Sign Out", systemImage: "arrow.left.circle.fill")
                            
                        }
                        
                        
                        Menu {
                            Button(role: .destructive) {
                                
                                viewModel.deleteUser { result in
                                    switch result {
                                    case .success:
                                        viewModel.signOut()
                                        
                                        
                                        Task{
                                            do{
                                                
                                                viewModel.userSession = nil
                                                viewModel.currentUser = nil
                                            }
                                        }
                                        
                                        
                                        
                                        
                                        if viewModel.userSession != nil {
                                            
                                            
                                        } else {
                                            
                                        }
                                    case .failure(let error):
                                        print(" \(error)")
                                    }
                                }
                                viewModel.signOut()
                                streak = 0
                                
                                
                            } label: {
                                Label("Delete Account", systemImage: "xmark.circle.fill")
                                    .frame(width:72, height: 72)
                                
                            }
                            
                            
                            
                            
                            
                        } label: {
                            Label("Delete Account", systemImage: "xmark.circle.fill")
                        }
                        
                    } label: {
                        
                        Image(systemName: "gearshape.fill")
                            .font(.system(size: 25))
                            .foregroundColor(darkMode ? Color.white : Color.black)
                        
                    }
                    
                    
                    
                }
                
                
                .padding(.bottom, 15)

                
                VStack{
                    
                    Toggle(isOn: $darkMode){
                        
                        Text("Dark Mode")
                        
                            .foregroundColor(darkMode ? Color.white : Color.black)
                            .font(.custom("Lora-Regular", size: 30))
                            .bold()

                        
                        
                        
                        
                    }
                }
                
                .padding(.leading, 5)
                .padding(.trailing, 15)
                
                
                .padding(.bottom, 15)
                
                VStack{
                    
                    Text("Todos Done On Time ")
                        .foregroundColor(darkMode ? Color.white : Color.black)
                        .font(.custom("Lora-Regular", size: 30))
                        .bold()
                    
                    
                    ZStack{
                        
                        
                        Text(fire)
                            .font(.system(size: 150))
                        
                        Text("\(streak)")
                            .font(.custom("Lora-Regular", size: 50))
                            .padding(.bottom, -100)
                            .foregroundColor(.black)
                            
                            
                        
                    }
                }
                
            }
            
            .frame(
                  minWidth: 0,
                  maxWidth: .infinity,
                  minHeight: 0,
                  maxHeight: .infinity,
                  alignment: .topLeading
                )

            
            
                
            
            .background(darkMode ? Color.black : Color.white)

            
            
            
        }
        
    }
    

    
    
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environmentObject(AuthViewModel())
    }
}


