//
//  ExecutionView.swift
//  MyApplication
//
//  Created by Marco Cerino on 16/02/23.
//


//Vista dove sono mostrati tutti gli esercizi di cui è possibile vedere descrizione ed esecuzione

import SwiftUI

struct ExecutionView: View {
    @State var searchText = ""
    
    var arraystatic = ExerciseDB()
    
    var filteredExercises: [ExerciseStatic] {
        if searchText.isEmpty {
            return arraystatic.exercisedb
        } else {
            return arraystatic.exercisedb.filter { exercise in
                exercise.exercisenamestatic.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List{
                ForEach(filteredExercises){ exercise in
                    NavigationLink(destination: {SingleExecutionView(exercisestatic: exercise)}, label: {ExerciseStaticCell(exercise: exercise)})
                }            }
            .navigationTitle("Executions").navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText)
        }
    }
}
struct ExerciseStaticCell: View {
    
    let exercise : ExerciseStatic
    
    var body: some View {
        HStack {
            GifImage(exercise.image).frame(width: 60,height: 60)
            Spacer().frame(width: 30)
            VStack(alignment: .leading, spacing: 10.0) {
                Text(exercise.exercisenamestatic)
                Text(exercise.bodypart.rawValue)
                    .font(.footnote)
            }
            Spacer()
        }
    }
}

struct ExecutionView_Previews: PreviewProvider {
    static var previews: some View {
        ExecutionView()
    }
}
