public struct PollOption: Decodable, Equatable, Identifiable {
    public let id: String?
    public let name: String?
    public var isSelected: Bool?
    public let percentageVotes: Int?
    
    public init(
        id: String?,
        name: String?,
        isSelected: Bool?,
        percentageVotes: Int?
    ) {
        self.id = id
        self.name = name
        self.isSelected = isSelected
        self.percentageVotes = percentageVotes
    }
}
