import SwiftUI

struct AegisButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundStyle(AegisTheme.foreground)
                .frame(maxWidth: .infinity, minHeight: 60)
                .padding(.horizontal, 12)
                .background(AegisTheme.accent)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .buttonStyle(.plain)
    }
}
