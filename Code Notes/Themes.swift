//
//  Themes.swift
//  Code Notes
//
//  Created by Peter Witham on 3/25/18.
//  Copyright © 2018 Peter Witham. All rights reserved.
//
import Foundation
import UIKit

struct Theme {
    enum ThemeTypes {
        case defaultTheme
        case darkTheme
    }

    static var currentTheme: ThemeTypes?
    static var backgroundColor: UIColor?
    static var buttonTextColor: UIColor?
    static var buttonTextColorDisabled: UIColor?
    static var buttonBackgroundColor: UIColor?
    static var navBackgroundColor: UIColor?

    // MARK: Themes
    static public func defaultTheme() {
        self.currentTheme = ThemeTypes.defaultTheme
        self.backgroundColor = UIColor.white
        self.buttonTextColor = UIColor.blue
        self.buttonTextColorDisabled = UIColor.lightGray
        self.buttonBackgroundColor = UIColor.clear
        self.navBackgroundColor = UIColor.white
        updateDisplay()
    }
    static public func darkTheme() {
        self.currentTheme = ThemeTypes.darkTheme
        self.backgroundColor = UIColor.darkGray
        self.buttonTextColor = UIColor.white
        self.buttonTextColorDisabled = UIColor.lightGray
        self.buttonBackgroundColor = UIColor.clear
        self.navBackgroundColor = UIColor.darkGray
        updateDisplay()
    }
    // MARK: Theme Controls
    fileprivate static func themeButtons() {
        let proxyButton = UIButton.appearance()
        proxyButton.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
        proxyButton.setTitleColor(Theme.buttonTextColor, for: .normal)
        proxyButton.backgroundColor = Theme.buttonBackgroundColor
        proxyButton.tintColor = Theme.buttonTextColor
    }
    fileprivate static func themeKeyboard() {
        // Theme the keyboard
        if currentTheme == ThemeTypes.defaultTheme {
            UITextField.appearance().keyboardAppearance = .default
        } else {
            UITextField.appearance().keyboardAppearance = .dark
        }
    }
    fileprivate static func themeNavBar() {
        let proxyNavBar = UINavigationBar.appearance()
        proxyNavBar.barTintColor = Theme.navBackgroundColor
        let proxyToolBar = UIToolbar.appearance()
        proxyToolBar.barTintColor = Theme.navBackgroundColor
    }
    fileprivate static func themeTable() {
        let proxyTable = UITableView.appearance()
        proxyTable.backgroundColor = Theme.backgroundColor
        let proxyTableCell = UITableViewCell.appearance()
        proxyTableCell.backgroundColor = Theme.backgroundColor
    }
    static public func updateDisplay() {
        themeButtons()
        themeKeyboard()
        themeNavBar()
        themeTable()
    }
}
