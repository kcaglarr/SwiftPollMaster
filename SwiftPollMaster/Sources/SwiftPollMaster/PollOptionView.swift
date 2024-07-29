//
//  PollOptionView.swift
//
//
//  Created by Kerim Çağlar on 28.07.2024.
//

import SwiftUI

struct PollOptionView: View {
    var choice: PollOption
    var totalVotes: Int
    var showResults: Bool
    let feedBlueColor = HexColor("#2155EC")
    let regular14 = Font.system(size: 14, weight: .regular)
    let medium14 = Font.system(size: 14, weight: .medium)
    
    var body: some View {
        let isSelected = choice.isSelected ?? false
        let percentage = Double(choice.percentageVotes ?? 0) / 100
        let fillColor = (choice.isSelected ?? false) ? HexColor("#D2DE55") : Color.clear
        
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                HStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(fillColor)
                        .frame(width: geometry.size.width * CGFloat(percentage), height: 46)
                    Spacer()
                    
                }
                
                if !isSelected, showResults {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(HexColor("#CBD3DD"))
                        .frame(width: percentage != 0 ? geometry.size.width * CGFloat(percentage) : 4, height: 46)
                }
                
                HStack {
                    Text(choice.name ?? "")
                        .font(showResults ? medium14 : regular14)
                        .foregroundColor(showResults ? .black : feedBlueColor)
                    Spacer()
                    if showResults {
                        
                        HStack(spacing: 10) {
                            if choice.isSelected ?? false {
                                Image(uiImage: .checkmark)
                                    .padding(.trailing)
                            }
                            Text("\(Int(percentage * 100))%")
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
                                .stroke(feedBlueColor, lineWidth: 2)
                        }
                    }
                )
            }
        }
        .frame(height: 46)
    }
}

#Preview {
    PollOptionView(
        choice: .init(
            id: "1",
            name: "Deneme",
            isSelected: false,
            percentageVotes: 30
        ),
        totalVotes: 120,
        showResults: false
    ).padding()
 }
