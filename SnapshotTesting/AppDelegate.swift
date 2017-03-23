//
//  AppDelegate.swift
//  memepedia
//
//  Created by Jindrich Dolezy on 09/10/16.
//  Copyright © 2016 STRV. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var container: Container = {
        let container = Container()
        container.storyboardInitCompleted(MemeListViewController.self) { r, c in
            c.viewModel = r.resolve(MemeListViewModel.self)
        }
        container.storyboardInitCompleted(MemeGeneratorViewController.self) {
            $1.viewModel = $0.resolve(MemeListViewModel.self)
        }
        container.register(MemeListViewModel.self) { _ in
            DummyLoadingMemeListViewModel(memes: Meme.memes)
        }
        return container
    }()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        Container.loggingFunction = nil
        
        UINavigationBar.appearance().titleTextAttributes = [
            NSFontAttributeName: R.font.impact(size:22)!
        ]
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window
        
        let storyboard = SwinjectStoryboard.create(name: "Main", bundle: nil, container: container)
        window.rootViewController = storyboard.instantiateInitialViewController()

        
        return true
    }

}

