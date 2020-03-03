//
//  LocalHost Manager.swift
//  TableApp
//
//  Created by Ian Mabon on 2/28/20.
//  Copyright © 2020 Ian Mabon. All rights reserved.
//

import Foundation

class LocalHostManager: ObservableObject {
    
    @Published var firstname: String = "Firstname"
    @Published var lastname: String = "Lastname"
    @Published var table: Int = 0

     
    
    func setUrl() {
        let url = "http://127.0.0.1"
        fetch(url: url)
    }
        func fetch(url: String) {
            print("the url is \(url)")
            if let url = URL(string: "\(url)") {
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { (data, response, error) in
                    if error == nil {
                        let decoder = JSONDecoder()
                        if let safeData = data {
                            do {
                                let results = try decoder.decode([TableInfo].self, from: safeData)
                                self.firstname = results[0].Firstname
                                self.lastname = results[0].Lastname
                                self.table = results[0].Table
                                
                            } catch {
                                print(error)
                            }
                        }
                    }
                }
                task.resume()
            }
            
        }
    }
