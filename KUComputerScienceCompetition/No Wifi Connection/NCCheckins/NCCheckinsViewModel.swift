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
    
    
    
    
    func delete(indexSet: IndexSet) {
        ds.delete(indexSet: indexSet)
    }
    

    
    
    
    
    
}



protocol NCDataService: ObservableObject {
    
    func get() -> AnyPublisher<[NCCheckIn], Error>
    func add(_ checkin: NCCheckIn)
    func update(_ checkin: NCCheckIn)
    func delete(indexSet: IndexSet)

}


class NCUserDefaultDataService: NCDataService {
   
    @Published private var NCcheckins: [NCCheckIn] {
        didSet {
            save(items: NCcheckins, key: key)
        }
    }
    
    private var key = "NotConnectedDATAS"
    init(){
        NCcheckins = []
        NCcheckins = load(key: key)
    }
    func get() -> AnyPublisher<[NCCheckIn], Error> {
        $NCcheckins.tryMap({$0}).eraseToAnyPublisher()
    }
    
    func add(_ item: NCCheckIn) {
        NCcheckins.append(item)
    }
    
    func update(_ item: NCCheckIn) {
        guard let index = NCcheckins.firstIndex(where: {$0.id == item.id}) else { return }
        NCcheckins[index] = item
    }
    
    func delete(indexSet: IndexSet) {
        NCcheckins.remove(atOffsets: indexSet)
    }
    
    // MARK: Private
     func save<T: Identifiable & Codable> (items: [T], key: String) {
        
        
        let encoder = JSONEncoder()
 
        if let encoded = try? encoder.encode (items) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: key)
        }
    }
    func load<T: Identifiable & Codable> (key: String) -> [T] {
        guard let data = UserDefaults.standard.object (forKey: key) as? Data else {
            
            return []
            
        }
        
        let decoder = JSONDecoder()
        if let dataArray = try? decoder.decode ([T].self, from: data) {
            print(dataArray)
            print(data)
            return dataArray
            
            
        }
        return []
        
    }
    
}
