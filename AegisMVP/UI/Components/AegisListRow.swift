import SwiftUI

struct AegisListRow: View {
    let title: String
    let subtitle: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundStyle(AegisTheme.foreground)
            if let subtitle {
                Text(subtitle)
                    .font(.body)
                    .foregroundStyle(AegisTheme.secondaryText)
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 10)
        .frame(minHeight: 60, alignment: .leading)
    }
}
