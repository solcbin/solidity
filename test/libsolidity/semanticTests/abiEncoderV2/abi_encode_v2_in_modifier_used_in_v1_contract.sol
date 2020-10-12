==== Source: A ====
pragma experimental ABIEncoderV2;

struct Data {
    uint value;
}

contract A {
    function get() public view returns (Data memory) {
        return Data(5);
    }
}

contract B {
    uint x = 10;
    uint y = 10;

    modifier updateStorage() {
        A a = new A();
        x = a.get().value;
        _;
        y = a.get().value;
    }
}
==== Source: B ====
import "A";

contract C is B {
    function test()
        public
        updateStorage
        returns (uint, uint)
    {
        return (x, y);
    }
}
// ----
// test() -> 5, 10