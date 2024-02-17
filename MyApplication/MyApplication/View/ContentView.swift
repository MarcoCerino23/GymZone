
import SwiftUI

struct ContentView: View {
    @StateObject var profile = Profilo()
    @State var showingAddView = false //Variabile di stato per mostrare lo sheet per l'aggiunta di un workout
    @StateObject var workoutStoreNew = WorkoutsStore()
    @State private var selection: Int? = 0
    @State var showAlert1 = false // Variabile di stato per mostrare l'avviso di dati mancanti
    @State var showAlert2 = false // Variabile di stato per mostrare l'avviso di scheda già generata
    
    var body: some View {
        // TabView per la navigazione tra le schede
        TabView(selection: $selection) {
            // Tab 0 - Workouts
            NavigationView {
                List {
                    ForEach(workoutStoreNew.workouts) { workout in
                        DisclosureGroup(workout.workoutname) {
                            VStack(alignment: .leading, spacing: 16) {
                                // Collegamento di navigazione alla vista del workout
                                NavigationLink(destination: { WorkoutView(workout: workout).environmentObject(workoutStoreNew) }) {
                                    WorkoutCell(workout: workout)
                                }
                            }
                        }
                        .listRowSeparator(.hidden)
                    }
                    .onDelete(perform: { indexSet in
                        deleteAction(indexSet)
                    })
                }
                .listStyle(.plain)
                .navigationTitle("My Workouts")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(
                    // Bottone per creare un workout standard
                    leading: Button(action: {
                        standardWorkout()
                    }) {
                        Image(systemName: "dumbbell.fill")
                    },
                    // Bottone per aggiungere un nuovo workout
                    trailing: Button(action: {
                        workoutStoreNew.addWorkout(Workout(id: workoutStoreNew.workouts.count, workoutname: "Workout \(workoutStoreNew.workouts.count+1)", exercises: [], creationdate: Date.now, exerciseTime: DateComponents()))
                        showingAddView.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                        .alert(isPresented: $showAlert1) {
                            Alert(
                                title: Text("Dati mancanti"),
                                message: Text("È necessario conoscere altezza, peso, sesso e livello di allenamento per generare una scheda di allenamento adatta a te!\nCompila i dati nella sezione profilo."),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                )
                .alert(isPresented: $showAlert2) {
                    Alert(
                        title: Text("Attenzione"),
                        message: Text("Hai già generato la tua scheda standard!\nPer crearne una nuova devi eliminare la precedente!"),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddView(trainingTime: DateComponents())
            }
            .environmentObject(workoutStoreNew)
            .environmentObject(profile)
            .tabItem {
                Label("Workouts", systemImage: "dumbbell.fill")
            }
            .tag(0)
            
            // Tab 1 - Executions
            ExecutionView()
                .tabItem {
                    Label("Executions", systemImage: "figure.strengthtraining.traditional")
                }
                .tag(1)
            
            // Tab 2 - Analytics
            AnalyticsView()
                .tabItem {
                    Label("Analytics", systemImage: "chart.bar.xaxis")
                }
                .tag(2)
            
            // Tab 3 - Profile
            ProfileView()
                .environmentObject(profile)
                .environmentObject(workoutStoreNew)
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .tag(3)
            /*modifica*/
            
            
            /*modifica*/
        }
        .accentColor(.green)
    }
    
    // Funzione per gestire l'eliminazione di un workout
    func deleteAction(_ index: IndexSet) {
        let deletedWorkoutNames = index.map { workoutStoreNew.workouts[$0].workoutname }
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: deletedWorkoutNames)
        
        workoutStoreNew.workouts.remove(atOffsets: index)
        for index in 0..<workoutStoreNew.workouts.count {
            workoutStoreNew.workouts[index].id = index
        }
        DataManager.shared.saveWorkouts(workoutStoreNew.workouts)
    }
    
    // Funzione per generare un workout standard
    func standardWorkout() {
        for workout in workoutStoreNew.workouts {
            if workout.workoutname == "Standard Workout" {
                showAlert2 = true
                return
            }
        }
        
        if profile.caratteristicheProfilo.altezza.isEmpty || profile.caratteristicheProfilo.peso.isEmpty || (profile.caratteristicheProfilo.peso.sorted(by: >).first?.value.isEmpty ?? true) {
            showAlert1 = true
            return
        }
        
        workoutStoreNew.addStandard(profile: profile)
    }
}

// Vista per visualizzare i dettagli di un workout
struct WorkoutCell: View {
    let workout: Workout
    
    var body: some View {
        let workoutPart = control(exercises: workout.exercises)
        
        HStack {
            VStack {
                ForEach(Array(workoutPart.keys), id: \.self) { item in
                    HStack {
                        Text(item + ":")
                        Spacer()
                        Text("\(workoutPart[item]!) ex.")
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
        .frame(height: 60.0)
    }
}

// Funzione per contare gli esercizi per parte del corpo
func control(exercises: [Exercise]) -> [String: Int] {
    var workoutPart = [String: Int]()
    for exercise in exercises {
        if let count = workoutPart[exercise.exercisestat.bodypart.rawValue] {
            workoutPart[exercise.exercisestat.bodypart.rawValue] = count + 1
        } else {
            workoutPart[exercise.exercisestat.bodypart.rawValue] = 1
        }
    }
    return workoutPart
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

