class Ball {
  int team ;
  PVector position ;
  PVector speed ;
  PVector prevPosition ;
  color col ;
  
  Ball(int team, PVector position, PVector speed) {
    this.team = team ;
    this.position = position ;
    this.speed = speed ;
    prevPosition = new PVector(0, 0) ;
    if(team == TEAM_BLUE) {
      col = color(63, 63, 255) ;
    }
    if(team == TEAM_GREEN) {
      col = color(63, 255, 63) ;
    }
}
  
  Ball move() {
    prevPosition = this.position ;
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
