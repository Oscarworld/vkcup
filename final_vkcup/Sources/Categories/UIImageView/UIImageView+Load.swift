import UIKit

extension UIImageView {
    func load(
        avatarUrl: String?,
        placeholder: UIImage,
        completion: @escaping ((UIImage?, String?) -> Void)
    ) {
        if image != placeholder {
            completion(placeholder, avatarUrl)
        }
        
        guard let urlString = avatarUrl,
              let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                completion(placeholder, avatarUrl)
            }
            return
        }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image, avatarUrl)
                }
            }
        }
    }
    
    func load(
        url: URL,
        completion: @escaping ((UIImage?) -> Void)
    ) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
    }
}
