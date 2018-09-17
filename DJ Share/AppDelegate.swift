//
//  AppDelegate.swift
//  DJ Share
//
//  Created by Reilly Freret on 9/14/18.
//  Copyright © 2018 Reilly Freret. All rights reserved.
//

import UIKit
import PureLayout

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, SPTSessionManagerDelegate, SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate {

    var window: UIWindow?
    
    let SpotifyClientID = "0cd7b2c764fb487a9533423854ce5036"
    let SpotifyRedirectURL = URL(string: "spotify-ios-quick-start://spotify-login-callback")!
    
    lazy var configuration = SPTConfiguration(
        clientID: SpotifyClientID,
        redirectURL: SpotifyRedirectURL
    )
    
    lazy var sessionManager: SPTSessionManager = {
        if let tokenSwapURL = URL(string: "https://dj-share-tokens.heroku.com/api/token"),
            let tokenRefreshURL = URL(string: "https://dj-share-tokens.heroku.com/api/refresh_token") {
            self.configuration.tokenSwapURL = tokenSwapURL
            self.configuration.tokenRefreshURL = tokenRefreshURL
            self.configuration.playURI = ""
        }
        let manager = SPTSessionManager(configuration: self.configuration, delegate: self)
        return manager
    }()
    
    lazy var appRemote: SPTAppRemote = {
        let appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
        appRemote.delegate = self
        return appRemote
    }()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let requestedScopes: SPTScope = [.appRemoteControl]
        self.sessionManager.initiateSession(with: requestedScopes, options: .default)
        print("\nHere\n")
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = MainNavController()
        window!.makeKeyAndVisible()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        self.sessionManager.application(app, open: url, options: options)
        
        return true
    }
    
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        self.appRemote.connectionParameters.accessToken = session.accessToken
        self.appRemote.connect()
    }
    
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        print(error)
    }
    
    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        print(session)
    }
    
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        print("connected")
        
        self.appRemote.playerAPI?.delegate = self
        self.appRemote.playerAPI?.subscribe(toPlayerState: { (result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
            }
        })
        
        // Want to play a new track?
        // self.appRemote.playerAPI?.play("spotify:track:13WO20hoD72L0J13WTQWlT", callback: { (result, error) in
        //     if let error = error {
        //         print(error.localizedDescription)
        //     }
        // })
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        print("disconnected")
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        print("failed")
    }
    
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        print("player state changed")
        print("isPaused", playerState.isPaused)
        print("track.uri", playerState.track.uri)
        print("track.name", playerState.track.name)
        print("track.imageIdentifier", playerState.track.imageIdentifier)
        print("track.artist.name", playerState.track.artist.name)
        print("track.album.name", playerState.track.album.name)
        print("track.isSaved", playerState.track.isSaved)
        print("playbackSpeed", playerState.playbackSpeed)
        print("playbackOptions.isShuffling", playerState.playbackOptions.isShuffling)
        print("playbackOptions.repeatMode", playerState.playbackOptions.repeatMode.hashValue)
        print("playbackPosition", playerState.playbackPosition)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        print("*** applicationWillResignActive ***")
        if self.appRemote.isConnected {
            self.appRemote.disconnect()
        }
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print("*** applicationDidEnterBackground ***")
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print("*** applicationWillEnterForeground ***")
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        print("*** applicationDidBecomeActive ***")
        if let _ = self.appRemote.connectionParameters.accessToken {
            self.appRemote.connect()
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

