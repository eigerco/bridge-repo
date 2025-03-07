module hp_library::hacks {
    use sui::bcs;

    public fun to_address(v: vector<u8>): address {
        let s = bcs::new(v);
        bcs::peel_address(&mut s)
    }

    public fun to_u32(v: vector<u8>): u32 {
        let s = bcs::new(v);
        bcs::peel_u32(&mut s)
    }

    public fun to_u8(v: vector<u8>): u8 {
        let s = bcs::new(v);
        bcs::peel_u8(&mut s)
    }

    public fun to_u256(v: vector<u8>): u256 {
        let s = bcs::new(v);
        bcs::peel_u256(& mut s)
    }
}
