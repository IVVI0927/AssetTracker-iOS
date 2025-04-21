<file name=ContentView.swift>import SwiftUI

struct ContentView: View {
    @State private var showDeleteAlert = false
    @State private var deleteOffsets: IndexSet?
    @State private var items: [Item] = []

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
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
                .onDelete { offsets in
                    deleteOffsets = offsets
                    showDeleteAlert = true
                }
            }
            .alert(isPresented: $showDeleteAlert) {
                Alert(
                    title: Text("确认删除"),
                    message: Text("你确定要删除这个物品吗？该操作无法撤销。"),
                    primaryButton: .destructive(Text("删除")) {
                        if let offsets = deleteOffsets {
                            deleteItems(at: offsets)
                        }
                    },
                    secondaryButton: .cancel(Text("取消"))
                )
            }
            .navigationTitle("物品列表")
            .navigationBarItems(trailing: NavigationLink(destination: AddItemView(items: $items)) {
                Text("添加物品")
            })
        }
    }

    func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}
</file>
