//
//  GiphyModel.swift
//  GiphyClient
//
//  Created by andrei zeniukevich on 06/10/2018.
//  Copyright © 2018 andrei zeniukevich. All rights reserved.
//

import Foundation
import Mapper

struct GiphyModel: Mappable {
    
    let id: String?
    let title: String?
    let gif: Image?
    
    init(map: Mapper) throws {
        id = try map.from("id")
        title = try map.from("title")
        gif = try map.from("images.fixed_width")
    }
}

struct Image: Mappable {
    
    let url: URL?
    let height: String?
    
    init(map: Mapper) throws {
        url = try map.from("url") as URL
        height = try map.from("height")
    }
}
