//
//  UIApplication.swift
//
//
//  Created by Kerim Çağlar on 31.07.2024.
//

import UIKit

extension UIApplication {
    func endEditing() {
        guard let scene = connectedScenes.first(where: { $0 is UIWindowScene }) as? UIWindowScene else {
            return
        }
        guard let window = scene.windows.first(where: { $0.isKeyWindow }) else {
            return
        }
        window.endEditing(true)
    }
}
