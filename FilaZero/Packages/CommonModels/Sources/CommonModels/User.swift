import Foundation

public struct User: Identifiable, Codable {
    public let id: String
    public let fullname: String
    public let email: String
    
    public var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
    
    public init(id: String, fullname: String, email: String) {
        self.id = id
        self.fullname = fullname
        self.email = email
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.fullname = try container.decode(String.self, forKey: .fullname)
        self.email = try container.decode(String.self, forKey: .email)
    }
}

public extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, fullname: "Stephen Curry", email: "Steph@gmail.com")
}

