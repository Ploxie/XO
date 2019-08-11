import js.Browser;
import mithril.M;
import haxe.ds.Option;

class Main{
	static function main() {
		final board = new Board();
		final view = new BoardView(board);

		M.mount(Browser.document.querySelector("#app"), view);		
	}
}

//-----------------------------------------------------------------------------

enum Content{
	X;
	O;
	None;
}

enum GameStatus {
	Winner(row : Array<Tile>);
	None;
	NobodyWon;
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

class CheckWinner{
	final board : Board;

	public function new(board){
		this.board = board;
	}

	public function check() : GameStatus {
		final tiles = board.tiles;

		final row1 = [tiles[0], tiles[1], tiles[2]];
		final row2 = [tiles[3], tiles[4], tiles[5]];
		final row3 = [tiles[6], tiles[7], tiles[8]];

		final col1 = [tiles[0], tiles[3], tiles[6]];
		final col2 = [tiles[1], tiles[4], tiles[7]];
		final col3 = [tiles[2], tiles[5], tiles[8]];

		final dia1 = [tiles[0], tiles[4], tiles[8]];
		final dia2 = [tiles[6], tiles[4], tiles[2]];

		var gameOver = true;

		for(check in [row1, row2, row3, col1, col2, col3, dia1, dia2]){
			if(check[0].content.equals(None) || 
			   check[1].content.equals(None) ||
			   check[2].content.equals(None)
			){
				gameOver = false;
				continue;
			}

			if(check[0].content.equals(check[1].content) && check[0].content.equals(check[2].content)){
				return Winner(check);
			}
		}

		return gameOver ? NobodyWon : None;
	}

}

class Board{
	public final tiles : Array<Tile> = [];
	public var turn(default, null) = X;

	public function new(){
		for(i in 0...9){
			tiles.push(new Tile(None));
		}
	}

	public function winner() : GameStatus {
		return new CheckWinner(this).check();
	}

	public function clicked(tilePos){
		final tile = tiles[tilePos];
		if(tile == null){
			throw 'Illegal Tile Pos: $tilePos';
		}

		if(!winner().equals(None)) return;

		switch tile.content{
			case X: return;
			case O: return;
			case None:
				tile.content = turn;
				if(turn == X) turn = O else	turn = X;
		}


		switch winner(){
			case Winner(winningRow): 
				for(tile in winningRow) tile.youWon();
			case None:
			case NobodyWon:
		}
	}
}