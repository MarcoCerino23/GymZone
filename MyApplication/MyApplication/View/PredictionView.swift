
import SwiftUI
import Charts
import AudioToolbox


struct Calor: Identifiable{
    var id = UUID().uuidString
    var cal: Double
    var weekDay: String
    
}

struct Ser: Identifiable{
    let name: String
    let c:[Calor]
    var id = UUID()
    
}


struct PredictionView: View{
    @Environment(\.dismiss) private var dismiss
    var caloriesReal:[Calor]
    var caloriesPredict:[Calor]
    @State var isShowingAlert = false
    @State private var isLiked: Bool = false
    var body: some View{
        var chartView = GraficoSwift3(caloriesReal: caloriesReal, caloriesPredict: caloriesPredict)
        
        NavigationView{
            ZStack{
                VStack(spacing: 20){
                    
                    //Richiamo della  view contenente il grafico
                    chartView
                    HStack{
                        //funzione per l'acquisizione della foto del grafico
                        ShareLink(item: Image(uiImage: generateSnapshot()), preview: SharePreview("Weather Chart", image: Image(uiImage: generateSnapshot())))
                            .buttonStyle(.borderedProminent)
                        
                    }
                    .alert(isPresented: $isShowingAlert) {
                        Alert(title: Text("Informazione"),
                              message: Text("Immagine del grafico acquisita."),
                              dismissButton: .default(Text("OK")))
                    }
                    
                }
            }
            .navigationBarItems(leading:Button(action: {
                
                dismiss()
                
                
            }, label: {Text("Cancel")}).foregroundColor(.green),trailing: Button(action: {
                let renderer = ImageRenderer(content: chartView)
                renderer.scale = UIScreen.main.scale
                
                if let image = renderer.uiImage {
                    if let data = image.pngData(), let pngImage = UIImage(data: data) {
                        UIImageWriteToSavedPhotosAlbum(pngImage, nil, nil, nil)
                    }
                    
                }
                
                AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {   }
                isShowingAlert.toggle()
            }, label: {Image(systemName: "photo.artframe")}).foregroundColor(.green))
            .navigationTitle("Calorie bruciate").navigationBarTitleDisplayMode(.inline)
        }
        
    }
    
    
    
    @MainActor
    private func generateSnapshot() -> UIImage {
        let renderer = ImageRenderer(content: GraficoSwift3(caloriesReal: caloriesReal, caloriesPredict: caloriesPredict))
        
        return renderer.uiImage ?? UIImage()
    }
    
    
    @ViewBuilder
    func CustomButton(systemImage: String, status: Bool,activateTint: Color, inActiveTint: Color, onTap: @escaping () -> ()) -> some View{
        Button(action: onTap) {
            
            Image(systemName: systemImage)
                .font(.title2)
                .foregroundColor(status ? activateTint : inActiveTint)
                .padding(.horizontal, 18)
                .padding(.vertical, 8)
                .background{
                    Capsule()
                        .fill(status ? activateTint.opacity(0.25) : Color("ButtonColor"))
                }
        }
    }
}


struct GraficoSwift3: View {
    @Environment(\.dismiss) private var dismiss
    var caloriesReal:[Calor]
    @State var caloriesPredict:[Calor]
    
    var body: some View {
        
        let dateFormatter = ISO8601DateFormatter()
        let calorData: [Ser] = [
            .init(name: "Real", c: caloriesReal),
            .init(name: "Prediction", c: caloriesPredict)
        ]
        
        VStack{
            //grafico contenente il confronto tra le calorie che l'utente ha bruciato nei 3 giorni precedenti e che brucerà nei 3 giorni successivi
            Chart(calorData){ series in
                ForEach(series.c) { element in
                    BarMark(
                        x: .value("Giorni", dateFormatter.date(from: element.weekDay /*?? ""*/) ?? Date(), unit: .day),
                        y:.value("Calorie", element.cal)
                    )
                    .foregroundStyle(by: .value("Calorie", series.name))
                    .symbol(by: .value("Calorie", series.name))
                    .position(by: .value("Calories",series.name))//togliere questo se si vuole confrontare con linee
                    
                }
            }
            
            .chartYAxis{
                AxisMarks(preset: .extended,position: .leading)
                
            }
            
            
        }
        
        .frame(height: 250,alignment: .center)
        .padding()
        
        
        
        
    }
    
    
}

