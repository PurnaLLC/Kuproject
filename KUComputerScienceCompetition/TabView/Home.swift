//
//  Home.swift
//  KUComputerScienceCompetition
//
//  Created by Maxwell Meyer on 9/6/23.
//

import SwiftUI


struct Home: View {
    
    @StateObject var vm = CheckInViewModel(ds: FirebaseDataService())
    
    
    
    @StateObject var newtworkManager = NetworkManager()

    
    
    
    @StateObject var ncVM = NCCheckInViewModel(ds: NCUserDefaultDataService())

    
    
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    NavigationLink {
                        
                        
                        if newtworkManager.isConnected{
                            
                            CheckInListView(vm: vm)
                        }else{
                            
                            
                            NotConnected()
                        }
                        
                        
                        
                    } label: {
                        Image(systemName: "calendar")
                            .font(.system(size: 40))
                            .foregroundColor(.black )
                    }
                    
                
                    
                    NavigationLink {
                        
                        
                    if newtworkManager.isConnected{
                            ProfileView()
                            
                            
                    }else{
                        
                        
                        NotConnected()
                    }
                        
                    } label: {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.black )

                    }
                    .padding(.leading, 75
                    )
                    
                }
                
                
                
                if newtworkManager.isConnected{
                    
                
      //            TodoListView(vm: vm)
                    
                    NCCheckinsView(vm: ncVM)
                    
                
                }else{
                    NCCheckinsView(vm: ncVM)
                  
                    
                }
                
            }
            
        }
        
    }
    
}
  



struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
          
    }
}
