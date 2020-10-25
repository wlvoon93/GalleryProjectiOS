//
//  Image.swift
//  interviewProject
//
//  Created by Voon Wei Liang on 24/10/2020.
//

public struct Image: Codable{
    // MARK: - Properties
    var id: String?
    var author: String?
    var width: Int?
    var height: Int?
    var url: String?
    var download_url: String?

    // MARK: - Methods
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case author = "author"
        case width = "width"
        case height = "height"
        case url = "url"
        case download_url = "download_url"
    }
}
