import SwiftUI

struct ScalabilityView: View {
    let intensity: Int

    private func buildInterfaceElements() -> [AnyView] {
        var elements: [AnyView] = []

        for i in 0..<intensity {
            if i % 4 == 0 {
                elements.append(
                    AnyView(
                        Button(action: {}) {
                            Text("Gumb \(i)")
                                .padding(.horizontal, 12)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(5)
                        }
                        .padding(4)
                    )
                )
            } else if i % 4 == 1 {
                elements.append(
                    AnyView(
                        Image(systemName: "plus")
                            .padding(4)
                    )
                )
            } else if i % 4 == 2 {
                elements.append(
                    AnyView(
                        Text("Oznaka \(i)")
                            .padding(4)
                    )
                )
            } else {
                elements.append(
                    AnyView(
                        TextField("Mali \(i)", text: .constant(""))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 100)
                            .padding(4)
                    )
                )
            }
        }

        return elements
    }

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(0..<buildInterfaceElements().count, id: \.self) { index in
                        buildInterfaceElements()[index]
                    }
                }
                .padding()
            }
            .navigationTitle("Skalabilnost korisničkog sučelja")
        }
    }
}

struct ScalabilityScreen_Previews: PreviewProvider {
    static var previews: some View {
        ScalabilityView(intensity: 10)
    }
}
