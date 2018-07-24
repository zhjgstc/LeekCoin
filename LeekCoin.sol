pragma solidity ^0.4.18;

contract ERC20{

    /**总发行量 */
    function totalSupply()public view returns (uint supply);

    /**查询余额 */
    function balanceOf(address _owner) public view returns (uint256 balance);

    /**转账 */
    function transfer(address _to, uint256 _value) public returns (bool success);
    /**转账 */
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success);

    /**设置某个账户的单币最大转账金额 */
    function approve(address _spender, uint256 _value) public returns (bool success);

    /**设置是否允许他人代转 */
    function allowance(address _owner, address _spender) public view returns (uint256 remaining);

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}

contract LeekCoin is ERC20 {

    string public constant name="韭菜币";                 
    uint8 public constant decimals=18;              
    string public constant symbol="Leek";       
    address public OWNER;  

    constructor()public{
        BALANCES_ACCOUNTS[msg.sender] = totalSupply();
        OWNER = msg.sender;
    }

    function totalSupply()public view returns (uint supply){
        return 26277000000000;
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(BALANCES_ACCOUNTS[msg.sender] >= _value && BALANCES_ACCOUNTS[_to] + _value > BALANCES_ACCOUNTS[_to]);
        require(_to != 0x0);
        BALANCES_ACCOUNTS[msg.sender] -= _value;
        BALANCES_ACCOUNTS[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns 
    (bool success) {
        require(BALANCES_ACCOUNTS[_from] >= _value && ALLOWED_ACCOUNTS[_from][msg.sender] >= _value);
        BALANCES_ACCOUNTS[_to] += _value;
        BALANCES_ACCOUNTS[_from] -= _value; 
        ALLOWED_ACCOUNTS[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return BALANCES_ACCOUNTS[_owner];
    }

    function approve(address _spender, uint256 _value) public returns (bool success)   
    { 
        ALLOWED_ACCOUNTS[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        return ALLOWED_ACCOUNTS[_owner][_spender];
    }
    mapping (address => uint256) BALANCES_ACCOUNTS;
    mapping (address => mapping (address => uint256)) ALLOWED_ACCOUNTS;
}