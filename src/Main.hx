import js.Browser;
import mithril.M;
import haxe.ds.Option;
import data.Tile;

class Main {
	static function main() {
		final container = new DeepStateContainer<GameState>(new DeepState<GameState>({
			tiles: [for (i in 0...9) new Tile({content: None})],
			turn: X
		}));
		final view = new BoardView(container);

		M.mount(Browser.document.querySelector("#app"), view);
	}
}
//-----------------------------------------------------------------------------
