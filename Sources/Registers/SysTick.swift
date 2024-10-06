import MMIO

@RegisterBlock
struct SysTick {
    @RegisterBlock(offset: 0x0)
    var csr: Register<CSR>

    @RegisterBlock(offset: 0x4)
    var rvr: Register<RVR>

    @RegisterBlock(offset: 0x8)
    var cvr: Register<CVR>

    @RegisterBlock(offset: 0xC)
    var calib: Register<CALIB>
}

extension SysTick {
    @Register(bitWidth: 32)
    struct CSR {
        @ReadWrite(bits: 0..<1)
        var enable: ENABLE

        @ReadWrite(bits: 1..<2)
        var tickInt: TICKINT

        @ReadWrite(bits: 2..<3)
        var clkSource: CLKSOURCE

        @ReadWrite(bits: 16..<17)
        var countFlag: COUNTFLAG
    }

    @Register(bitWidth: 32)
    struct RVR {
        @ReadWrite(bits: 0..<24)
        var reload: RELOAD
    }

    @Register(bitWidth: 32)
    struct CVR {
        @ReadWrite(bits: 0..<24)
        var current: CURRENT
    }

    @Register(bitWidth: 32)
    struct CALIB {
        @ReadWrite(bits: 0..<24)
        var tenms: TENMS

        @ReadWrite(bits: 30..<31)
        var skew: SKEW

        @ReadWrite(bits: 31..<32)
        var noref: NOREF
    }
}
