// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Plural format key: "%#@VARIABLE@"
  internal static func ageValue(_ p1: Int) -> String {
    return L10n.tr("Localizable", "age-value", p1)
  }

  internal enum Auth {
    /// Войти
    internal static let action = L10n.tr("Localizable", "auth.action")
    /// Логин
    internal static let login = L10n.tr("Localizable", "auth.login")
    /// Пароль
    internal static let password = L10n.tr("Localizable", "auth.password")
  }

  internal enum Catalog {
    /// Купить
    internal static let buy = L10n.tr("Localizable", "catalog.buy")
    /// Каталог
    internal static let title = L10n.tr("Localizable", "catalog.title")
    /// Каталог
    internal static let tittle = L10n.tr("Localizable", "catalog.title")
  }
    internal enum History {
      /// Мои заказы
      internal static let title = L10n.tr("Localizable", "history.title")
        /// Отменен
        internal static let canceled = L10n.tr("Localizable", "history.canceled")
        /// В работе
        internal static let inWork = L10n.tr("Localizable", "history.inWork")
    }
    
    internal enum Product {
        
        /// КУПИТЬ СЕЙЧАС
        internal static let payTitle = L10n.tr("Localizable", "product.payTitle")
        /// Размер
        internal static let size = L10n.tr("Localizable", "product.size")
        /// S
        internal static let sizeS = L10n.tr("Localizable", "product.sizeS")
        /// M
        internal static let sizeM = L10n.tr("Localizable", "product.sizeM")
        /// L
        internal static let sizeL = L10n.tr("Localizable", "product.sizeL")
        /// XL
        internal static let sizeXL = L10n.tr("Localizable", "product.sizeXL")
        /// Хит сезона
        internal static let badge = L10n.tr("Localizable", "product.badge")
    }
    internal enum Order {
        /// Оформление заказа
        internal static let title = L10n.tr("Localizable", "order.title")
        /// Квартира
        internal static let apartment = L10n.tr("Localizable", "order.apartment")
        /// Дом
        internal static let house = L10n.tr("Localizable", "order.house")
        /// Дата доставки
        internal static let orderDate = L10n.tr("Localizable", "order.orderDate")
        /// Купить за
        internal static let payTitle = L10n.tr("Localizable", "order.payTitle")
    }

  internal enum Common {
    /// Поле пустое
    internal static let emptyField = L10n.tr("Localizable", "common.emptyField")
    /// Что-то пошло не так
    internal static let error = L10n.tr("Localizable", "common.error")
  }
    internal enum Editing {
        /// Имя
        internal static let name = L10n.tr("Localizable", "editingTitle.name")
        /// Фамилия
        internal static let surname = L10n.tr("Localizable", "editingTitle.surname")
        /// Род деятельности
        internal static let occupation = L10n.tr("Localizable", "editingTitle.occupation")
        /// Другой род деятельности
        internal static let anotherOccupation = L10n.tr("Localizable", "editingTitle.anotherOccupation")
        /// Изменить
        internal static let edit = L10n.tr("Localizable", "editingTitle.action")
        /// Редактирование профиля
        internal static let title = L10n.tr("Localizable", "editingTitle.title")
        /// Род деятельности не изменился
        internal static let duble = L10n.tr("Localizable", "editingTitle.double")
        /// Настройки
        internal static let settings = L10n.tr("Localizable", "editingTitle.settings")
    }
    
    internal enum Profile {
        
        internal static let title = L10n.tr("Localizable", "profile.title")
    }
    
    internal enum Occupation {
      /// Другое
      internal static let another = L10n.tr("Localizable", "occupation.another")
      /// IOS разработчик
      internal static let iosDeveloper = L10n.tr("Localizable", "occupation.iosDeveloper")
      /// Android разработчик
      internal static let androidDeveloper = L10n.tr("Localizable", "occupation.androidDeveloper")
      /// Тестировщик
      internal static let tester = L10n.tr("Localizable", "occupation.tester")
    }
    internal enum Actions {
        /// Назад
        internal static let back = L10n.tr("Localizable", "action.back")
        /// Отменить
        internal static let cancel = L10n.tr("Localizable", "action.cancel")
        /// Выход
        internal static let exit = L10n.tr("Localizable", "action.exit")
        /// Выйти
        internal static let exitAction = L10n.tr("Localizable", "action.exitAction")
        /// Удаление
        internal static let delete = L10n.tr("Localizable", "action.delete")
        /// Удалить
        internal static let deleteAction = L10n.tr("Localizable", "action.deleteAction")
        /// Ошибка
        internal static let error = L10n.tr("Localizable", "action.error")
        /// Вы не можете удалить активный заказ
        internal static let errorMsg = L10n.tr("Localizable", "action.errorMsg")
        /// Ок
        internal static let ok = L10n.tr("Localizable", "action.ok")
        
    }
    internal enum Questions {
        /// Хотите выйти?
        internal static let exit = L10n.tr("Localizable", "question.exit")
        /// Хотите удалить заказ из истории?
        internal static let delete = L10n.tr("Localizable", "question.delete")
    }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
