import UIKit

class ColorHash {
    private(set) var str: String
    private(set) var brightness: [CGFloat]
    private(set) var saturation: [CGFloat]
    private let seed2 = CGFloat(137.0)
    private let maxSafeInteger = 9007199254740991.0 / CGFloat(137.0)
    private let full = CGFloat(360.0)
    
    public init(
        _ str: String,
        _ saturation: [CGFloat] = [CGFloat(0.35), CGFloat(0.5), CGFloat(0.65)],
        _ brightness: [CGFloat] = [CGFloat(0.35), CGFloat(0.5), CGFloat(0.65)]
    ) {
        self.str = str
        self.saturation = saturation
        self.brightness = brightness
    }
    
    var bkdrHash: CGFloat {
        var hash = CGFloat(0)
        for char in "\(str)x" {
            if let scl = String(char).unicodeScalars.first?.value {
                if hash > maxSafeInteger {
                    hash = hash / seed2
                }
                hash = hash * CGFloat(131.0) + CGFloat(scl)
            }
        }
        return hash
    }
    public var HSB: (CGFloat, CGFloat, CGFloat) {
        var hash = CGFloat(bkdrHash)
        let H = hash.truncatingRemainder(dividingBy: full - 1.0) / full
        hash /= full
        let S = saturation[Int((full * hash).truncatingRemainder(dividingBy: CGFloat(saturation.count)))]
        hash /= CGFloat(saturation.count)
        let B = brightness[Int((full * hash).truncatingRemainder(dividingBy: CGFloat(brightness.count)))]
        return (H, S, B)
    }

    var color: UIColor {
        let (H, S, B) = HSB
        return UIColor(hue: H, saturation: S, brightness: B, alpha: 1.0)
    }
}
