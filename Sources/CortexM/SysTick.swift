import MMIO

@RegisterBlock
public struct SysTick: Sendable {
    @RegisterBlock(offset: 0x0)
    public var csr: Register<CSR>

    @RegisterBlock(offset: 0x4)
    public var rvr: Register<RVR>

    @RegisterBlock(offset: 0x8)
    public var cvr: Register<CVR>

    @RegisterBlock(offset: 0xC)
    public var calib: Register<CALIB>
}

extension SysTick {
    @Register(bitWidth: 32)
    public struct CSR: Sendable {
        @ReadWrite(bits: 0..<1)
        public var enable: ENABLE

        @ReadWrite(bits: 1..<2)
        public var tickInt: TICKINT

        @ReadWrite(bits: 2..<3)
        public var clkSource: CLKSOURCE

        @ReadWrite(bits: 16..<17)
        public var countFlag: COUNTFLAG
    }

    @Register(bitWidth: 32)
    public struct RVR: Sendable {
        @ReadWrite(bits: 0..<24)
        public var reload: RELOAD
    }

    @Register(bitWidth: 32)
    public struct CVR: Sendable {
        @ReadWrite(bits: 0..<24)
        public var current: CURRENT
    }

    @Register(bitWidth: 32)
    public struct CALIB: Sendable {
        @ReadWrite(bits: 0..<24)
        public var tenms: TENMS

        @ReadWrite(bits: 30..<31)
        public var skew: SKEW

        @ReadWrite(bits: 31..<32)
        public var noref: NOREF
    }
}
