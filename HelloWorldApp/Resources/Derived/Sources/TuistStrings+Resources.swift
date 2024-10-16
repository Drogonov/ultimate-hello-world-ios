// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation
import Common

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
public struct ResourcesStrings {

    /// Your current version of the application is not supported. The application needs to be updated
    public static func appOutdated() -> String {
        tr("Localizable", "app_outdated")
    }

    /// Attention!
    public static func attention() -> String {
        tr("Localizable", "attention")
    }

    /// Cancel
    public static func cancel() -> String {
        tr("Localizable", "cancel")
    }

    /// Change
    public static func change() -> String {
        tr("Localizable", "change")
    }

    /// Change Language
    public static func changeLanguageText() -> String {
        tr("Localizable", "change_language_text")
    }

    /// Change Language
    public static func changeLanguageTitle() -> String {
        tr("Localizable", "change_language_title")
    }

    /// Clear
    public static func clear() -> String {
        tr("Localizable", "clear")
    }

    /// Failed to convert response from %@ to JSON
    public static func errorConvertation(_ p1: String) -> String {
        tr("Localizable", "error_convertation",p1)
    }

    /// Failed to convert response from %@ to JSON completely. Received nil at the end of conversion
    public static func errorConvertationNil(_ p1: String) -> String {
        tr("Localizable", "error_convertation_nil",p1)
    }

    /// Request %@ responded with empty data
    public static func errorEmptyData(_ p1: String) -> String {
        tr("Localizable", "error_empty_data",p1)
    }

    /// Failed to serialize response to JSON
    public static func errorSerialization() -> String {
        tr("Localizable", "error_serialization")
    }

    /// %@\n\nError Code: %@
    public static func errorWithTraceId(_ p1: String, _ p2: String) -> String {
        tr("Localizable", "error_with_trace_id",p1, p2)
    }

    /// Functionality is unavailable
    public static func forbiddenErrorDefaultMessage() -> String {
        tr("Localizable", "forbidden_error_default_message")
    }

    /// Functionality is unavailable
    public static func functionalityUnavailable() -> String {
        tr("Localizable", "functionality_unavailable")
    }

    /// Hello World
    public static func helloWorldButtonTitle() -> String {
        tr("Localizable", "hello_world_button_title")
    }

    /// Hello World
    public static func helloWorldText() -> String {
        tr("Localizable", "hello_world_text")
    }

    /// Hello World
    public static func helloWorldTitle() -> String {
        tr("Localizable", "hello_world_title")
    }

    /// Internet is unavailable
    public static func internetNotAvailable() -> String {
        tr("Localizable", "internet_not_available")
    }

    /// Connect to another network, check the internet and try again
    public static func internetNotAvailableMessage() -> String {
        tr("Localizable", "internet_not_available_message")
    }

    /// Internet Connection Issue
    public static func internetNotAvailableTitle() -> String {
        tr("Localizable", "internet_not_available_title")
    }

    /// Tap to see error alert 🏴‍☠️
    public static func magicButtonText() -> String {
        tr("Localizable", "magic_button_text")
    }

    /// Ok
    public static func ok() -> String {
        tr("Localizable", "ok")
    }

    /// Let's Go!
    public static func onboardingButtonText() -> String {
        tr("Localizable", "onboarding_buttonText")
    }

    /// Here you can see information about our onboarding
    public static func onboardingText() -> String {
        tr("Localizable", "onboarding_text")
    }

    /// Refresh
    public static func refresh() -> String {
        tr("Localizable", "refresh")
    }

    /// Sorry, a request error occurred, please try again later
    public static func serverInaccessible() -> String {
        tr("Localizable", "server_inaccessible")
    }

    /// Reload it and try logging in later
    public static func serverInaccessibleMessage() -> String {
        tr("Localizable", "server_inaccessible_message")
    }

    /// Application is temporarily unavailable
    public static func serverInaccessibleTitle() -> String {
        tr("Localizable", "server_inaccessible_title")
    }

    /// Functionality is temporarily unavailable
    public static func unknownError() -> String {
        tr("Localizable", "unknown_error")
    }
}

fileprivate extension ResourcesStrings {
    static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
        let format = BundleProvider.shared.localizedString(
             forKey: key,
             value: nil,
             table: table
         )
        return String(format: format, arguments: args)
    }
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name
