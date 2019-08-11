package data;

enum Content{
	X;
	O;
	None;
}

class Tile implements DataClass{
	@:validate(_ == 0)
	public final content : Content;
}