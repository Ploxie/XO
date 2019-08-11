package data;
import data.Tile;

enum GameStatus {
	Winner(row : Array<Tile>);
	None;
	NobodyWon;
}

class Board{
	public final tiles : Array<Tile> = [];
	public var turn = X;

	public function new(){
		for(i in 0...9){
			tiles.push(new Tile(None));
		}
	}
}