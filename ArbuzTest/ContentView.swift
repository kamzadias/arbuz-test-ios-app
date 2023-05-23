//
//  ContentView.swift
//  arbuzTest
//


import SwiftUI

struct ContentView: View {
    
    @State var changeScreen = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 50) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                Text("Доставим вам продукты до двери")
                    .font(.system(size: 42, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                Text("Закажите свежие продукты\n как фрукты, овощи и т.д.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                Button() {
                    changeScreen = true
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 50)
                        Text("Начать")
                            .foregroundColor(.white)
                            .bold()
                    }
                }.frame(width: 200, height: 70)
                    .foregroundColor(.green)
            }
            .navigationDestination(isPresented: $changeScreen) {
                Shop()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
