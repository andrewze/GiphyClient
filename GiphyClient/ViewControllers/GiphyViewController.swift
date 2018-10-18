//
//  GiphyViewController.swift
//  GyphyClient
//
//  Created by andrei zeniukevich on 06/10/2018.
//  Copyright © 2018 andrei zeniukevich. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import Moya

class GiphyViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: GiphyViewModel!
    var provider: MoyaProvider<GiphyEndpoint>!
    let disposeBag = DisposeBag()
    
    var searchText: Observable<String> {
        return searchBar.rx.text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        providerSetup()
        viewModelSetup()
        collectionViewSetup()
    }
    
    func providerSetup() {
        provider = MoyaProvider<GiphyEndpoint>()
    }
    
    func viewModelSetup() {
        viewModel = GiphyViewModel(provider: provider, searchText: searchText)
    }
    
    func collectionViewSetup() {
        viewModel.getItems().bind(to: collectionView.rx.items(cellIdentifier: "Cell", cellType: GiphyCollectionViewCell.self)) { row, model, cell in
            cell.viewModel = model
            cell.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            }
            .disposed(by: disposeBag)
    }
}

