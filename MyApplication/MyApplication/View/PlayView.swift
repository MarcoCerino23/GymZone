//Vista di esecuzione del workout

import SwiftUI

struct PlayView: View {
    @EnvironmentObject var workoutStore: WorkoutsStore
    @State var isNextView = false //Permette di scorrere tra gli esercizi del workout
    @State var isFinalView = false // Permette di terminare il workout in esecuzione
    var workoutindex: Int
    var exerciseindex: Int
    @Environment(\.dismiss) private var dismiss
    @State var newWeight = [String](repeating: "", count: 20)
    
    
    
    var body: some View {
        NavigationStack {
            Form {
                GifImage(workoutStore.workouts[workoutindex].exercises[exerciseindex].exercisestat.image)
                    .frame(width: 500, height: 300, alignment: .center)
                
                Section(header:Text("Rest Timer"), content: {
                    
                    HStack {
                        Spacer()
                        TimerView(restTime: workoutStore.workouts[workoutindex].exercises[exerciseindex].min * 60 + workoutStore.workouts[workoutindex].exercises[exerciseindex].sec)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                    }
                    
                })
                
                Section(header: Text("Sets"), content: {
                    ForEach(0..<workoutStore.workouts[workoutindex].exercises[exerciseindex].sets.count) { index2 in
                        HStack {
                            Text("\(index2+1). reps: \(workoutStore.workouts[workoutindex].exercises[exerciseindex].sets[index2].reps)    weight: ")
                            TextField("\(String(format: "%.1f", workoutStore.workouts[workoutindex].exercises[exerciseindex].sets[index2].weight))",text: $newWeight[index2]).textFieldStyle(PlainTextFieldStyle()).padding().foregroundColor(.black).font(.system(size: 16)).bold() //modifica 1
                                .keyboardType(.numberPad)
                                .onTapGesture {
                                    dismissKeyboard()
                                }
                        }
                    }
                })
            }
            
            .navigationTitle(workoutStore.workouts[workoutindex].exercises[exerciseindex].exercisestat.exercisenamestatic)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        nextset()
                        print(workoutindex)
                    }, label: { Text("Next") }).foregroundColor(.green)
                }
            }
            
            
            
        }
        
        
        .fullScreenCover(isPresented: $isNextView, content: {PlayView(workoutindex: workoutindex, exerciseindex: exerciseindex+1)})
        .fullScreenCover(isPresented: $isFinalView, content: {WorkoutViewAward(workout: workoutStore.workouts[workoutindex])})
    }
    
    
    
    //Permette di scorrere tra le serie di un esercizio del workout
    func nextset() {
        for index in 0..<workoutStore.workouts[workoutindex].exercises[exerciseindex].sets.count {
            if newWeight[index] == "" {
                newWeight[index] = "0"
            }
            workoutStore.workouts[workoutindex].exercises[exerciseindex].sets[index].weight = Double(newWeight[index])!
        }
        
        if workoutStore.workouts[workoutindex].exercises.count-1 == exerciseindex {
            isFinalView.toggle()
        } else {
            isNextView.toggle()
        }
        DataManager.shared.saveWorkouts(workoutStore.workouts)
    }
    
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}





