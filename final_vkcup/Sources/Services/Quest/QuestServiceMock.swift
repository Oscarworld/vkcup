enum QuestRequestType {
    case all
    case personal
}

final class QuestServiceMock {
    
}

// MARK: - QuestService

extension QuestServiceMock: QuestService {
    func cancelAllOperations() { }
    
    func getQuests(
        requestType: QuestRequestType,
        lat: Double,
        lon: Double,
        completion: @escaping (Result<[Quest], ServiceError>) -> Void
    ) {
        let quests: [Quest]
        switch requestType {
        case .personal:
            quests = [
                personalQuest1,
                personalQuest2,
                personalQuest3,
            ]
        case .all:
            quests = [
                personalQuest1,
                personalQuest2,
                personalQuest3,
                privateQuest1,
                privateQuest2,
                privateQuest3,
                privateQuest4,
                quest1,
                quest2,
            ]
        }
        completion(.success(quests))
    }
}

private let personalQuest1 = Quest(
    id: "1",
    type: .personal,
    owner: "Алексей Иванов",
    title: "Квест на День рождение",
    description: "С Днём рождения дружище! Найди эти деревья и отправь их геолокацию",
    gifts: [
        QuestGift(
            id: "1",
            type: .product(
                BriefProductViewModel(
                    id: 1,
                    ownerId: 1,
                    title: "iPhone 12 Pro",
                    subtitle: "Новый iPhone от компании Apple",
                    description: "Новый iPhone от компании Apple",
                    avatarUrl: "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/iphone-12-pro-family-hero?wid=926&amp;hei=1112&amp;fmt=jpeg&amp;qlt=80&amp;op_usm=0.5,0.5&amp;.v=1602088412000",
                    isFavorite: false
                )
            ),
            count: 1,
            available: 1
        ),
    ],
    steps: [
        QuestStep(
            id: "1",
            type: .location,
            title: "Задание в Сосновке",
            description: "Найди дерево в парке Сосновка",
            photo: "https://media-cdn.tripadvisor.com/media/photo-s/0b/11/21/b2/caption.jpg",
            lat: 60.022343,
            lon: 30.350665,
            availableType: .available
        ),
    ],
    accessIds: [
        "1",
    ]
)

private let personalQuest2 = Quest(
    id: "1",
    type: .personal,
    owner: "Денис Колмыков",
    title: "Корпоративный квест",
    description: "Поздравляю! У тебя 2 года стажа!",
    gifts: [
        QuestGift(
            id: "1",
            type: .product(
                BriefProductViewModel(
                    id: 1,
                    ownerId: 1,
                    title: "iPhone 12 Pro",
                    subtitle: "Новый iPhone от компании Apple",
                    description: "Новый iPhone от компании Apple",
                    avatarUrl: "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/iphone-12-pro-family-hero?wid=926&amp;hei=1112&amp;fmt=jpeg&amp;qlt=80&amp;op_usm=0.5,0.5&amp;.v=1602088412000",
                    isFavorite: false
                )
            ),
            count: 1,
            available: 1
        ),
    ],
    steps: [
        QuestStep(
            id: "1",
            type: .location,
            title: "Задание в Сосновке",
            description: "Найди дерево в парке Сосновка",
            photo: "https://images.unsplash.com/photo-1571850566965-dc36cae1dd44?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=975&q=80",
            lat: 59.938933,
            lon: 30.315540,
            availableType: .available
        ),
    ],
    accessIds: [
        "1",
    ]
)

private let personalQuest3 = Quest(
    id: "1",
    type: .personal,
    owner: "Денис Колмыков",
    title: "Корпоративный квест",
    description: "Поздравляю! У тебя 2 года стажа!",
    gifts: [
        QuestGift(
            id: "1",
            type: .product(
                BriefProductViewModel(
                    id: 1,
                    ownerId: 1,
                    title: "Apple 13.3 MacBook Air with Retina Display",
                    subtitle: "Новый MacBook от компании Apple",
                    description: "Новый MacBook от компании Apple",
                    avatarUrl: "https://images.unsplash.com/photo-1590784776259-682d0042347f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=985&q=80",
                    isFavorite: false
                )
            ),
            count: 1,
            available: 1
        ),
    ],
    steps: [
        QuestStep(
            id: "1",
            type: .location,
            title: "Задание в Сосновке",
            description: "Найди дерево в парке Сосновка",
            photo: "https://images.unsplash.com/photo-1590784776259-682d0042347f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=985&q=80",
            lat: 59.934158,
            lon: 30.306293,
            availableType: .available
        ),
    ],
    accessIds: [
        "1",
    ]
)

