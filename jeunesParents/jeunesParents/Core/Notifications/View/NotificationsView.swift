import SwiftUI

struct NotificationsView: View {
    var body: some View {
        VStack {
            Text("Notifications")
                .font(.largeTitle)
                .padding()

            // Vous pouvez ajouter ici le contenu de vos notifications
            List {
                Text("Notification 1")
                Text("Notification 2")
                Text("Notification 3")
            }
        }
    }
}

#Preview {
    NotificationsView()
}
