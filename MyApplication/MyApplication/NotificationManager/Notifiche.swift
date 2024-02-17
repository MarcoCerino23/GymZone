//
//  Notifiche.swift
//  GymZone
//
//  Created by Marco Cerino on 01/05/23.
//

import Foundation
import UserNotifications

//Classe per le gestione delle notifiche  attraverso UserNotification
class Notifiche{
    
    
    func requestAuthorization(){
        let options : UNAuthorizationOptions = [.alert,.sound]
        //Richiedo autorizzazione
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success,error)  in
            if let error = error  {  //serve se voglio vedere che tipo di errore c'è stato
                print("ERRORE: \(error.localizedDescription)")
            } else{
                print("SUCCESSO")
            }
        }
    }
    
    
    //Funzione per schedulare notifica.Passo la data in cui deve essere mandata la notifica , il nome del workout associato  e il nome dell'utente
    func scheduleNotification(date: DateComponents,nome:String,workoutName:String) {
        
        //Variabile per schedulare notifiche
        let center = UNUserNotificationCenter.current()
        //Variabile per settare il contenuto della notifica
        let content = UNMutableNotificationContent()
        content.title =  "GymZone"
        if(nome != ""){
            content.body = "\(nome) è tempo di eseguire il workout \(workoutName)"
        }else{
            content.body = "E' tempo di eseguire il workout:\(workoutName)"
        }
        content.sound = .default
        
        
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date,repeats: true)
        
        let request = UNNotificationRequest(identifier: workoutName, content: content, trigger: trigger)
        
        center.add(request) { (error) in
            if error != nil {
                print("Errore durante l'aggiunta della richiesta di notifica: \(error?.localizedDescription ?? "Errore sconosciuto")")
            }
        }
        
        
        
    }
    
    
}
