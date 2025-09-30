import SwiftUI

@main
struct RudimentaryApp: App {
    @StateObject private var bucketListViewModel = BucketListViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(bucketListViewModel)
        }
    }
}
