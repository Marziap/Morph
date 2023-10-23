//
//  ButtonComponent.swift
//  Morph
//
//  Created by Marzia Pirozzi on 20/10/23.
//

import Foundation
import SwiftUI


struct customButton: View {

    var buttonImage: String

    var body: some View {

        Button (action: {
            //record
        } , label: {
            ZStack {
                Circle()

                    .foregroundColor(.green)
                    .frame(height: 50)

                Image(systemName: buttonImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 30)
            }
            .padding(.horizontal)
        })
    }

}
