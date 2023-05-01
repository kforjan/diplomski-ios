import SwiftUI

struct MainView: View {
    @State private var sliderValueScalability: Double = 1
    @State private var sliderValueAnimation: Double = 1
    @State private var sliderValueCalculation: Double = 1
    @State private var sliderValueDatabase: Double = 1
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        MainItem(title: "Skalabilnost korisničkog sučelja", onStart: { intensity in
                            let contentView = ScalabilityView(intensity: Int(pow(7, sliderValueScalability  )))
                            let hostingController = UIHostingController(rootView: contentView)
                            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                                windowScene.windows.first?.rootViewController?.present(hostingController, animated: true, completion: nil)
                            }
                        }, showIntensitySlider: true, intensity: $sliderValueScalability)
                        .frame(width: max(geometry.size.width - 24, 0))
                        
                        MainItem(title: "Animacija", onStart: { intensity in
                            let contentView = AnimationView(intensity:(10 - Int(sliderValueAnimation)) * Int(pow(3, sliderValueAnimation + 2)))
                            let hostingController = UIHostingController(rootView: contentView)
                            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                                windowScene.windows.first?.rootViewController?.present(hostingController, animated: true, completion: nil)
                            }
                        }, showIntensitySlider: true, intensity: $sliderValueAnimation)
                        .frame(width: max(geometry.size.width - 24, 0))
                        
                        MainItem(title: "Računanje - CPU opterečenje", onStart: { intensity in
                            let contentView = CalculationView(intensity: Int(pow(10, sliderValueCalculation)*10000))
                            let hostingController = UIHostingController(rootView: contentView)
                            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                                windowScene.windows.first?.rootViewController?.present(hostingController, animated: true, completion: nil)
                            }
                        }, showIntensitySlider: true, intensity: $sliderValueCalculation)
                        .frame(width: max(geometry.size.width - 24, 0))
                        
                        MainItem(title: "SQLite baza podataka", onStart: { intensity in
                            let contentView = DatabaseView(numberOfUsers: Int(pow(10, sliderValueDatabase - 1)))
                            let hostingController = UIHostingController(rootView: contentView)
                            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                                windowScene.windows.first?.rootViewController?.present(hostingController, animated: true, completion: nil)
                            }
                        }, showIntensitySlider: true, intensity: $sliderValueDatabase
                        )
                        .frame(width: max(geometry.size.width - 24, 0))
                        
                        MainItem(title: "Rad s nativnim značajkama", onStart: { _ in
                            let contentView = NativeFeaturesView()
                            let hostingController = UIHostingController(rootView: contentView)
                            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                                windowScene.windows.first?.rootViewController?.present(hostingController, animated: true, completion: nil)
                            }

                        }, showIntensitySlider: false, intensity: .constant(1))
                        .frame(width: max(geometry.size.width - 24, 0))
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Usporedba Flutter i nativnih performansi", displayMode: .inline)
        }
    }
    
    struct MainScreen_Previews: PreviewProvider {
        static var previews: some View {
            MainView()
        }
    }
}
