import data.Tile;

typedef GameState = {
    final tiles : ds.ImmutableArray<Tile>;
    final turn : Content;
    
}