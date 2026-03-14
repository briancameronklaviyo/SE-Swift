import Foundation

/// Simple product model for the product list and detail views.
struct Product: Identifiable, Hashable {
    let id: UUID
    var name: String
    var price: Double
    var description: String
    var category: String

    init(id: UUID = UUID(), name: String, price: Double, description: String, category: String) {
        self.id = id
        self.name = name
        self.price = price
        self.description = description
        self.category = category
    }
}

// MARK: - Sample data
extension Product {
    static let sampleProducts: [Product] = [
        Product(name: "Wireless Earbuds", price: 49.99, description: "Noise-cancelling wireless earbuds with 24-hour battery life.", category: "Audio"),
        Product(name: "Mechanical Keyboard", price: 129.00, description: "RGB mechanical keyboard with Cherry MX switches.", category: "Accessories"),
        Product(name: "USB-C Hub", price: 34.99, description: "7-in-1 USB-C hub with HDMI, USB-A, and SD card reader.", category: "Accessories"),
        Product(name: "Standing Desk Mat", price: 39.95, description: "Ergonomic anti-fatigue mat for standing desks.", category: "Office"),
        Product(name: "Monitor Arm", price: 89.00, description: "Dual monitor arm with cable management.", category: "Office"),
        Product(name: "Webcam HD", price: 79.99, description: "1080p webcam with built-in microphone and privacy shutter.", category: "Video"),
    ]
}
