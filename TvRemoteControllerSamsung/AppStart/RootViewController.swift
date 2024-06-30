import SwiftUI
import UIKit

final class RootViewController: UIViewController {
    
    private let mainScreen = UINavigationController(rootViewController: UIHostingController(rootView: MainView()))
    private var current: UIViewController?
    private var statusBarStyle: UIStatusBarStyle = .darkContent

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        launchingTheApp()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        statusBarStyle
    }
    
    private func launchingTheApp() {
        showingTabBar()
    }
    
    private func showingOnboarding() {
        
    }
    
    private func showingTabBar() {
        mainScreen.willMove(toParent: self)
        addChild(mainScreen)
        view.addSubview(mainScreen.view)
        
        current?.view.removeFromSuperview()
        current?.removeFromParent()
        mainScreen.didMove(toParent: self)
        current = mainScreen
    }
    
    private func showingMainPaywall() {
        
    }
    
    private func showingSpecialPaywall() {
        
    }
}

