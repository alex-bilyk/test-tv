import SwiftUI
import TVCommanderKit

struct TVView: View {
    
    @StateObject private var viewModel: TVViewModel

    init(tv: TV) {
        _viewModel = .init(wrappedValue: .init(tv: tv))
    }

    var body: some View {
        Form {
            Section("TV") {
                Text("id: \(viewModel.tv.id)")
                Text("type: \(viewModel.tv.type)")
                Text("uri: \(viewModel.tv.uri)")
            }
            Section("Device") {
                Button("Fetch Device") {
                    viewModel.fetchTVDevice()
                }
                Button("Cancel Fetch") {
                    viewModel.cancelFetch()
                }
                if let device = viewModel.tv.device {
                    Text("powerState: \(device.powerState ?? "")")
                    Text("tokenAuthSupport: \(device.tokenAuthSupport)")
                    Text("wifiMac: \(device.wifiMac)")
                }
            }
        }
        .navigationTitle(viewModel.tv.name)
    }
}
