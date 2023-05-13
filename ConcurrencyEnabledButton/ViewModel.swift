//
//  ViewModel.swift
//  ConcurrencyEnabledButton
//
//  Created by shinohara.yuki.2250 on 2023/05/13.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var text = ""
    @Published var isButtonEnabled = false

//    var isButtonEnabled: Bool {
//        text.count == 13
//    }

    private let model = Model()
    private var task: Task<Void, Error>?

    init() {
        task = Task {
            for try await (isButtonEnabled) in model.stream { // 5
                Task.detached { @MainActor in
                    self.isButtonEnabled = isButtonEnabled
                }
            }
        }
    }

    deinit {
        task?.cancel()
    }

    func checkButtonStatus() { // 2
        model.checkButtonStatus(text: text)
    }
}
