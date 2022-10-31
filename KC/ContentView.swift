//
//  ContentView.swift
//  KC
//
//  Created by miuraken on 2022/10/31.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            
            HStack{
                Button(action:{}){
                    Text("Button22")
                }
                Button(action:{}){
                    Text("Button3")
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
