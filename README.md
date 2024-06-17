# 향기

향기 앱을 통해 시향지를 핸드폰 속에 저장할 수 있습니다. </br>
금방 사라지는 향을 오랫동안 간직하고 싶다면, 기억하고 싶은 그날의 향을 바로 기록하세요. 💐

개발 인원: 1명 </br>
프로젝트 기간: 2024.04~2024.05

[💐 app store link](https://apps.apple.com/kr/app/향기/id6503708700)

</br>


## 기술 스택

- UIKit
- RxSwift
- RxCocoa
    - input-output pattern
- Realm
- MVVM

</br>

## 기능

<details>
    <summary> 전체 시향지/찜한 시향지/향수 정보 조회 </summary>

<!-- summary 아래 한칸 공백 두고 내용 삽입 -->

<img src = "https://github.com/minnnidev/Hyanggi/assets/108191001/97dca9a8-78a4-48d5-899b-ce717486dad9" width = 30% >
<img src = "https://github.com/minnnidev/Hyanggi/assets/108191001/cae79f05-f986-4dc3-ba21-49e6427833bb" width = 30% >
<img src = "https://github.com/minnnidev/Hyanggi/assets/108191001/878df245-870b-4c22-9bda-8bdb1fd4f5d1" width = 30% >

</details>

<details>
    <summary> 시향지 등록 </summary>

<!-- summary 아래 한칸 공백 두고 내용 삽입 -->

<img src = "https://github.com/minnnidev/Hyanggi/assets/108191001/d4a029b4-691d-4959-a8e0-1932ff3fe4d6" width = 30%>

</details>

<details>
    <summary> 시향지 수정/삭제 </summary>

<!-- summary 아래 한칸 공백 두고 내용 삽입 -->

<img src = "https://github.com/minnnidev/Hyanggi/assets/108191001/01725a49-66cb-423c-b90d-45470560ea78" width = 30%>
<img src = "https://github.com/minnnidev/Hyanggi/assets/108191001/cf9f7ee4-8526-4e90-af37-4483a80aad6b" width = 30%>



</details>

<details>
    <summary> 시향지 검색 </summary>

<!-- summary 아래 한칸 공백 두고 내용 삽입 -->

<img src = "https://github.com/minnnidev/Hyanggi/assets/108191001/fe99a6ab-bf49-4295-801e-a499b27b71c5" width = 30%>

</details>

</br>

## 회고

<details>
<summary> RxSwift와 input-output 패턴 사용기</summary>

**ViewModel은 View에 보여줄 형태로 가공, View는 UI에 보여줄 용도로만.** </br>
최대한 의도를 명확하게 하기 위해 RxSwift의 input-output pattern을 활용했다.

- input-output pattern 사용 전
  ```
  // ViewModel
  
  let dateRelay = BehaviorRelay<String>(value: "")
  let brandNameRelay = BehaviorRelay<String>(value: "")
  let perfumeNameRelay = BehaviorRelay<String>(value: "")
  let contentRelay = BehaviorRelay<String>(value: "")
  let sentenceRelay = BehaviorRelay<String>(value: "")

  let completeAction = PublishRelay<Void>()

  var initialPerfume: Driver<Perfume?> {
    return Observable.just(perfume)
      .asDriver(onErrorJustReturn: nil)
  }

  var formValid: Observable<Bool> {
    return Observable.combineLatest(brandNameRelay,
                                    perfumeNameRelay,
                                    sentenceRelay)
      .map { !$0.isEmpty && !$1.isEmpty && !$2.isEmpty }
  }
  ```

  </br>
  
- input-output pattern 사용 후
  ```
  // ViewModel
  
  struct Input {
    let dateText: Observable<String>
    let brandNameText: Observable<String>
    let perfumeNameText: Observable<String>
    let contentText: Observable<String>
    let sentenceText: Observable<String>
    let dismissButtonTap: ControlEvent<Void>
    let completeButtonTap: ControlEvent<Void>
    let selectImage: Observable<UIImage?>
    let deletePhotoButtonTap: ControlEvent<Void>
  }
  
  struct Output {
    let isFormValid: Observable<Bool>
    let dismissToPrevious: Observable<Void>
    let initialPerfume: Driver<Perfume?>
    let perfumeImage: BehaviorRelay<UIImage?>
  }
  
  func transform(input: Input) -> Output {
    // return Output(...)
  }
  ```

  ```
  // ViewController - bindViewModel()

  let output = viewModel.transform(input: input)

  output.initialPerfume
    .compactMap { $0 }
    .drive(with: self, onNext: { vc, perfume in
        vc.layoutView.dateTextField.textField.text = perfume.date
        vc.layoutView.brandTextField.textField.text = perfume.brandName
        vc.layoutView.nameTextField.textField.text = perfume.perfumeName
        vc.layoutView.contentTextView.text = perfume.content
        vc.layoutView.sentenceTextField.textField.text = perfume.sentence
    })
    .disposed(by: disposeBag)

  output.perfumeImage
    .withUnretained(self)
    .subscribe(onNext: { vc, image in
        vc.layoutView.photoView.image = image
        vc.layoutView.deletePhotoButton.isHidden = (image == nil)
    })
    .disposed(by: disposeBag)

  output.dismissToPrevious
    .withUnretained(self)
    .bind { vc, _ in
        vc.dismiss(animated: true)
    }
    .disposed(by: disposeBag)

  output.isFormValid
    .bind(to: layoutView.completeButton.rx.isEnabled)
    .disposed(by: disposeBag)
  ```
  

모든 이벤트나 입력 데이터를 input으로 넣어줘야 하기 때문에, 간단하게 적을 수 있는 코드도 길어질 수 있다는 단점이 존재하였다. </br>
하지만 output 데이터를 통해 View에 나타낼 수 있다는 점은 데이터의 흐름을 명확하게 보여주고, ViewModel과 View의 역할을 분리할 수 있다고 느껴졌다. </br>
input-ouput pattern을 사용해 보면서, ViewModel은 View에 보여줄 데이터를 가공하는 곳이라는 정의를 확실하게 내릴 수 있었다. </br>

</details>

<details>
<summary>massive viewController 관리</summary>

- ViewController에서 View를 분리하기 위해 `loadView()` 메서드를 사용하여 View를 분리
- View에 보여줄 모델을 가공하는 로직은 ViewModel로 이동

</details>


<details>
<summary>realm database</summary>

- realm database에 향수 정보 저장
- Repository Pattern 활용
    - `PerfumeStorageType` 프로토콜을 정의하여 local database → realm database 이전을 쉽게 수정할 수 있었음.
- 관련 파일: Service 폴더

</details>


<details>
<summary>FileManager</summary>

- 향수 이미지 등록 시, 이미지는 file 내에 저장하고, file에 접근하는 경로를 realm database에 저장하도록 하였다.
- 관련 파일: Service 폴더 내의 `ImageFileManager`

</details>
