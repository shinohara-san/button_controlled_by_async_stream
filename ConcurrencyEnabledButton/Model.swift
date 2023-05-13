//
//  Model.swift
//  ConcurrencyEnabledButton
//
//  Created by shinohara.yuki.2250 on 2023/05/13.
//

import Foundation

class Model {
    private var handler: ((String, Bool) -> Void)?
    var stream: AsyncThrowingStream<(String, Bool), Error> {
        .init { continuation in
            self.handler = { (val, boo) in // 4
                continuation.yield((val, boo))
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
        handler(text, buttonEnabled) // 3
    }
}


