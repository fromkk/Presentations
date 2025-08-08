import Foundation

extension NSObject {
  func kvoStream<Object: NSObject, Value: Sendable>(
    of object: Object,
    _ keyPath: KeyPath<Object, Value>,
    options: NSKeyValueObservingOptions = [.initial, .new]
  ) -> AsyncStream<Value> {
    AsyncStream { continuation in
      let obs = object.observe(keyPath, options: options) { _, change in
        if let v = change.newValue { continuation.yield(v) }
      }
      continuation.onTermination = { _ in obs.invalidate() }
    }
  }
}
