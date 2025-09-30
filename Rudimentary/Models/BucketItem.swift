import Foundation

struct BucketItem: Identifiable, Codable {
    enum Status: String, Codable, CaseIterable, Identifiable {
        case planned
        case inProgress
        case completed

        var id: String { rawValue }

        var label: String {
            switch self {
            case .planned:
                return "Planned"
            case .inProgress:
                return "In Progress"
            case .completed:
                return "Completed"
            }
        }
    }

    let id: UUID
    var title: String
    var detail: String
    var category: CatCategory
    var status: Status
    var targetSeason: Season?
    var dateCompleted: Date?
    var photoIdentifier: String?
    var loveNote: String

    init(
        id: UUID = UUID(),
        title: String,
        detail: String,
        category: CatCategory,
        status: Status = .planned,
        targetSeason: Season? = nil,
        dateCompleted: Date? = nil,
        photoIdentifier: String? = nil,
        loveNote: String = ""
    ) {
        self.id = id
        self.title = title
        self.detail = detail
        self.category = category
        self.status = status
        self.targetSeason = targetSeason
        self.dateCompleted = dateCompleted
        self.photoIdentifier = photoIdentifier
        self.loveNote = loveNote
    }

    var celebratoryMessage: String {
        switch status {
        case .planned:
            return "Start plotting this purrfect memory!"
        case .inProgress:
            return "Keep prowling forward together."
        case .completed:
            return "Paws high! Another memory made."
        }
    }
}
