import SwiftUI
import RealityKit
import RealityKitContent

struct FirstSetupView: View {
    @State private var step = 1

    var body: some View {
        VStack {
            switch step {
            case 1:
                StepOneView(nextStep: nextStep)
            case 2:
                StepTwoView(previousStep: previousStep, nextStep: nextStep)
            case 3:
                StepThreeView(previousStep: previousStep, finishSetup: finishSetup)
            default:
                EmptyView()
            }
        }
        .padding()
    }

    private func nextStep() {
        if step < 3 {
            step += 1
        }
    }

    private func previousStep() {
        if step > 1 {
            step -= 1
        }
    }

    private func finishSetup() {
        // Perform any necessary actions to complete setup
    }
}

struct StepOneView: View {
    var nextStep: () -> Void

    var body: some View {
        VStack {
            Text("Hey! Welcome to OnScript")
            Text("Let's Get Started.")
            Text("Step 1: Enter your name")
            // Add text fields and input fields for Step 1
            Button("Next") {
                nextStep()
            }
        }
    }
}

struct StepTwoView: View {
    var previousStep: () -> Void
    var nextStep: () -> Void

    var body: some View {
        VStack {
            Text("Secondly we need to accept some Permisssions, OnScript doesn't upload or collect data and any processing is done locally")
            // Add text fields and input fields for Step 2
            HStack {
                Button("Previous") {
                    previousStep()
                }
                Button("Next") {
                    nextStep()
                }
            }
        }
    }
}

struct StepThreeView: View {
    var previousStep: () -> Void
    var finishSetup: () -> Void

    var body: some View {
        VStack {
            Text("Step 3: Review and finish setup")
            // Add a summary of user input for review
            HStack {
                Button("Previous") {
                    previousStep()
                }
                Button("Finish") {
                    finishSetup()
                }
            }
        }
    }
}
