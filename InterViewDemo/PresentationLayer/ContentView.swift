//
//  ContentView.swift
//  InterViewDemo
//
//  Created by Nitin Tandon on 25/12/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var viewModelUserList: UserListViewModel
    
    init(viewModelUserList: UserListViewModel) {
        self.viewModelUserList = viewModelUserList
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.ignoresSafeArea()
                VStack {
                    switch viewModelUserList.loadingState {
                    case .idle:
                        Text("We are featching List")
                    case .loading:
                        ProgressView("Loading...")
                    case .loaded(let users):
                        VStack {
                            List(users) { user in
                                NavigationLink(value: user) {
                                    HStack {
                                        Text("\(user.id)")
                                            .multilineTextAlignment(.leading)
                                            .foregroundStyle(Color.gray)
                                            .font(.system(.largeTitle))
                                        VStack(alignment: .leading){
                                            Text(user.name)
                                            Text(user.email)
                                        }
                                        .font(.system(size: 24))
                                    }
                                }
                            }
                        }
                    case.error(let errorMessage):
                        VStack {
                            Text("Error")
                            Text(errorMessage)
                        }
                        .foregroundStyle(.red)
                    }
                }
            }
            .navigationTitle("Demo Users")
            .navigationDestination(for: User.self) { user in
                CellView(user: user)
            }
        }
        .task {
            await self.viewModelUserList.loadUsers()
        }
    }
}


struct CellView: View {
    var user: User
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            Text("\(user.id)")
            Text(user.name)
            Text(user.email)
            Text(user.username)
            Spacer()
        }
        .font(.system(size: 20,weight: .medium))
        .foregroundStyle(Color.gray)
        .multilineTextAlignment(.leading)
    }
}


