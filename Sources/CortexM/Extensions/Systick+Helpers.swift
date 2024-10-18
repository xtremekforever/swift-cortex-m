extension SysTick {

    /// Clock source for the SysTick timer.
    public enum ClockSource: UInt32 {
        /// External Reference Clock
        case external = 0

        /// Processor Clock
        case processor = 1
    }

    /// State of the SysTick timer.
    ///
    /// At reset, the SysTick timer is disabled. To enable it, first `configure()` the peripheral,
    /// then call `setState(.enabled)` to start it.
    ///
    public var state: BitFlagState {
        BitFlagState(rawValue: systick.csr.read().raw.enable) ?? .disabled
    }

    /// Whether or not the `COUNTFLAG` is set to 1, indicating the count register reached 0.
    ///
    /// When this is `true`, this can be counted as a single "tick".
    ///
    public var triggered: Bool {
        systick.csr.read().raw.countFlag == 1
    }

    /// Configure the SysTick register for normal usage.
    ///
    /// This assumes that the SysTick counter register is not enabled. It can be disabled
    /// by calling `setState(.disabled)` before calling this method.
    ///
    /// - Parameters:
    ///   - reload: Reload value to program into the reload value register. Example: 1000
    ///   - tickInterrupt: Whether or not the tick interrupt is enabled.
    ///     Enabling this requires implementing an ISR handler for the SysTick interrupt.
    ///   - clockSource: The clock source to use.
    ///
    public func configure(
        reload: UInt32,
        tickInterrupt: BitFlagState = .disabled,
        clockSource: ClockSource = .external
    ) {
        assert(state == .disabled)

        // Set reload value
        systick.rvr.modify { rw in
            rw.raw.reload = reload
        }

        // Clear current value
        systick.cvr.modify { rw in
            rw.raw.current = 0
        }

        // Program control and status register
        systick.csr.modify { rw in
            rw.raw.tickInt = tickInterrupt.rawValue
            rw.raw.clkSource = clockSource.rawValue
        }
    }

    /// Set the state of the SysTick counter register.
    ///
    /// The systick peripheral can either be in a disabled or enabled state.
    /// This helper makes it easy to set the state for readability and understanding of the code.
    /// NOTE: The systick peripheral will need to be configured beforehand!
    ///
    /// - Parameter state: `.enabled` to enable the systick peripheral, `.disabled` to disable it.
    ///
    public func setState(_ state: BitFlagState) {
        systick.csr.modify { rw in
            rw.raw.enable = state.rawValue
        }
    }

    /// Delay processor by using SysTick register as a tick source.
    ///
    /// This assumes that `systick` is _configured and enabled_. Otherwise, the method
    /// will stay locked forever!!
    ///
    /// - Parameter ticks: number of systick "ticks" to delay by.
    ///
    public func delay(ticks: Int) {
        for _ in 0...ticks {
            while !triggered {}
        }
    }
}
