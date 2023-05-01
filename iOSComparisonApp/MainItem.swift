import SwiftUI
import UIKit

struct MainItem: View {
    let title: String
    let onStart: (Int) -> Void
    let showIntensitySlider: Bool
    @Binding var intensity: Double
    
    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 20, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 8)
            
            if showIntensitySlider {
                HStack {
                    Text("Intenzitet")
                    Spacer()
                    Slider(value: $intensity, in: 1...5, step: 1, onEditingChanged: { _ in
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    })
                    Spacer()
                    Text("\(Int(intensity))")
                }
            }
            
            Spacer(minLength: 16)
            
            Button(action: {
                onStart(Int(intensity))
            }) {
                Text("Pokreni")
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding()
        .background(Color(.systemGroupedBackground))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

