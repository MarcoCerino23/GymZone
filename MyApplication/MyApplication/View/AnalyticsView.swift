//
//  View2.swift
//  GymZone
//
//  Created by Marco Cerino on 17/04/23.
import SwiftUI
import HealthKit
import CoreML


struct AnalyticsView: View {
    //Struttura per raccogliere i dati dell'utente con Healthkit
    struct DailyData {
        var steps: String = ""
        var sedentaryMinutes: String = ""
        var activeMinutes: String = ""
        var totalDistance: String = ""
        var trackerDistance: String = ""
    }
    //Inizializzazione della struttura
    @State var day1 = DailyData()
    @State var day2 = DailyData()
    @State var day3 = DailyData()
    @State var dataReal = Date()
    @State private var isShowingAlert = false
    @Environment(\.dismiss) private var dismiss
    let dateFormatter=DateFormatter()
    @State var caloriesPredict = [Calor(cal: 500, weekDay: ""),Calor(cal: 0.0, weekDay: ""),Calor(cal: 0.0, weekDay: "")]
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    let healthStore = HKHealthStore()
    @State var caloriesBurned = [0.0, 0.0, 0.0]
    @State var caloriesBurnedInfo = [Calor(cal: 500, weekDay: ""),Calor(cal: 0.0, weekDay: ""),Calor(cal: 0.0, weekDay: "")]
    @State var caloriesPrediction = [Calor]()
    @State var showGraphicView = false
    
    
    var body: some View {
        
        
        
        VStack {
            
            NavigationView {
                Form{
                    //Sezione per la raccolta delle informazioni dell'utente
                    Section(header: Text("Giorno 1")
                        .foregroundColor(.green)) {
                            TextField("Passi", text: $day1.steps)
                                .keyboardType(.decimalPad)
                                .onTapGesture {
                                    dismissKeyboard()
                                }
                            
                            
                            TextField("Minuti sedentari", text: $day1.sedentaryMinutes)
                                .keyboardType(.decimalPad)
                                .onTapGesture {
                                    dismissKeyboard()
                                }
                            TextField("Minuti di attività", text: $day1.activeMinutes)
                                .keyboardType(.decimalPad)
                                .onTapGesture {
                                    dismissKeyboard()
                                }
                            
                            TextField("Distanza totale", text: $day1.totalDistance)
                                .keyboardType(.decimalPad)
                                .onTapGesture {
                                    dismissKeyboard()
                                }
                            
                            
                        }
                    //Sezione per la raccolta delle informazioni dell'utente
                    Section(header: Text("Giorno 2").foregroundColor(.green)) {
                        TextField("Passi", text: $day2.steps)
                            .keyboardType(.decimalPad)
                            .onTapGesture {
                                dismissKeyboard()
                            }
                        
                        TextField("Minuti sedentari", text: $day2.sedentaryMinutes)
                            .keyboardType(.decimalPad)
                            .onTapGesture {
                                dismissKeyboard()
                            }
                        
                        
                        TextField("Minuti di attività", text: $day2.activeMinutes)
                            .keyboardType(.decimalPad)
                            .onTapGesture {
                                dismissKeyboard()
                            }
                        
                        
                        TextField("Distanza totale", text: $day2.totalDistance)
                            .keyboardType(.decimalPad)
                            .onTapGesture {
                                dismissKeyboard()
                            }
                        
                        
                        
                    }
                    //Sezione per la raccolta delle informazioni dell'utente
                    Section(header: Text("Giorno 3").foregroundColor(.green)) {
                        TextField("Passi", text: $day3.steps)
                            .keyboardType(.decimalPad)
                            .onTapGesture {
                                dismissKeyboard()
                            }
                        
                        TextField("Minuti sedentari", text: $day3.sedentaryMinutes)
                            .keyboardType(.decimalPad)
                            .onTapGesture {
                                dismissKeyboard()
                            }
                        
                        TextField("Minuti di attività", text: $day3.activeMinutes)
                            .keyboardType(.decimalPad)
                            .onTapGesture {
                                dismissKeyboard()
                            }
                        
                        TextField("Distanza totale", text: $day3.totalDistance)
                            .keyboardType(.decimalPad)
                            .onTapGesture {
                                dismissKeyboard()
                            }
                        
                    }
                    
                    Section(footer:Text("Nota: I tuoi dati non verranno condivisi a terze parti")){
                        
                    }
                    
                    
                }.navigationTitle("Digita dati")
                
                
                    .navigationBarItems(trailing: Button(action: {
                        passToButton()
                    }, label: {Text("Save")}))
                
                
                
                
            }
            .onAppear{
                let sampleTypes = Set([HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!])
                healthStore.requestAuthorization(toShare: nil, read: sampleTypes) { (success, error) in
                    if success {
                        
                        fetchActiveEnergyBurnedData()
                    } else {
                        print("Autorizzazione negata")
                    }
                }
            }
            .fullScreenCover(isPresented: $showGraphicView, content: {PredictionView(caloriesReal: caloriesBurnedInfo,caloriesPredict: caloriesPredict)})
            
            
        }
        .navigationDestination(isPresented: $showGraphicView, destination: {PredictionView(caloriesReal: caloriesBurnedInfo,caloriesPredict: caloriesPredict)})
        
        
    }
    
