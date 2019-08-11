package contexts;
import data.Board;
import data.Tile;

using Lambda;
/*
    När spelaren klickar på en ruta, så fylls den med spelarens symbol.
    Därefter testar spelplanen om det finns 3 symboler i rad.
    Sedan ändras turen till nästa spelare.
*/

class GameRound implements dci.Context{

    public function new(boardObject: Board, tilePos: Int){
        this.board = boardObject;
        this.player = boardObject;
        this.tile = boardObject.index(tilePos);
    }

    public function start(){
        if(new CheckWinner(board).check().equals(None)){
            tile.fill();
        }        
    }

    @role var player: {
        var turn : Content;

        public function switchTurn(){
            if(self.turn == X) self.turn = O else self.turn = X;
        }

        public function currentTurn(){
            return self.turn;
        }

    };

    @role var tile: {
        var content : Content;

        public function fill(){
            switch self.content{
                case X: return;
                case O: return;
                case None:
                    self.content = player.currentTurn();                    
		    }     

            board.checkThreeInRow();       
        }

    };
    @role var board: {
       function index(i: Int): Tile; 
       function find(f: Tile -> Bool) : Tile;

        public function checkThreeInRow(){
            switch new CheckWinner(self).check(){
                case Winner(winningRow):
                    for(tile in winningRow){
                        final tile = find(t -> t == tile);
                        tile.youWon();
                    }
                case None: player.switchTurn();
                case NobodyWon:   
            }
        }

    };

    

}