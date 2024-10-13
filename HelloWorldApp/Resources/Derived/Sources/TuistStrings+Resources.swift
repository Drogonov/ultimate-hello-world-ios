// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
public struct ResourcesStrings {

    /// Ваша текущая версия приложения не поддерживается. Необходимо обновить приложение
    public static func appOutdated() -> String {
        tr("Localizable", "app_outdated")
    }

    /// Внимание!
    public static func attention() -> String {
        tr("Localizable", "attention")
    }

    /// Отмена
    public static func cancel() -> String {
        tr("Localizable", "cancel")
    }

    /// Изменить
    public static func change() -> String {
        tr("Localizable", "change")
    }

    /// Hello World
    public static func changeLanguageText() -> String {
        tr("Localizable", "change_language_text")
    }

    /// Hello World
    public static func changeLanguageTitle() -> String {
        tr("Localizable", "change_language_title")
    }

    /// Понятно
    public static func clear() -> String {
        tr("Localizable", "clear")
    }

    /// Failed to convert response from %@ to JSON
    public static func errorConvertation(_ p1: String) -> String {
        tr("Localizable", "error_convertation",p1)
    }

    /// Failed to convert response from %@ to JSON in total. Get nil at the end of conversion
    public static func errorConvertationNil(_ p1: String) -> String {
        tr("Localizable", "error_convertation_nil",p1)
    }

    /// Request %@ respond with empty data
    public static func errorEmptyData(_ p1: String) -> String {
        tr("Localizable", "error_empty_data",p1)
    }

    /// Failed to serialize response to JSON
    public static func errorSerialization() -> String {
        tr("Localizable", "error_serialization")
    }

    /// %@\n\nКод ошибки: %@
    public static func errorWithTraceId(_ p1: String, _ p2: String) -> String {
        tr("Localizable", "error_with_trace_id",p1, p2)
    }

    /// Функциональность недоступна
    public static func forbiddenErrorDefaultMessage() -> String {
        tr("Localizable", "forbidden_error_default_message")
    }

    /// Функциональность недоступна
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

    /// Интернет недоступен
    public static func internetNotAvailable() -> String {
        tr("Localizable", "internet_not_available")
    }

    /// Подключитесь к другой сети, проверьте интернет и повторите попытку
    public static func internetNotAvailableMessage() -> String {
        tr("Localizable", "internet_not_available_message")
    }

    /// Проблема с подключением к интернету
    public static func internetNotAvailableTitle() -> String {
        tr("Localizable", "internet_not_available_title")
    }

    /// оk
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

    /// Обновить
    public static func refresh() -> String {
        tr("Localizable", "refresh")
    }

    /// Извините, произошла ошибка выполнения запроса, попробуйте повторить действие позже
    public static func serverInaccessible() -> String {
        tr("Localizable", "server_inaccessible")
    }

    /// Перезагрузите его и повторите попытку входа позже
    public static func serverInaccessibleMessage() -> String {
        tr("Localizable", "server_inaccessible_message")
    }

    /// Приложение временно недоступно
    public static func serverInaccessibleTitle() -> String {
        tr("Localizable", "server_inaccessible_title")
    }

    /// Функциональность временно недоступна
    public static func unknownError() -> String {
        tr("Localizable", "unknown_error")
    }
}

fileprivate extension ResourcesStrings {
    static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
        let format = NSLocalizedString(
            key,
            tableName: table,
            bundle: Bundle(identifier: "com.drogonov.HelloWorldApp.Resources") ?? Bundle.main,
            comment: ""
        )
        return String(format: format, arguments: args)
    }
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name
