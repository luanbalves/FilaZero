//
//  AuthService.swift
//  FilaZero
//
//  Created by Luan Alves Barroso on 01/05/24.
//

import Foundation
import Firebase
import FirebaseFirestore
import CommonModels
import AuthServiceInterface
import FirebaseAuth

public protocol AuthFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
public final class AuthService: ObservableObject, AuthServiceInterface {
    @Published public var userSession: FirebaseAuth.User?
    @Published public var currentUser: CommonModels.User?
    public static let shared = AuthService()
    
    public init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
        
    }
    
    public func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        }catch {
            print(error.localizedDescription)
        }
    }
    
    public func createUser(withEmail email: String, password: String, fullname: String, accountType: String) async throws {
        do {
            
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullname: fullname, email: email, accountType: accountType)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            print("Falha \(error.localizedDescription)")
        }
    }
    
    public func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        }catch {
            print(error.localizedDescription)
        }
    }
    
    public func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
    }
    
}
