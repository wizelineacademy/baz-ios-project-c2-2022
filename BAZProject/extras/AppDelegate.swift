//
//  AppDelegate.swift
//  BAZProject
//
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NotificationCenter.default.addObserver(self, selector: #selector(didLanguageChange(_:)), name: .didLanguageChange, object: nil)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        NotificationCenter.default.removeObserver(self, name: .didLanguageChange, object: nil)
    }
    
    @objc private func didLanguageChange(_ notification: Notification) {
        guard
            let info = notification.userInfo as? [String: LanguageType.RawValue],
            let language = info["language"] else { return }
        UserDefaults.standard.set(language, forKey: "SelectedLanguage")
    }

}

extension NSNotification.Name {
    static var didLanguageChange = NSNotification.Name("didLanguageChange")
}

