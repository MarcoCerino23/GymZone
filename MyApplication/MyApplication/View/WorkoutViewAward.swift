//
//  WorkoutViewAward.swift
//  GymZone
//
//  Created by Marco Cerino on 08/05/23.
//

//Vista di riepilogo che mostra i risultati del workout appena eseguito.
import SwiftUI

struct WorkoutViewAward: View {
    let workout: Workout
    @Environment(\.dismiss) private var dismiss
    @State var isContent = false
    var body: some View {
        ZStack{
           
        NavigationView{
            
            List{
                
                ForEach(workout.exercises){ exercise in
                    ExerciseWorkoutCellAward(exercise: exercise)
                    ForEach(0..<exercise.sets.count){ index in
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
                .listRowSeparator(.hidden)
                
            }.listStyle(.insetGrouped)
                .navigationTitle(workout.workoutname)
                .navigationBarTitleDisplayMode(.inline)
                
                .navigationBarItems(leading: NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true)){Image(systemName: "arrowshape.backward")}.foregroundColor(.green))
        }
            Circle()
                .fill(Color.blue)
                .frame(width: 12, height: 12)
                .modifier(ParticlesModifier())
                .offset(x: -100, y : -50)
            
            Circle()
                .fill(Color.red)
                .frame(width: 12, height: 12)
                .modifier(ParticlesModifier())
                .offset(x: 60, y : 70)
    }

    }
}

struct ExerciseWorkoutCellAward:View {
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

struct WorkoutViewAward_Previews: PreviewProvider {
    static var previews: some View {
 let exercisestatic = ExerciseStatic(exercisenamestatic: "nome", description: "descrizione", bodypart: Bodyparts.back, image: "Panca")
 let arrayExercise = [Exercise(exercisestat: exercisestatic)]
 let dates = [Date.now]
        WorkoutViewAward(workout: Workout(id: 1,workoutname: "Nome workout", exercises: arrayExercise, creationdate: Date.now, exerciseTime: DateComponents()))
    }
}


struct FireworkParticlesGeometryEffect : GeometryEffect {
    var time : Double
    var speed = Double.random(in: 20 ... 200)
    var direction = Double.random(in: -Double.pi ...  Double.pi)
    
    var animatableData: Double {
        get { time }
        set { time = newValue }
    }
    func effectValue(size: CGSize) -> ProjectionTransform {
        let xTranslation = speed * cos(direction) * time
        let yTranslation = speed * sin(direction) * time
        let affineTranslation =  CGAffineTransform(translationX: xTranslation, y: yTranslation)
        return ProjectionTransform(affineTranslation)
    }
}

struct ParticlesModifier: ViewModifier {
    @State var time = 0.0
    @State var scale = 0.1
    let duration = 5.0
    
    func body(content: Content) -> some View {
        ZStack {
            ForEach(0..<80, id: \.self) { index in
                content
                    .hueRotation(Angle(degrees: time * 80))
                    .scaleEffect(scale)
                    .modifier(FireworkParticlesGeometryEffect(time: time))
                    .opacity(((duration-time) / duration))
            }
        }
        .onAppear {
            withAnimation (.easeOut(duration: duration)) {
                self.time = duration
                self.scale = 1.0
            }
        }
    }
}
