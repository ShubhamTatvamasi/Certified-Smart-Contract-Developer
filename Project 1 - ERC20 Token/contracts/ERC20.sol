pragma solidity ^0.4.18;

contract admined {
	address public admin;

	function admined() public {
		admin = msg.sender;
	}

	modifier onlyAdmin(){
		require(msg.sender == admin) ;
		_;
	}

	function transferAdminship(address newAdmin) onlyAdmin public  {
		admin = newAdmin;
	}

}

contract TCoin {

	mapping (address => uint256) public balanceOf;
	mapping (address => mapping (address => uint256)) public allowance;
	// balanceOf[address] = 5;
	string public standard = "TCoin v1.0";
	string public name;
	string public symbol;
	uint8 public decimals; 
	uint256 public totalSupply;
	event Transfer(address indexed from, address indexed to, uint256 value);


	function TCoin(uint256 initialSupply, string tokenName, string tokenSymbol, uint8 decimalUnits) public {
		balanceOf[msg.sender] = initialSupply;
		totalSupply = initialSupply;
		decimals = decimalUnits;
		symbol = tokenSymbol;
		name = tokenName;
	}

	function transfer(address _to, uint256 _value) public {
		require(balanceOf[msg.sender] > _value) ;
		require(balanceOf[_to] + _value > balanceOf[_to]) ;
		//if(admin)

		balanceOf[msg.sender] -= _value;
		balanceOf[_to] += _value;
		Transfer(msg.sender, _to, _value);
	}

	function approve(address _spender, uint256 _value) public returns (bool success){
		allowance[msg.sender][_spender] = _value;
		return true;
	}

	function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){
		require(balanceOf[_from] > _value) ;
		require(balanceOf[_to] + _value > balanceOf[_to]) ;
		require(_value < allowance[_from][msg.sender]) ;
		balanceOf[_from] -= _value;
		balanceOf[_to] += _value;
		allowance[_from][msg.sender] -= _value;
		Transfer(_from, _to, _value);
		return true;

	}
}
