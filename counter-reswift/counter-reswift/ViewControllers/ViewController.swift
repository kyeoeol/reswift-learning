//
//  ViewController.swift
//  counter-reswift
//
//  Created by haanwave on 2022/02/26.
//

import UIKit
import ReSwift

class ViewController: UIViewController, StoreSubscriber {
    typealias StoreSubscriberStateType = AppState
    
    @IBOutlet weak var counterLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// state 변화를 구독한다.
        mainStore.subscribe(self)
    }
    
    func newState(state: AppState) {
        /// state가 변경되면 UI가 현재 state를 반영하도록 업데이트
        counterLabel.text = "\(mainStore.state.counter)"
    }
    
    /// 두 버튼 중 하나를 탭하면 앱의 state를 업데이트하기 위한 action이 mainStore로 전달된다.
    @IBAction func tapIncreaseButton(_ sender: UIButton) {
        mainStore.dispatch(CounterActionIncrease())
    }
    
    @IBAction func tapDecreaseButton(_ sender: UIButton) {
        mainStore.dispatch(CounterActionDecrease())
    }
}

