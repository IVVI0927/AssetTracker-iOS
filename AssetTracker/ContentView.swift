import SwiftUI

struct ContentView: View {
    @State private var items: [Item] = []
    @State private var showAddView = false

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("总资产")
                            .font(.caption)
                        Text("¥\(totalValue, specifier: "%.2f")")
                            .font(.title2)
                            .bold()
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("日均成本")
                            .font(.caption)
                        Text("¥\(averageDailyCost, specifier: "%.2f")/天")
                            .font(.title2)
                            .bold()
                    }
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)
                .padding()

                List(items) { item in
                    VStack(alignment: .leading) {
                        Text(item.name).font(.headline)
                        Text("¥\(item.price, specifier: "%.0f")  ¥\(item.dailyCost, specifier: "%.2f")/天")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("\(item.daysUsed) 天")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                    .padding(.vertical, 5)
                }

                Button(action: {
                    showAddView = true
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("添加物品")
                    }
                    .font(.headline)
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(10)
                }
                .padding()
                .sheet(isPresented: $showAddView) {
                    AddItemView(items: $items)
                }
            }
            .navigationTitle("归物本")
        }
    }

    var totalValue: Double {
        items.map { $0.price }.reduce(0, +)
    }

    var averageDailyCost: Double {
        guard !items.isEmpty else { return 0 }
        let total = items.map { $0.dailyCost }.reduce(0, +)
        return total / Double(items.count)
    }
}
