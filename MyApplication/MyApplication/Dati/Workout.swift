//
//  Workout.swift
//  MyApplication
//
//  Created by Marco Cerino on 16/02/23.
//

import Foundation

enum Bodyparts: String, Codable {
    case chest = "Chest"
    case biceps = "Biceps"
    case legs = "Legs"
    case shoulders = "Shoulders"
    case triceps = "Triceps"
    case back = "Back"
}

struct Sets: Identifiable, Codable {
    var id = UUID()
    var reps: Int
    var weight: Double
}

struct ExerciseStatic: Identifiable, Codable {
    var id = UUID()
    var exercisenamestatic: String
    var description: String
    var bodypart: Bodyparts
    var image: String
}

struct Exercise: Identifiable, Codable {
    var id = UUID()
    var exercisestat: ExerciseStatic
    var sets: [Sets]
    var min: Int
    var sec: Int

    init(exercisestat: ExerciseStatic) {
        self.exercisestat = exercisestat
        self.sets = [Sets(reps: 0, weight: 0.0)]
        self.min = 0
        self.sec = 0
    }
}


struct Workout: Identifiable, Codable {
    var id: Int
    var workoutname: String
    var exercises: [Exercise]
    let creationdate: Date

    //var date: [Date]
    var exerciseTime: DateComponents
}




class WorkoutsStore: ObservableObject {
    @Published var workouts: [Workout] = []
    

    init(){
 
        workouts = DataManager.shared.loadWorkouts()
        
        
    }
    func addWorkout(_ workout: Workout) {
        workouts.append(workout)
        print(workouts[workouts.count-1].id)
    }
    func deleteWorkout(id: Int){
        var indexCopy = 0
        for index in 0..<workouts.count{
            if workouts[index].id == id {
                workouts.remove(at: index)
                indexCopy = index
            }
        }
        if indexCopy != 0{
            for index in indexCopy..<workouts.count{
                workouts[index].id = workouts[index].id-1
            }
        }
    }
    
