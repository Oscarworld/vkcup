/// AddPromocode view input
protocol AddPromocodeViewInput: class { }

/// AddPromocode view output
protocol AddPromocodeViewOutput: class { 
	func setupView()
    
    func didHandleAddPromocode(
        title: String,
        description: String,
        value: String
    )
}
