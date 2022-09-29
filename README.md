# Mobon iOS SDK

[![CI Status](https://img.shields.io/travis/mobon/MobonSDK.svg?style=flat)](https://travis-ci.org/mobon/MobonSDK)
[![Version](https://img.shields.io/cocoapods/v/MobonSDK.svg?style=flat)](https://cocoapods.org/pods/MobonSDK)
[![License](https://img.shields.io/cocoapods/l/MobonSDK.svg?style=flat)](https://cocoapods.org/pods/MobonSDK)
[![Platform](https://img.shields.io/cocoapods/p/MobonSDK.svg?style=flat)](https://cocoapods.org/pods/MobonSDK)



|지원 환경|
|---:| 
| Deployment Target: iOS 11.0 이상|
| 최신 버전의 Xcode (Xcode 12.0 / Swift 5.3)|

* MobonSDK는 Swift로 개발되었습니다. Swift 기반의 프로젝트에서 MobonSDK를 사용하시려면 반드시 최신 버전의 Xcode를 사용해주세요.


## 1. SDK 설치하기
### 1) Cocoapods 사용하여 설치
#### 프로젝트의 Podfile에 'MobonSDK' 를 추가합니다.
```swift
pod 'MobonSDK'
```


### 2) 수동 설치
 - MobonSDKFramework.framework와 MobonSDKBundle.bundle을 다운로드 받습니다.  
 - MobonSDKFramework.framework을 앱 프로젝트의 General > Embeded Binaries 항목으로 끌어서 놓습니다.  
 - MobonSDKBundle.bundle이 앱 프로젝트의  Build Phases > Copy Bundle Resources에 포함되도록 수정 합니다.  


## 2. 프로젝트 설정
### 1) iOS 9 ATS(App Transport Security) 처리
iOS 9부터 ATS(App Transport Security) 기능이 기본적으로 활성화 되어 있으며, 암호화된 HTTPS 방식의 통신만 허용됩니다.  
Mobon SDK는 ATS 활성화 상태에서도 정상적으로 동작하도록 구현되어 있으나, 광고를 통해 노출되는 광고주 페이지는 HTTPS 방식을 지원하지 않을 수도 있습니다.  
따라서 아래의 사항을 앱 프로젝트의 Info.plist 파일에 적용하여 주시기 바랍니다.  

```swift
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```
### 2) Objective-C 프로젝트
Mobon SDK는 Swift 기반으로 개발되었습니다. Objective-C 기반의 프로젝트에서 Mobon SDK를 사용하기 위해서는 Swift Standard 라이브러리들을 Embed 시켜주어야 합니다.  
앱 프로젝트의 빌드 세팅에서 Always Embed Swift Standard Libraries 항목을 Yes로 설정해주세요.  


### 3) ATT(App Tracking Transparency) framework 적용
iOS14 타겟팅된 앱은 IDFA 식별자를 얻기 위해서는 ATT Framework를 반드시 적용해야 합니다.

##### 1. 업데이이트 Info.plist
앱이 사용자 또는 장치를 추적하기 위해 데이터 권한을 요청하는 이유를 사용자에게 알리는 메세지를 추가해야 합니다.  
```swift
<key> NSUserTrackingUsageDescription </key>
<string> 맞춤형 광고 제공을 위해 사용자의 데이터가 사용됩니다. </string>
```

##### 2. ATTrackingManager 코드 적용
```swift
if #available(iOS 14, *) {
    ATTrackingManager.requestTrackingAuthorization { (status) in
        if status == .authorized {
            bannerView.loadAd()
        }
    }
}
else {
    bannerView.loadAd()
}
```



## 3. 광고 요청

### 1. 배너 사이즈 광고 요청 및 적용
```swift

let bannerView = MobonBannerAdView(frame: CGRect(x: 0, 
                                                 y: view.frame.size.height - 50, 
                                                 width: view.bounds.width, 
                                                 height: 50),
                                   mediaCode:MEDIACODE,
                                   sCode:UNITID)
bannerView.rootViewController = self
bannerView.delegate = self
bannerView.bannerType = .Banner320x50

```
현재 지원하는 배너 타입은 아래와 같습니다.

```swift
enum MOBannerType: Int {
    case Banner320x50
    case Banner320x100
}
```

bannerType은 Banner320x50이 기본값이며, bannerType과 bannerView의 높이값이 동일해야 광고가 정상적으로 출력 됩니다.



### 2. 전면배너 요청 및 적용
전면 배너의 경우 먼저 광고를 로드한 뒤 화면에 표시하는 과정이 필요합니다.
따라서 광고를 표시하기 전에 아래와 같이 MobonInterstitialAdView를 먼저 생성해 주어야 합니다.  

```swift
...
interstitialView = MobonInterstitialAdView(mediaCode:MEDIACODE,unitId:UNITID)
interstitialView?.rootViewController = self
interstitialView?.delegate = self
...
```

이후 화면에 광고를 노출 시키기전 다음과 같이 광고를 로드합니다.
```swift
...
interstitialView?.loadAd()
...

```

광고가 성공적으로 로딩이 되면 MobonInterstitialAdViewDelegate의 아래 메소드를 통해 광고를 정상적으로 불러왔음을 확인할수 있습니다.
```swift
func interstitialDidReceiveAd(_ interstitialAdView: MobonInterstitialAdView) {
    print("interstitialDidReceiveAd")
    showPopup(controller: self, message: "interstitialDidReceiveAd", seconds: 1.0)
}
```

마지막으로 아래를 호출하면 화면에 전면배너가 표시됩니다.
```swift
...
interstitialView?.show()
...
```

### 3. 더 자세한 사항은 MobonSDKSample 의 소스를 확인해 주세요.



