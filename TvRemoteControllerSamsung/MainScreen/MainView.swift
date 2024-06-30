import TVCommanderKit
import SwiftUI

struct MainView: View {
    
    enum Route: Hashable {
        case tv(TV)
        
        func hash(into hasher: inout Hasher) {
            switch self {
            case .tv(let tv):
                hasher.combine(tv.id)
            }
        }
    }
    
    @StateObject var contentViewModel = ContentViewModel()
    @State private var isPresentingError = false
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            Form {
                Section("Connect / Disconnect TV") {
                    TextField("App Name", text: $contentViewModel.appName)
                    TextField("TV IP Address", text: $contentViewModel.tvIPAddress)
                    if contentViewModel.tvIsConnected {
                        Button("Disconnect", action: contentViewModel.userTappedDisconnect)
                            .disabled(!contentViewModel.disconnectEnabled)
                    } else {
                        Button("Connect", action: contentViewModel.userTappedConnect)
                            .disabled(!contentViewModel.connectEnabled)
                    }
                }
                Section("TV Auth Status") {
                    Text(authStatusAsText(contentViewModel.tvAuthStatus))
                }
                Section("Search for TVs") {
                    Button(contentViewModel.isSearchingForTVs ? "Stop" : "Start", action: contentViewModel.userTappedSearchForTVs)
                    List(contentViewModel.tvsFoundInSearch) { tv in
                        Button {
                            path.append(Route.tv(tv))
                        } label: {
                            VStack(alignment: .leading) {
                                Text(tv.name)
                                Text(tv.uri)
                                    .font(.caption)
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .tv(let tv):
                    TVView(tv: tv)
                }
            }
            .alert(isPresented: $isPresentingError) {
                Alert(
                    title: Text("Error"),
                    message: Text(contentViewModel.tvError!.localizedDescription),
                    dismissButton: .default(Text("Dismiss")) {
                        contentViewModel.userTappedDismissError()
                    }
                )
            }
            .onReceive(contentViewModel.$tvError) { newError in
                if newError != nil {
                    isPresentingError = true
                }
            }
        }
    }
    
    private func authStatusAsText(_ authStatus: TVAuthStatus) -> String {
        switch authStatus {
        case .none: return "None"
        case .allowed: return "Allowed"
        case .denied: return "Denied"
        }
    }
}
#Preview {
    MainView()
}
