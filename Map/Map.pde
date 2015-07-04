
protected Region world;
protected String[] mapData;

void setup() {
  size(960,960);
  background(0);
  mapData = loadStrings("ohana.txt");
  world = new Region(mapData);
}

void draw(){
  world.draw();
}
