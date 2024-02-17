//
//  View2.swift
//  GymZone
//
//  Created by marco cerino on 06/07/23.
//

import SwiftUI

struct View2: View {
    @State private var text: String = ""
    var body: some View {
        
        VStack {
                    Text("")
                        .padding()
                }
                .frame(width: 330, height: 400) // Imposta le dimensioni del pannello
                .background(Color(.systemGray6)) // Imposta il colore dello sfondo del pannello
                .cornerRadius(10)
    }
}

struct View2_Previews: PreviewProvider {
    static var previews: some View {
        View2()
    }
}
