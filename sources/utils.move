module dev::utils {
    use std::string::{String, utf8};
    use std::vector;
    use aptos_std::debug::print;

    // ============ PRINTING FUNCTIONS ============

    /// Print only key
    public fun print_key(key: vector<u8>) {
        print(&utf8(key));
    }

    /// Print only value
    public fun print_value<T: drop>(value: T) {
        print(&value);
    }

    /// Print key with value (original function)
    public fun print_kv<T: drop>(key: vector<u8>, value: T) {
        print(&utf8(key));
        print(&value);
    }

    /// Print key with value in formatted way
    public fun print_formatted<T: drop>(key: vector<u8>, value: T) {
        let byte = b"[";
        byte.append(key);

        byte.append(b"]: ");
        print(&utf8(byte));
        print(&value);
    }

    /// Print separator line
    public fun print_separator() {
        print(&utf8(b"================================"));
    }

    /// Print with prefix
    public fun print_with_prefix<T: drop>(prefix: vector<u8>, value: T) {
        print(&utf8(prefix));
        print(&utf8(b" "));
        print(&value);
    }

    /// Print debug information
    public fun print_debug<T: drop>(msg: vector<u8>, value: T) {
        let byte = b"DEBUG: ";
        byte.append(msg);
        byte.append(b" = ");
        print(&utf8(byte));
        print(&value);
    }

    /// Print error with message
    public fun print_error(msg: vector<u8>) {
        print(&utf8(b"ERROR: "));
        print(&utf8(msg));
    }

    /// Print success with message
    public fun print_success(msg: vector<u8>) {
        print(&utf8(b"SUCCESS: "));
        print(&utf8(msg));
    }

    /// Print warning with message
    public fun print_warning(msg: vector<u8>) {
        print(&utf8(b"WARNING: "));
        print(&utf8(msg));
    }

    /// Print info with message
    public fun print_info(msg: vector<u8>) {
        print(&utf8(b"INFO: "));
        print(&utf8(msg));
    }

    // ============ STRING CONVERSION FUNCTIONS ============

    /// Convert string to u256 (original function)
    public fun to_u256(value: String): u256 {
        let to_bytes = value.bytes();
        let length = to_bytes.length();
        let i = 0;
        let num: u256 = 0;
        while (i < length) {
            num = num * 10 + ((*to_bytes.borrow(i) - 48) as u256);
            i += 1;
        };
        num
    }

    /// Convert string to u64 with overflow protection (original function)
    public fun to_u64(value: String): u64 {
        let to_bytes = value.bytes();
        let length = to_bytes.length();
        let i = 0;
        let num: u256 = 0;
        let max_u64: u256 = 18446744073709551615;

        while (i < length) {
            num = num * 10 + ((*to_bytes.borrow(i) - 48) as u256);
            i += 1;
        };

        if (num > max_u64) {
            (max_u64 as u64)
        } else {
            (num as u64)
        }
    }

    /// Convert string to u128 with overflow protection
    public fun to_u128(value: String): u128 {
        let to_bytes = value.bytes();
        let length = to_bytes.length();
        let i = 0;
        let num: u256 = 0;
        let max_u128: u256 = 340282366920938463463374607431768211455;

        while (i < length) {
            num = num * 10 + ((*to_bytes.borrow(i) - 48) as u256);
            i += 1;
        };

        if (num > max_u128) {
            (max_u128 as u128)
        } else {
            (num as u128)
        }
    }

    /// Convert string to u32 with overflow protection
    public fun to_u32(value: String): u32 {
        let to_bytes = value.bytes();
        let length = to_bytes.length();
        let i = 0;
        let num: u64 = 0;
        let max_u32: u64 = 4294967295;

        while (i < length) {
            num = num * 10 + ((*to_bytes.borrow(i) - 48) as u64);
            i += 1;
        };

        if (num > max_u32) {
            (max_u32 as u32)
        } else {
            (num as u32)
        }
    }

    /// Convert string to u16 with overflow protection
    public fun to_u16(value: String): u16 {
        let to_bytes = value.bytes();
        let length = to_bytes.length();
        let i = 0;
        let num: u64 = 0;
        let max_u16: u64 = 65535;

        while (i < length) {
            num = num * 10 + ((*to_bytes.borrow(i) - 48) as u64);
            i += 1;
        };

        if (num > max_u16) {
            (max_u16 as u16)
        } else {
            (num as u16)
        }
    }

    /// Convert string to u8 with overflow protection
    public fun to_u8(value: String): u8 {
        let to_bytes = value.bytes();
        let length = to_bytes.length();
        let i = 0;
        let num: u64 = 0;
        let max_u8: u64 = 255;

        while (i < length) {
            num = num * 10 + ((*to_bytes.borrow(i) - 48) as u64);
            i += 1;
        };

        if (num > max_u8) {
            (max_u8 as u8)
        } else {
            (num as u8)
        }
    }

    // ============ VECTOR UTILITY FUNCTIONS ============

    /// Check if vector is empty
    public fun is_empty<T: drop>(v: &vector<T>): bool {
        v.length() == 0
    }

    /// Get vector size
    public fun size<T: drop>(v: &vector<T>): u64 {
        v.length()
    }

    /// Check if vector contains element
    public fun contains<T: drop>(v: &vector<T>, item: &T): bool {
        let i = 0;
        let len = v.length();
        while (i < len) {
            if (v.borrow(i) == item) {
                return true
            };
            i += 1;
        };
        false
    }

    /// Find index of element in vector
    public fun find_index<T: drop>(v: &vector<T>, item: &T): u64 {
        let i = 0;
        let len = v.length();
        while (i < len) {
            if (v.borrow(i) == item) {
                return i
            };
            i += 1;
        };
        len // Return length if not found (out of bounds)
    }

    /// Get first element of vector
    public fun first<T: drop>(v: &vector<T>): &T {
        v.borrow(0)
    }

    /// Get last element of vector
    public fun last<T: drop>(v: &vector<T>): &T {
        v.borrow(v.length() - 1)
    }

    /// Reverse a vector
    public fun reverse<T: drop>(v: &mut vector<T>) {
        let len = v.length();
        let i = 0;
        while (i < len / 2) {
            v.swap(i, len - 1 - i);
            i += 1;
        };
    }

    // ============ MATH UTILITY FUNCTIONS ============

    /// Calculate maximum of two u64 values
    public fun max_u64(a: u64, b: u64): u64 {
        if (a > b) a else b
    }

    /// Calculate minimum of two u64 values
    public fun min_u64(a: u64, b: u64): u64 {
        if (a < b) a else b
    }

    /// Calculate maximum of two u128 values
    public fun max_u128(a: u128, b: u128): u128 {
        if (a > b) a else b
    }

    /// Calculate minimum of two u128 values
    public fun min_u128(a: u128, b: u128): u128 {
        if (a < b) a else b
    }

    /// Calculate maximum of two u256 values
    public fun max_u256(a: u256, b: u256): u256 {
        if (a > b) a else b
    }

    /// Calculate minimum of two u256 values
    public fun min_u256(a: u256, b: u256): u256 {
        if (a < b) a else b
    }

    /// Calculate absolute difference between two u64 values
    public fun abs_diff_u64(a: u64, b: u64): u64 {
        if (a > b) a - b else b - a
    }

    /// Calculate power (base^exponent) for u64
    public fun pow_u64(base: u64, exponent: u64): u64 {
        if (exponent == 0) {
            return 1
        };
        let result = 1;
        let i = 0;
        while (i < exponent) {
            result *= base;
            i += 1;
        };
        result
    }

    /// Calculate power (base^exponent) for u128
    public fun pow_u128(base: u128, exponent: u128): u128 {
        if (exponent == 0) {
            return 1
        };
        let result = 1;
        let i = 0;
        while (i < exponent) {
            result *= base;
            i += 1;
        };
        result
    }

    /// Check if number is even
    public fun is_even(n: u64): bool {
        n % 2 == 0
    }

    /// Check if number is odd
    public fun is_odd(n: u64): bool {
        n % 2 == 1
    }

    // ============ VALIDATION FUNCTIONS ============

    /// Check if string is numeric
    public fun is_numeric(s: String): bool {
        let bytes = s.bytes();
        let len = bytes.length();
        if (len == 0) return false;

        let i = 0;
        while (i < len) {
            let byte = *bytes.borrow(i);
            if (byte < 48 || byte > 57) { // Not 0-9
                return false
            };
            i += 1;
        };
        true
    }

    /// Check if string is empty
    public fun is_string_empty(s: String): bool {
        s.bytes().length() == 0
    }

    /// Get string length
    public fun string_length(s: String): u64 {
        s.bytes().length()
    }

    // ============ CONVERSION HELPERS ============

    /// Convert u64 to string
    public fun u64_to_string(n: u64): String {
        if (n == 0) return utf8(b"0");

        let digits = vector::empty<u8>();
        let temp = n;

        while (temp > 0) {
            digits.push_back(((temp % 10) as u8) + 48);
            temp /= 10;
        };

        digits.reverse();
        utf8(digits)
    }

    /// Convert bool to string
    public fun bool_to_string(b: bool): String {
        if (b) utf8(b"true") else utf8(b"false")
    }

    // ============ TESTING HELPERS ============

    /// Assert with custom message
    public fun assert_with_message(condition: bool, message: vector<u8>) {
        if (!condition) {
            print_error(message);
            assert!(condition, 1);
        };
    }

    /// Assert equality with message
    public fun assert_eq<T: drop + copy>(left: T, right: T, message: vector<u8>) {
        if (left != right) {
            print_error(message);
            print_debug(b"Expected", right);
            print_debug(b"Actual", left);
            assert!(left == right, 2);
        };
    }

    // ============ UTILITY FUNCTIONS ============

    /// Create a range vector from start to end (exclusive)
    public fun range(start: u64, end: u64): vector<u64> {
        let result = vector::empty<u64>();
        let i = start;
        while (i < end) {
            result.push_back(i);
            i += 1;
        };
        result
    }

    /// Create a vector with repeated value
    public fun repeat<T: copy + drop>(value: T, count: u64): vector<T> {
        let result = vector::empty<T>();
        let i = 0;
        while (i < count) {
            result.push_back(value);
            i += 1;
        };
        result
    }

    /// Clamp value between min and max
    public fun clamp_u64(value: u64, min_val: u64, max_val: u64): u64 {
        if (value < min_val) min_val
        else if (value > max_val) max_val
        else value
    }

    /// Check if value is in range [min, max]
    public fun in_range_u64(value: u64, min_val: u64, max_val: u64): bool {
        value >= min_val && value <= max_val
    }
}