    func passToButton(){
        
        let data = bruciato(Totalsteps: [Double(day1.steps) ?? 0, Double(day2.steps) ?? 0, Double(day3.steps) ?? 0], veryActiveMinutes: [Double(day1.activeMinutes) ?? 0, Double(day2.activeMinutes) ?? 0, Double(day3.activeMinutes) ?? 0], sedentaryMinutes: [Double(day1.sedentaryMinutes) ?? 0, Double(day2.sedentaryMinutes) ?? 0, Double(day3.sedentaryMinutes) ?? 0], totalDistance: [Double(day1.totalDistance) ?? 0, Double(day2.totalDistance) ?? 0, Double(day3.totalDistance) ?? 0])
        prediction(dati: data)
        showGraphicView.toggle()
        
        
        
        
    }
    
    func dismissKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),to: nil,from: nil,for: nil)
    }
    //Funzione per implementazioni future
    func fetchHeartRateData() {
        let calendar = Calendar.current
        
        for i in 1...3 {
            let endDate = calendar.date(byAdding: .day, value: -i, to: Date())!
            let startDate = calendar.date(byAdding: .day, value: -i - 1, to: Date())!
            
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
            
            let query = HKStatisticsQuery(quantityType: HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!, quantitySamplePredicate: predicate, options: .cumulativeSum) { (query, result, error) in
                
                if let sum = result?.sumQuantity() {
                    let calories = sum.doubleValue(for: HKUnit.largeCalorie())
                    DispatchQueue.main.async {
                        self.caloriesBurned[i-1] = calories//questo si può eliminare forse
                        let weekday = calendar.weekdaySymbols[calendar.component(.weekday, from: startDate)-1]
                        _ = Calor(cal: calories, weekDay: weekday.description
                        )
                        
                    }
                }
            }
            
            healthStore.execute(query)
        }
        
        
    }
    //Funzione per la raccolta dei dati dell'utente da Healthkit
    func fetchActiveEnergyBurnedData() {
        let calendar = Calendar.current
        dateFormatter.dateFormat="yyyy-MM-dd'T'HH:mm:ssZ"
        for i in 1...3 {
            let endDate = calendar.date(byAdding: .day, value: -i , to: Date())!
            let startDate = calendar.date(byAdding: .day, value: -i - 1 , to: Date())!
            
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
            
            let query = HKStatisticsQuery(quantityType: HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!, quantitySamplePredicate: predicate, options: .cumulativeSum) { (query, result, error) in
                
                if let sum = result?.sumQuantity() {
                    let calories = sum.doubleValue(for: HKUnit.kilocalorie())
                    DispatchQueue.main.async {
                        self.caloriesBurned[i-1] = calories
                        
                        dataReal=calendar.date(byAdding: .day, value: -i , to: Date())!
                        let calorieInfo = Calor(cal: calories, weekDay: dateFormatter.string(from: dataReal))
                        
                        caloriesBurnedInfo[i-1] = calorieInfo
                        
                        
                    }
                }
            }
            
            healthStore.execute(query)
        }
        
    }
    
    //Funzione per la predizione delle calorie che l'utente brucerà utilizzando framework CoreML
    func prediction(dati: bruciato){
        do{
            let config = MLModelConfiguration()
            //let model = try calories(configuration: config)
            let model = try TesiModel(configuration: config)
            let calendar = Calendar.current
            var date: Date
            dateFormatter.dateFormat="yyyy-MM-dd'T'HH:mm:ssZ"
            for i in 0...2{
                
                let prediction = try model.prediction(TotalSteps: dati.Totalsteps[i], TotalDistance: dati.totalDistance[i], VeryActiveMinutes: dati.veryActiveMinutes[i], SedentaryMinutes: dati.sedentaryMinutes[i])
                caloriesPredict[i].cal = prediction.Calories
                
                date=calendar.date(byAdding: .day, value: +i + 1, to: Date())!
                caloriesPredict[i].weekDay =  dateFormatter.string(from: date)
                
                
            }
            
            
        } catch{
            alertTitle = "Errore"
            alertMessage = "C'è un problema per il calcolo delle calorie"
            
        }
        
    }
    
    
}

struct bruciato: Identifiable {
    var id = UUID()
    var Totalsteps: [Double]
    var veryActiveMinutes: [Double]
    var sedentaryMinutes: [Double]
    var totalDistance: [Double]
    
    
}

struct AnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsView()
    }
}

