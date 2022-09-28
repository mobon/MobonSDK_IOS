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
```ruby
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

```java
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
```java
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

MobonSDKSample 의 소스를 확인해 주세요.
