import SwiftUI
import Kingfisher

struct ContentView: View {
    @ObservedObject private var viewModel: GridViewModel
    @State private var selectedImage: URL?
    @State private var showModal = false
        
    private var imageLinks: [URL] {
        viewModel.imageLinks
    }
    
    init(viewModel: GridViewModel) {
        self.viewModel = viewModel
    }
        
    var coloumnGrid: [GridItem] {
        [GridItem(.adaptive(minimum: 125))]
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                LazyVGrid(columns: coloumnGrid, alignment: .center, spacing: 1, content: {
                    ForEach(imageLinks.indices, id: \.self) { index in
                        KFImage(url(at: index))
                            .placeholder {
                                Color.gray.opacity(0.1)
                                Image(systemName: "photo")
                                    .foregroundColor(.gray)
                            }
                            .waitForCache()
                            .resizable()
                            .scaledToFill()
                            .frame(width: 125,
                                   height: 125)
                            .clipped()
                            .onTapGesture {
                                selectedImage = imageLinks[index]
                                showModal = true
                            }
                    }
                    .fullScreenCover(isPresented: $showModal, content: {
                        FullImageView(selectedImage: selectedImage)
                    })
                })
            }
            .onAppear(perform: { fetchImages() })
            .navigationTitle("Grid images")
        }
    }
    
    private func url(at index: Int) -> URL? {
        imageLinks[index]
    }
    
    private func fetchImages() {
        Task {
            await viewModel.fetchImages()
        }
    }
}

#Preview {
    ContentView(viewModel: ApplicationManager.sharedInstanse.viewModel)
}
