//
//  SwiftUIView.swift
//  
//
//  Created by Wahyu Alfandi on 12/04/23.
//

import SwiftUI

extension UINavigationController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
    }
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
    }
    public func canRotate() -> Void {}
}
