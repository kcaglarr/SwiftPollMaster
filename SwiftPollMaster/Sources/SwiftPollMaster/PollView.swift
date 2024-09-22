//
//  PollView.swift
//
//
//  Created by Kerim Çağlar on 28.07.2024.
//

import SwiftUI

public struct PollView<VoteOptionContent: View>: View {
    
    let choices: [PollOption]
    let totalVotes: Int
    let remainTime: String
    
    @ViewBuilder var voteOptionContent: (_ pollOption: PollOption, _ optionIndex: Int) -> VoteOptionContent
    
    public init(
        choices: [PollOption],
        totalVotes: Int,
        remainTime: String,
        @ViewBuilder voteOptionContent: @escaping (
            _ pollOption: PollOption,
            _ optionIndex: Int
        ) -> VoteOptionContent
    ) {
        self.choices = choices
        self.totalVotes = totalVotes
        self.remainTime = remainTime
        self.voteOptionContent = voteOptionContent
    }
    
    public init(
        choices: [PollOption],
        totalVotes: Int,
        remainTime: String,
        showResults: Bool,
        totalWidth: CGFloat
    ) where VoteOptionContent == PollOptionView {
        self.choices = choices
        self.totalVotes = totalVotes
        self.remainTime = remainTime
        self.voteOptionContent = { pollOption, optionIndex in
            PollOptionView(
                choice: pollOption,
                totalVotes: totalVotes,
                showResults: showResults,
                totalWidth: totalWidth
            )
        }
    }
    
    public var body: some View {
        
        LazyVStack(alignment:.leading, spacing: 20) {
            ForEach(choices.indices, id: \.self) { index in
                voteOptionContent(choices[index], index)
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
    }
}

private extension View {
    func pollBorderStyle() -> some View {
        self
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            }
            .padding()
    }
}


//MARK: - Default initializer preview
#Preview("Default Cell View") {
    
    let pollOptions: [PollOption] = [
        .init(name: "Opt 1", isSelected: true, votePercentage: 30),
        .init(name: "Opt 2", isSelected: false, votePercentage: 100)
    ]
    
    return GeometryReader { geo in
        
        let voteAreaWidth = geo.size.width - 64
        
        VStack {
            PollView(
                choices: pollOptions,
                totalVotes: 10,
                remainTime: "10",
                showResults: true,
                totalWidth: voteAreaWidth
            )
            .pollBorderStyle()
            
        }
    }
}


//MARK: - Customized cell initializer preview
#Preview("Customized Cell Initializer") {
    
    let pollOptions: [PollOption] = [
        .init(name: "Opt 1", isSelected: false, votePercentage: 30),
        .init(name: "Opt 2", isSelected: false, votePercentage: 100)
    ]
    
    return GeometryReader { geo in
        
        let voteAreaWidth = geo.size.width - 64
        
        PollView(
            choices: pollOptions,
            totalVotes: 10,
            remainTime: "10"
        ) { pollOption, optionIndex in
            
            HStack {
                Text(pollOption.name)
                Spacer()
                    .frame(minWidth: 0)
                Text("\(Int(pollOption.votePercentage))%")
            }
            .padding(12)
            .background(
                Color.gray
                    .clipShape(
                        RoundedRectangle(cornerSize: .init(width: 6, height: 6))
                    )
                    .frame(width: voteAreaWidth * pollOption.votePercentage / 100)
                    .frame(maxWidth: .infinity, alignment: .leading)
            )
            .contentShape(
                Rectangle()
            )
            .onTapGesture {
                print("Option tapped: \(optionIndex)")
            }
        }
        .pollBorderStyle()
    }
}
