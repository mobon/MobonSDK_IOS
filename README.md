# Mobon iOS SDK

|지원 환경|
|---:| 
| Deployment Target: iOS 11.0 이상|
| 최신 버전의 Xcode (Xcode 12.0 / Swift 5.3)|

* MobonSDK는 Swift로 개발되었습니다. Swift 기반의 프로젝트에서 MobonSDK를 사용하시려면 반드시 최신 버전의 Xcode를 사용해주세요.


## 1. SDK 설치하기
### 1) Cocoapods 사용하여 설치
#### 프로젝트의 Podfile에 pod 'MobonSDK' 를 추가합니다.
#### 터미널에서 pod install 명령을 실행합니다.

### 2) 수동 설치
#### MobonSDKFramework.framework를 다운로드 받습니다.
#### MobonSDKFramework.framework을 앱 프로젝트의 General > Embeded Binaries 항목으로 끌어서 놓습니다.

## 2. 프로젝트 설정
### 1) iOS 9 ATS(App Transport Security) 처리
#### iOS 9부터 ATS(App Transport Security) 기능이 기본적으로 활성화 되어 있으며, 암호화된 HTTPS 방식의 통신만 허용됩니다.
#### Mobon SDK는 ATS 활성화 상태에서도 정상적으로 동작하도록 구현되어 있으나, 광고를 통해 노출되는 광고주 페이지는 HTTPS 방식을 지원하지 않을 수도 있습니다.
#### 따라서 아래의 사항을 앱 프로젝트의 Info.plist 파일에 적용하여 주시기 바랍니다.

```java
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```
### 2) Objective-C 프로젝트
#### AdFit SDK는 Swift 4.2 기반으로 개발되었습니다. Objective-C 기반의 프로젝트에서 AdFit SDK를 사용하기 위해서는 Swift Standard 라이브러리들을 Embed 시켜주어야 합니다.
#### 앱 프로젝트의 빌드 세팅에서 Always Embed Swift Standard Libraries 항목을 Yes로 설정해주세요.


## 3. 광고 요청

MobonSDKSample 의 소스를 확인해 주세요.
