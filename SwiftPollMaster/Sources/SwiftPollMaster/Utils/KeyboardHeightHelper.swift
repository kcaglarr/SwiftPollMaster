//
//  KeyboardHeightHelper.swift
//
//
//  Created by Kerim Çağlar on 31.07.2024.
//

import UIKit

public final class KeyboardHeightHelper: ObservableObject {
    
    @Published public var keyboardHeight: CGFloat = 0
    @Published public var keyboardIsOpen: Bool = false

    public init() {
        self.listenForKeyboardNotifications()
    }
    
    private func listenForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardDidShowNotification,
            object: nil,
            queue: .main
        ) { (notification) in
                guard let userInfo = notification.userInfo,
                      let keyboardRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            self.keyboardHeight = keyboardRect.height
            self.keyboardIsOpen = true
        }
        
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardDidHideNotification,
            object: nil,
            queue: .main
        ) { (notification) in
            self.keyboardHeight = 0
            self.keyboardIsOpen = false
        }
    }
}

