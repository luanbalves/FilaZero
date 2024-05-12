import Foundation
import CommonModels
import FirebaseAuth

@MainActor
public protocol AuthServiceInterface {
    var userSession: FirebaseAuth.User? { get }
    var currentUser: CommonModels.User? { get }
    
    func signIn(withEmail email: String, password: String) async throws
    func createUser(withEmail email: String, password: String, fullname: String) async throws
    func signOut()
    func fetchUser() async
}
