//
//  PollOptionView.swift
//
//
//  Created by Kerim Çağlar on 28.07.2024.
//

import SwiftUI

public struct PollOptionView: View {
    public let choice: PollOption
    public let totalVotes: Int
    public let showResults: Bool
    public let totalWidth: CGFloat
    let pollBlueColor = HexColor("#2155EC")
    let regular14 = Font.system(size: 14, weight: .regular)
    let medium14 = Font.system(size: 14, weight: .medium)
    
    public init(
        choice: PollOption,
        totalVotes: Int,
        showResults: Bool,
        totalWidth: CGFloat
    ) {
        self.choice = choice
        self.totalVotes = totalVotes
        self.showResults = showResults
        self.totalWidth = totalWidth
    }
    
    public var body: some View {
        let isSelected = choice.isSelected
        let percentage = choice.votePercentage
        let fillColor = choice.isSelected ? HexColor("#D2DE55") : Color.clear
        
        ZStack(alignment: .leading) {
            HStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(fillColor)
                    .frame(width: totalWidth * CGFloat(percentage) / 100, height: 46)
                
                Spacer()
                    .frame(minWidth: .zero)
            }
            
            if !isSelected, showResults {
                RoundedRectangle(cornerRadius: 8)
                    .fill(HexColor("#CBD3DD"))
                    .frame(width: percentage != 0 ? totalWidth * CGFloat(percentage) / 100 : 4, height: 46)
            }
            
            HStack {
                Text(choice.name)
                    .font(showResults ? medium14 : regular14)
                    .foregroundColor(showResults ? .black : pollBlueColor)
                
                Spacer()
                    .frame(minWidth: .zero)
                
                if showResults {
                    
                    HStack(spacing: 10) {
                        if choice.isSelected {
                            Image(uiImage: .checkmark)
                                .padding(.trailing)
                        }
                        Text("\(Int(percentage))%")
                            .font(medium14)
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .overlay(
                Group {
                    if showResults {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.clear, lineWidth: 1)
                    } else {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(pollBlueColor, lineWidth: 2)
                    }
                }
            )
        }
    }
}

//#Preview {
//    PollOptionView(
//        choice: .init(
//            id: "1",
//            name: "Choice",
//            isSelected: false,
//            percentageVotes: 30
//        ),
//        totalVotes: 120,
//        showResults: false
//    ).padding()
// }
