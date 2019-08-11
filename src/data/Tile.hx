package data;
import haxecontracts.*;

enum Content{
	X;
	O;
	None;
}

class Tile implements haxecontracts.HaxeContracts{
	public var content : Content;
	public var won(default, null) : Bool = false;

	public function new(content){
		this.content = content;
	}

	public function youWon(){
        Contract.requires(won == false, "You cannot win twice");
		this.won = true;
	}

    @invariants function invariants(){
        Contract.invariant(content != null);
        Contract.invariant(won != null);
    }

}