import SwiftUI
import TVCommanderKit

final class TVViewModel: ObservableObject {
    private let tvFetcher = TVFetcher()

    @Published private(set) var tv: TV

    init(tv: TV) {
        self.tv = tv
    }

    func fetchTVDevice() {
        tvFetcher.fetchDevice(for: tv) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let tvFetched):
                    self.tv = tvFetched
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    func cancelFetch() {
        tvFetcher.cancelFetch()
    }
}
