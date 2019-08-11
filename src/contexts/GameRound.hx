package contexts;
import data.GameStatus;
import data.Tile;

using Lambda;
/*
    När spelaren klickar på en ruta, så fylls den med spelarens symbol.
    Därefter testar spelplanen om det finns 3 symboler i rad.
    Sedan ändras turen till nästa spelare.
*/

class GameRound implements dci.Context{

    final container : DeepStateContainer<GameState>;
    final tilePos : Int;

    public function new(container: DeepStateContainer<GameState>, tilePos: Int){
        this.container = container;
        this.tilePos = tilePos;
        this.board = container.state;
        this.player = container.state;
        this.tile = container.state.tiles[tilePos];
    }

    public function start(){
        if(new CheckWinner(container).check().equals(None)){
            tile.fill();
        }        
    }

    @role var player: {
        final turn : Content;

        public function switchTurn(){
            final newTurn = if(self.turn == X) O else X;
            container.update(container.state.turn = newTurn);
        }

        public function currentTurn(){
            return self.turn;
        }

    };

    @role var tile: {
        final content : Content;

        public function fill(){
            switch self.content{
                case X: return;
                case O: return;
                case None:
                    container.update(container.state.tiles[tilePos] = new Tile(player.currentTurn()));
		    }     

            board.checkThreeInRow();       
        }

    };
    @role var board: {

        public function checkThreeInRow(){
            final tiles = container.state.tiles;
            switch new CheckWinner(container).check(){
                case Winner(winningRow):
                    for(tile in winningRow){
                        final winningTile = tiles.find(t -> t == tile);
                        final index = tiles.indexOf(tile);
                        container.update(tiles[index] = new Tile(winningTile.content, true));
                    }
                case None: player.switchTurn();
                case NobodyWon:   
            }
        }

    };

    

}