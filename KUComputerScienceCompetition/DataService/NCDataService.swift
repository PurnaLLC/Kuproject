//
//  NCDataService.swift
//  KUComputerScienceCompetition
//
//  Created by Maxwell Meyer on 10/21/23.
//

import Foundation
import Combine

protocol NCDataService: ObservableObject {
    
    func get() -> AnyPublisher<[NCCheckIn], Error>
    func add(_ checkin: NCCheckIn)
    func update(_ checkin: NCCheckIn)
    func delete(checkIn: NCCheckIn)

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
        NCcheckins = load(key: "NotConnectedDATAS")
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
    
    func delete(checkIn: NCCheckIn) {
        if let index = NCcheckins.firstIndex(where: { $0.id == checkIn.id }) {
            NCcheckins.remove(at: index)
        }
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



