import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            RecordingView()
                .tabItem {
                    Label("Record", systemImage: "waveform.badge.mic")
                }
                .tag(0)
            
            SummaryView()
                .tabItem {
                    Label("History", systemImage: "text.word.spacing")
                }
                .tag(1)
        }
    }
}

struct MainView: View {
    var body: some View {
        Text("Main View")
    }
}

struct SummaryView: View {
    var body: some View {
        Text("Summary View")
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
