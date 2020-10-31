final class CityViewModelFactoryImpl { }

// MARK: - GroupsViewModelFactory

extension CityViewModelFactoryImpl: CityViewModelFactory {
    func makeCityViewModels(
        _ cities: [City]
    ) -> [SelectViewModel] {
        return cities.map(makeCityViewModel)
    }
    
    private func makeCityViewModel(
        _ city: City
    ) -> SelectViewModel {
        return SelectViewModel(
            id: city.id,
            title: city.title
        )
    }
}
