import SwiftUI
import RealityKit
import RealityKitContent
import SwiftUI
import AVFoundation

struct RecordingView: View {
    @StateObject private var speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false
    @State private var isPaused = false
    @State private var timer: Timer?
    @State private var elapsedTime: TimeInterval = 0

    var body: some View {
        VStack {
            if isRecording {
                TimerView(elapsedTime: $elapsedTime)
                Spacer()
                HStack {
                    Button(action: {
                        // Pause/Resume recording
                        if self.isPaused {
                            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                                self.elapsedTime += 1
                            }
                        } else {
                            self.timer?.invalidate()
                        }
                        self.isPaused.toggle()
                    }) {
                        Image(systemName: isPaused ? "play" : "pause")
                            .foregroundColor(isPaused ? .green : .blue)
                            .font(.system(size: 30))
                    }
                    Button(action: {
                        // End recording
                        self.isRecording = false
                        self.timer?.invalidate()
                        self.elapsedTime = 0
                        Task {
                            await speechRecognizer.stopTranscribing()
                        }
                    }) {
                        Image(systemName: "stop")
                            .font(.system(size: 30))
                            .foregroundColor(.red)
                    }
                }
            } else {
                Button(action: {
                    // Start recording
                    self.isRecording = true
                    self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                        self.elapsedTime += 1
                    }
                    Task {
                        await speechRecognizer.startTranscribing()
                    }
                }) {
                    Image(systemName: "mic")
                        .font(.system(size: 30))
                        .foregroundColor(.blue)
                }
            }
        }
        .padding()
        .navigationTitle("Recording")
    }
}

struct TimerView: View {
    @Binding var elapsedTime: TimeInterval

    var body: some View {
        Text(timeString(from: elapsedTime))
            .font(.title)
            .padding()
    }

    private func timeString(from timeInterval: TimeInterval) -> String {
        let hours = Int(timeInterval) / 3600
        let minutes = (Int(timeInterval) % 3600) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

struct RecordingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecordingView()
        }
    }
}
