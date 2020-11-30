//
//  ViewController.swift
//  maio_flutter
//
//  Created by 0maru on 2020/11/30.
//

import Foundation

class ViewController {
  static func get() -> UIViewController {
    let viewController = UIApplication.shared.windows.filter { (v) -> Bool in
        v.isHidden == false
    }.first?.rootViewController
    return viewController!
  }
}
