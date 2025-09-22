//
//  AppDelegate+Support.swift
//  BTPexel
//
//  Created by Ilia Baudin on 04.09.2025.
//

import Foundation
import UIKit
import PexelDomain

// MARK: - AppDelegate + AppService
func appService() -> PexelService {
    (UIApplication.shared.delegate as! AppDelegate).pexelService
}
