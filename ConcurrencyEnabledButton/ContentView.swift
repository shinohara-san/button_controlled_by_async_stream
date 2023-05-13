//
//  ContentView.swift
//  ConcurrencyEnabledButton
//
//  Created by shinohara.yuki.2250 on 2023/05/13.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @State var isPresentingAlert = false
    @State var alertEntity: AlertEntity?

    var body: some View {
        VStack {
            TextField("here", text: $viewModel.text)
                .textFieldStyle(.roundedBorder)
                .onChange(of: viewModel.text) { newValue in
                    viewModel.checkButtonStatus() // 1
                }
            Button("Save") {
                alertEntity = AlertEntity(
                    title: viewModel.text,
                    message: "\(viewModel.text) is a valid number",
                    actionText: "OK"
                )
                isPresentingAlert.toggle()
            }
            .disabled(!viewModel.isButtonEnabled)
            .buttonStyle(.bordered)
        }
        .padding()
        .alert(
            "Well done!",
            isPresented: $isPresentingAlert,
            presenting: alertEntity
        ) { entity in
            Button(entity.actionText) {
                print("print for dubug")
            }
        } message: { entity in
            Text(entity.message)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AlertEntity {
    let title: String
    let message: String
    let actionText: String
}
