import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private init() {}

    @UserDefault(key: "jwtToken")
    var jwtToken: String?

    @UserDefault(key: "phoneNumber")
    var phoneNumber: String?
    
    @UserDefault(key: "loginStatus")
    var loginStatus: Bool = false


    func resetData() {
        jwtToken = nil
        phoneNumber = nil
        loginStatus = false
    }
}

private protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    var isNil: Bool { self == nil }
}

@propertyWrapper
public struct UserDefault<Value> {
    public let key: String
    public let defaultValue: Value
    public var container: UserDefaults

    public init(wrappedValue defaultValue: Value, key: String, container: UserDefaults = .standard) {
        self.defaultValue = defaultValue
        self.key = key
        self.container = container
    }

    public var wrappedValue: Value {
        get {
            return container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            if let optional = newValue as? AnyOptional, optional.isNil {
                container.removeObject(forKey: key)
            } else {
                container.setValue(newValue, forKey: key)
            }
        }
    }
}

public extension UserDefault where Value: ExpressibleByNilLiteral {
    init(key: String, storage _: UserDefaults = .standard) {
        self.init(wrappedValue: nil, key: key)
    }
}
