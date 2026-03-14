import SwiftUI

/// Product detail: shows a single product's full information.
struct ProductDetailView: View {
    let product: Product

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(product.category)
                    .font(.caption)
                    .textCase(.uppercase)
                    .foregroundStyle(.secondary)

                Text(product.name)
                    .font(.title)
                    .fontWeight(.bold)

                Text(product.price, format: .currency(code: "USD"))
                    .font(.title2)
                    .foregroundStyle(Color.accentColor)

                Divider()

                Text("Description")
                    .font(.headline)
                Text(product.description)
                    .font(.body)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .navigationTitle(product.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    if #available(iOS 16.0, *) {
        NavigationStack {
            ProductDetailView(product: Product.sampleProducts[0])
        }
    } else {
        EmptyView()
    }
}
