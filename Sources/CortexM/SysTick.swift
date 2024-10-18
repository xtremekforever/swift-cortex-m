import MMIO

/// SysTick timer register block description
@RegisterBlock
public struct SysTick: Sendable {
    /// SysTick control and status register
    @RegisterBlock(offset: 0x0)
    public var csr: Register<CSR>

    /// SysTick reload value register
    @RegisterBlock(offset: 0x4)
    public var rvr: Register<RVR>

    /// SysTick current value register
    @RegisterBlock(offset: 0x8)
    public var cvr: Register<CVR>

    /// SysTick calibration value register
    @RegisterBlock(offset: 0xC)
    public var calib: Register<CALIB>
}

extension SysTick {
    /// SysTick control and status register
    @Register(bitWidth: 32)
    public struct CSR: Sendable {
        /// Enables the counter.
        @ReadWrite(bits: 0..<1)
        public var enable: ENABLE

        /// Enables SysTick exception request.
        @ReadWrite(bits: 1..<2)
        public var tickInt: TICKINT

        /// Selects the SysTick timer clock source.
        @ReadWrite(bits: 2..<3)
        public var clkSource: CLKSOURCE

        /// Returns 1 if timer counted to 0 since the last read of this register.
        @ReadWrite(bits: 16..<17)
        public var countFlag: COUNTFLAG
    }

    /// SysTick reload value register
    @Register(bitWidth: 32)
    public struct RVR: Sendable {
        /// Value to load into the current value register when the counter is enabled and it reaches 0.
        @ReadWrite(bits: 0..<24)
        public var reload: RELOAD
    }

    /// SysTick current value register
    @Register(bitWidth: 32)
    public struct CVR: Sendable {
        /// Reads return the current value of the SysTick counter.
        /// A write of any value clears the field to 0, and also clears the `CSR.countFlag` to 0.
        @ReadWrite(bits: 0..<24)
        public var current: CURRENT
    }

    /// SysTick calibration value register
    @Register(bitWidth: 32)
    public struct CALIB: Sendable {
        /// Indicates the calibration value when the SysTick counter runs on HCLK max/8 as external.
        @ReadWrite(bits: 0..<24)
        public var tenms: TENMS

        /// Reads as one. Calibration value for the 1ms inexact timing is not known because TENMS is not known.
        /// This can affect the suitability of SysTick as a software real time clock.
        @ReadWrite(bits: 30..<31)
        public var skew: SKEW

        /// Reads as zero. Indicates that separate reference clock is provided. The frequency of this clock is HCLK/8.
        @ReadWrite(bits: 31..<32)
        public var noref: NOREF
    }
}
