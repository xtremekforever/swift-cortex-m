extension SysTick {
    /// Delay processor by using systick register as a tick source.
    ///
    /// This assumes that `systick` is initialized, configured, and in the global scope.
    ///
    /// - Parameter ticks: number of systick "ticks" to delay by.
    ///
    public func delay(ticks: Int) {
        for _ in 0...ticks {
            while systick.csr.read().raw.countFlag != 1 {}
        }
    }
}
