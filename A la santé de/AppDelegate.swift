//
//  AppDelegate.swift
//  A la santé de
//
//  Created by Valentin on 03/04/2019.
//  Copyright © 2019 Valentin Garcia. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var listUserNames: [String] = []
    var tabScore: [Int] = []
    var listQuestions: [String] = []
    var lapQuestion = 1

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func shuffleQuestions() {
        let preferences = UserDefaults.standard
        
        if preferences.object(forKey: "difficulty") != nil {
            //var questionsArray: [String]
            let difficulty = preferences.string(forKey: "difficulty")
            if (difficulty == "SOFT") {
                listQuestions = ["worst_student".str(), "most_intelligent".str(), "most_sleep".str(), "most_roisterer".str(), "most_emotional".str(), "most_arrogant".str(), "most_skinflint".str(), "worst_cook".str(), "most_snore".str(), "most_shy".str(), "most_shopping".str(), "most_talkative".str(), "worst_singer".str(), "best_english".str(), "worst_english".str(), "best_sport".str(), "most_cry".str(), "most_alcoholic".str(), "worst_alcoholic".str(), "most_beautiful_boy".str(), "most_dredger".str(), "worst_dredger".str(), "most_slackness".str(), "most_drunk".str(), "worst_drunk".str(), "most_extrovert".str(), "most_loyal".str(), "most_spew".str(), "most_lier".str(), "most_duck".str(), "worst_driver".str(), "worst_character".str(), "justin_bieber".str(), "kiss_celebrity".str(), "lie_for_game".str()]
            }
            else {
                listQuestions = ["most_alcoholic".str(), "worst_alcoholic".str(), "most_beautiful_boy".str(), "most_dredger".str(), "worst_dredger".str(), "most_slackness".str(), "most_drunk".str(), "worst_drunk".str(), "most_extrovert".str(), "most_loyal".str(), "most_spew".str(), "most_lier".str(), "most_duck".str(), "worst_driver".str(), "worst_character".str(), "justin_bieber".str(), "kiss_celebrity".str(), "lie_for_game".str(), "most_precocious".str(), "best_shot".str(), "worst_shot".str(), "most_apt_milf".str(), "most_sex_like".str(), "most_apt_bit_h".str(), "most_cheater".str(), "most_sado".str(), "most_michto".str(), "most_masturbate".str(), "worst_stink".str(), "eat_shit".str(), "most_sister".str(), "mistake_name".str(), "fake_orgasm".str(), "send_nudes".str(), "sex_here".str(), "polygame".str(), "sextoys".str()]
            }
            listQuestions.shuffle()
        }
    }
    
    func cleanScore() {
        for i in 0..<tabScore.count {
            tabScore[i] = 0
        }
    }
}

