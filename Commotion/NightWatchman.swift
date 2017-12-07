//
//  NightWatchman.swift
//  Commotion
//
//  Created by Logan Dorsey on 12/6/17.
//  Copyright © 2017 Eric Larson. All rights reserved.
//

import Foundation
import os.log


class NightWatchman
{
    var nights = [NightyNight]()

    func saveNights() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(nights, toFile: NightyNight.ArchiveURL.path)
        if isSuccessfulSave
        {
            os_log("Nights successfully saved.", log: OSLog.default, type: .debug)
            print("Good shit")
        }
        else
        {
            os_log("Failed to save nights...", log: OSLog.default, type: .error)
            print("FECK")
        }
    }

    func loadNights() -> [NightyNight]? {
        let x = NSKeyedUnarchiver.unarchiveObject(withFile: NightyNight.ArchiveURL.path) as? [NightyNight]
      
        if let nightsArg = x {
            nights = nightsArg
        } else {
            nights = [NightyNight]()
        }
        return nights

    }
}
