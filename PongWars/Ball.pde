class Ball {
  int team ;
  PVector position ;
  PVector speed ;
  color col ;
  
  Ball(PVector position, PVector speed, int team, color col) {
    this.team = team ;
    this.position = position ;
    this.speed = speed ;
    this.col = col ;
}
  
  Ball move() {
    this.position.add(speed) ;
    return this ;
  }
  
  Ball draw() {
    fill(this.col) ;
    strokeWeight(0) ;
    rect(this.position.x, this.position.y, 10, 10) ;
    return this ;
  }
  
  Ball bounceX() {
    this.speed.x = -1 * this.speed.x ;
    return this ;
  }

  Ball bounceY() {
    this.speed.y = -1 * this.speed.y ;
    return this ;
  }
}
