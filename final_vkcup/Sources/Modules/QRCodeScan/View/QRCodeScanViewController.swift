import UIKit
import AVFoundation

final class QRCodeScanViewController: UIViewController {

    // MARK: - VIPER

    var output: QRCodeScanViewOutput!

    // MARK: - Data
    
    private var qrCodeUrl: String?
    
    private var captureSession = AVCaptureSession()
    
    private lazy var videoPreviewLayer: AVCaptureVideoPreviewLayer? = {
        let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        return videoPreviewLayer
    }()

    // MARK: - Initializing

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - UI properties
    
    private lazy var qrCodeFrameView: UIView = {
        $0.layer.borderColor = UIColor.Styles.yellow.cgColor
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 4
        return $0
    }(UIView())
    
    private lazy var submitButton: UIButton = {
        let attributedString = NSAttributedString(
            string: "Сканировать",
            attributes: [
                .font: UIFont.Styles.title2,
                .foregroundColor: UIColor.Styles.white
            ]
        )
        $0.setAttributedTitle(attributedString, for: .normal)
        $0.addTarget(self, action: #selector(didPressSubmitButton), for: .touchUpInside)
        $0.backgroundColor = UIColor.Styles.primary
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        return $0
    }(UIButton())

    // MARK: - Managing the View

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor.Styles.white
        setupView()
        setupConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.setupView()
        var deviceType: [AVCaptureDevice.DeviceType] = [
            .builtInWideAngleCamera,
            .builtInTelephotoCamera,
        ]
        if #available(iOS 10.2, *) {
            deviceType.append(.builtInDualCamera)
        }
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(
            deviceTypes: deviceType,
            mediaType: AVMediaType.video,
            position: .back
        )

        guard let captureDevice = deviceDiscoverySession.devices.first else {
            print("Failed to get the camera device")
            return
        }

        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(input)

            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
        
        if let videoPreviewLayer = videoPreviewLayer {
            view.layer.addSublayer(videoPreviewLayer)
        }
        view.addSubview(qrCodeFrameView)
        view.bringSubviewToFront(submitButton)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        captureSession.startRunning()
        videoPreviewLayer?.frame = view.layer.bounds
    }

    // MARK: - Setup

    private func setup() { }

    private func setupView() {
        [
            submitButton,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }

    private func setupConstraints() {
        let viewBottomAnchor: NSLayoutYAxisAnchor
        if #available(iOS 11, *) {
            viewBottomAnchor = view.safeAreaLayoutGuide.bottomAnchor
        } else {
            viewBottomAnchor = bottomLayoutGuide.topAnchor
        }
        let constraints = [
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            submitButton.bottomAnchor.constraint(equalTo: viewBottomAnchor, constant: -12),
            submitButton.heightAnchor.constraint(equalToConstant: 44),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Action
    
    @objc
    private func didPressSubmitButton() {
        captureSession.stopRunning()
        output.didScanQRCode(url: qrCodeUrl)
    }
}

// MARK: - QRCodeScanViewInput

extension QRCodeScanViewController: QRCodeScanViewInput {
    
}

// MARK: - QRCodeScanTransitionHandler

extension QRCodeScanViewController: QRCodeScanTransitionHandler { }

extension QRCodeScanViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(
        _ output: AVCaptureMetadataOutput,
        didOutput metadataObjects: [AVMetadataObject],
        from connection: AVCaptureConnection
    ) {
        if metadataObjects.count == 0 {
            qrCodeFrameView.frame = CGRect.zero
            return
        }

        if let metadataObj = metadataObjects[0] as? AVMetadataMachineReadableCodeObject,
           metadataObj.type == AVMetadataObject.ObjectType.qr,
           let bounds = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)?.bounds {
            qrCodeFrameView.frame = bounds

            if let url = metadataObj.stringValue {
                self.qrCodeUrl = url
            }
        }
    }
}

// MARK: - Localization

private extension QRCodeScanViewController {
    enum Localized {
        // swiftlint:disable line_length
        // swiftlint:enable line_length
    }
}

// MARK: - Constants

private extension QRCodeScanViewController {
    enum Constants { }
}
