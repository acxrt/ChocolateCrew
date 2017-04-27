//
//  StringExtensionLocalizable.swift
//  ChocolateCrew
//
//  Created by Aina Cuxart on 27/4/17.
//  Copyright © 2017 Aina Cuxart. All rights reserved.
//

import UIKit

extension NSObject {
    func localizedString(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}

