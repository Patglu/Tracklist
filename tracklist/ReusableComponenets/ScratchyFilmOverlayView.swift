import SwiftUI
import CoreImage
import SpriteKit
import GameplayKit
import CoreImage.CIFilterBuiltins

struct ScratchyFilmOverlayView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        
        // Assuming you have a method to create the scratchy film effect
        let filteredImage = createScratchyFilmEffect()
        let imageView = UIImageView(image: filteredImage)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = view.bounds
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(imageView)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // Update the view if necessary
    }
    
    private func createScratchyFilmEffect() -> UIImage? {
        // Create and configure your CIFilters to simulate the scratchy film effect,
        // then return the resulting UIImage. This is a placeholder for your actual implementation.
        return UIImage(named: "yourPlaceholderImage")
    }
}

//struct FilmGrainOverlay: UIViewRepresentable {
//  func makeUIView(context: Context) -> some UIView {
//    let imageView = UIImageView(frame: .zero)
//    
//    // Create a noise map with desired characteristics
//    let noiseMap = GKNoiseMap(fractalPerlin: GKPerlinNoiseSource(frequency: 0.05, lacunarity: 2.0, persistence: 0.5))
//    
//    // Convert noise map to image data
//    let imageData = noiseMap.textureWithNoiseMap(size: CGSize(width: 100, height: 100), colorMap: .grayscale)
//    
//    // Set image and properties
//    imageView.image = UIImage(data: imageData!)
//    imageView.alpha = 0.1
//    imageView.blendMode = .multiply
//    
//    return imageView
//  }
//
//  func updateUIView(_ uiView: some UIView, context: Context) {
//    // Update properties as needed
//  }
//}


