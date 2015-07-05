
protected Region world;
protected String[] mapData;

void setup() {
  size(864,960);
  background(0);
  mapData = loadStrings("ohana.txt");
  world = new Region(mapData);
}

void draw(){
  world.draw();
}
class Region {

  protected Tile[][] camera = new Tile[7][10];
  protected Tile[][] map = new Tile[30][28];
  protected PImage T = loadImage("terrain.png");
  protected PImage N = loadImage("node.png");
  protected PImage W = loadImage("warp.png");
  protected PImage E = loadImage("extra.png");

  Region(String[] mapData) {
    int lineCount=0;
    String tileData;
    for (int i=0; i<map.length; i++) {
      for (int j=0; j<map[0].length; j++) {
        tileData = mapData[lineCount];
        map[i][j]=new Tile(tileData.charAt(0), tileData.charAt(1), tileData.charAt(2));
        println(tileData.charAt(0));
        if (tileData.charAt(0)==0) {
          map[i][j].setImage(E);
        } else {
          if (tileData.charAt(1)==1) {
            map[i][j].setImage(N);
          } else {
            if (tileData.charAt(2)==1) {
              map[i][j].setImage(W);
            } else {
              map[i][j].setImage(T);
            }
          }
        }
        map[i][j].setXY(j,i);
        lineCount++;
      }
    }
  }

  /* void setupCamera(){
   Tile temporary = new Tile(temporary);
   
   }
   */

  void draw() {
    for (Tile[] e : map) {
      for (Tile f : e) {
        f.draw();
      }
    }
  }
}

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