    func addStandard(profile:Profilo){
        
        if(profile.caratteristicheProfilo.livello==Livello.principiante && profile.caratteristicheProfilo.sesso==Sesso.femmina){
            addWorkout(Workout(id:workouts.count, workoutname: "Standard Workout", exercises: [Exercise(exercisestat:  ExerciseStatic(exercisenamestatic: "Alternate Dumbbell Curl", description:descrizioni.AlternateDumbbellCurl.rawValue, bodypart: Bodyparts.biceps, image: "CurlAlt")),Exercise(exercisestat:    ExerciseStatic(exercisenamestatic: "Barbell Bent Over Row", description: descrizioni.BarbellBentOverRow.rawValue, bodypart: Bodyparts.back, image: "BarbBentOverRow")),Exercise(exercisestat:  ExerciseStatic(exercisenamestatic: "Dumbbell Overhead Triceps Exctensions", description:descrizioni.DumbbellOverheadTricepsExctensions.rawValue, bodypart: Bodyparts.triceps, image: "DumbTricepsExtensions"))], creationdate: Date.now,  exerciseTime: DateComponents()))
        }else if(profile.caratteristicheProfilo.livello==Livello.principiante && profile.caratteristicheProfilo.sesso==Sesso.maschio){
            addWorkout(Workout(id: workouts.count, workoutname: "Standard Workout", exercises: [Exercise(exercisestat: ExerciseStatic(exercisenamestatic: "Bench Press", description: descrizioni.BenchPress.rawValue, bodypart: Bodyparts.chest, image: "Panca")),Exercise(exercisestat: ExerciseStatic(exercisenamestatic: "Incline Bench Press", description: descrizioni.InclineBenchPress.rawValue, bodypart: Bodyparts.chest, image: "PancaInc")),Exercise(exercisestat: ExerciseStatic(exercisenamestatic: "Barbell French Press", description: descrizioni.BarbellFrenchPress.rawValue, bodypart: Bodyparts.triceps, image: "FrenchPress"))], creationdate: Date.now,  exerciseTime: DateComponents()))
        }else if(profile.caratteristicheProfilo.livello == Livello.intermedio && profile.caratteristicheProfilo.sesso == Sesso.maschio){
            addWorkout(Workout(id: workouts.count, workoutname: "Standard Workout", exercises: [Exercise(exercisestat: ExerciseStatic(exercisenamestatic: "Bench Press", description: descrizioni.BenchPress.rawValue, bodypart: Bodyparts.chest, image: "Panca")),Exercise(exercisestat: ExerciseStatic(exercisenamestatic: "Incline Bench Press", description: descrizioni.InclineBenchPress.rawValue, bodypart: Bodyparts.chest, image: "PancaInc")),Exercise(exercisestat: ExerciseStatic(exercisenamestatic: "Barbell French Press", description: descrizioni.BarbellFrenchPress.rawValue, bodypart: Bodyparts.triceps, image: "FrenchPress")),Exercise(exercisestat:ExerciseStatic(exercisenamestatic: "Dumbbell Overhead Triceps Exctensions", description: descrizioni.DumbbellOverheadTricepsExctensions.rawValue, bodypart: Bodyparts.triceps, image: "DumbTricepsExtensions")),Exercise(exercisestat: ExerciseStatic(exercisenamestatic: "Dumbbell Curl", description: descrizioni.DumbbellCurl.rawValue, bodypart: Bodyparts.biceps, image: "Curl"))], creationdate: Date.now, exerciseTime: DateComponents()))
        }else if(profile.caratteristicheProfilo.livello == Livello.intermedio && profile.caratteristicheProfilo.sesso == Sesso.femmina){
            addWorkout(Workout(id: workouts.count, workoutname: "Standard Workout", exercises: [Exercise(exercisestat: ExerciseStatic(exercisenamestatic: "Bench Press", description: descrizioni.BenchPress.rawValue, bodypart: Bodyparts.chest, image: "Panca")),Exercise(exercisestat: ExerciseStatic(exercisenamestatic: "Incline Bench Press", description: descrizioni.InclineBenchPress.rawValue, bodypart: Bodyparts.chest, image: "PancaInc")),Exercise(exercisestat: ExerciseStatic(exercisenamestatic: "Barbell French Press", description: descrizioni.BarbellFrenchPress.rawValue, bodypart: Bodyparts.triceps, image: "FrenchPress")),Exercise(exercisestat:ExerciseStatic(exercisenamestatic: "Dumbbell Overhead Triceps Exctensions", description: descrizioni.DumbbellOverheadTricepsExctensions.rawValue, bodypart: Bodyparts.triceps, image: "DumbTricepsExtensions"))], creationdate: Date.now,  exerciseTime: DateComponents()))
        }else if(profile.caratteristicheProfilo.livello == Livello.esperto && profile.caratteristicheProfilo.sesso == Sesso.maschio){
            addWorkout(Workout(id: workouts.count, workoutname: "Standard Workout", exercises: [Exercise(exercisestat: ExerciseStatic(exercisenamestatic: "Bench Press", description: descrizioni.BenchPress.rawValue, bodypart: Bodyparts.chest, image: "Panca")),Exercise(exercisestat: ExerciseStatic(exercisenamestatic: "Incline Bench Press", description: descrizioni.InclineBenchPress.rawValue, bodypart: Bodyparts.chest, image: "PancaInc")),Exercise(exercisestat: ExerciseStatic(exercisenamestatic: "Barbell French Press", description: descrizioni.BarbellFrenchPress.rawValue, bodypart: Bodyparts.triceps, image: "FrenchPress")),Exercise(exercisestat:ExerciseStatic(exercisenamestatic: "Dumbbell Overhead Triceps Exctensions", description: descrizioni.DumbbellOverheadTricepsExctensions.rawValue, bodypart: Bodyparts.triceps, image: "DumbTricepsExtensions")),Exercise(exercisestat: ExerciseStatic(exercisenamestatic: "Dumbbell Curl", description:descrizioni.DumbbellCurl.rawValue, bodypart: Bodyparts.biceps, image: "Curl")),Exercise(exercisestat: ExerciseStatic(exercisenamestatic: "Barbell Bent Over Row", description: descrizioni.BarbellBentOverRow.rawValue, bodypart: Bodyparts.back, image: "BarbBentOverRow")),Exercise(exercisestat: ExerciseStatic(exercisenamestatic: "Dumbbell Front Raise", description: descrizioni.DumbbellFrontRaise.rawValue, bodypart: Bodyparts.shoulders, image: "DumbFrontRaise"))], creationdate: Date.now,  exerciseTime: DateComponents()))
        }else if(profile.caratteristicheProfilo.livello == Livello.esperto && profile.caratteristicheProfilo.sesso == Sesso.femmina){
            addWorkout(Workout(id: workouts.count, workoutname: "Standard Workout", exercises: [Exercise(exercisestat: ExerciseStatic(exercisenamestatic: "Bench Press", description: descrizioni.BenchPress.rawValue, bodypart: Bodyparts.chest, image: "Panca")),Exercise(exercisestat: ExerciseStatic(exercisenamestatic: "Incline Bench Press", description: descrizioni.InclineBenchPress.rawValue, bodypart: Bodyparts.chest, image: "PancaInc")),Exercise(exercisestat: ExerciseStatic(exercisenamestatic: "Barbell French Press", description: descrizioni.BarbellFrenchPress.rawValue, bodypart: Bodyparts.triceps, image: "FrenchPress")),Exercise(exercisestat:ExerciseStatic(exercisenamestatic: "Dumbbell Overhead Triceps Exctensions", description: descrizioni.DumbbellOverheadTricepsExctensions.rawValue, bodypart: Bodyparts.triceps, image: "DumbTricepsExtensions")),Exercise(exercisestat: ExerciseStatic(exercisenamestatic: "Dumbbell Curl", description:descrizioni.DumbbellCurl.rawValue, bodypart: Bodyparts.biceps, image: "Curl")),Exercise(exercisestat: ExerciseStatic(exercisenamestatic: "Barbell Bent Over Row", description: descrizioni.BarbellBentOverRow.rawValue, bodypart: Bodyparts.back, image: "BarbBentOverRow"))], creationdate: Date.now,  exerciseTime: DateComponents()))
        }
        for index in 0..<workouts[workouts.count-1].exercises.count {
            workouts[workouts.count-1].exercises[index].min = 1
            workouts[workouts.count-1].exercises[index].sec = 30
            workouts[workouts.count-1].exercises[index].sets = [
                Sets(reps: 8, weight: 0.0),
                Sets(reps: 8, weight: 0.0),
                Sets(reps: 8, weight: 0.0),
                Sets(reps: 8, weight: 0.0)
            ]
        }
        print(workouts[workouts.count-1].id)
        DataManager.shared.saveWorkouts(self.workouts)
    }
}

