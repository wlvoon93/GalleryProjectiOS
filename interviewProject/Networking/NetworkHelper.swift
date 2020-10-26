//
//  NetworkHelper.swift
//  interviewProject
//
//  Created by Voon Wei Liang on 24/10/2020.
//

import Foundation
import PromiseKit

public struct NetworkHelper {
    public func getImages() -> Promise<[Image]> {
        return Promise { seal in
            
            let Url = String("https://picsum.photos/v2/list")
            guard let serviceUrl = URL(string: Url) else { return }

            var request = URLRequest(url: serviceUrl)
            request.httpMethod = "GET"
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")

            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
//                if let response = response {
//                    print(response)
//                }
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print(json)
                    } catch {
                        print(error)
                    }
                }

                if data == nil {
                    
                    
                    seal.fulfill(Array<Image>())
                } else {

                    do {
                        let Images = try self.decodeJSONData([Image].self, jsonData: data ?? nil)

                        seal.fulfill(Images)
                    } catch {
                        // Your handling code
                        print("Error info: \(error)")

                    }
                }
            }.resume()

        }
    }
}

extension NetworkHelper {

    private func decodeJSONData<T>(_ type: T.Type, jsonData: Data?) throws -> T where T: Decodable {
        let decoder = JSONDecoder()
        let athleteList3 = try decoder.decode(type, from: jsonData!)
        return athleteList3
    }
}
