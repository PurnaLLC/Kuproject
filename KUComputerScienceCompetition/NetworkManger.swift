//
//  NetworkManger.swift
//  KUComputerScienceCompetition
//
//  Created by Maxwell Meyer on 10/3/23.
//

import Foundation
import Network

class NetworkManager: ObservableObject{
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "NetworkManager")
    @Published var isConnected = true
    
    
    var imageName: String{
        return isConnected ? "wifi" : "wifi.slash"
    }
    
    
    var connectionDescripiton: String{
        if isConnected{
            return "Internet connection looks good!"
        }else{
            return "It looks like you are not connected to the Internet"
        }
    }
    
    init(){
        
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
            
        }
        
        monitor.start(queue: queue)
    }
    
    
    
    
}