private let privateQuest1 = Quest(
    id: "1",
    type: .sponsor(.onlyForMembers),
    owner: "Денис Колмыков",
    title: "Розыгрыш призов",
    description: "Этот квест доступен только для подписчиков Дениса Колмыкова",
    gifts: [
        QuestGift(
            id: "1",
            type: .product(
                BriefProductViewModel(
                    id: 1,
                    ownerId: 1,
                    title: "Apple 13.3 MacBook Air with Retina Display",
                    subtitle: "Новый MacBook от компании Apple",
                    description: "Новый MacBook от компании Apple",
                    avatarUrl: "https://images.unsplash.com/photo-1590784776259-682d0042347f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=985&q=80",
                    isFavorite: false
                )
            ),
            count: 5,
            available: 5
        ),
    ],
    steps: [
        QuestStep(
            id: "1",
            type: .location,
            title: "Задание в Сосновке",
            description: "Найди дерево в парке Сосновка",
            photo: "https://images.unsplash.com/photo-1590784776259-682d0042347f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=985&q=80",
            lat: 59.978514,
            lon: 30.293144,
            availableType: .available
        ),
    ],
    accessIds: [
        "1",
    ]
)

private let privateQuest2 = Quest(
    id: "1",
    type: .sponsor(.onlyForMembers),
    owner: "NVIDIA",
    title: "Розыгрыш RTX 3080",
    description: "Этот квест доступен только для подписчиков сообщества NVIDIA",
    gifts: [
        QuestGift(
            id: "1",
            type: .product(
                BriefProductViewModel(
                    id: 1,
                    ownerId: 1,
                    title: "Apple 13.3 MacBook Air with Retina Display",
                    subtitle: "Новый MacBook от компании Apple",
                    description: "Новый MacBook от компании Apple",
                    avatarUrl: "https://images.unsplash.com/photo-1590784776259-682d0042347f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=985&q=80",
                    isFavorite: false
                )
            ),
            count: 10,
            available: 10
        ),
    ],
    steps: [
        QuestStep(
            id: "1",
            type: .location,
            title: "Задание в Сосновке",
            description: "Найди дерево в парке Сосновка",
            photo: "https://images.unsplash.com/photo-1590784776259-682d0042347f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=985&q=80",
            lat: 59.972431,
            lon: 30.230653,
            availableType: .available
        ),
    ],
    accessIds: [
        "1",
    ]
)
private let privateQuest3 = Quest(
    id: "1",
    type: .sponsor(.onlyForMembers),
    owner: "Денис Колмыков",
    title: "Корпоративный квест",
    description: "Поздравляю! У тебя 2 года стажа!",
    gifts: [
        QuestGift(
            id: "1",
            type: .product(
                BriefProductViewModel(
                    id: 1,
                    ownerId: 1,
                    title: "Apple 13.3 MacBook Air with Retina Display",
                    subtitle: "Новый MacBook от компании Apple",
                    description: "Новый MacBook от компании Apple",
                    avatarUrl: "https://images.unsplash.com/photo-1590784776259-682d0042347f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=985&q=80",
                    isFavorite: false
                )
            ),
            count: 1,
            available: 1
        ),
    ],
    steps: [
        QuestStep(
            id: "1",
            type: .location,
            title: "Задание в Сосновке",
            description: "Найди дерево в парке Сосновка",
            photo: "https://images.unsplash.com/photo-1590784776259-682d0042347f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=985&q=80",
            lat: 59.924681,
            lon: 30.317517,
            availableType: .available
        ),
    ],
    accessIds: [
        "1",
    ]
)

