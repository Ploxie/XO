package data;

enum Content{
	X;
	O;
	None;
}

class Tile {
	public var content : Content;
	public var won(default, null) : Bool = false;


	public function new(content){
		this.content = content;
	}

	public function youWon(){
		this.won = true;
	}

}