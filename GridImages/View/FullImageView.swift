import SwiftUI
import Kingfisher

struct FullImageView: View {
    @State var selectedImage: URL?
    @State private var scale: CGFloat = 1.0
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            
            Color.black
                .ignoresSafeArea()
                .overlay(
                    ZStack {
                        fullImage
                        closeButton
                    }
                )
        }
    }
    
    var fullImage: some View {
        let magnificationGesture = MagnificationGesture()
            .onChanged { scale = $0.magnitude }
        let dragGesture = DragGesture().onEnded {
            if $0.location.y - $0.startLocation.y > 200 {
                dismiss()
            }
        }
        
        return KFImage(selectedImage)
            .resizable()
            .cacheOriginalImage()
            .waitForCache()
            .scaledToFit()
            .clipped()
            .scaleEffect(scale)
            .gesture(dragGesture)
            .gesture(magnificationGesture)
    }
    
    var closeButton: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .font(.system(size: 25))
                        .foregroundStyle(.gray)
                }
            }
            .padding(.top, 5)
            Spacer()
        }
    }
}
