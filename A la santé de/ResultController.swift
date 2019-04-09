//
//  ResultController.swift
//  A la santé de
//
//  Created by Valentin on 08/04/2019.
//  Copyright © 2019 Valentin Garcia. All rights reserved.
//

import Foundation
import GoogleMobileAds

class ResultController: UIViewController, GADInterstitialDelegate {
    
    @IBOutlet weak var textSentence: UILabel!
    @IBOutlet weak var nameLoser: UILabel!
    @IBOutlet weak var buttonView: UIView!
    
    var interstitial: GADInterstitial!
    
    override func viewDidLoad() {
        
        var highscore = 0
        var drinking = ""
        
        createAndLoadInterstitial()
        
        if #available(iOS 11.0, *) {
            if ((getAppdelegate()) != nil) {
                textSentence.ry = textSentence.ry + (getAppdelegate().window?.safeAreaInsets.top)!
            }
        }
        buttonView.layoutIfNeeded()
        buttonView.layer.cornerRadius = 5
        buttonView.layer.masksToBounds = true
        if(getAppdelegate() != nil && getAppdelegate().lapQuestion%3 == 1) {
            buttonView.isHidden = true
        }
        
        if(getAppdelegate() != nil) {
            for i in 0..<getAppdelegate().listUserNames.count {
                if (highscore < getAppdelegate().tabScore[i]) {
                    highscore = getAppdelegate().tabScore[i]
                    drinking = getAppdelegate().listUserNames[i]
                }
                else if (highscore == getAppdelegate().tabScore[i] && highscore > 0) {
                    drinking = drinking.replacingOccurrences(of: " et ", with: ", ")
                    drinking = drinking + " et " + getAppdelegate().listUserNames[i]
                }
            }
        }
        nameLoser.text = drinking.capitalized
    }
    
    @IBAction func onClickGoAgain(_ sender: Any) {
        
        if(getAppdelegate() != nil) {
            if(getAppdelegate().lapQuestion%3 == 1) {
                showInterstitial()
            }
            else {
                getAppdelegate().cleanScore()
                getAppdelegate().lapQuestion+=1
                performSegue(withIdentifier: "newquestion", sender: self)
                self.navigationController?.viewControllers.remove(at: (navigationController?.viewControllers.firstIndex(of: self))!)
            }
        }
    }
    
    func createAndLoadInterstitial() {
        //TODO: Change adUnitID for production
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        interstitial.delegate = self
        let request = GADRequest()
        // Request test ads on devices you specify. Your test device ID is printed to the console when
        // an ad request is made.
        request.testDevices = [ kGADSimulatorID, "2077ef9a63d2b398840261c8221a0c9a" ]
        interstitial.load(request)
    }
    
    /// Tells the delegate an ad request succeeded.
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        buttonView.isHidden = false
        print("interstitialDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        buttonView.isHidden = false
        print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that an interstitial will be presented.
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        print("interstitialWillPresentScreen")
    }
    
    /// Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        print("interstitialWillDismissScreen")
    }
    
    /// Tells the delegate the interstitial had been animated off the screen.
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        createAndLoadInterstitial()
        getAppdelegate()?.cleanScore()
        getAppdelegate()?.lapQuestion+=1
        performSegue(withIdentifier: "newquestion", sender: self)
        self.navigationController?.viewControllers.remove(at: (navigationController?.viewControllers.firstIndex(of: self))!)
        print("interstitialDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        print("interstitialWillLeaveApplication")
    }
    
    func showInterstitial() {
        if (interstitial.isReady) {
            interstitial.present(fromRootViewController: self)
        }
        else {
            print("Ad wasn't ready")
            getAppdelegate()?.cleanScore()
            getAppdelegate()?.lapQuestion+=1
            performSegue(withIdentifier: "newquestion", sender: self)
            self.navigationController?.viewControllers.remove(at: (navigationController?.viewControllers.firstIndex(of: self))!)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        if(isMovingFromParent) {
            getAppdelegate()?.cleanScore()
        }
    }
}
