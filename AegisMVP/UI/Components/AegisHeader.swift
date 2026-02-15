import SwiftUI

struct AegisHeader: View {
    let title: String
    let subtitle: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.largeTitle.weight(.bold))
                .foregroundStyle(AegisTheme.foreground)
            if let subtitle {
                Text(subtitle)
                    .font(.body)
                    .foregroundStyle(AegisTheme.secondaryText)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
