import SwiftUI
import SwiftData
import Charts

struct StatisticsView: View {
    @Query private var purchaseItems: [PurchaseItem]
    @State private var selectedMonth: Date = Date()
    
    private var months: [Int] { Array(1...12) }
    private var years: [Int] {
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date())
        return Array((currentYear-10)...currentYear)
    }
    private var selectedMonthComponent: Int {
        Calendar.current.component(.month, from: selectedMonth)
    }
    private var selectedYearComponent: Int {
        Calendar.current.component(.year, from: selectedMonth)
    }
    
    private var monthlyPurchases: [PurchaseItem] {
        purchaseItems.filter { Calendar.current.isDate($0.purchase.date, equalTo: selectedMonth, toGranularity: .month) }
    }
    
    private var storeTotals: [(store: String, total: Double)] {
        let grouped = Dictionary(grouping: monthlyPurchases) { $0.purchase.supermarket.name }
        return grouped.map { (store: $0.key, total: $0.value.reduce(0) { $0 + $1.total }) }
            .sorted { $0.total > $1.total }
    }
    
    private var monthlyTotal: Double {
        monthlyPurchases.reduce(0) { $0 + $1.total }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Month and Year Pickers
                HStack {
                    Picker(Strings.month.localizable, selection: Binding(
                        get: { selectedMonthComponent },
                        set: { newMonth in
                            if let newDate = Calendar.current.date(from: DateComponents(year: selectedYearComponent, month: newMonth)) {
                                selectedMonth = newDate
                            }
                        })
                    ) {
                        ForEach(months, id: \.self) { month in
                            Text(DateFormatter().monthSymbols[month - 1]).tag(month)
                        }
                    }
                    .pickerStyle(.menu)

                    Picker(Strings.year.localizable, selection: Binding(
                        get: { selectedYearComponent },
                        set: { newYear in
                            if let newDate = Calendar.current.date(from: DateComponents(year: newYear, month: selectedMonthComponent)) {
                                selectedMonth = newDate
                            }
                        })
                    ) {
                        ForEach(years, id: \.self) { year in
                            Text(year.description).tag(year)
                        }
                    }
                    .pickerStyle(.menu)
                }
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
                                x: .value(Strings.store.localizable, store.store),
                                y: .value(Strings.total.localizable, store.total)
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
        .modelContainer(Previews.modelContainer)
        .onAppear(perform: loadCSV)
}
