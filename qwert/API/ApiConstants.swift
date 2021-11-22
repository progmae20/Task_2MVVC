//
//  ApiConstants.swift
//  qwert
//
//  Created by Anastasiya on 17.11.21.
//

import Foundation

class ApiConstants {

    static let jsonUrl = "https://jsonplaceholder.typicode.com/"
    
    // users
    static let usersPath = jsonUrl + "users"
    static let usersPathURL = URL(string: usersPath)

    // album
    static let albumsPath = jsonUrl + "albums"
    static let albumsPathURL = URL(string: albumsPath)

    // photos
    static let photosPath = jsonUrl + "photos"
    static let photosPathURL = URL(string: photosPath)
}
