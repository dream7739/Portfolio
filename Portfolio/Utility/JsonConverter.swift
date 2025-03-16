//
//  JsonConverter.swift
//  Portfolio
//
//  Created by 홍정민 on 3/16/25.
//

import Foundation

final class JSONConverter {
    private init() { }
    static let shared = JSONConverter()
    
    func readJSONFile(fileName: String) -> Data? {
        if let filePath = Bundle.main.path(forResource: fileName, ofType: "json") {
            let fileURL = URL(fileURLWithPath: filePath)
            
            do {
                let data = try Data(contentsOf: fileURL)
                return data
            } catch {
                print("Error reading JSON file: \(error)")
                return nil
            }
        } else {
            print("File not found in bundle.")
            return nil
        }
    }
    
    func convertFromJSON<T: Decodable>(data: Data) -> T? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
}
