//
//  Configuration.swift
//  Code Notes
//
//  Created by Peter Witham on 8/11/18.
//  Copyright © 2018 Peter Witham. All rights reserved.
//

import Foundation
import UIKit

enum AppData {
    static let context = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
}
