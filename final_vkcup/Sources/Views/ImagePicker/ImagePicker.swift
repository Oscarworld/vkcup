import UIKit

class ImagePicker: NSObject {

    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerDelegate?

    init(
        presentationController: UIViewController,
        delegate: ImagePickerDelegate
    ) {
        self.pickerController = UIImagePickerController()
        super.init()

        self.presentationController = presentationController
        self.delegate = delegate

        self.pickerController.delegate = self
        self.pickerController.mediaTypes = ["public.image"]
    }

    func action(
        for type: UIImagePickerController.SourceType,
        title: String
    ) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }

        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }

    func present() {
        let alertController = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )
        
        let actions = [
            action(for: .camera, title: "Сделать фото"),
            action(for: .savedPhotosAlbum, title: "Выбрать из фотоальбома"),
            action(for: .photoLibrary, title: "Выбрать из галереи"),
            UIAlertAction(title: "Отменить", style: .cancel, handler: nil),
        ].compactMap { $0 }
        
        actions.forEach {
            alertController.addAction($0)
        }

        self.presentationController?.present(alertController, animated: true)
    }

    private func pickerController(
        _ controller: UIImagePickerController,
        didSelect image: UIImage?
    ) {
        controller.dismiss(animated: true, completion: nil)
        self.delegate?.didSelect(image: image)
    }
}

extension ImagePicker: UIImagePickerControllerDelegate {
    public func imagePickerControllerDidCancel(
        _ picker: UIImagePickerController
    ) {
        self.pickerController(picker, didSelect: nil)
    }

    public func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        guard let image = info[.originalImage] as? UIImage else {
            return self.pickerController(picker, didSelect: nil)
        }
        self.pickerController(picker, didSelect: image)
    }
}

extension ImagePicker: UINavigationControllerDelegate { }
