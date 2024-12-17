//
//  Store.swift
//  HP Trivia
//
//  Created by Lorusso, Michele on 17/12/24.
//

import StoreKit
import SwiftUI

enum BookStatus {
    case active
    case inactive
    case locked
}

@MainActor
class Store: ObservableObject {
    @Published var books: [BookStatus] = [
        .active, .active, .inactive, .locked, .locked, .locked, .locked,
    ]

    @Published var products: [Product] = []

    private var productIDs = ["hp4", "hp5", "hp6", "hp7"]

    @Published var purchasedProductIDs = Set<String>()

    private var updates: Task<Void, Never>? = nil

    init() {
        Task {
            await loadProducts()
        }
        updates = watchForUpdates()
    }

    func loadProducts() async {
        do {
            products = try await Product.products(for: productIDs)
            products.sort { $0.displayName < $1.displayName }
        } catch {
            print("Couldn't fetch those products: \(error)")
        }
    }

    func purchaseProduct(_ product: Product) async {
        do {
            let result = try await product.purchase()
            switch result {
            case .success(let verification):
                switch verification {
                case .verified(let transaction):
                    purchasedProductIDs.insert(transaction.productID)
                case .unverified(_, let error):
                    print(
                        "Purchase verification failed: \(error.localizedDescription)"
                    )
                }
            case .pending:
                print("Purchase is pending.")
            case .userCancelled:
                print("Purchase was cancelled by the user.")
            @unknown default:
                print("Unknown purchase result.")
            }
        } catch {
            print("Purchase failed: \(error.localizedDescription)")
        }
    }

    private func checkPurchased() async {
        for product in products {
            guard let state = await product.currentEntitlement else { continue }

            switch state {
            case .unverified(let transaction, let verificationError):
                print(
                    "Error on \(transaction): \(verificationError.localizedDescription)"
                )

            case .verified(let transaction):
                if transaction.revocationDate == nil {
                    purchasedProductIDs.insert(transaction.productID)
                } else {
                    purchasedProductIDs.remove(transaction.productID)
                }
            }
        }
    }

    private func watchForUpdates() -> Task<Void, Never> {
        Task(priority: .background) {
            for await _ in Transaction.updates {
                await checkPurchased()
            }
        }
    }

}
