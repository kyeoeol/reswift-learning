//
//  MainViewController.swift
//  github-browser-reswift
//
//  Created by haanwave on 2022/02/27.
//

import UIKit
import ReSwift
import ReSwiftRouter
import OctoKit
import RequestKit
import ListKit

class MainViewController: UIViewController, StoreSubscriber {
    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource: ArrayDataSource<RepositoryTableViewCell, Repository>?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /// repositories state 구독
        mainStore.subscribe(self) { state in
            state.select { $0.repositories }
        }
        
        /// Repository 데이터 업데이트
        /*
         How to work Thunk
         1. fetchGitHubRepositories라는 Thunk를 이용해 Repository를 받아온다.(with OctoKit URLSession)
         2. 받아오는 데 성공하면 DispatchQueue.main.async을 이용해 SetRepositories라는 Action을 dispatch
         */
        mainStore.dispatch(
            fetchGitHubRepositories
        )
        
        /// tableView dataSource 초기화
        if dataSource == nil {
            dataSource = ArrayDataSource(array: [],
                                         cellType: RepositoryTableViewCell.self)
        }
        
        tableView.dataSource = dataSource
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        /// 구독 해지
        mainStore.unsubscribe(self)
    }
    
    // MARK: - State Update
    func newState(state: Response<[Repository]>?) {
        guard let state = state else { return }
        
        if case let .success(repositories) = state {
            dataSource?.array = repositories
            tableView.reloadData()
        }
    }
}
