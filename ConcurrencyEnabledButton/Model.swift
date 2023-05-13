//
//  Model.swift
//  ConcurrencyEnabledButton
//
//  Created by shinohara.yuki.2250 on 2023/05/13.
//

import Foundation

class Model {
    private var handler: ((Bool) -> Void)?
    var stream: AsyncThrowingStream<Bool, Error> {
        .init { continuation in
            self.handler = { value in // 4
                continuation.yield(value)
            }

            continuation.onTermination = { termination in
                switch termination {
                case .cancelled:
                    print("cancelled")
                case let .finished(error):
                    if error != nil {
                        print("error")
                    } else {
                        print("finished")
                    }
                @unknown default:
                    fatalError()
                }
            }
        }
    }

    func checkButtonStatus(text: String) {
        guard let handler else { return }
        let buttonEnabled = text.count == 13
        handler(buttonEnabled) // 3
    }
}


