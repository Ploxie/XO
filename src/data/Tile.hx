package data;
import haxecontracts.*;

enum Content{
	X;
	O;
	None;
}

class Tile implements haxecontracts.HaxeContracts{
	public final content : Content;
	public final won : Bool;

	public function new(content, won = false){
		this.content = content;
		this.won = won;
	}

    @invariants function invariants(){
        Contract.invariant(content != null);
        Contract.invariant(won != null);
    }

}