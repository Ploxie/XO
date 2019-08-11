import js.Browser;
import mithril.M;
import haxe.ds.Option;
import data.Board;

class Main{
	static function main() {
		final board = new Board();
		final view = new BoardView(board);

		M.mount(Browser.document.querySelector("#app"), view);		
	}
}

//-----------------------------------------------------------------------------





