//
//  View1.swift
//  GymZone
//
//  Created by Marco Cerino on 17/04/23.
//

import SwiftUI

/*struct DataEntryView: View {
    struct DailyData {
        var steps: String = ""
        var sedentaryMinutes: String = ""
        var activeMinutes: String = ""
    }
    
    
    @State var day1 = DailyData()
    @State var day2 = DailyData()
    @State var day3 = DailyData()
    @State var day4 = bruciato(Totalsteps: [], veryActiveMinutes: [], sedentaryMinutes: [])
    @State var bruciatoData: [bruciato] = []
    
    var body: some View {
        VStack {
            Section(header: Text("Giorno 1")) {
                /*TextField("Numero di passi", text: $day4.Totalsteps[0])
                    .padding()*/
                TextField("Minuti sedentari", text: $day1.sedentaryMinutes)
                    .padding()
                TextField("Minuti di attività", text: $day1.activeMinutes)
                    .padding()
            }
            Section(header: Text("Giorno 2")) {
                TextField("Numero di passi", text: $day2.steps)
                    .padding()
                TextField("Minuti sedentari", text: $day2.sedentaryMinutes)
                    .padding()
                TextField("Minuti di attività", text: $day2.activeMinutes)
                    .padding()
            }
            Section(header: Text("Giorno 3")) {
                TextField("Numero di passi", text: $day3.steps)
                    .padding()
                TextField("Minuti sedentari", text: $day3.sedentaryMinutes)
                    .padding()
                TextField("Minuti di attività", text: $day3.activeMinutes)
                    .padding()
            }
            Button(action: {
                // Salva i dati inseriti dall'utente in un array di tre elementi della struct bruciato
                let day1Data = bruciato(Totalsteps: [Int(day1.steps) ?? 0], veryActiveMinutes: [Int(day1.activeMinutes) ?? 0], sedentaryMinutes: [Int(day1.sedentaryMinutes) ?? 0])
                let day2Data = bruciato(Totalsteps: [Int(day2.steps) ?? 0], veryActiveMinutes: [Int(day2.activeMinutes) ?? 0], sedentaryMinutes: [Int(day2.sedentaryMinutes) ?? 0])
                let day3Data = bruciato(Totalsteps: [Int(day3.steps) ?? 0], veryActiveMinutes: [Int(day3.activeMinutes) ?? 0], sedentaryMinutes: [Int(day3.sedentaryMinutes) ?? 0])
                bruciatoData = [day1Data, day2Data, day3Data]
                print("Dati salvati: \(bruciatoData)")
            }) {
                Text("Invia")
            }
        }
        .padding()
    }
}

struct DataEntryView_Previews: PreviewProvider {
    static var previews: some View {
        DataEntryView()
    }
}
*/
