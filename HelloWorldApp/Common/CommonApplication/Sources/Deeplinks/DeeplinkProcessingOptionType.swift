//
//  DeeplinkProcessingOptionType.swift
//  CommonApplication
//
//  Created by Anton Vlezko on 17/10/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation

public enum DeeplinkProcessingOptionType {
    case processingConditionsAgree(Bool)
    case amount(Decimal)
    case account(String?)
    case fromCardNumberDetails(String?)
    case payment(account: String, amount: Decimal)
}
