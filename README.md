![LastCommit](https://img.shields.io/github/last-commit/haanwave/reswift-learning?color=3182F6) <br>
![header](https://capsule-render.vercel.app/api?type=waving&color=gradient&height=200&text=Let's%20learn%20ReSwift%20!&fontSize=45&fontColor=ffffff)

# ReSwift
**ReSwift**는 Swift의 단방향 데이터 흐름 아키텍처를 **Redux**와 유사하게 구현한 것으로 앱 구성 요소의 세 가지 중요한 문제를 분리하는 데 도움을 준다.
> **Redux?**<br>
> <a href="https://github.com/reduxjs/redux">리덕스(Redux)</a>는 오픈 소스 자바스크립트 라이브러리의 일종으로, state를 이용한 웹 사이트 혹은 앱의 상태 관리를 목적으로 사용한다.

<br>

- **State:** 앱의 상태는 데이터 구조에 명시적으로 저장된다. 이것은 복잡한 상태 관리 코드를 피하고 더 나은 디버깅을 가능하게 한다.
- **Views:** 앱의 상태가 변경되면 view가 업데이트된다. view는 현재 앱의 상태를 간단하게 시각화한다.
- **State Changes:** ReSwift에서 앱은 action을 통해서만 상태를 변경할 수 있다. action은 상태 변경을 설명하는 작은 데이터 조각이다. 상태 변경 방법을 제한함으로써 앱을 더 쉽게 이해할 수 있고 더 쉽게 협업을 할 수 있다.

<br>

# A few principles of ReSwift
- **The Store**<br>
Store는 전체 앱 상태를 단일 데이터 구조의 형태로 저장한다. 이 상태는 Store에 Action을 전달해야만 수정할 수 있다. Store의 상태가 변경될 때마다 Store는 모든 Observer에게 알린다.

- **Actions**<br>
Action은 상태 변경을 설명하는 선언적 방법이다. Action에는 코드가 포함되어 있지 않으며 Store에서 사용하고 Reducer로 전달된다.<br>
Reducer는 각 Action에 대해 다른 상태 변경을 구현하여 작업을 처리한다.

- **Reducers**<br>
Reducer는 현재 Action과 현재 앱 상태를 기반으로 새 앱 상태를 생성하는 순수한 기능(pure function)을 제공한다.

<div align=center>
<image src="https://user-images.githubusercontent.com/80438047/155837832-37d9407c-b31c-44c2-ac00-1e340d4de3ad.png" width="550">
</div>

<br>
<br>

증가 및 감소할 수 있는 카운터를 유지하는 매우 간단한 앱이 있다고 할 때, 다음과 같이 앱 상태를 정의할 수 있다:
```swift
struct AppState {
    var counter = 0
}
```

<br>

이 예제와 같이 간단한 Action의 경우 카운터 증가 및 감소에 대한 두 가지 Action을 다음과 같이 빈 구조체로 정의할 수 있다:
> <a href="http://reswift.github.io/ReSwift/master/getting-started-guide.html">Getting Started Guide</a>에서 더 복잡한 Action을 구성하는 방법에 대해 배울 수 있다.
```swift
struct CounterActionIncrease: Action {}
struct CounterActionDecrease: Action {}
```

<br>

다음과 같이 switch문을 사용함으로써 Reducer는 다양한 Action type에 응답할 수 있다:
> **예측 가능한(predictable) 앱 상태를 갖기 위해서 중요한 것.**
> 1. Reducer is always free of side effects.
> 2. 현재 앱의 상태와 Action을 받아야 한다.
> 3. 새로운 앱 상태를 return 해야 한다.
```swift
func counterReducer(action: Action, state: AppState?) -> AppState {
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
```

<br>

상태를 유지하고 Reducer에 Action을 위임하려면 Store가 필요한데, 이 예제에서는 AppDelegate 파일에 mainStore라는 전역 상수를 만들었다.
```swift
let mainStore = Store<AppState>(
    reducer: counterReducer,
    state: nil
)

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	[...]
}
```

<br>

마지막으로, ViewController(or view layer)는 앱 상태를 변경할 때마다 Store 업데이트 및 방출(emitting) Action을 구독함으로써 이 시스템에 연결되어야 한다.
```swift
class CounterViewController: UIViewController, StoreSubscriber {
    typealias StoreSubscriberStateType = AppState

    @IBOutlet var counterLabel: UILabel!

    override func viewWillAppear(_ animated: Bool) {
        mainStore.subscribe(self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        mainStore.unsubscribe(self)
    }

    func newState(state: AppState) {
        counterLabel.text = "\(state.counter)"
    }

    @IBAction func increaseButtonTapped(_ sender: UIButton) {
        mainStore.dispatch(
            CounterActionIncrease()
        )
    }

    @IBAction func decreaseButtonTapped(_ sender: UIButton) {
        mainStore.dispatch(
            CounterActionDecrease()
        )
    }

}
```
- ``newState`` 메서드는 새 앱 상태를 사용할 수 있을 때마다 Store에서 호출되고, 이 메서드에서 최신 앱 상태가 반영되도록 view를 조정해야 한다.
- 버튼을 탭하면 Store와 해당 Reducer에 처리해야 할 Action이 전달되어 새로운 앱 상태가 생성된다.

이 예제는 ReSwift 기능의 일부만 보여주는 아주 기본적인 예제이고, 이 아키텍처로 전체 앱을 빌드하는 방법을 알아보려면 <a href="http://reswift.github.io/ReSwift/master/getting-started-guide.html">Getting Started Guide</a>를 참고하면 된다.<br>
증가 및 감소할 수 있는 카운터 예제의 완전한 구현은 <a href="https://github.com/haanwave/reswift-learning/tree/main/counter-reswift">counter-reswift</a> 프로젝트를 참고하면 된다.

<br>

## Create a subscription of several substates combined
- 전체 앱 상태를 매개변수로 사용하는 initializer를 사용해 subscriber 클래스에 필요한 데이터 모델을 나타내는 구조체를 생성하기만 하면 된다.<br>
- 이 initializer를 앱 상태에서 subscriber 상태로 가는 mapper/selector로 간주한다.<br>
- MySubState가 구조체이고 Equatable을 준수하기 때문에 ReSwift는 계산된(Computed) 출력이 변경되지 않은 경우 subscriber에게 알리지 않는다.<br>
- 또한, Swift는 subscription type을 유추할 수 있다.
```swift
struct MySubState: Equatable {
    // 전체 앱 상태에서 파생되어 결합된 하위 상태
    
    init(state: AppState) {
        // 필요한 하위 상태를 여기에서 계산(Compute)한다.
    }
}
```
```swift
store.subscribe(self) { $0.select(MySubState.init) }
    
func newState(state: MySubState) {
    // Profit!
}
```

<br>

# To get an understanding of the core principles
ReSwift recommend reading the brilliant <a href="https://redux.js.org">redux documentation</a>.


<br>
<br>
<br>
<br>

***
cf.<br>
https://github.com/ReSwift/ReSwift
