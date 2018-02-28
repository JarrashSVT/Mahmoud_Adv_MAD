//
//  API.swift
//  NYTimes Most Viewed
//
//  Created by Mahmoud Aljarrash on 2/26/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import Foundation

struct API: Decodable
{
    let results: [MostViewed]
}

struct MostViewed: Decodable
{
    let title: String
    let byline: String
    let abstract: String
   // let media: [Media]
    let url: String
    let published_date: String
}

struct Media: Decodable
{
    let caption: String
    let type: String
    // there suppose to be images in the app but I couldnt access them using codable because of the hyphen in the media-metadata attribute
//    let media-metadata: [MediaMetadata]
}

struct MediaMetadata: Decodable
{
    let url: String
    let format: String
    let height: Int
    let width: Int
}


