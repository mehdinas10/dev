//
//  Bundle .swift
//  Vision45
//
//  Created by Mehdi Nasiri on 12/1/20.
//  Copyright © 2020 Mehdi Nasiri. All rights reserved.
//

import Foundation
import UIKit

var bundleKey: UInt8 = 0

class AnyLanguageBundle: Bundle {

  override func localizedString(forKey key: String,
                              value: String?,
                              table tableName: String?) -> String {

    guard let path = objc_getAssociatedObject(self, &bundleKey) as? String,
        let bundle = Bundle(path: path) else {
        return super.localizedString(forKey: key, value: value, table: tableName)
    }

    return bundle.localizedString(forKey: key, value: value, table: tableName)
  }
}

extension Bundle{
    class func setLanguage(_ language: String) {
      defer {
          object_setClass(Bundle.main, AnyLanguageBundle.self)
      }
      objc_setAssociatedObject(Bundle.main, &bundleKey, Bundle.main.path(forResource: language, ofType: "lproj"), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
