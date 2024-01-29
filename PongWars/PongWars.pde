int BLOCK_WIDTH = 10 ;
int TEAM_BLUE = 0 ;
int TEAM_GREEN = 1 ;
color COL_BLUE = color(63, 63, 255) ;
color COL_GREEN = color(63, 255, 63) ;

Ball[] balls ;
int[][] blocks ;

void setup() {
  size(200, 200) ;
  balls = new Ball[]{
    new Ball(TEAM_BLUE, new PVector(0, height / 2), new PVector(2.7 + random(-0.1, 0.1), 2)),
    new Ball(TEAM_GREEN, new PVector(width - 10, height / 2), new PVector(-2 + random(-0.1, 0.1), -2.5)) 
    } ;
    
  blocks = new int[20][20] ;
  
  initBlocks() ;
 }



void draw() {
  //background(127, 127, 127) ;
  
  drawBlocks() ;

  for(Ball ball : balls) { 
    ball.draw().move() ;

    if((ball.position.x <= 0) || (ball.position.x + BLOCK_WIDTH >= width)) {
      ball.bounceX() ;
    }
  
    if((ball.position.y <= 0) || (ball.position.y + BLOCK_WIDTH >= height)) {
      ball.bounceY() ;
    }
    
    int pos[] = blockIdx(ball.position) ;
    int col = pos[0] ;
    int row = pos[1] ;
 
    int val = blocks[row][col] ;

    if(val == ball.team) {
      ball.bounceX() ;
      
      if(ball.team == TEAM_BLUE) {
        blocks[row][col] = TEAM_GREEN ;
      }
      if(ball.team == TEAM_GREEN) {
        blocks[row][col] = TEAM_BLUE ;
      }
    }
  } ;

}

int[] blockIdx(PVector position) {
  int[] idx = new int[] { int(position.x / BLOCK_WIDTH ), int(position.y / BLOCK_WIDTH)} ;
  return idx ;
}

void initBlocks() {
  for(int row = 0 ; row < blocks.length ; row++) {
    for(int col = 0 ; col < blocks[0].length ; col++) {
      if(col < blocks[0].length / 2) {
        blocks[row][col] = TEAM_GREEN ;  
      } else {
        blocks[row][col] = TEAM_BLUE ;  
      }
    }  
  }
  //remainingBlocks = blocks.length * blocks[0].length ;
}

void drawBlocks() {
  strokeWeight(0) ;
  noStroke() ;
  for(int row = 0 ; row < blocks.length ; row++) {
    for(int col = 0 ; col < blocks[0].length ; col++) {
      if(blocks[row][col] == TEAM_BLUE) {
        fill(COL_BLUE) ;
      }
      if(blocks[row][col] == TEAM_GREEN) {
        fill(COL_GREEN) ;
      }    
      rect(col * BLOCK_WIDTH, row * BLOCK_WIDTH, BLOCK_WIDTH, BLOCK_WIDTH) ; 
    }  
  }
}
