contract UniloanV1Helper {
    function withdrawAll(address to, IUniswapV2Pair pair, uint deadline, uint8 v, bytes32 r, bytes32 s) external returns (bool) {
        UniloanV1Pair _pair = UniloanV1Pair(pairs[address(pair)]);
        _pair.permit(msg.sender, address(this), _pair.balanceOf(msg.sender), deadline, v, r, s);
        _pair.transferFrom(msg.sender, address(this), _pair.balanceOf(msg.sender));
        _pair.depositLiquidity();
        _pair.withdrawAll(to);

    }

    function withdraw(address to, IUniswapV2Pair pair, uint amount, uint deadline, uint8 v, bytes32 r, bytes32 s) external returns (bool) {
        UniloanV1Pair _pair = UniloanV1Pair(pairs[address(pair)]);
        _pair.permit(msg.sender, address(this), amount, deadline, v, r, s);
        _pair.transferFrom(msg.sender, address(this), amount);
        _pair.depositLiquidity();
        _pair.withdraw(to, amount);
    }

    function depositAll(address to, IUniswapV2Pair pair, uint deadline, uint8 v, bytes32 r, bytes32 s) external returns (bool) {
        UniloanV1Pair _pair = UniloanV1Pair(pairs[address(pair)]);
        uint _b = pair.balanceOf(msg.sender);
        pair.permit(msg.sender, address(this), _b, deadline, v, r, s);
        pair.transferFrom(msg.sender, address(this), _b);
        pair.approve(address(_pair), _b);
        _pair.depositAll(to);
    }

    function deposit(address to, IUniswapV2Pair pair, uint amount, uint deadline, uint8 v, bytes32 r, bytes32 s) external returns (bool) {
        UniloanV1Pair _pair = UniloanV1Pair(pairs[address(pair)]);
        pair.permit(msg.sender, address(this), amount, deadline, v, r, s);
        pair.transferFrom(msg.sender, address(this), amount);
        pair.approve(address(_pair), amount);
        _pair.deposit(to, amount);
    }
}
