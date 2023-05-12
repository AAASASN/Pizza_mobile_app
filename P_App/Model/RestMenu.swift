//
//  RestMenu.swift
//  P_App
//
//  Created by Александр Мараенко on 05.04.2023.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

//// MARK: - RestMenu
//struct RestMenu: Decodable {
//    let data: DataClass?
//}
//
//// MARK: - DataClass
//struct DataClass: Decodable {
//    let menu: [Menu]?
//    let categories: [Category]?
//    let banners: [Banner]?
//}

// MARK: - Banner
struct Banner: Decodable {
    let id: UUID?
    let appId: Int?
    let image: String?
}

// MARK: - Category
struct Category: Decodable {
    let id: UUID?
    let appId: Int?
    let name: String?
}

// MARK: - Menu
struct Menu: Decodable {
    
    let id: UUID?
    let appId: Int?
    
    let name: String?
    let description: String?

    let priceFrom: Int?
    let categoryId: Int?

    let categoryName: String?
    let image: String?
}
