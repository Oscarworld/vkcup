enum QuestGiftType {
    case money(SelectViewModel, String)
    case product(BriefProductViewModel)
    case promocode(PromocodeViewModel)
}

struct QuestGift {
    var id: String
    var type: QuestGiftType
    var count: Int
    var available: Int
    
    var photoUrl: String? {
        switch type {
        case .product(let productView):
            return productView.avatarUrl
        default:
            return nil
        }
    }
    
    var photo: UIImage? {
        switch type {
        case .promocode:
            return UIImage.Styles.promocodeOutline
        case .money:
            return UIImage.Styles.moneyOutline
        default:
            return nil
        }
    }
    
    var title: String {
        switch type {
        case .product(let productViewModel):
            return productViewModel.title
        case .promocode(let promocodeViewModel):
            return promocodeViewModel.title
        case .money(let moneyViewModel, _):
            return moneyViewModel.title
        }
    }
    
    var description: String {
        switch type {
        case .product(let productViewModel):
            return productViewModel.description
        case .promocode(let promocodeViewModel):
            return promocodeViewModel.description
        case .money(_, let value):
            return value
        }
    }
}
