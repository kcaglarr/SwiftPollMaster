public struct PollOption {
    public let name: String
    public var isSelected: Bool
    public let votePercentage: Double
    
    public init(
        name: String,
        isSelected: Bool,
        votePercentage: Double
    ) {
        self.name = name
        self.isSelected = isSelected
        self.votePercentage = votePercentage
    }
}
