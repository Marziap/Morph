//
//  ModalView.swift
//  ProvaMusic
//
//  Created by Marzia Pirozzi on 17/10/23.
//

import SwiftUI

struct ModalView: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("Your sounds")
                .font(.largeTitle)
                .padding(.vertical, 50)
            
            ScrollView{
                ForEach(datas.sounds){sound in
                    Button {
                        datas.mixSounds.append(sound)
                        print(datas.mixSounds[0].name)
                    } label: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color(red: 0.87, green: 0.87, blue: 0.87))
                                .frame(width: 188, height: 30)
                                .cornerRadius(10)
                            
                            Text(sound.name)
                                .foregroundColor(.black)
                        }
                    }.padding(10)
                }
            }
            
        }
        
    }
}

#Preview {
    ModalView()
}
