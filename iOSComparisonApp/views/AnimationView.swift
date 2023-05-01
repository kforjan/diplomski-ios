import SwiftUI

struct AnimationView: View {
    let intensity: Int

    @State private var animationValue: CGFloat = 0

    var body: some View {
        NavigationView {
            VStack {
                CircleAnimation(animationValue: $animationValue, intensity: intensity)
                    .frame(width: 300, height: 300)
                    .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
            }
            .navigationBarTitle("Animation Screen", displayMode: .inline)
            .onAppear {
                withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                    animationValue = 2 * CGFloat.pi
                }
            }
        }
    }
}

struct CircleAnimation: View {
    @Binding var animationValue: CGFloat
    let intensity: Int

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0 ..< intensity, id: \.self) { i in
                    let color = i % 2 == 0 ? Color.red : Color.yellow
                    let angle = 2 * CGFloat.pi / CGFloat(intensity) * CGFloat(i)
                    let xPos = geometry.size.width / 2 + 100 * cos(angle)
                    let yPos = geometry.size.height / 2 + 100 * sin(angle)

                    Circle()
                        .fill(color)
                        .frame(width: 20, height: 20)
                        .offset(x: xPos - geometry.size.width / 2, y: yPos - geometry.size.height / 2)
                        .rotationEffect(.radians(Double(animationValue)), anchor: UnitPoint(x: 0.5, y: 0.5 + 100 / geometry.size.height))
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}


struct AnimationScreen_Previews: PreviewProvider {
    static var previews: some View {
        AnimationView(intensity: 6)
    }
}
