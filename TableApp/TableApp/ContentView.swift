//
//  ContentView.swift
//  TableApp
//
//  Created by Ian Mabon on 2/14/20.
//  Copyright © 2020 Ian Mabon. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var localHostManager = LocalHostManager()
    
    @State var studentSearched: String = ""
    @State var tableSearched: Int = 0
    @State private var selection = 0
    
    let tableNumbers = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10).frame(width: 375, height: 50, alignment: .center)
                    .foregroundColor(.white)
                
                Text("Cate Formal Dinner Seating")
                    .font(.system(size: 30))
                    .foregroundColor(.black)
            }
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 10)                        .frame(width: 250, height: 50, alignment: .center)
                    .foregroundColor(.white)
                
                Text("Search by Name")
                    .font(.system(size: 30))
                    .foregroundColor(.black)
                
            }
            VStack {
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 300, height: 50, alignment: .center)
                            .foregroundColor(.white)
                        TextField("Search", text: $studentSearched)
                            .font(.system(size: 30))
                            .padding(.leading)
                            .foregroundColor(.black)
                    }
                    Button(action: {
                        self.localHostManager.setUrl()
                        print("\(self.$localHostManager.firstname)")
                    }) {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50, alignment: .center)
                            .padding(.all)
                    }
                    
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 250, height: 40, alignment: .center)
                        .foregroundColor(.white)
                    Text("Your Are Sitting at Table: butt")
                }
                
            }
            Spacer()
            Spacer()
            ZStack {
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 250, height: 50, alignment: .center)
                    .foregroundColor(.white)
                
                Text("Search by Table")
                    .font(.system(size: 30))
                    .foregroundColor(.black)
            }
            VStack {
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 300, height: 125, alignment: .center)
                            .foregroundColor(.white)
                        
                        Picker(selection:$selection, label:
                        Text("Table Number")) {
                            ForEach(0 ..< tableNumbers.count) { index in
                                
                                Text(self.tableNumbers[index]).tag(index)
                            }
                        }
                    }
                    Image(systemName: "magnifyingglass.circle.fill")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50, alignment: .center)
                        .padding(.all)
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 300, height: 90, alignment: .center)
                        .foregroundColor(.white)
                    VStack {
                        Text("The People At Your Table Are:")
                        Text("People at table")
                    }
                }
            }
            Spacer()
            Spacer()
            
        } .background(Image("NEWZOME").resizable().edgesIgnoringSafeArea(.all).aspectRatio(contentMode: .fill))
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
