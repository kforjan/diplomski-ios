import SwiftUI
import CoreLocation
import UIKit

struct NativeFeaturesView: View {
    @State private var isCameraPresented = false
    @StateObject private var locationManager = CLLocationManagerWrapper()

    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    locationManager.requestLocation()
                }) {
                    Text("Pokreni GPS")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()

                Button(action: {
                    isCameraPresented = true
                }) {
                    Text("Pokreni kameru")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
                .sheet(isPresented: $isCameraPresented) {
                    CameraView(isPresented: $isCameraPresented)
                }
            }
            .navigationBarTitle("Rad s nativnim značajkama", displayMode: .inline)
        }
    }
}

class CLLocationManagerWrapper: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
    }

    func requestLocation() {
        let startTime = DispatchTime.now()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        let endTime = DispatchTime.now()
        let elapsed = (endTime.uptimeNanoseconds - startTime.uptimeNanoseconds) / 1000
        print(elapsed)

    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("Trenutna lokacija: \(location)")
            
            locationManager.stopUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Nije pronađena trenutna lokacija: \(error.localizedDescription)")
    }
}

struct CameraView: UIViewControllerRepresentable {
    @Binding var isPresented: Bool

    func makeCoordinator() -> Coordinator {
        return Coordinator(isPresented: $isPresented)
    }

    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Binding var isPresented: Bool

        init(isPresented: Binding<Bool>) {
            _isPresented = isPresented
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            print("Uspješno snimljena fotografija")
            isPresented = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            print("Nije snimljena fotografija")
            isPresented = false
        }
    }
}
