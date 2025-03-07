module hp_library::hacks {
    use sui::bcs;
    use sui::ecdsa_k1;
    use std::string;

    // replacement of aptos string_utils::format1(...)
    // &string_utils::format1(&b"\x19Ethereum Signed Message:\n{}", message_len))
    public fun concat(prefix: vector<u8>, message_len: u64): string::String {
        let res = string::utf8(prefix);
        string::append(
            &mut res,
            std::macros::num_to_string !(message_len)
        );
        res
    }

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


    public struct ECDSASignature {
        inner: vector<u8>
    }

    public fun signature_from_bytes(v: vector<u8>): ECDSASignature {
        assert!(vector::length(&v) == 64, 100);
        ECDSASignature {
            inner: v
        }
    }

    public struct ECDSARawPublicKey has drop , copy {        
        inner: vector<u8>
    }

    public fun public_key_from_bytes(v: vector<u8>): ECDSARawPublicKey {
        assert!(vector::length(&v) == 65, 100);
        ECDSARawPublicKey{
            inner: v
        }
    }

    public fun ecdsa_recover(msg: &vector<u8>, sig: ECDSASignature , hash: u8): ECDSARawPublicKey {
        ECDSARawPublicKey{
        inner: ecdsa_k1::secp256k1_ecrecover(&sig.inner, msg, hash)
        }
    }

    public fun pub_key_to_bytes(public_key: ECDSARawPublicKey): vector<u8> {
        public_key.inner
    }
}
