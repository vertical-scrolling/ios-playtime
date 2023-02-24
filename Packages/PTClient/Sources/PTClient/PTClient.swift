import UIKit

public protocol Client {

}

public struct PTClient: Client {
    private let endpoint: Endpoint
}
