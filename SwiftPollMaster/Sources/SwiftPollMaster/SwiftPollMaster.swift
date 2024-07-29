//
//  SwiftPollMaster.swift
//
//
//  Created by Kerim Çağlar on 28.07.2024.
//

import SwiftUI

struct SwiftPollMaster: View {
    
    @State private var dotCount = 0
    let dotAnimationDuration: Double = 0.5
    let dotMaxCount = 3
    
    var body: some View {
        VStack {
            
            Text(loadingText)
                .font(.title)
                .padding()
                .animation(.easeInOut(duration: dotAnimationDuration), value: dotCount)
        }
        .onAppear {
            startLoadingAnimation()
        }
    }
    
    // "Loading..." metnindeki nokta sayısını döngüye koyma
    private var loadingText: String {
        let dots = String(repeating: ".", count: dotCount)
        return "Loading\(dots)"
    }

    // Yüklenme animasyonunu başlatma
    private func startLoadingAnimation() {
        Timer.scheduledTimer(withTimeInterval: dotAnimationDuration, repeats: true) { _ in
            withAnimation {
                dotCount = (dotCount % dotMaxCount) + 1
            }
        }
    }
}

#Preview {
    SwiftPollMaster()
}
