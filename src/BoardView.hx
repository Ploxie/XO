import mithril.M;
import Main.Board;

class BoardView implements Mithril{
	final board : Board;


	public function new(board){
		this.board = board;
	}

	function tileContent(i){
		return switch board.tiles[i].content{
			case X: "X";
			case O: "O";
			case None: " ";
		}
	}

	function tile(i){
		return m("span", {
            onclick: e -> board.clicked(i),
            "class": board.tiles[i].won ? "won" : null
        }, tileContent(i));
	}

    function gameStatus(){
        return switch board.winner(){
            case Winner(winnerRow): switch winnerRow[0].content{
                case X: "X Won!";
                case O: "O Won!";
                case None: throw "Invalid Winner state";
            }
            case NobodyWon: "It's a draw!";
            
            case None: switch board.turn{
                case X: "X's Turn!";
                case O: "O's Turn!";
                case None: throw "Invalid Turn state";
            }            
        }
    }

	public function view()[
        m("h1", gameStatus()),
		m("pre", [
			m("div", [for(i in 0...3) tile(i)]),
			m("div", [for(i in 3...6) tile(i)]),
			m("div", [for(i in 6...9) tile(i)]),
		])
	];

}