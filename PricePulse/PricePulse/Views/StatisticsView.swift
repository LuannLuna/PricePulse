import SwiftUI
import SwiftData
import Charts

struct StatisticsView: View {
    @Query private var purchases: [PurchaseHistory]
    @State private var selectedMonth: Date = Date()
    
    private var monthlyPurchases: [PurchaseHistory] {
        purchases.filter { Calendar.current.isDate($0.date, equalTo: selectedMonth, toGranularity: .month) }
    }
    
    private var storeTotals: [(store: String, total: Double)] {
        let grouped = Dictionary(grouping: monthlyPurchases) { $0.store }
        return grouped.map { (store: $0.key, total: $0.value.reduce(0) { $0 + $1.totalPrice }) }
            .sorted { $0.total > $1.total }
    }
    
    private var monthlyTotal: Double {
        monthlyPurchases.reduce(0) { $0 + $1.totalPrice }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Month Picker
                DatePicker(
                    Strings.selectMonth.localizable,
                    selection: $selectedMonth,
                    displayedComponents: .date
                )
                .datePickerStyle(.compact)
                .padding(.horizontal)
                
                // Monthly Total Card
                VStack(alignment: .leading, spacing: 8) {
                    Text(Strings.monthlyTotal.localizable)
                        .font(.headline)
                    
                    Text(Strings.currencyFormat.localized(monthlyTotal))
                        .font(.title)
                        .bold()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(10)
                .shadow(radius: 2)
                
                // Store Totals Chart
                VStack(alignment: .leading, spacing: 12) {
                    Text(Strings.totalPerStore.localizable)
                        .font(.headline)
                    
                    Chart {
                        ForEach(storeTotals, id: \.store) { store in
                            BarMark(
                                x: .value("Store", store.store),
                                y: .value("Total", store.total)
                            )
                            .foregroundStyle(.blue.gradient)
                        }
                    }
                    .frame(height: 200)
                    .chartXAxis {
                        AxisMarks(values: .automatic) { _ in
                            AxisValueLabel()
                                .font(.caption)
                        }
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(10)
                .shadow(radius: 2)
                
                // Store Totals List
                VStack(alignment: .leading, spacing: 12) {
                    Text(Strings.storeBreakdown.localizable)
                        .font(.headline)
                    
                    ForEach(storeTotals, id: \.store) { store in
                        HStack {
                            Text(store.store)
                                .lineLimit(1)
                                .truncationMode(.tail)
                            
                            Spacer()
                            
                            Text(Strings.currencyFormat.localized(store.total))
                                .bold()
                        }
                        .padding(.vertical, 4)
                        
                        if store.store != storeTotals.last?.store {
                            Divider()
                        }
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(10)
                .shadow(radius: 2)
            }
            .padding()
        }
        .navigationTitle(Strings.statistics.localizable)
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    StatisticsView()
} 
