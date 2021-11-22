//
//  Models.swift
//  qwert
//
//  Created by Anastasiya on 16.11.21.
//

import Foundation

struct User: Decodable {
    let id: Int?
    let name: String?
    let username: String?
    let email: String?
}

struct Album: Decodable {
    let userId: Int?
    let id: Int?
    let title: String?
}

struct Photo: Decodable {
    let albumId: Int?
    let id: Int?
    let title: String?
    let url: String?
    let thumbnailUrl: String?
}
