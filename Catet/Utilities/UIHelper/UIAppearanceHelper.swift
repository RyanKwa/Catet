//
//  UIAppearanceHelper.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 22/07/22.
//

import Foundation
import SwiftUI

class UIAppearanceHelper {
    
    static func setupNavigationTitle(withColor color: Color){
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navBarAppearance.backgroundColor = UIColor(color)
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().tintColor = UIColor(named: Theme.accentColor.rawValue)
    }
}
