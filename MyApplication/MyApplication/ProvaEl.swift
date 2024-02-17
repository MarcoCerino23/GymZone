//
//  ProvaEl.swift
//  GymZone
//
//  Created by Marco Cerino on 30/04/23.
//

import SwiftUI

struct ImageVi: View{
   
    
    var body: some View{
        var chartView = ProvaEl()
        VStack(spacing: 20){
            //GraficoSwift3(caloriesReal: caloriesReal, caloriesPredict: caloriesPredict)
            chartView
            HStack{
                Button {
                                let renderer = ImageRenderer(content: chartView)

                                if let image = renderer.uiImage {
                                    //UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                                   if let data = image.pngData(), let pngImage = UIImage(data: data) {
                                               UIImageWriteToSavedPhotosAlbum(pngImage, nil, nil, nil)
                                           }
//                                    let imageSaver = ImageSever()
//                                  imageSaver.writeToPhotoAlbum(image: image)
                                }
                   
                            } label: {
                                Label("Save to Photos", systemImage: "photo")
                            }
                            .buttonStyle(.borderedProminent)
                
                
                ShareLink(item: Image(uiImage: generateSnapshot()), preview: SharePreview("Weather Chart", image: Image(uiImage: generateSnapshot())))
                .buttonStyle(.borderedProminent)
            }
        }
        
    }
 

    
    @MainActor
    private func generateSnapshot() -> UIImage {
        let renderer = ImageRenderer(content: ProvaEl())
     
        return renderer.uiImage ?? UIImage()
    }
}

struct ProvaEl: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ProvaEl_Previews: PreviewProvider {
    static var previews: some View {
        ProvaEl()
    }
}
