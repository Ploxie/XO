package data;
import data.Tile;

enum GameStatus {
	Winner(row : Array<Tile>);
	None;
	NobodyWon;
}