protocol CityViewModelFactory {
    func makeCityViewModels(_ cities: [City]) -> [SelectViewModel]
}
