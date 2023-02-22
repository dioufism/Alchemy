//
//  AuthLayer.swift
//  Alchemy
//
//  Created by ousmane diouf on 2/20/23.
//

import SwiftUI

/*
 * Allows consumer to to verify that authentication has passed
 */
public protocol AuthDelegate {
    func isAuthenticated()
}

/*
 * Interface that allow consumer to provide their own implementation of the login features
 */
public protocol AuthProtocol: ObservableObject {
    func authenticate()
    func logout()
    func toggleAuthentication()
    func buttonPressed()
}

public class AuthLayer: AuthProtocol {
    @AppStorage("AUTH_KEY") public var isAuthenticated = false {     ///  username and password should not be stored in the framework

        willSet { objectWillChange.send() }
    }
    @AppStorage("USER_KEY") public var username = ""
    @Published public var password = ""
    @Published public var invalidCredentials = false
    
    private var sampleUser = "ousmane"
    private var samplePassword = "password"
    
    var authDelegate: AuthDelegate?
    
    public init() {
        /// for debugging purposes, logging can be used insterad
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
        
        authDelegate?.isAuthenticated()
        
        toggleAuthentication()
    }
    
    public func logout() {
        toggleAuthentication()
    }
    
    public func buttonPressed() {
        print("we can execute an action here")
    }
}
