final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;
int gameState;

final int ENEMY_1=0;
final int ENEMY_2=1;
final int ENEMY_3=2;
int enemyState;

PImage bg1Img, bg2Img, enemyImg, fighterImg, hpImg, treasureImg, start1Img, start2Img, end1Img, end2Img;

// treasure positon
int treasureX=floor(random(25,590));
int treasureY=floor(random(50,440));
int treasureW=40;
int treasureH=40;

int hplength; // hp

int bg1x; // background1
int bg2x; // backpround2

// enemy postion & speed
int enemyX=0;
int enemyY=floor(random(50,430));
int enemyW=50;
int enemyH=60;
int enemySpace=10;
float enemySpeedX;
float enemySpeedY;

// fighter postion & speed
int fighterX;
int fighterY;
int fighterW=40;
int fighterH=50;
float fighterSpeed;


// fighter control
boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

  
void setup () {
  size(640,480);
  //load image
  bg1Img=loadImage("img/bg1.png");
  bg2Img=loadImage("img/bg2.png");
  enemyImg=loadImage("img/enemy.png");
  fighterImg=loadImage("img/fighter.png");
  hpImg=loadImage("img/hp.png");
  treasureImg=loadImage("img/treasure.png");
  start1Img=loadImage("img/start1.png");
  start2Img=loadImage("img/start2.png");
  end1Img=loadImage("img/end1.png");
  end2Img=loadImage("img/end2.png");
  
  //background intial
  bg1x=0;
  bg2x=-640;
  
  //enemy move direction
  enemySpeedX= 5;
  enemySpeedY= 0;
  
  // fighter speed
  fighterSpeed=5;
  
  // fighter position
  fighterX=580;
  fighterY=240;
  //  hp length
  hplength = 2*200/10;

  gameState = GAME_START; 
   
}

void draw() {
  
  switch(gameState){
    case GAME_START:
       //show startpage
      image(start2Img,0,0);
                 
      // mouse action
      if (mouseX>200 && mouseX<450){
        if(mouseY>370 && mouseY<420){
          if(mousePressed){
          gameState=GAME_RUN;
        } else {
          image(start1Img,0,0);
        }
        }
       }
      break;
      
    case GAME_RUN:
      
      image(bg1Img,bg1x,0);
      image(bg2Img,bg2x,0);
      image(fighterImg,fighterX,fighterY);
      image(hpImg,20,20);
      image(treasureImg,treasureX,treasureY);
      image(enemyImg,enemyX,enemyY);
      
           
      // hp position 
      noStroke();
      colorMode(RGB);
      fill(255,0,0);
      rect(25,25,hplength,20);
      

      // background move
      bg1x += 1;
      bg2x +=1;
      if (bg1x>=640){
      bg1x=-640;
      }
      if (bg2x>=640){
      bg2x=-640;
      }
      
      switch (enemyState){
      case ENEMY_1:
        for(int i=0; i<5; i++){
          image(enemyImg, enemyX-i*(enemyW+enemySpace), enemyY);
        }
      enemyX += enemySpeedX;
      //enemy boundary 
      if (enemyY>420){
        enemyY=420;
        }
      if (enemyX> 640+4*(enemyW+enemySpace)){
        enemyState=ENEMY_2;
        enemyX=-50;
        }
      break;
      
      case ENEMY_2:
       for(int i=0; i<5; i++){
          image(enemyImg, enemyX-i*(enemyW+enemySpace), enemyY+i*enemyH);
       }
       enemyX += enemySpeedX;
        //enemy boundary 
        if (enemyY>420-5*enemyH){
          enemyY=420-5*enemyH;
        }
        if (enemyX > 640+4*(enemyW+enemySpace)){
          enemyState=ENEMY_3;
          enemyX=-50;
        }
      break;
      
      case ENEMY_3:
         //enemy boundary 
        if (enemyY>420-3*enemyH){
          enemyY=420-3*enemyH;
        }   
        if (enemyY<50+3*enemyH){
          enemyY=50+3*enemyH;
        }   
      
        for(int i=0; i<5; i++){
          if (i==0){
          image(enemyImg, enemyX, enemyY);
          }
          if (i==1){
          image(enemyImg, enemyX-i*(enemyW+enemySpace), enemyY+i*enemyH);          
          image(enemyImg, enemyX-i*(enemyW+enemySpace), enemyY-i*enemyH);
          }
          if (i==2){
          image(enemyImg, enemyX-i*(enemyW+enemySpace), enemyY+i*enemyH);          
          image(enemyImg, enemyX-i*(enemyW+enemySpace), enemyY-i*enemyH);
          }
          if (i==3){
          image(enemyImg, enemyX-i*(enemyW+enemySpace), enemyY+enemyH);          
          image(enemyImg, enemyX-i*(enemyW+enemySpace), enemyY-enemyH);
          }
          if (i==4){
          image(enemyImg, enemyX-i*(enemyW+enemySpace), enemyY); 
          }
        }
        enemyX += enemySpeedX; 
        if (enemyX > 640+4*(enemyW+enemySpace)){
          enemyState=ENEMY_1;
          enemyX=-50;
        }
      break;
      }
      
        
      //if(enemyY>fighterY){
      //enemyY -=2;
      //} else {
      //enemyY +=2;
      //}


      // fighter move
      if(upPressed){
        fighterY -= fighterSpeed;
      }
      if(downPressed){
        fighterY += fighterSpeed;
      }
      if(leftPressed){
        fighterX -= fighterSpeed;
      }
      if(rightPressed){
        fighterX += fighterSpeed;
      }
      
      // fighter over boundary
      if(fighterY < 0){
        fighterY = 0;
      }
      if(fighterY > height-50){
        fighterY = height-50;
      }
      if(fighterX < 0){
        fighterX = 0;
      }
      if(fighterX > width-50){
        fighterX = width-50;
      } 
                  
      // get treasure
      if (fighterX <= treasureX+treasureW && fighterX >=treasureX-fighterW){
        if (fighterY >= treasureY-fighterH && fighterY <= treasureY+treasureH){
        hplength += 20;
        treasureX=floor(random(25,590));
        treasureY=floor(random(50,440));
        }
      }
      if (hplength>200){
        hplength=200;
      }
          
            
       // touch enemy
      //if (enemyX >= fighterX-enemyW && enemyX <= fighterX+fighterW){
        //if (enemyY >= fighterY-enemyH && enemyY <= fighterY+fighterH){
         //hplength -= 40;
          //enemyX=0;
          //enemyY=floor(random(50,430));
        //}
      //} 
                   
      // game over
      if (hplength<=0){
        gameState= GAME_OVER;
        hplength=40;
      }
      break;
      
    case GAME_OVER:
      //show startpage
      image(end2Img,0,0);
      
      // mouse action
      if (mouseX>200 && mouseX<450){
        if(mouseY>310 && mouseY<350){
          if(mousePressed){
          gameState = GAME_RUN;
          } else {
          image(end1Img,0,0);
          }
        }
       }
      break;
    }
}
        
void keyPressed(){
  if (key == CODED){ 
    switch (keyCode){
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
      }
  }
}
void keyReleased(){
  if (key == CODED){ 
      switch(keyCode){
        case UP:
          upPressed = false;
          break;
        case DOWN:
          downPressed = false;
          break;
        case LEFT:
          leftPressed = false;
          break;
        case RIGHT:
          rightPressed = false;
          break;
      }
  }
}
