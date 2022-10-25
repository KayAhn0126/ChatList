# Chat List

- UICollectionView with Storyboard!

|            작동 화면             |
|:--------------------------------:|
| ![](https://i.imgur.com/GjAcmrC.gif) |


## 🍎 ChatListCollectionViewCell 클래스 내 awakeFromNib의 역할

- dequeueReusableCell을 할 때 “ChatListCollectionViewCell”이라는 identifier를 가지고 있는 cell을 스토리보드에서 꺼내올때 처음에 호출되는 함수

## 🍎 각진 image를 둥글게 만들기
```swift
thumbnailImageView.layer.cornerRadius = 10
```
- [CALayer 관련 자료](https://github.com/KayAhn0126/iOS-Study/tree/main/UI/CALayer)

## 🍎 날짜를 "yyyy-MM-dd" 형식에서 "M/d" 형식으로 변환

|                변환 전                 |               변환 후                |
|:--------------------------------------:|:------------------------------------:|
|               yyyy-MM-dd               |                 M/d                  |
|  ![](https://i.imgur.com/CEQRjxf.png)  | ![](https://i.imgur.com/g48Ckju.png) |

- 아래의 코드를 사용해 문제 해결.
```swift
func formattedDateString(dateString: String) -> String {
    let formatter = DateFormatter                        // 변환 해 줄 formatter 생성.
    formatter.dateFormat = "yyyy-MM-dd"                  // formatter의 date 형태를 "yyyy-MM-dd"로 설정.
        
    if let date = formatter.date(from: dateString) {     // 만약 매개변수로 받아온 dateString을 formatter의 date형태로 바꿀수 있다면.
        formatter.dateFormat = "M/d"                     // formatter의 date 형태를 "M/d"로 설정.
        return formatter.string(from: date)              // 다시 문자열로 형 변환후 반환.
    } else {
        return ""
    }
}
```

## 🍎 collectionViewCell의 오토 레이아웃이 제대로 잡히지 않는 문제 해결
- 셀의 넓이와 높이를 아래와 같이 코드로 정해줌에도 불구하고 뒤죽박죽인 셀이 나왔다.
```swift
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 100)
    }
}
```

- 하단의 왼쪽 사진은 Estimate Size를 Automatic(기본값)일때,
    - 셀의 오토레이아웃이 정확하게 잡혀있지 않았다.
    - 정확히는 셀의 우측에 날짜가 나와야 하는데 나오지 않는다. 

|      Estimate Size      |              Automatic               |                 None                 |
|:-----------------------:|:------------------------------------:|:------------------------------------:|
| Automatic과 None의 차이 | ![](https://i.imgur.com/J1aRNuR.png) | ![](https://i.imgur.com/VfTsT2S.png) |


- 공식문서에서는 원하는 답변을 찾을 수 없었고 StackOverFlow의 한 유저는 ***xcode 11 이후 부터 UICollectionViewDelegateFlowLayout의 size 결정 메서드가 제대로 동작하려면 Estimate Size 속성을 None으로 바꿔줘야 한다***고 나와있다. [StackOverflow 출처](https://stackoverflow.com/questions/38028013/how-to-set-uicollectionviewcell-width-and-height-programmatically)



## 🍎 날짜가 순서대로 나오지 않는 문제 해결

|          날짜를 정렬하기 전          |           날짜를 정렬한 후           |
|:------------------------------------:|:------------------------------------:|
| ![](https://i.imgur.com/sLH14xr.png) | ![](https://i.imgur.com/AmIV92O.png) |

- 하단의 viewDidLoad()에서 기본 데이터가 될 chatList를 정렬해주고 있다.
- 즉 화면이 나오자마자 기본 데이터를 정렬하는 것.

```swift
class ViewController: UIViewController {
    
    var chatList: [ChatModel] = ChatModel.list
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        chatList = chatList.sorted(by: { chat1, chat2 in
            return chat1.date > chat2.date
        })
    }
}
```
