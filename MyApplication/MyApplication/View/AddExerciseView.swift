//
//  AddExerciseView.swift
//  MyApplication
//
//  Created by Marco Cerino on 22/02/23.
//

//Sezione per aggiungere un esercizio  al workout in fase di creazione

import SwiftUI

struct AddExerciseView: View {
    //Stringa di ricerca dell'esercizio
    @State var searchText = ""
    
    @Environment(\.dismiss) private var dismiss
    
    //Array statico degli esercizi
    var arraystatic = ExerciseDB()
    
    // Array filtrato degli esercizi in base alla stringa di ricerca
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
                    NavigationLink(destination: {ExercisePropertyView(exercisestatic: exercise)}, label: {ExerciseStaticCell(exercise: exercise)})
                }
            }
            .navigationTitle("Exercises").navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                
                dismiss()
                
            }, label: {Text("Cancel").foregroundColor(.green)}))
            .searchable(text: $searchText)
        }.accentColor(.green)
    }
}

struct AddExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        
        AddExerciseView()
    }
}
