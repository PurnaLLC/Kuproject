//
//  ProfileView.swift
//  KUComputerScienceCompetition
//
//  Created by Maxwell Meyer on 9/6/23.
//


import SwiftUI


struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
        
        
        if let user = viewModel.currentUser{
            
            
            VStack{
                
                HStack {
                    HStack{
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 50))
                        
                        
                        
                        
                        VStack (alignment: .leading, spacing:4){
                            Text(user.email)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top,4)
                            
                            
                            VStack(alignment: .center){
                                
                            }
                            
                            
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
                                
                                
                                
                            } label: {
                                Label("Delete Account", systemImage: "xmark.circle.fill")
                                    .frame(width:72, height: 72)
                                
                            }
                            
                            
                            
                            
                            
                        } label: {
                            Label("Delete Account", systemImage: "xmark.circle.fill")
                        }
                        
                    } label: {
                       
                         Image(systemName: "gearshape.fill")
                            .foregroundColor(.black)
                        .frame(width:100, height: 100)
                        
                    }
                    
                    
                    
                }
                
                
                
            }
            
        }
        
    }
    
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environmentObject(AuthViewModel())
    }
}


