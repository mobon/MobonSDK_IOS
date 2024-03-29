//
//  ViewController.swift
//  MobonSdkSample
//
//  Created by enliple2015 on 2020/10/13.
//

import UIKit
import MobonSDKFramework

import AppTrackingTransparency

class ViewController: UIViewController,MobonBannerAdViewDelegate,MobonInterstitialAdViewDelegate {

    let MEDIACODE : String = "mobon"
    let UNITID : String = "432394"
    var interstitialView : MobonInterstitialAdView?
    
    
    @IBAction func intertstitialLoad(_ sender: Any) {
        interstitialView?.loadAd()
    }
    
    @IBAction func interstitalShow(_ sender: Any) {
        interstitialView?.show()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        let bannerView = MobonBannerAdView(frame: CGRect(x: 0, y: view.frame.size.height - 50, width: view.bounds.width, height: 50),mediaCode:MEDIACODE,sCode:UNITID)
        bannerView.rootViewController = self
        bannerView.delegate = self
        bannerView.bannerType = .Banner320x50   //반드시 View Height와 동일한 값으로 맞춰줘야 한다. 기본값은 320x50
        
        view.addSubview(bannerView)
        
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
        
        
        interstitialView = MobonInterstitialAdView(mediaCode:MEDIACODE,unitId:UNITID)
        interstitialView?.rootViewController = self
        interstitialView?.delegate = self
    }


    func adViewDidReceiveAd(_ bannerAdView: MobonBannerAdView) {
        print("adViewDidReceiveAd")
        
    }
    
    
    func adViewFailedAd(_ bannerAdView: MobonBannerAdView, _ error: String) {
        print("adViewFailedAd : \(error)");
    }
    
    func adViewClicked(_ bannerAdView: MobonBannerAdView) {
        print("adView Click")
    }
    
    
    func interstitialAdNotLoaded(_ interstitialAdView: MobonInterstitialAdView) {
        print("interstitialAdNotLoaded")
        showPopup(controller: self, message: "interstitialAdNotLoaded", seconds: 1.0)
    }
    
    func interstitialDidReceiveAd(_ interstitialAdView: MobonInterstitialAdView) {
        print("interstitialDidReceiveAd")
        showPopup(controller: self, message: "interstitialDidReceiveAd", seconds: 1.0)
    }
    
    func interstitialFailedAd(_ interstitialAdView: MobonInterstitialAdView, _ error: String) {
        print("interstitialFailedAd : \(error)");
        showPopup(controller: self, message: "interstitialFailedAd : \(error)", seconds: 1.0)
    }
    
    func interstitialClicked(_ interstitialAdView: MobonInterstitialAdView) {
        print("interstitialClicked")
    }
    
    func interstitialClose(_ interstitialAdView: MobonInterstitialAdView) {
        print("interstitialClose")
    }
    
    func showPopup(controller: UIViewController,message : String, seconds:Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.9
        alert.view.layer.cornerRadius = 15
        
        controller.present(alert,animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds){
            alert.dismiss(animated: true)
        }
    }
}

