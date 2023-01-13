import UIKit

protocol AlertFactoryProtocol {
    static func showAlert(with error: Error) -> UIAlertController
}

final class AlertFactory: AlertFactoryProtocol {
    static func showAlert(with error: Error) -> UIAlertController {
        let alertController = UIAlertController(
            title: "Ошибка получения данных",
                message: error.localizedDescription,
                preferredStyle: .alert
        )
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        return alertController
    }
}
