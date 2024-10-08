//
//  DeeplinkProcessingOptionType.swift
//  Deeplinks
//
//  Created by Anton Vlezko on 28/09/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

public enum DeeplinkProcessingOptionType {
    case processingConditionsAgree(Bool)
    case amount(Decimal)
    case account(String?)
    case fromCardNumberDetails(String?)
    case payment(account: String, amount: Decimal)
}
