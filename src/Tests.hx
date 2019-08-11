import data.Board;
import data.Tile;
import contexts.*;
using buddy.Should;
using Lambda;

@colorize class Tests extends buddy.SingleSuite {
    public function new() {
        // A test suite:
        describe("When playing XO", {
            describe("Setting symbols", {
                var board = new Board();
                
                it("When a player clicks a tile, the players symbol should be set on the tile", {
                    new GameRound(board, 4).start();
                    board.index(4).content.should.equal(X);    
                });
                
                it("When the next player clicks, the other players symbol should be set", {
                    new GameRound(board, 3).start();
                    board.index(3).content.should.equal(O);    
                });

                it("Player should not be allowed to place a symbol on an existing one", {
                    new GameRound(board, 4).start();
                    board.index(4).content.should.equal(X);    
                });
            });

            describe("Winning a game", {
                var board : Board;
                beforeEach({
                    board = new Board();
                });

                it("Should be a win when 3 symbols are aligned", {
                    board.index(0).content = X;
                    board.index(1).content = X;
                    //board.index(2).content = X;

                    new GameRound(board, 2).start();

                    switch new CheckWinner(board).check(){
                        case Winner(row): 
                            row[0].content.should.equal(X);
                            row[1].content.should.equal(X);
                            row[2].content.should.equal(X);
                        case _: fail("X should win");
                    }
                });

                it("Should be a draw when there are no empty tiles on the board and less than 3 aligned symbols", {
                    final boardState = "XOXOXXOXO";
                    boardState.split("").mapi((i, sym) -> {
                        board.index(i).content = sym == "X" ? X : O;
                    });

                    new CheckWinner(board).check().should.equal(NobodyWon);
                });



            });

          
            afterEach({

            });
        });
    }
}