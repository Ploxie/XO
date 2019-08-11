import data.Tile;
import data.GameStatus;
import contexts.*;

using buddy.Should;
using Lambda;

@colorize class Tests extends buddy.SingleSuite {
    public function new() {
        describe("When playing XO", {
            describe("Setting symbols", {
		        final container = new DeepStateContainer<GameState>(new DeepState<GameState>({
                    tiles: [for(i in 0...9)	new Tile({content: None})],
                    turn: X
                }));		

                it("When a player clicks a tile, the players symbol should be set on the tile", {
                    new GameRound(container, 4).start();
                    container.state.tiles[4].content.should.equal(X);    
                });
                
                it("When the next player clicks, the other players symbol should be set", {
                    new GameRound(container, 3).start();
                    container.state.tiles[3].content.should.equal(O);
                });

                it("Player should not be allowed to place a symbol on an existing one", {
                    new GameRound(container, 4).start();
                    container.state.tiles[4].content.should.equal(X);    
                });
            });

            describe("Winning a game", {
                
                function newContainer() return new DeepStateContainer<GameState>(new DeepState<GameState>({
                    tiles: [for(i in 0...9)	new Tile({content: None})],
                    turn: X
                }));

                it("Should be a win when 3 symbols are aligned", {
                    final container = newContainer();
                    container.update(container.state.tiles[0] = new Tile({content: X}));
                    container.update(container.state.tiles[1] = new Tile({content: X}));

                    new GameRound(container, 2).start();

                    switch new CheckWinner(container.state.tiles).check(){
                        case Winner(row): 
                            row[0].content.should.equal(X);
                            row[1].content.should.equal(X);
                            row[2].content.should.equal(X);
                        case _: fail("X should win");
                    }
                });

                it("Should be a draw when there are no empty tiles on the board and less than 3 aligned symbols", {
                    final container = newContainer();
                    final boardState = "XOXOXXOXO";
                    boardState.split("").mapi((i, sym) -> {
                        container.update(container.state.tiles[i] = new Tile({content: sym == "X" ? X : O}));
                        return null;
                    });

                    new CheckWinner(container.state.tiles).check().should.equal(NobodyWon);
                });



            });

          
            afterEach({

            });
        });
    }
}