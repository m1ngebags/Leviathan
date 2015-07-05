
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
