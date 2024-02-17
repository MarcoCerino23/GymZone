//
//  WorkoutView.swift
//  MyApplication
//
//  Created by Marco Cerino on 16/02/23.
//
//
import SwiftUI




struct WorkoutView: View {
    let workout: Workout
    
    //variabile condivisa per lo store dei workout
    @EnvironmentObject var workoutStore: WorkoutsStore
    @Environment(\.dismiss) private var dismiss
    @State var isActive = false
    @State var isPlay = false // variabile per il controllo della riproduzione del workout
    var body: some View {
        
        NavigationView {
            //La vista contiene una lista di esercizi, ciascuno dei quali è un DisclosureGroup che mostra ulteriori dettagli quando viene espanso
            List {
                ForEach(workout.exercises) { exercise in
                    //All'interno del DisclosureGroup, vengono visualizzati i dettagli dell'esercizio,compresi i dettagli di ogni set, come il numero di ripetizioni e il peso
                    DisclosureGroup(exercise.exercisestat.exercisenamestatic){
                        VStack(alignment: .leading, spacing: 16) {
                            ExerciseWorkoutCell(exercise: exercise)
                            
                            ForEach(0..<exercise.sets.count) { index in
                                let set = exercise.sets[index]
                                HStack {
                                    Text("Set \(index + 1):")
                                    
                                    Spacer()
                                    
                                    Text("\(set.reps) reps, \(String(format: "%.1f", set.weight)) kg")
                                        .foregroundColor(.secondary)
                                }
                                .padding(.horizontal, 16)
                            }
                            
                            HStack {
                                Text("Rest time:")
                                
                                Spacer()
                                
                                Text(String(format: "%02d:%02d", exercise.min, exercise.sec))
                                    .foregroundColor(.secondary)
                            }
                            .padding(.horizontal, 16)
                        }
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .navigationTitle(workout.workoutname)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: Button(action: {isPlay.toggle()}, label: {Image(systemName: "play").foregroundColor(.green)})
            )
        }.accentColor(.green)
            .fullScreenCover(isPresented: $isPlay, content: {PlayView(workoutindex: workout.id, exerciseindex: 0).navigationBarBackButtonHidden(true)})
    }
    
}




struct ExerciseWorkoutCell:View {
    let exercise: Exercise
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            GifImage(exercise.exercisestat.image)
                .frame(width: 80, height: 80)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(exercise.exercisestat.exercisenamestatic)
                    .font(.headline)
                    .lineLimit(1)
                
                Spacer()
                
                HStack {
                    Text(exercise.exercisestat.bodypart.rawValue)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text("\(exercise.sets.count) sets")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .background(
            Color.gray.opacity(0.2)
                .cornerRadius(10)
        )
    }
}


struct WorkoutView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        let exercisestatic = ExerciseStatic(exercisenamestatic: "nome", description: "descrizione", bodypart: Bodyparts.back, image: "Panca")
        let arrayExercise = [Exercise(exercisestat: exercisestatic)]
        let dates = [Date.now]
        WorkoutView(workout: Workout(id: 1,workoutname: "Nome workout", exercises: arrayExercise, creationdate: Date.now, exerciseTime: DateComponents()))
    }
}

