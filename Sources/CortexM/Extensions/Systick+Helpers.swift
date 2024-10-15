extension SysTick {

    /// Set the state of the systick counter register.
    ///
    /// The systick peripheral can either be in a disabled or enabled state.
    /// This helper makes it easy to set the state for readability and understanding of the code.
    /// Note that the systick peripheral may need to be configured beforehand!
    ///
    /// - Parameter state: `.enabled` to enable the systick peripheral, `.disabled` to disable it.
    ///
    public func setState(_ state: EnabledDisabled) {
        systick.csr.modify { rw in
            rw.raw.enable = state.rawValue
        }
    }

    /// Delay processor by using systick register as a tick source.
    ///
    /// This assumes that `systick` is _configured and enabled_. Otherwise, the method
    /// will stay locked forever!!
    ///
    /// - Parameter ticks: number of systick "ticks" to delay by.
    ///
    public func delay(ticks: Int) {
        for _ in 0...ticks {
            while systick.csr.read().raw.countFlag != 1 {}
        }
    }
}
