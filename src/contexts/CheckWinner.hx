package contexts;
import data.Board;
import data.Tile;

class CheckWinner{
	final board : {
        function index(i: Int) : Tile;
    };

	public function new(board){
		this.board = board;
	}

	public function check() : data.Board.GameStatus {
		final index = board.index;

		final row1 = [index(0), index(1), index(2)];
		final row2 = [index(3), index(4), index(5)];
		final row3 = [index(6), index(7), index(8)];

		final col1 = [index(0), index(3), index(6)];
		final col2 = [index(1), index(4), index(7)];
		final col3 = [index(2), index(5), index(8)];

		final dia1 = [index(0), index(4), index(8)];
		final dia2 = [index(6), index(4), index(2)];

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