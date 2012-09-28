class GeoPoint {
  
  float lat, lon;
  PVector pos = new PVector();
  PVector tpos = new PVector();
  Date theDate;
  
  void update(){
    pos.lerp(tpos, 0.1);
  }
  
  void render(){
    pushMatrix();
      translate(pos.x, pos.y);
      fill(255,255,255);
      rect(0,0,5,5);
    popMatrix();
  }
}
