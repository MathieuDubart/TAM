//
//  ContentView.swift
//  TAM Project
//
//  Created by Mathieu DUBART on 14/03/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            .padding()
            .tabItem { Label("Home", systemImage: "house").tag("home-page") }
            
            Text("Stats")
                .tabItem { Label("Stats", systemImage: "binoculars").tag("stats-page") }
            
            Text("Customize")
                .tabItem { Label("Customize", systemImage: "paintbrush").tag("customize-page") }
            
            Text("Shop")
                .tabItem { Label("Shop", systemImage: "cart").tag("shop-page") }
        }
    }
}

#Preview {
    ContentView()
}
