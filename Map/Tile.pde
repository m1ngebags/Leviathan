class Tile{
  
  protected boolean inNode,isWP;
    // Nodes are set amount of tiles
    // Warp points are 2x2 areas
  protected int level; 
    // level 0 will be terrain that cannot be built upon

  protected int x,y;
  protected PImage T;
  protected int tileSize=32;
  
  Tile(int level,int nodeCheck,int wpCheck){
    this.level=level;
    inNode=(nodeCheck==1);
    isWP=(wpCheck==1);
  }
  
  void setImage(PImage T){
    this.T=T;
  }
  
  void setXY(int x,int y){
    this.x=x;
    this.y=y;
  }
  
  
  void draw(){
    imageMode(CORNER);
    image(T, x*tileSize, y*tileSize, tileSize, tileSize);
  }
  
}
