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

증가 및 감소할 수 있는 카운터를 유지하는 매우 간단한 앱의 경우 앱 상태를 다음과 같이 정의할 수 있다:
```swift
struct AppState {
    var counter = 0
}
```

<br>
<br>
<br>
<br>

***
cf.<br>
https://github.com/ReSwift/ReSwift