class ExerciseDB {
    @Published var exercisedb: [ExerciseStatic] = [
        ExerciseStatic(exercisenamestatic: "Bench Press", description: "Lie face up on a flat bench, and grip a barbell with the hands slightly wider than shoulder-width. Press the feet into the ground and the hips into the bench while lifting the bar off the rack. Slowly lower the bar to the chest by allowing the elbows to bend out to the side. Stop when the elbows are just below the bench, and press feet into the floor to press the weight straight up to return to the starting position.", bodypart: Bodyparts.chest, image: "Panca"),
        ExerciseStatic(exercisenamestatic: "Incline Bench Press", description: "Lie face up on a flat bench, and grip a barbell with the hands slightly wider than shoulder-width. Press the feet into the ground and the hips into the bench while lifting the bar off the rack. Slowly lower the bar to the chest by allowing the elbows to bend out to the side. Stop when the elbows are just below the bench, and press feet into the floor to press the weight straight up to return to the starting position.", bodypart: Bodyparts.chest, image: "PancaInc"),
        ExerciseStatic(exercisenamestatic: "Dumbbell Curl", description: "Begin by standing up straight with a dumbbell in each hand, palms facing inwards towards your thighs. Keep your elbows tucked in close to your sides and exhale as you curl one dumbbell towards your shoulder, rotating your forearm so that your palm faces your shoulder at the top of the movement. Hold the contraction for a brief moment and then slowly lower the dumbbell back down to the starting position, inhaling as you go.Repeat the same movement with the opposite arm, alternating between left and right arm curls for the desired number of repetitions.As you progress through the exercise, you can choose to perform the curls in a more controlled or explosive manner, depending on your fitness goals and desired intensity.", bodypart: Bodyparts.biceps, image: "Curl"),
        ExerciseStatic(exercisenamestatic: "Alternate Dumbbell Curl", description: "Begin by standing up straight with a dumbbell in each hand, palms facing inwards towards your thighs.Keep your elbows tucked in close to your sides and exhale as you curl one dumbbell towards your shoulder, rotating your forearm so that your palm faces your shoulder at the top of the movement. Hold the contraction for a brief moment and then slowly lower the dumbbell back down to the starting position, inhaling as you go. Repeat the same movement with the opposite arm, alternating between left and right arm curls for the desired number of repetitions. As you progress through the exercise, you can choose to perform the curls in a more controlled or explosive manner, depending on your fitness goals and desired intensity.", bodypart: Bodyparts.biceps, image: "CurlAlt"),
        ExerciseStatic(exercisenamestatic: "Barbell Bent Over Row", description: "Grip a barbell with palms down so that the wrists, elbows, and shoulders are in a straight line. Lift the bar from the rack, bend forward at the hips, and keep the back straight with a slight bend in the knees. Lower the bar towards the floor until the elbows are completely straight, and keep the back flat as the bar is pulled towards the belly button. Then slowly lower the bar to the starting position and repeat. ", bodypart: Bodyparts.back, image: "BarbBentOverRow"),
        ExerciseStatic(exercisenamestatic: "Dumbbell Front Raise", description: "Begin by standing up straight with a dumbbell in each hand, palms facing your thighs. Keep your arms straight and exhale as you lift one dumbbell straight out in front of you until it reaches shoulder height. Hold the contraction for a brief moment and then slowly lower the dumbbell back down to the starting position, inhaling as you go. Repeat the same movement with the opposite arm, alternating between left and right arm raises for the desired number of repetitions. As you progress through the exercise, you can choose to perform the raises in a more controlled or explosive manner, depending on your fitness goals and desired intensity.", bodypart: Bodyparts.shoulders, image: "DumbFrontRaise"),
        ExerciseStatic(exercisenamestatic: "Dumbbell Overhead Triceps Extensions", description: "Begin by standing up straight with your feet shoulder-width apart and holding a dumbbell in both hands with both palms facing up. Raise the dumbbell above your head and keep your elbows close to your ears. Your upper arms should be vertical and perpendicular to the floor, and the dumbbell should be positioned behind your head with your forearms pointing up. Inhale and slowly lower the dumbbell behind your head, keeping your upper arms stationary. Pause briefly at the bottom of the movement, then exhale as you contract your triceps and lift the dumbbell back up to the starting position. Repeat the movement for the desired number of repetitions, making sure to keep your core engaged and avoiding any movement in your shoulders.", bodypart: Bodyparts.triceps, image: "DumbTricepsExtensions"),
        ExerciseStatic(exercisenamestatic: "Barbell French Press", description: "Begin by lying on a flat bench with your feet flat on the floor and your head positioned at the end of the bench. Grasp a barbell with an overhand grip, hands positioned slightly closer than shoulder-width apart. Hold the barbell with your arms extended straight up above your chest, keeping your elbows locked. Inhale and slowly lower the barbell towards your forehead by bending your elbows, keeping your upper arms stationary. Pause briefly at the bottom of the movement, then exhale as you press the barbell back up to the starting position, extending your arms straight up again. Repeat the movement for the desired number of repetitions, focusing on keeping your elbows stationary and avoiding any movement in your shoulders.", bodypart: Bodyparts.triceps, image: "FrenchPress")
    ]
    
}



