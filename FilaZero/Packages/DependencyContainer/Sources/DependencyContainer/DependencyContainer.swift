import Foundation

public typealias DC = DependencyContainer

public final class DependencyContainer {
    public static let shared = DependencyContainer()
    
    private var singleInstanceDependencies: [ObjectIdentifier: AnyObject] = [:]
    private var closureBasedDependencies: [ObjectIdentifier: () -> Any] = [:]
    
    private let dependencyAcessQueue = DispatchQueue(
        label: "com.modularization.dependency.container.acess.queue",
        attributes: .concurrent
    )
    
    private init() {
        
    }
    
    public func register(type: DependencyContainerRegistrationType, for interface: Any.Type) {
        dependencyAcessQueue.sync(flags: .barrier) {
            let objectIdentifier = ObjectIdentifier(interface)
            
            switch type {
            case .singlesInstance(let instance):
                singleInstanceDependencies[objectIdentifier] = instance
            case .closureBased(let closure):
                closureBasedDependencies[objectIdentifier] = closure
            }
        }
    }
    
    public func resolve<Value>(type: DependencyContainerResolvingType, for interface: Value.Type) -> Value {
        var value: Value!
        dependencyAcessQueue.sync {
            let objectIdentifier = ObjectIdentifier(interface)
            switch type {
            case .singleInstance:
                guard let singleInstanceDependecy = singleInstanceDependencies[objectIdentifier] as? Value else {
                    fatalError("Could not retrieve a dependency for the given type: \(interface)")
                }
                value = singleInstanceDependecy
            case .closureBased:
                guard let closure = closureBasedDependencies[objectIdentifier],
                      let closureBasedDependency = closure() as? Value else {
                    fatalError("Could not retrieve closure based dependency for the given type: \(interface)")
                }
                value = closureBasedDependency
            }
        }
        return value
    }
}
