//
//  InterViewDemoApp.swift
//  InterViewDemo
//
//  Created by Nitin Tandon on 25/12/25.
//

import SwiftUI

@main
struct InterViewDemoApp: App {
    
    // Build dependencies
    private let networkService: NetworkServiceProtocol
    private let userRepository: UserRepositoryProtocol
    private let fetchUserUseCase: FetchUserUseCaseProtocol
    private let appDependency: AppDependency
    
    init(){
        let networkService = NetworkService()
        let userRepository = UserRepository(networkService: networkService)
        let fetchUserUseCase = FetchUserUseCase(userRepository: userRepository)
        // Store into 
        self.networkService = networkService
        self.userRepository = userRepository
        self.fetchUserUseCase = fetchUserUseCase
        self.appDependency = AppDependency( networkService: networkService, userRepositroy: userRepository, fecthUserUseCase: fetchUserUseCase )
    }
    
  
    var body: some Scene {
        WindowGroup {
            ContentView(viewModelUserList: appDependency.makeVM())
        }
    }
}
