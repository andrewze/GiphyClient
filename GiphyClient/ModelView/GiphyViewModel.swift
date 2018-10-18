//
//  GiphyViewModel.swift
//  GiphyClient
//
//  Created by andrei zeniukevich on 06/10/2018.
//  Copyright © 2018 andrei zeniukevich. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Moya_ModelMapper
import Mapper

struct GiphyViewModel {
    
    var provider: MoyaProvider<GiphyEndpoint>
    var searchText: Observable<String>
    
    func getItems() -> Observable<[GiphyModel]> {
        return searchText
            .observeOn(MainScheduler.instance)
            .flatMapLatest({ text -> Observable<[GiphyModel]> in
                self.request(text)
            })
    }
    
    func request(_ string: String) -> Observable<[GiphyModel]> {
        let requestType: GiphyEndpoint!
        
        // Set request type depending on the empty string or not
        if string.count > 0 {
            requestType = GiphyEndpoint.search(string)
        } else {
            requestType = GiphyEndpoint.trending
        }
        
        return provider.rx.request(requestType)
            .map(to: [GiphyModel].self, keyPath: "data")
            .asObservable()
    }
}
