SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
ArrayList <GeoPoint> pointList = new ArrayList();

void setup() {
  size(800, 600);
  smooth();
  background(0);
  loadGeo();
}

void draw() {
  background(0);
  for(GeoPoint p : pointList){
    p.update();
    p.render();
  }  
}

void loadGeo() {
  //Import the CSV
  String[] input = loadStrings("openpaths_house.csv");

  for (int i = 1; i < input.length; i++) {
    GeoPoint gp = new GeoPoint();
    String [] splits = input[i].split(",");
    gp.lat = float(splits[0]);
    gp.lon = float(splits[1]);
    String dateString = splits[3];

    try {
      gp.theDate = sdf.parse(dateString);
    } 
    catch (Exception e) {
      println("Error parsing date!" + e);
    }
    
    gp.tpos = getXY(gp.lat, gp.lon);
    
    pointList.add(gp);
  }
}

PVector getXY(float lat, float lon){
  PVector tl = new PVector(-180, -90);
  PVector br = new PVector(180, 90);
  
  float x = map(lon, tl.x, br.x, 0, width);
  float y = map(lat, br.y, tl.y, 0, height);
  PVector out = new PVector(x,y);
  
  return(out);
}

