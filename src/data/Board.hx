package data;
import data.Tile;
import haxecontracts.*;
using Lambda;

enum GameStatus {
	Winner(row : Array<Tile>);
	None;
	NobodyWon;
}

class Board implements haxecontracts.HaxeContracts{
	final tiles : Array<Tile> = [];
	public var turn = X;

	public function new(){
		for(i in 0...9){
			tiles.push(new Tile(None));
		}
	}

    public function index(i: Int) return tiles[i];

    public function find(f: Tile -> Bool) : Tile {
        Contract.ensures(Contract.result != null);       		
        return tiles.find(f);
    }
}