enum descrizioni:String{
    case BenchPress="Lie face up on a flat bench, and grip a barbell with the hands slightly wider than shoulder-width. Press the feet into the ground and the hips into the bench while lifting the bar off the rack. Slowly lower the bar to the chest by allowing the elbows to bend out to the side. Stop when the elbows are just below the bench, and press feet into the floor to press the weight straight up to return to the starting position."
    case InclineBenchPress = " Lie face up on a flat bench, and grip a barbell with the hands slightly wider than shoulder-width. Press the feet into the ground and the hips into the bench while lifting the bar off the rack. Slowly lower the bar to the chest by allowing the elbows to bend out to the side. Stop when the elbows are just below the bench, and press feet into the floor to press the weight straight up to return to the starting position."
    case DumbbellCurl = "Begin by standing up straight with a dumbbell in each hand, palms facing inwards towards your thighs. Keep your elbows tucked in close to your sides and exhale as you curl one dumbbell towards your shoulder, rotating your forearm so that your palm faces your shoulder at the top of the movement. Hold the contraction for a brief moment and then slowly lower the dumbbell back down to the starting position, inhaling as you go.Repeat the same movement with the opposite arm, alternating between left and right arm curls for the desired number of repetitions.As you progress through the exercise, you can choose to perform the curls in a more controlled or explosive manner, depending on your fitness goals and desired intensity."
    case AlternateDumbbellCurl = "Begin by standing up straight with a dumbbell in each hand, palms facing inwards towards your thighs.Keep your elbows tucked in close to your sides and exhale as you curl one dumbbell towards your shoulder, rotating your forearm so that your palm faces your shoulder at the top of the movement. Hold the contraction for a brief moment and then slowly lower the dumbbell back down to the starting position, inhaling as you go. Repeat the same movement with the opposite arm, alternating between left and right arm curls for the desired number of repetitions. As you progress through the exercise, you can choose to perform the curls in a more controlled or explosive manner, depending on your fitness goals and desired intensity."
    case BarbellBentOverRow = "Grip a barbell with palms down so that the wrists, elbows, and shoulders are in a straight line. Lift the bar from the rack, bend forward at the hips, and keep the back straight with a slight bend in the knees. Lower the bar towards the floor until the elbows are completely straight, and keep the back flat as the bar is pulled towards the belly button. Then slowly lower the bar to the starting position and repeat. "
    case DumbbellFrontRaise = "Begin by standing up straight with a dumbbell in each hand, palms facing your thighs. Keep your arms straight and exhale as you lift one dumbbell straight out in front of you until it reaches shoulder height. Hold the contraction for a brief moment and then slowly lower the dumbbell back down to the starting position, inhaling as you go. Repeat the same movement with the opposite arm, alternating between left and right arm raises for the desired number of repetitions. As you progress through the exercise, you can choose to perform the raises in a more controlled or explosive manner, depending on your fitness goals and desired intensity."
    case DumbbellOverheadTricepsExctensions = "Begin by standing up straight with your feet shoulder-width apart and holding a dumbbell in both hands with both palms facing up. Raise the dumbbell above your head and keep your elbows close to your ears. Your upper arms should be vertical and perpendicular to the floor, and the dumbbell should be positioned behind your head with your forearms pointing up. Inhale and slowly lower the dumbbell behind your head, keeping your upper arms stationary. Pause briefly at the bottom of the movement, then exhale as you contract your triceps and lift the dumbbell back up to the starting position. Repeat the movement for the desired number of repetitions, making sure to keep your core engaged and avoiding any movement in your shoulders."
    case BarbellFrenchPress = "Begin by lying on a flat bench with your feet flat on the floor and your head positioned at the end of the bench. Grasp a barbell with an overhand grip, hands positioned slightly closer than shoulder-width apart. Hold the barbell with your arms extended straight up above your chest, keeping your elbows locked. Inhale and slowly lower the barbell towards your forehead by bending your elbows, keeping your upper arms stationary. Pause briefly at the bottom of the movement, then exhale as you press the barbell back up to the starting position, extending your arms straight up again. Repeat the movement for the desired number of repetitions, focusing on keeping your elbows stationary and avoiding any movement in your shoulders."
}


