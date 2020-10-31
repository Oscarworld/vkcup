/// QRCodeScan view input
protocol QRCodeScanViewInput: class { }

/// QRCodeScan view output
protocol QRCodeScanViewOutput: class { 
	func setupView()
    
    func didScanQRCode(
        url: String?
    )
}
