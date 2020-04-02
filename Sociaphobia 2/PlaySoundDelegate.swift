//
//  playSoundDelegate.swift
//  Sociaphobia 2
//
//  Created by Evgeniy Uskov on 30.03.2020.
//  Copyright © 2020 Evgeniy Uskov. All rights reserved.
//

import Foundation
import UIKit

protocol PlaySoundDelegate: AnyObject {
    func didPlayedSound(_ sender: UIButton)
}
