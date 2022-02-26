//
//  CounterReducer.swift
//  counter-reswift
//
//  Created by haanwave on 2022/02/26.
//

import Foundation
import ReSwift

/// Reducer는 수신한 Action을 기반으로 State를 업데이트 한다.
func counterReducer(action: Action, state: AppState?) -> AppState {
    /// state가 nil일 경우 기본 state를 생성한다.
    var state = state ?? AppState()
    
    switch action {
    case _ as CounterActionIncrease:
        state.counter += 1
        
    case _ as CounterActionDecrease:
        state.counter -= 1
        
    default:
        break
    }
    
    return state
}
