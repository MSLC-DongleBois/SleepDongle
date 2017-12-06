//
//  NightWatchman.swift
//  Commotion
//
//  Created by Logan Dorsey on 12/6/17.
//  Copyright © 2017 Eric Larson. All rights reserved.
//

import Foundation
import os.log

var nights = [NightyNight]()

func saveNights() {
    let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(nights, toFile: NightyNight.ArchiveURL.path)
    if isSuccessfulSave {
        os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
    } else {
        os_log("Failed to save meals...", log: OSLog.default, type: .error)
    }
}

func loadNights() -> [NightyNight]? {
    return NSKeyedUnarchiver.unarchiveObject(withFile: NightyNight.ArchiveURL.path) as? [NightyNight]
}
