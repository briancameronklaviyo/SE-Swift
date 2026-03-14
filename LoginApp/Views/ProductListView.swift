import SwiftUI

/// Product list: shows all products; tapping a row navigates to product detail.
struct ProductListView: View {
    let products = Product.sampleProducts

    var body: some View {
        if #available(iOS 16.0, *) {
            List(products) { product in
                NavigationLink {
                    ProductDetailView(product: product)
                } label: {
                    ProductRowView(product: product)
                }
            }
            .navigationTitle("Products")
        } else {
            // Fallback on earlier versions
            EmptyView()
        }
    }
}

/// Row representation of a product in the list.
struct ProductRowView: View {
    let product: Product

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(product.name)
                .font(.headline)
            HStack {
                Text(product.category)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Spacer()
                Text(product.price, format: .currency(code: "USD"))
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
        }
        .padding(.vertical, 2)
    }
}

#Preview {
    if #available(iOS 16.0, *) {
        NavigationStack {
            ProductListView()
        }
    } else {
        EmptyView()
    }
}
