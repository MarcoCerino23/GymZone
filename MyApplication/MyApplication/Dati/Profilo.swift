//
//  Profilo.swift
//  GymZone
//
//  Created by Mattia De Bartolomeis on 01/05/23.
//

import Foundation

class Profilo:ObservableObject {
     @Published var caratteristicheProfilo : CaratteristicheProfilo


    init() {

        caratteristicheProfilo = DataManager.shared.loadProfile() ?? CaratteristicheProfilo()
        }

}

struct CaratteristicheProfilo:  Codable {
    var nome:String
    //var cognome:String
   // var dataNascita:Date
    var altezza:String
    var peso: Dictionary<Date, String>
     var sesso:Sesso
     var livello:Livello
    var misure:Misure
    var ultimopeso: String
    //var permessoNotifiche : Bool
    
    init() {
        self.nome = ""
        //self.cognome = ""
        //self.dataNascita = Date.now
        self.altezza = ""
       // self.permessoNotifiche = false
        self.peso = [:]
        self.sesso = Sesso.maschio
        self.livello = Livello.principiante
        self.misure = Misure(collo: "", spalle: "", bicipite: "", tricipite: "", avambracci: "", polpacci: "")
        self.ultimopeso = ""
    }
}

enum Sesso:String,Codable{
    case maschio="Maschio"
    case femmina="Femmina"
    case null = "Non selezionato"
}
enum Livello:String,Codable{
    case principiante = "Principiante"
    case esperto = "Esperto"
    case intermedio="Intermedio"
    case null = "Non selezionato"
}
struct Misure:Codable{
    var collo:String
    var spalle:String
    var bicipite:String
    var tricipite:String
    var avambracci:String
    var polpacci:String
}
