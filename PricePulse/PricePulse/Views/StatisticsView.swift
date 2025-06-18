import SwiftUI

struct StatisticsView: View {
    var body: some View {
        VStack {
            Text("Statistics")
                .font(.title)
                .padding()
            
            Text("Coming soon...")
                .foregroundColor(.secondary)
        }
        .navigationTitle("Statistics")
    }
}

#Preview {
    StatisticsView()
} 