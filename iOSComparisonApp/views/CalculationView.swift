import SwiftUI
import BigInt

// Dodavanje ovde
@inlinable
func calculate(_ n: Int) -> Double {
    var temp = 0.0
    
    // Unaprijed izračunajte sve vrijednosti
    let valueToAdd = 2.0
    let divisor = 4.0
    let multiplier = 2.0
    
    for _ in 0..<n {
        temp += valueToAdd
        temp /= divisor
        temp *= multiplier
    }

    return temp
}


struct CalculationView: View {
    let intensity: Int
    @State private var currentNumber: Double? = nil
    @State private var calculating = false
    @State private var elapsed: UInt64 = 0

    // Uklonjeni ovdje
    // func calculate(_ n: Int) -> Double { ... }

    func startCalculation() {
        calculating = true

        let startTime = DispatchTime.now()
        let result = calculate(self.intensity) // Izračunavanje je sada izvan SwiftUI-a
        let endTime = DispatchTime.now()
        elapsed = (endTime.uptimeNanoseconds - startTime.uptimeNanoseconds) / 1000
        self.currentNumber = result
        self.calculating = false
            
    }

    var body: some View {
        VStack(spacing: 16) {
            Text("Rezultat:")
                .font(.system(size: 22, weight: .medium))

            if calculating {
                ProgressView()
            } else {
                Text("Trajanje: \(elapsed) µs")
                    .font(.system(size: 14, weight: .bold))
            }

            if let currentNumber = currentNumber {
                Text("Izvedeno \(intensity) operacija zbrajanja, dijeljenja i množenja.")
                    .font(.system(size: 20))
            } else {
                Text("-")
                    .font(.system(size: 20))
                    .opacity(0.5)
            }

            Button(action: startCalculation) {
                Text("Pokreni zadatak")
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .navigationBarTitle("Kalkulacija", displayMode: .inline)
    }
}

struct CalculationScreen_Previews: PreviewProvider {
    static var previews: some View {
        CalculationView(intensity: 1)
    }
}
