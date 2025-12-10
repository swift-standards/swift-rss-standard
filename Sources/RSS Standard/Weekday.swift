extension RSS {
    /// Represents a day of the week for RSS skipDays element
    public enum Weekday: String, Hashable, Sendable, Codable, CaseIterable {
        case monday = "Monday"
        case tuesday = "Tuesday"
        case wednesday = "Wednesday"
        case thursday = "Thursday"
        case friday = "Friday"
        case saturday = "Saturday"
        case sunday = "Sunday"
    }
}