private let privateQuest4 = Quest(
    id: "1",
    type: .sponsor(.onlyForMembers),
    owner: "Денис Колмыков",
    title: "Корпоративный квест",
    description: "Поздравляю! У тебя 2 года стажа!",
    gifts: [
        QuestGift(
            id: "1",
            type: .product(
                BriefProductViewModel(
                    id: 1,
                    ownerId: 1,
                    title: "Apple 13.3 MacBook Air with Retina Display",
                    subtitle: "Новый MacBook от компании Apple",
                    description: "Новый MacBook от компании Apple",
                    avatarUrl: "https://images.unsplash.com/photo-1590784776259-682d0042347f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=985&q=80",
                    isFavorite: false
                )
            ),
            count: 1,
            available: 1
        ),
    ],
    steps: [
        QuestStep(
            id: "1",
            type: .location,
            title: "Задание в Сосновке",
            description: "Найди дерево в парке Сосновка",
            photo: "https://images.unsplash.com/photo-1590784776259-682d0042347f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=985&q=80",
            lat: 59.952340,
            lon: 30.390669,
            availableType: .available
        ),
    ],
    accessIds: [
        "1",
    ]
)

private let quest1 = Quest(
    id: "1",
    type: .quest,
    owner: "Mail.ru Group",
    title: "Квест от Вконтакте",
    description: "Выполните все задания и выиграйт суперприз",
    gifts: [
        QuestGift(
            id: "1",
            type: .product(
                BriefProductViewModel(
                    id: 1,
                    ownerId: 1,
                    title: "Apple 16 MacBook Pro",
                    subtitle: "Новый MacBook Pro от компании Apple",
                    description: "MacBook Pro на 16 дюймов и процессором i9",
                    avatarUrl: "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/mbp16touch-space-select-201911_GEO_RU?wid=892&hei=820&&qlt=80&.v=1572654989311",
                    isFavorite: false
                )
            ),
            count: 1,
            available: 0
        ),
        QuestGift(
            id: "2",
            type: .product(
                BriefProductViewModel(
                    id: 2,
                    ownerId: 1,
                    title: "iPhone 12 Pro",
                    subtitle: "Новый iPhone от компании Apple",
                    description: "iPhone 12 Pro 256GB",
                    avatarUrl: "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/iphone-12-pro-family-hero?wid=926&amp;hei=1112&amp;fmt=jpeg&amp;qlt=80&amp;op_usm=0.5,0.5&amp;.v=1602088412000",
                    isFavorite: false
                )
            ),
            count: 5,
            available: 3
        ),
        QuestGift(
            id: "3",
            type: .money(
                SelectViewModel(
                    id: 0,
                    title: "Деньги"
                ),
                "10000 ₽"
            ),
            count: 10,
            available: 10
        ),
        QuestGift(
            id: "4",
            type: .promocode(
                PromocodeViewModel(
                    id: 0,
                    title: "Промокод на Такси",
                    description: "-50% на 10 поездок",
                    value: ""
                )
            ),
            count: 10,
            available: 10
        ),
    ],
    steps: [
        QuestStep(
            id: "1",
            type: .location,
            title: "Найти Дом Книги",
            description: "Отыщите Дом Книги и пришлите геолокацию (или отметьте на карте)",
            photo: "https://varlamov.me/2016/vk_of/29.jpg",
            lat: 59.935616,
            lon: 30.325930,
            availableType: .available
        ),
        QuestStep(
            id: "2",
            type: .qr,
            title: "В кафе Зингеръ отыщите QR-код",
            description: "На одном из окон кафе Зингеръ вывешен распечатаный QR-код - отсканируйте его для прохождения задания",
            photo: "https://rogaine-spb.ru/wp-content/uploads/2019/06/Kafe_zinger_spb_-_prekrasnyy_vid_na_kazanskiy_sobor_1-4.jpg",
            lat: 59.935673,
            lon: 30.325844,
            availableType: .locked
        ),
        QuestStep(
            id: "3",
            type: .question((question: "У какой IT компании штаб квартира в Доме Зингера?", answer: "вконтакте")),
            title: "Ответьте на вопрос, чтобы получить заветный приз!",
            description: "У какой IT компании штаб квартира в Доме Зингера?",
            photo: "https://cdn.the-village.ru/the-village.ru/post_image-image/VKMXmYaV9cp0bbhx8OGmgA-wide.jpg",
            lat: 59.935673,
            lon: 30.325844,
            availableType: .locked
        ),
    ],
    accessIds: [
        "1",
    ]
)

