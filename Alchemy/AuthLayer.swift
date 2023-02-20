//
//  AuthLayer.swift
//  Alchemy
//
//  Created by ousmane diouf on 2/20/23.
//

import SwiftUI

public class AuthLayer: ObservableObject {
    @AppStorage("AUTH_KEY") public var isAuthenticated = false {
        willSet { objectWillChange.send() }
    }
    @AppStorage("USER_KEY") public var username = ""
    @Published public var password = ""
    @Published public var invalidCredentials = false
    
    private var sampleUser = "ousmane"
    private var samplePassword = "password"
    
    public init() {
        /// for debugging
        print("currently logged on \(isAuthenticated)")
        print("current user \(username)")
    }
    
    public func toggleAuthentication() {
        self.password = ""
        
        withAnimation {
            isAuthenticated.toggle()
        }
    }
    
    public func authenticate() {
        /// check for user
        guard self.username.lowercased() == sampleUser else {
            self.invalidCredentials = true
            return
        }
        
        /// check for password
        guard self.password.lowercased() == samplePassword else {
            self.invalidCredentials = true
            return
        }
        
        toggleAuthentication()
    }
    
    public func logout() {
        toggleAuthentication()
    }
    
    public func buttonPressed() {
        print("we can execute an action here")
    }
}
