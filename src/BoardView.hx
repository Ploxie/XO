import mithril.M;
import data.GameStatus;
import contexts.GameRound;
import contexts.CheckWinner;
import data.Tile;

class BoardView implements Mithril{
	final container : DeepStateContainer<GameState>;
	var winnerRow : ds.ImmutableArray<Tile>;

	public function new(container){
		this.container = container;
		this.winnerRow = [];
	}

	function tileContent(i){
		return switch container.state.tiles[i].content{
			case X: "X";
			case O: "O";
			case None: " ";
		}
	}

	function tile(i){
		return m("span", {
            onclick: e -> new GameRound(container, i).start(),
            "class": winnerRow.has(container.state.tiles[i]) ? "won" : null
        }, tileContent(i));
	}

    function gameStatus(){
        return switch new CheckWinner(container).check(){
            case Winner(winnerRow): 
				this.winnerRow = winnerRow;
				switch winnerRow[0].content{
					case X: "X Won!";
					case O: "O Won!";
					case None: throw "Invalid Winner state";
				}
            case NobodyWon: "It's a draw!";
            
            case None: switch container.state.turn{
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