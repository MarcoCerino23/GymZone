//
//  AddView.swift
//  MyApplication
//
//  Created by Marco Cerino on 16/02/23.
//

import SwiftUI

struct AddView: View {
    // Stati per gestire il tempo di allenamento e il giorno della settimana
    @State var trainingTime:DateComponents
    @State var trainingDay = 1
    @State var nManager = Notifiche()
    @EnvironmentObject var profile:Profilo
    
    // Stati per gestire il nome del workout e la visualizzazione della vista di aggiunta esercizio
    @State var workoutname: String = ""
    @State var showingAddExerciseView = false
    
    // Stati per gestire le informazioni sull'esercizio
    @State var exercisestatic = ExerciseStatic(exercisenamestatic: "nome", description: "descrizione", bodypart: Bodyparts.back, image: "immagine")
    @State var creationdate: Date = Date.now
    @State var date: Date = Date.now
    
    // Variabili di ambiente per accedere allo store di workouts
    @EnvironmentObject var workoutStore : WorkoutsStore
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    //sezione per aggiungere nome del workout
                    Section(content: {TextField("name", text: $workoutname)}, header: {Text("Name").foregroundColor(.green)})
                    Section(content:
                                {
                        if !workoutStore.workouts.isEmpty{
                            List{
                                ForEach(workoutStore.workouts[workoutStore.workouts.count-1].exercises) { exercise in
                                    ExerciseCell(exercise: exercise)
                                }
                            }}
                        
                    }, header: {Text("Exercises").foregroundColor(.green)})
                    //sezione per aggiungere quando eseguire l'allenamento per le notifiche
                    Section(header: Text("Training time").foregroundColor(.green)) {
                        //
                        
                        HStack {
                            Picker(selection: $trainingDay, label: Text("Day of week")) {
                                Text("Sunday").tag(1)
                                Text("Monday").tag(2)
                                Text("Tuesday").tag(3)
                                Text("Wednesday").tag(4)
                                Text("Thursday").tag(5)
                                Text("Friday").tag(6)
                                Text("Saturday").tag(7)
                            }
                            .pickerStyle(.wheel)
                            .frame(width: 150)
                            
                            DatePicker("Time", selection: Binding(get: {
                                let calendar = Calendar.current
                                let date = calendar.date(from: trainingTime) ?? Date()
                                return date
                            }, set: { newDate in
                                let calendar = Calendar.current
                                self.trainingTime.hour = calendar.component(.hour, from: newDate)
                                self.trainingTime.minute = calendar.component(.minute, from: newDate)
                            }), displayedComponents: .hourAndMinute)
                            .padding()
                        }
                        
                    }.frame( height: 100)
                }
                
                .navigationTitle("Add Workout")
                .navigationBarItems(leading: Button(action: {
                    //workoutStore.workouts.remove(at: workoutStore.workouts.count-1)
                    workoutStore.workouts.removeLast()
                    dismiss()//chiudo la finestra
                    
                }, label: {Text("Cancel")}), trailing: Button(action: {
                    
                    showingAddExerciseView.toggle()
                    
                }, label: {Text("Add Exercise")}))
                .toolbar{
                    ToolbarItem(placement: .bottomBar) {
                        Button(action: {
                            workoutStore.workouts[workoutStore.workouts.count-1].workoutname = workoutname
                            workoutStore.workouts[workoutStore.workouts.count-1].exerciseTime = trainingTime
                            nManager.scheduleNotification(date:DateComponents(hour:trainingTime.hour, minute:trainingTime.minute,weekday:trainingDay), nome: profile.caratteristicheProfilo.nome,workoutName: workoutStore.workouts[workoutStore.workouts.count-1].workoutname)
                            DataManager.shared.saveWorkouts(workoutStore.workouts)
                            dismiss()
                            
                        }, label: {Text("Save")})
                    }
                }
            }.accentColor(.green)
        }.sheet(isPresented: $showingAddExerciseView, content: {AddExerciseView()})
    }
}
struct ExerciseCell: View {
    
    let exercise : Exercise
    
    var body: some View {
        HStack {
            GifImage(exercise.exercisestat.image).frame(width: 60,height: 60)
            Spacer().frame(width: 30)
            VStack(alignment: .leading, spacing: 10.0) {
                Text(exercise.exercisestat.exercisenamestatic)
                Text(exercise.exercisestat.bodypart.rawValue)
                    .font(.footnote)
            }
            Spacer()
        }
        .frame(height: 60.0)
        
    }
    
}

