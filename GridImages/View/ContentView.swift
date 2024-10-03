import SwiftUI
import Kingfisher

struct ContentView: View {
    @State private var selectedImage: URL?
    @State private var showModal = false
        
    private var images: [String]()
    var coloumnGrid: [GridItem] {
        [GridItem(.adaptive(minimum: 125))]
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                LazyVGrid(columns: coloumnGrid, alignment: .center, spacing: 1, content: {
                    ForEach(images.indices, id: \.self) { index in
                        KFImage(url(at: index))
                            .placeholder({
                                Color.gray.opacity(0.1)
                                Image(systemName: "photo")
                                    .foregroundColor(.gray)
                            })
                            .waitForCache()
                            .resizable()
                            .scaledToFill()
                            .frame(width: 125,
                                   height: 125)
                            .clipped()
                            .onTapGesture {
                                selectedImage = images[index]
                                showModal = true
                            }
                    }
                    .fullScreenCover(isPresented: $showModal, content: {
                    })
                })
            }
            .navigationTitle("Grid images")
        }
    }
    
    private func url(at index: Int) -> URL? {
        images[index]
    }
}

#Preview {
    ContentView(viewModel: ApplicationManager.sharedInstanse.viewModel)
}
