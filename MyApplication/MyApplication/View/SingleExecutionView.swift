//
//  SingleExecutionView.swift
//  MyApplication
//
//  Created by Marco Cerino on 21/02/23.
//


//View per mostrare gif e descrizione di uno specifico esercizio

import SwiftUI
struct SingleExecutionView: View {
    let exercisestatic: ExerciseStatic
    
    var body: some View {
        NavigationView{
            Form{
                GifImage(exercisestatic.image).frame(width: 300,height: 300,alignment: .center)
                Section(header: Text("Exercise description")){Text(exercisestatic.description)
                }
            }
            .navigationTitle(exercisestatic.exercisenamestatic)
        }
    }
}

struct SingleExecutionView_Previews: PreviewProvider {
    static var previews: some View {
        SingleExecutionView(exercisestatic: ExerciseStatic(exercisenamestatic: "Bench Press", description: "descrizione", bodypart: Bodyparts.chest, image: "Panca"))
    }
}
