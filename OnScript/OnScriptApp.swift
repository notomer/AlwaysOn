import SwiftUI

@main
struct OnScriptApp: App {
    @AppStorage("hasCompletedSetup") var hasCompletedSetup = false
    
    var body: some Scene {
        WindowGroup {
            if hasCompletedSetup {
                ContentView()
            } else {
                FirstSetupView()
            }
        }
    }
}
