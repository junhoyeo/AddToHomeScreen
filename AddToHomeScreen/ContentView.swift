import SwiftUI
import WebKit

class ShareExtensionHelper {
    func createActivityViewController(webView: WKWebView?, _ completionHandler: @escaping (_ completed: Bool, _ activityType: UIActivity.ActivityType?) -> Void) -> UIActivityViewController {
        var activityItems = [Any]()
        if let webView = webView {
            activityItems.append(webView)
        }
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { activityType, completed, returnedItems, error in
            completionHandler(completed, activityType)
        }
        return activityViewController
    }
}

struct ContentView: View {
    let uniswapURL = URL(string: "https://app.uniswap.org")!
    let shareExtensionHelper = ShareExtensionHelper()

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Button("Add to Home Screen") {
                let webView = WKWebView()
                webView.load(URLRequest(url: uniswapURL))
                let activityVC = shareExtensionHelper.createActivityViewController(webView: webView) { (completed, activityType) in
                    // Handle completion of activity here
                }

                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
                    window.rootViewController?.present(activityVC, animated: true, completion: nil)
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
