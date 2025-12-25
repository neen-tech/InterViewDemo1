//
//  ContentView.swift
//  InterViewDemo
//
//  Created by Nitin Tandon on 25/12/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var viewModelUserList: UserListViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModelUserList.isLoading {
                    ProgressView("Loading...")
                } else if viewModelUserList.errorMassage != nil {
                    VStack{
                        Text("Error")
                        Text(viewModelUserList.errorMassage ?? "Error" )
                    }
                }
                else {
                    List(viewModelUserList.users) { user in
                        NavigationLink(user.name, value: user)
                        
//                        NavigationLink(value: user) {
//                            CellView(user: user)
//                        }
                    }
                    .navigationDestination(for: User.self) { user in
                        CellView(user: user)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Demo Users")
        .task {
           await self.viewModelUserList.loadUsers()
        }
    }
}


struct CellView: View {
    var user: User
    var body: some View {
        VStack {
            Text(user.name)
            Text(user.email)
        }
        .font(.system(size: 20,weight: .medium))
        .foregroundStyle(Color.blue)
        .multilineTextAlignment(.leading)
    }
}


