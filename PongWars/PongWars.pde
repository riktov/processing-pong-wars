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
    new Ball(new PVector(0, height / 2), new PVector(2.7 + random(-0.4, 0.4), 2 + random(-0.4, 0.4)), TEAM_BLUE, COL_BLUE),
    new Ball(new PVector(width - BLOCK_WIDTH, height / 2), new PVector(-2 + random(-0.4, 0.4), -2.5 + random(-0.4, 0.4)), TEAM_GREEN, COL_GREEN) 
    } ;
    
  blocks = new int[20][20] ;
  
  initBlocks() ;
 }


void draw() {  
  drawBlocks() ;

  for(Ball ball : balls) { 
    ball.draw().move() ;
  
    //bounce off walls
    if((ball.position.x <= 0) || (ball.position.x + BLOCK_WIDTH >= width)) {
      ball.bounceX() ;
    }
  
    if((ball.position.y <= 0) || (ball.position.y + BLOCK_WIDTH >= height)) {
      ball.bounceY() ;
    }
    
    //crush blocks
    PVector ballCenter = PVector.add(ball.position, new PVector(BLOCK_WIDTH / 2, BLOCK_WIDTH / 2)) ;
    int idxBallCenter[] = blockIdx(ballCenter) ;
    int col = idxBallCenter[0] ;
    int row = idxBallCenter[1] ;
 
    int val = blocks[row][col] ;

    
    if(val == ball.team) {
      //determine the direction of bounce by the vector from ball center to block center
      PVector blockCenter = new PVector(col * BLOCK_WIDTH + (BLOCK_WIDTH / 2), row * BLOCK_WIDTH  + (BLOCK_WIDTH / 2)) ;
      float diffX = abs(ballCenter.x - blockCenter.x) ;
      float diffY = abs(ballCenter.y - blockCenter.y) ;
      
      if(diffX > diffY) {
        ball.bounceX() ;
      } else {
        ball.bounceY() ;
      }
      
      if(ball.team == TEAM_BLUE) {
        blocks[row][col] = TEAM_GREEN ;
      }
      if(ball.team == TEAM_GREEN) {
        blocks[row][col] = TEAM_BLUE ;
      }
    }
  } ;

}

//which block the ball is over
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
