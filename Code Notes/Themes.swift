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
    static var labelTextColor: UIColor?
    static var textFieldTextColor: UIColor?
    static var textFieldBackgroundColor: UIColor?
    static var viewBackgroundColor: UIColor?
    static var tableCellBackgroundSelectedColor: UIColor?

    // MARK: Themes
    static public func defaultTheme() {
        self.currentTheme = ThemeTypes.defaultTheme
        self.backgroundColor = UIColor.white
        self.buttonTextColor = UIColor.red
        self.buttonTextColorDisabled = UIColor.lightGray
        self.buttonBackgroundColor = UIColor.clear
        self.navBackgroundColor = UIColor.white
        self.labelTextColor = UIColor.black
        self.textFieldTextColor = UIColor.black
        let textFieldColor = UIColor(white: 0.9, alpha: 0)
        self.textFieldBackgroundColor = textFieldColor
        let viewColor = UIColor(red: CGFloat(245.0/255.0),
                                green: CGFloat(245.0/255.0),
                                blue: CGFloat(245.0/255.0),
                                alpha: CGFloat(1.0))
        self.tableCellBackgroundSelectedColor = UIColor(red: CGFloat(245.0/255.0),
                                                green: CGFloat(245.0/255.0),
                                                blue: CGFloat(245.0/255.0),
                                                alpha: CGFloat(1.0))
        self.viewBackgroundColor = viewColor
        updateDisplay()
    }
    static public func darkTheme() {
        self.currentTheme = ThemeTypes.darkTheme
        self.backgroundColor = UIColor.darkGray
        self.buttonTextColor = UIColor.white
        self.buttonTextColorDisabled = UIColor.lightGray
        self.buttonBackgroundColor = UIColor.clear
        self.navBackgroundColor = UIColor.darkGray
        self.labelTextColor = UIColor.white
        self.textFieldTextColor = UIColor.white
        self.textFieldBackgroundColor = UIColor.darkGray
        let viewColor = UIColor.darkGray
        self.tableCellBackgroundSelectedColor = UIColor.darkGray
        self.viewBackgroundColor = viewColor
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
    fileprivate static func themeLabel() {
        let proxyLabel = UILabel.appearance()
        proxyLabel.textColor = Theme.labelTextColor
    }
    fileprivate static func themeViewBacking() {
        let proxyViewBacking = UIView.appearance()
        proxyViewBacking.backgroundColor = Theme.navBackgroundColor
    }
    fileprivate static func themeScrollViewBacking() {
        let proxyScrollViewBacking = UIScrollView.appearance()
        proxyScrollViewBacking.backgroundColor = Theme.textFieldBackgroundColor
    }
    fileprivate static func themeTextFieldBacking() {
        let proxyTextFieldBacking = UITextField.appearance()
        proxyTextFieldBacking.backgroundColor = Theme.textFieldBackgroundColor
        proxyTextFieldBacking.borderStyle = .none
    }
    fileprivate static func themeTextFieldText() {
        let proxyTextFieldText = UITextField.appearance()
        proxyTextFieldText.textColor = Theme.textFieldTextColor
    }

    static public func updateDisplay() {
        themeButtons()
        themeKeyboard()
        themeNavBar()
        themeTable()
        themeLabel()
        themeScrollViewBacking()
        themeTextFieldBacking()
        themeTextFieldText()
    }
}
