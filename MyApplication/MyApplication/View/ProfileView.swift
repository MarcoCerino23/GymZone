//
//  ProfileView.swift
//  GymZone
//
//  Created by Marco Cerino on 01/05/23.

import SwiftUI
import UserNotifications




struct ProfileView: View {
    @EnvironmentObject var workoutStore : WorkoutsStore
    
    //variabile condivisa per la gestione dei dati del profilo
    @EnvironmentObject var profile:Profilo
    //classe per la gestione di notifiche
    var nManager = Notifiche()
    @State var showChart = false
    var body: some View {

        NavigationView {
            // Creazione di un `Form` per organizzare i contenuti della vista
            Form {
                // Sezione delle informazioni personali

                Section(header: Text("Informazioni personali").foregroundColor(.green)
                ) {

                    HStack {
                        Text("Nome")
                            .foregroundColor(Color.black)
                        TextField("", text: $profile.caratteristicheProfilo.nome)
                            .foregroundColor(Color.gray)
                            .font(Font.system(size: 16, weight: .medium))
                            .textContentType(.name)
                            .autocapitalization(.words)
                            .onChange(of: profile.caratteristicheProfilo.nome) { newValue in
                            DataManager.shared.saveProfile(profile.caratteristicheProfilo)
                            }

                    }
                    HStack{
                        Text("Sesso").foregroundColor(.black)
                        Picker("", selection: $profile.caratteristicheProfilo.sesso, content: {
                            Text("Maschio").tag(Sesso.maschio)
                            Text("Femmina").tag(Sesso.femmina)
                        }).pickerStyle(MenuPickerStyle())
                            .padding(.horizontal)
                            .onChange(of: profile.caratteristicheProfilo.sesso) { newValue in
                            DataManager.shared.saveProfile(profile.caratteristicheProfilo)
                            }
                    }
                    HStack{
                        Text("Livello ").foregroundColor(.black)
                        Picker("", selection: $profile.caratteristicheProfilo.livello, content: {
                            Text("Principiante").tag(Livello.principiante)
                            Text("Intermedio").tag(Livello.intermedio)
                            Text("Esperto").tag(Livello.esperto)
                        }).pickerStyle(MenuPickerStyle())
                            .padding(.horizontal)
                            .onChange(of: profile.caratteristicheProfilo.livello) { newValue in
                            DataManager.shared.saveProfile(profile.caratteristicheProfilo)
                            }


                    }



                    // Gestione del tap sulla sezione per nascondere la tastiera
                }.onTapGesture {
                    dismissKeyboard()
                }

                //Sezione delle misure antropometriche
                Section(header: Text("Misure antropometriche").foregroundColor(.green)
                ) {

                        HStack {
                            Image("altezza").resizable().frame(width: 28, height: 28)
                            Text("Altezza")
                                .foregroundColor(.black)
                            TextField("", text: $profile.caratteristicheProfilo.altezza)
                                .foregroundColor(Color.gray)
                                .font(Font.system(size: 16, weight: .medium))
                                .textContentType(.name)
                                .autocapitalization(.words)
                                .keyboardType(.decimalPad)
                                .onChange(of: profile.caratteristicheProfilo.altezza) { newValue in
                                DataManager.shared.saveProfile(profile.caratteristicheProfilo)
                                }
                            Text("cm").foregroundColor(.gray)
                        }.onTapGesture {
                            dismissKeyboard()
                        }

                        HStack {
                            Image("bilancia").resizable().frame(width: 28, height: 28)

                            Text("Peso")
                                .foregroundColor(.black)
                            TextField("", text: $profile.caratteristicheProfilo.ultimopeso, onCommit: {
                                if !profile.caratteristicheProfilo.ultimopeso.isEmpty {
                                    profile.caratteristicheProfilo.peso[Date.now] = profile.caratteristicheProfilo.ultimopeso
                                    DataManager.shared.saveProfile(profile.caratteristicheProfilo)
                                }
                            })

                            .foregroundColor(Color.gray)
                            .font(Font.system(size: 16, weight: .medium))
                            .textContentType(.name)
                            .autocapitalization(.words)
                            .onChange(of: profile.caratteristicheProfilo.peso) { newValue in
                            DataManager.shared.saveProfile(profile.caratteristicheProfilo)
                            }
                            Text("kg").foregroundColor(.gray)
                            Button(action: {showChart = true}, label:  {Image(systemName: "chart.xyaxis.line")} )
                        }




                }
                // Sezione delle circonferenze.

                Section(header: Text("Circonferenze").foregroundColor(.green))//.font(.title3)
                {
                    HStack{
                        Image(systemName: "list.bullet.clipboard")
                        Text("Collo")
                            .foregroundColor(.black)
                        TextField("", text: $profile.caratteristicheProfilo.misure.collo)
                            .foregroundColor(Color.gray)
                            .font(Font.system(size: 16, weight: .medium))
                            .textContentType(.name)
                            .autocapitalization(.words)
                            .keyboardType(.decimalPad)
                            .onChange(of: profile.caratteristicheProfilo.misure.collo) { newValue in
                            DataManager.shared.saveProfile(profile.caratteristicheProfilo)
                            }
                        Text("cm").foregroundColor(.gray)
                    }
                    HStack{
                        Image(systemName: "list.bullet.clipboard")
                        Text("Spalle")
                            .foregroundColor(.black)
                        TextField("", text: $profile.caratteristicheProfilo.misure.spalle)
                            .foregroundColor(Color.gray)
                            .font(Font.system(size: 16, weight: .medium))
                            .textContentType(.name)
                            .autocapitalization(.words)
                            .keyboardType(.decimalPad)
                            .onChange(of: profile.caratteristicheProfilo.misure.spalle) { newValue in
                            DataManager.shared.saveProfile(profile.caratteristicheProfilo)
                            }
                        Text("cm").foregroundColor(.gray)
                    }
                    HStack{
                        Image(systemName: "list.bullet.clipboard")
                        Text("Bicipite")
                            .foregroundColor(.black)
                        TextField("", text: $profile.caratteristicheProfilo.misure.bicipite)
                            .foregroundColor(Color.gray)
                            .font(Font.system(size: 16, weight: .medium))
                            .textContentType(.name)
                            .autocapitalization(.words)
                            .keyboardType(.decimalPad)
                            .onChange(of: profile.caratteristicheProfilo.misure.bicipite) { newValue in
                            DataManager.shared.saveProfile(profile.caratteristicheProfilo)
                            }
                        Text("cm").foregroundColor(.gray)

                    }
                    HStack{
                        Image(systemName: "list.bullet.clipboard")
                        Text("Tricipite")
                            .foregroundColor(.black)
                        TextField("", text: $profile.caratteristicheProfilo.misure.tricipite)
                            .foregroundColor(Color.gray)
                            .font(Font.system(size: 16, weight: .medium))
                            .textContentType(.name)
                            .autocapitalization(.words)
                            .keyboardType(.decimalPad)
                            .onChange(of: profile.caratteristicheProfilo.misure.tricipite) { newValue in
                            DataManager.shared.saveProfile(profile.caratteristicheProfilo)
                            }
                        Text("cm").foregroundColor(.gray)

                    }
                    HStack{
                        Image(systemName: "list.bullet.clipboard")
                        Text("Avambraccio")
                            .foregroundColor(.black)
                        TextField("", text: $profile.caratteristicheProfilo.misure.avambracci)
                            .foregroundColor(Color.gray)
                            .font(Font.system(size: 16, weight: .medium))
                            .textContentType(.name)
                            .autocapitalization(.words)
                            .keyboardType(.decimalPad)
                            .onChange(of: profile.caratteristicheProfilo.misure.avambracci) { newValue in
                            DataManager.shared.saveProfile(profile.caratteristicheProfilo)
                            }
                        Text("cm").foregroundColor(.gray)

                    }
                    HStack{
                        Image(systemName: "list.bullet.clipboard")
                        Text("Polpaccio")
                            .foregroundColor(.black)
                        TextField("", text: $profile.caratteristicheProfilo.misure.polpacci)
                            .foregroundColor(Color.gray)
                            .font(Font.system(size: 16, weight: .medium))
                            .textContentType(.name)
                            .autocapitalization(.words)
                            .keyboardType(.decimalPad)
                            .onChange(of: profile.caratteristicheProfilo.misure.polpacci) { newValue in
                            DataManager.shared.saveProfile(profile.caratteristicheProfilo)
                            }
                        Text("cm").foregroundColor(.gray)

                    }
                }.onTapGesture {
                    dismissKeyboard()

                }
                //richiesrta autorizzazione notifiche quando si apre la sezione
            }.navigationTitle("Profilo").onAppear {
                nManager.requestAuthorization()
            }

            // Schermata a schermo intero che mostra la vista del grafico quando `showChart` è `true`
        }.fullScreenCover(isPresented: $showChart, content:{ ChartView().environmentObject(profile)})

    }

}






func dismissKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),to: nil,from: nil,for: nil)
}

struct ProfileView_Previews: PreviewProvider {
        static var previews: some View {
            ProfileView()
                .environmentObject(Profilo())
        }
}











