package contexts;
import data.Board;
import data.Tile;

class CheckWinner{
	final board : {
        final tiles : Array<Tile>;
    };

	public function new(board){
		this.board = board;
	}

	public function check() : data.Board.GameStatus {
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