private let quest2 = Quest(
    id: "2",
    type: .quest,
    owner: "Бегущий город",
    title: "Квест от Бегущего города",
    description: "Выполните все задания и выиграйте суперприз",
    gifts: [
        QuestGift(
            id: "1",
            type: .product(
                BriefProductViewModel(
                    id: 1,
                    ownerId: 1,
                    title: "Apple 16 MacBook Pro",
                    subtitle: "Новый MacBook Pro от компании Apple",
                    description: "MacBook Pro на 16 дюймов и процессором i9",
                    avatarUrl: "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/mbp16touch-space-select-201911_GEO_RU?wid=892&hei=820&&qlt=80&.v=1572654989311",
                    isFavorite: false
                )
            ),
            count: 1,
            available: 0
        ),
        QuestGift(
            id: "2",
            type: .product(
                BriefProductViewModel(
                    id: 2,
                    ownerId: 1,
                    title: "iPhone 12 Pro",
                    subtitle: "Новый iPhone от компании Apple",
                    description: "iPhone 12 Pro 256GB",
                    avatarUrl: "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/iphone-12-pro-family-hero?wid=926&amp;hei=1112&amp;fmt=jpeg&amp;qlt=80&amp;op_usm=0.5,0.5&amp;.v=1602088412000",
                    isFavorite: false
                )
            ),
            count: 5,
            available: 3
        ),
        QuestGift(
            id: "3",
            type: .money(
                SelectViewModel(
                    id: 0,
                    title: "Деньги"
                ),
                "10000 ₽"
            ),
            count: 10,
            available: 10
        ),
        QuestGift(
            id: "4",
            type: .promocode(
                PromocodeViewModel(
                    id: 0,
                    title: "Промокод на Такси",
                    description: "-50% на 10 поездок",
                    value: ""
                )
            ),
            count: 10,
            available: 10
        ),
    ],
    steps: [
        QuestStep(
            id: "1",
            type: .location,
            title: "Найти Дом Книги",
            description: "Отыщите Дом Книги и пришлите геолокацию (или отметьте на карте)",
            photo: "https://sun9-50.userapi.com/tNoyunZy_5YjT6Q9Yfsd7sg5g_d41hWSO5Vttg/XSvhEy6-OFM.jpg?ava=1",
            lat: 59.965690,
            lon: 30.312336,
            availableType: .available
        ),
        QuestStep(
            id: "2",
            type: .qr,
            title: "В кафе Зингеръ отыщите QR-код",
            description: "На одном из окон кафе Зингеръ вывешен распечатаный QR-код - отсканируйте его для прохождения задания",
            photo: "https://rogaine-spb.ru/wp-content/uploads/2019/06/Kafe_zinger_spb_-_prekrasnyy_vid_na_kazanskiy_sobor_1-4.jpg",
            lat: 59.935673,
            lon: 30.325844,
            availableType: .locked
        ),
        QuestStep(
            id: "3",
            type: .question((question: "У какой IT компании штаб квартира в Доме Зингера?", answer: "вконтакте")),
            title: "Ответьте на вопрос, чтобы получить заветный приз!",
            description: "У какой IT компании штаб квартира в Доме Зингера?",
            photo: "https://cdn.the-village.ru/the-village.ru/post_image-image/VKMXmYaV9cp0bbhx8OGmgA-wide.jpg",
            lat: 59.935673,
            lon: 30.325844,
            availableType: .locked
        ),
    ],
    accessIds: [
        "1",
    ]
)
