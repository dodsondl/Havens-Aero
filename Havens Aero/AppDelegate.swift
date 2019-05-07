//
//  AppDelegate.swift
//  Havens Aero
//
//  Created by Daniel Dodson on 4/2/19.
//  Copyright © 2019 Daniel Dodson. All rights reserved.
//

import UIKit
import CoreData
//import PSPDFKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        /*
        PSPDFKit.setLicenseKey("n3izHSLJsuWCVxzq7ssdNPUTVxfGy2sUMcJuK3fsrElmS4lvxPtigEBNnCsqfhTO6bGMI6mXNSYMGHu+XBekncapYbaNKvabjL79PL6LrSKX5u8QlI2L/wZk3V5Dood8yGdzYchrqQv/0QMnrf9sVL5fT1xOz4CsPXJuiTwnBwex3jAqRKriU7sxbNhK4CqXXDMnOMUCl8LPQQj1Bj3iaZHyEMfolOlWVSs0r8CXPF7VAJKr4X3u9MNDeTnfX/Sh+Mp3LD6mPEIIDA/mnVHvIMETZA9RwtrQoGtDyDHMxZQj3NX2Bk4qeVj90wDYksuqUOn+Isss06hzVGG32sEDzEYNuqBYG2icMrBb2d5Xf2lQP16CeOh4prA3DtsPbNi6wJkB2TEQueDhKIDhGhPsQl5jY0+0TYajN+1k5/bMAcQ7dOqNgkgx3J9yQjRW4qBh")
 */
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
     
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
       
    }

    func applicationWillTerminate(_ application: UIApplication) {
       
        self.saveContext()
    }
    
    class func getAppDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
  
        let container = NSPersistentContainer(name: "Havens_Aero")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
          
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
             
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

