//
//  Home.swift
//  KUComputerScienceCompetition
//
//  Created by Maxwell Meyer on 9/6/23.
//

import SwiftUI


struct Home: View {
    
    @StateObject var vm = CheckInViewModel(ds: FirebaseDataService())
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    NavigationLink {
                        
                        CheckInListView(vm: vm)
                    } label: {
                        Image(systemName: "calendar")
                            .font(.system(size: 40))
                            .foregroundColor(.black )
                    }
                    
                
                    
                    NavigationLink {
                        ProfileView()
                    } label: {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.black )

                    }
                    .padding(.leading, 75
                    )
                    
                }
                
                TodoListView(vm: vm)

            }
            
        }
        
    }
    
}
  



struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
          
    }
}
