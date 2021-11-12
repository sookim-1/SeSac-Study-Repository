# 앱 예시

## 스크린샷 
- 팝업화면 구현
<img src="https://user-images.githubusercontent.com/55218398/141443493-f53a239e-da17-4c01-a9aa-f11d888520fa.png" width="200" height="400"/>


- 네비게이션 바 메모 갯수 1000단위마다 콤마 구현
- 메모 고정 기능, 삭제 기능
<img src="https://user-images.githubusercontent.com/55218398/141443933-3242c1ff-3380-4d7e-a223-509bf94c9cf1.png" width="200" height="400"/>
<img src="https://user-images.githubusercontent.com/55218398/141443872-a510b098-eef6-4bb4-a321-a0f19b0b784f.png" width="200" height="400"/>

- 5개 이상시 경고창
<img src="https://user-images.githubusercontent.com/55218398/141443826-b4030310-0c8b-4139-ac95-993ce1367203.png" width="200" height="400"/>

- 테이블뷰 날짜 최신순으로 정렬
<img src="https://user-images.githubusercontent.com/55218398/141443858-5a83dfe0-c435-4da5-b141-11a4a18df647.png" width="200" height="400"/>

- 검색기능 구현
<img src="https://user-images.githubusercontent.com/55218398/141443905-4fba764a-959d-4537-9750-f874e0df8bb5.png" width="200" height="400"/>

- 공유기능 구현

<img src="https://user-images.githubusercontent.com/55218398/141444442-b6523249-aa51-4689-bfd7-619d01ee9d50.png" width="200" height="400"/>
# 트러블 슈팅 기록

### 모달뷰를 ViewDidLoad에서 띄우면 나는 오류

- whose view is not in the window hierarchy에러

- viewDidLoad()는 뷰가 메모리에 올라갔을 때 1번호출되고 인스턴스 변수를 인스턴스 화하고 뷰컨트롤러의 전체 수명주기 동안 존재할 뷰를 빌드하려고 하는 시점

  → 즉 뷰컨트롤러가 완성되지 않았다는 의미 (그래서 완성되지않았는데 모달뷰를 호출하기 때문에 나는 에러)

- viewDidAppear()는 뷰가 실제로 표시될때마다 호출됩니다.

  → 따라서 매번 뷰가 표시될때마다 호출되기 때문에 플래그처리를 권장합니다.



> 참고링크

- 에러관련 블로그 링크 - https://m.blog.naver.com/PostView.naver?isHttpsRedirect=true&blogId=wlsdml1103&logNo=221026623860

### 앱 실행시 팝업 띄우기 - 테스트가능한 코드

앱 설치를 처음하는 경우에만 화면을 표시하거나 이벤트처리를 하는 등 어떤 동작을 구현하고 싶은 경우 기본적으로 UserDefault를 사용하여 flag를 저장해주는 방식이 있습니다.

```swift
override func viewDidLoad() {
		super.viewDidLoad()

    let isFirstLauch = UserDefaults.standard.bool(forKey: "isFirstLauch") //값을 확인
    if isFirstLauch
    { print("최초가 아닙니다") }
    else
    {
        print("최초실행")
        UserDefaults.standard.set(true, forKey: "isFirstLauch") // 최초실행에만 값을저장합니다.
    }
}
```

1. UserDefaults에서 지정한 flag 키값을 확인합니다.
2. 앱 설치를 처음한 경우라면 값이 없기 때문에 false로 분기됩니다.
3. 설치를 처음 한 경우 에서 flag 키 값을 지정해주면 앱이 매번 실행되도 더 이상 동작하지 않습니다.

🚨  하지만 개발을 하는 경우 매번 테스트를 할 때마다 앱을 삭제하고 실행하고 하는 과정은 번거롭습니다.

UserDefaults의 의존성을 줄이고 클로저도 함께 사용하여 구현하도록 합니다.

```swift
final class FirstLaunch {
    
    let wasLaunchedBefore: Bool
    var isFirstLaunch: Bool {
        return !wasLaunchedBefore
    }
    
    init(getLaunchedFlag: () -> Bool, setLaunchedFlag: (Bool) -> ())
    {
        self.wasLaunchedBefore = getLaunchedFlag()
        
        if !wasLaunchedBefore {
            setLaunchedFlag(true)
        }
    }
    
    convenience init(userDefaults: UserDefaults, key: String) {
        self.init(getLaunchedFlag: { userDefaults.bool(forKey: key) },
                  setLaunchedFlag: { userDefaults.set($0, forKey: key) })
    }
    
}
// 1. 테스트하기 위해 직접 코드 입력한 경우
let firstLaunch = FirstLaunch(getLaunchedFlag: { return false }, 
															setLaunchedFlag: { _ in }) 
if alwaysFirstLaunch.isFirstLaunch { 
	print("최초실행")
}

// 2. UserDefault사용한 경우
let firstLaunch = FirstLaunch(userDefaults: .standard, key: "firstLaunchKey")
if firstLaunch.isFirstLaunch {
    print("최초실행")
}
```

- 테스트하기 위해 직접 코드 입력하는 경우에 getLaunchedFlag 반환값을 false로 하면 최초실행시를 테스트하고 true를 하면 최초실행이 아닌 경우를 확인할 수 있습니다.



> 참고링크

- 앱 최초 실행시 Swift Walkthrough 페이지뷰 적용 - https://ichi.pro/ko/aeb-choecho-silhaengsi-swift-walkthrough-41847053428052 
- app first launch 블로그 - https://umtaengnote.tistory.com/24
- Dongky's Programming 블로그 - [[번역\] iOS 앱의 첫 실행 감지 - 잘못된 방법과 올바른 방법](https://dongkyprogramming.tistory.com/30)
