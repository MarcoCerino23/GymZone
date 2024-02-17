//Classe per la permanenza dei dati mediante l'uso di DataManager
import SwiftUI

class DataManager {
    
    
    
    
    static let shared = DataManager()
    
    private let userDefaults = UserDefaults.standard
    
    // Salva un array di allenamenti nel UserDefaults
    func saveWorkouts(_ workouts: [Workout]) {
        let data = try? JSONEncoder().encode(workouts)
        userDefaults.set(data, forKey: "workouts")
        userDefaults.synchronize()
    }
    
    // Recupera un array di allenamenti dal UserDefaults
    func loadWorkouts() -> [Workout] {
        guard let data = userDefaults.data(forKey: "workouts"),
              let workouts = try? JSONDecoder().decode([Workout].self, from: data)
        else {
            return []
        }
        
        return workouts
    }
    
    
    
    
    
    func saveProfile(_ profile: CaratteristicheProfilo) {
        let data = try? JSONEncoder().encode(profile)
        userDefaults.set(data, forKey: "profile")
        userDefaults.synchronize()
    }
    
    func loadProfile() -> CaratteristicheProfilo? {
        guard let data = userDefaults.data(forKey: "profile"),
              let profile = try? JSONDecoder().decode(CaratteristicheProfilo.self, from: data)
        else {
            return nil
        }
        return profile
    }
    
}
