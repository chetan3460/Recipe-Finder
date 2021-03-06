//
//  Recipe.swift
//  BlueCart
//
//  Created by David Rothschild on 11/6/17.
//  Copyright © 2017 Dave Rothschild. All rights reserved.
//

import Foundation

/// The data structure for receipes retrieved from the server
struct RecipePage: Codable {
    var count: Int?
    var recipes: [Recipe]?
    var pageNumber: Int?
    var createdAt: Date?
    var searchTerm: String?
}

struct Recipe: Codable {
    
    /// Enums to map all the Json keys to Swift data structure keys
    enum RootKeys: String, CodingKey {
        case publisher
        case url = "f2f_url"
        case title
        case sourceUrl = "source_url"
        case recipeID = "recipe_id"
        case imageUrl = "image_url"
        case socialRank = "social_rank"
        case publisherUrl = "publisher_url"
        case ingredients
        case searchTerm
    }
    var publisher: String?
    var url: String?
    var title: String?
    var sourceUrl: String?
    var recipeID: String?
    var imageUrl: String?
    var socialRank: Double?
    var publisherUrl: String?
    var ingredients: [String]?
    var searchTerm: String?
}

extension Recipe {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        publisher = try container.decode(String.self, forKey: .publisher)
        url = try container.decode(String.self, forKey: .url)
        title = try container.decode(String.self, forKey: .title)
        sourceUrl = try container.decode(String.self, forKey: .sourceUrl)
        recipeID = try container.decode(String.self, forKey: .recipeID)
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
        socialRank = try container.decode(Double?.self, forKey: .socialRank)
        publisherUrl = try container.decode(String.self, forKey: .publisherUrl)
        /// Note decodeIfPresent ... adds nil if empty. Needs this for initial recipe as it does not have ingredients.
        /// Ingredients added after user taps on a recipe picture.
        ingredients = try container.decodeIfPresent([String].self, forKey: .ingredients)
        searchTerm = try container.decodeIfPresent(String.self, forKey: .searchTerm)
    }
}
