//
//  PollView.swift
//
//
//  Created by Kerim Çağlar on 28.07.2024.
//

import SwiftUI

public protocol PollViewDelegate {
    func selectedOption(_ postId: String, _ optionId: String)
}

public struct PollView: View {
    
    let choices: [PollOption]
    let postId: String
    let totalVotes: Int
    let remainTime: String
    let showResults: Bool
    let delegate: PollViewDelegate?
    let selectedOption: PollOption?
    
    public init(
        choices: [PollOption],
        postId: String,
        totalVotes: Int,
        remainTime: String,
        showResults: Bool,
        delegate: PollViewDelegate?,
        selectedOption: PollOption? = nil
    ) {
        self.choices = choices
        self.postId = postId
        self.totalVotes = totalVotes
        self.remainTime = remainTime
        self.showResults = showResults
        self.delegate = delegate
        self.selectedOption = selectedOption
    }
    
    public var body: some View {
        
        LazyVStack(alignment:.leading, spacing: 20) {
            ForEach(choices.indices, id: \.self) { index in
                PollOptionView(
                    choice: choices[index],
                    totalVotes: totalVotes,
                    showResults: showResults
                )
                .contentShape(Rectangle())
                .onTapGesture {
                    if selectedOption == nil, !showResults {
                        withAnimation {
                            delegate?.selectedOption(postId, choices[index].id ?? "")
                        }
                    }
                }
            }
            
            HStack {
                Text("\(totalVotes) votes")
                    .font(.system(size: 14, weight: .medium)) //medium14
                    .foregroundColor(.blue) //#2155EC
                Text("•")
                    .font(.system(size: 14, weight: .regular)) //regular14
                    .foregroundColor(Color.gray)
                Text(remainTime)
                    .font(.system(size: 14, weight: .regular)) //regular14
                    .foregroundColor(Color.gray)
            }
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 1)
        }
        .padding()
    }
}

#Preview {
    PollView(
        choices: [
            .init(
                id: "1",
                name: "Test 1",
                isSelected: false,
                percentageVotes: 5
            ),
            .init(
                id: "2",
                name: "Test 2",
                isSelected: true,
                percentageVotes: 95
            ),
            .init(
                id: "3",
                name: "Test 3",
                isSelected: false,
                percentageVotes: 0
            )
        ],
        postId: "",
        totalVotes: 206,
        remainTime: "21h left",
        showResults: false,
        delegate: nil
    )
}
