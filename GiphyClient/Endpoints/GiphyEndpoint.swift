//
//  GiphyEndpoint.swift
//  GiphyClient
//
//  Created by andrei zeniukevich on 04/10/2018.
//  Copyright © 2018 andrei zeniukevich. All rights reserved.
//

import Foundation
import Moya

private extension String {
    
    var URLEscapedSearchString: String {
        return self.lowercased().replacingOccurrences(of: " ", with: "+")
    }
}

enum GiphyEndpoint {
    case trending
    case search(_ string: String)
}

extension GiphyEndpoint: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.giphy.com")!
    }
    
    var path: String {
        switch self {
        case .trending: return "/v1/gifs/trending"
        case .search: return "/v1/gifs/search"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .search(let searchText):
            return .requestParameters(parameters: ["q": searchText],
                                      encoding: URLEncoding.default)
        case .trending: return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["api_key": "YUAoFkF42JjpIRdLWmJu70IGDXilhltD"]
    }
}
