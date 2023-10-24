//
//  NCCheckinsViewModel.swift
//  KUComputerScienceCompetition
//
//  Created by Maxwell Meyer on 10/12/23.
//

import Foundation
import Combine


// ViewModel
class NCCheckInViewModel: ObservableObject {
    
    @Published private(set) var ncCheckins: [NCCheckIn] = []
    
    private let ds: any NCDataService
    
    private var cancellables = Set<AnyCancellable>()
    
    init(ds: any NCDataService = NCUserDefaultDataService() ) {
        self.ds = ds
        ds.get()
            .sink { error in
                fatalError("\(error)")
            } receiveValue: { ncCheckins in
                self.ncCheckins = ncCheckins
            }
            .store(in: &cancellables)
    }
    
    func add(checkin: NCCheckIn) {
        ds.add(checkin)
    }
    func update(checkin: NCCheckIn) {
        ds.update(checkin)
    }
    
    
    
    
    func delete(checkin: NCCheckIn) {
        ds.delete(checkIn: checkin)
    }
    

    
    
    
    
    
}


