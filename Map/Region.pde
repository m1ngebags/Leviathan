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

