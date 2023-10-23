//
//  PopUpBar2.swift
//  Learners
//
//  Created by Sadhana Fagwani  on 17/10/23.
//

import SwiftUI

struct PopUpBar: View {
    @State private var showingAlert = false
    @State private var name = ""
    @State private var tags = ""

    var body: some View {
        Button("Enter name") {
            showingAlert.toggle()
        }
        .alert("Do you want to Keep it?", isPresented: $showingAlert) {
            TextField("Name", text: $name)
            TextField("Tags", text: $tags)
            Button("Cancel", action: submit)
            Button("Save", action: submit)
                .foregroundStyle(Color.green)
        }
    }

    func submit() {
        print("You entered \(name)")
    }
}

#Preview {
    PopUpBar()
}
