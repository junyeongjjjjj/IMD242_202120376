color[] rainbowColors = {
  color(255, 0, 0),    // 빨간색
  color(255, 127, 0),  // 주황색
  color(255, 255, 0),  // 노란색
  color(0, 255, 0),    // 초록색
  color(0, 0, 255),    // 파란색
  color(75, 0, 130),   // 남색
  color(148, 0, 211)   // 보라색
};
int currentColorIndex = 0;  // 현재 배경색

float mouthWidth = 60;  // 핑크색 입의 너비
float mouthHeight = 0; // 핑크색 입의 높이

void setup() {
  size(640, 640);
  
  // 초기 배경색을 설정.
  background(rainbowColors[currentColorIndex]);  
}

void draw() {
  background(rainbowColors[currentColorIndex]);
  draw(width / 8, height / 8);
}

void draw(float x, float y) {
  
  // 얼굴
  stroke(0);
  fill(255);
  strokeWeight(4);
  ellipse(320, 300, 400, 395);
  
  // 얼굴 하이라이트
  noStroke();
  fill(137, 195, 234);
  ellipse(323, 304, 395 , 390); 
  fill(255);
  
  // 스트로크 한 번 더
  stroke(0);
  noFill();
  strokeWeight(4);
  ellipse(320, 300, 400, 395);
  
  // 눈 
  fill(0);
  noStroke();
  //x값으로 눈 동일하게 떨구기
  float eyeOffsetX = 150;  
  
  // 왼쪽 눈
  circle(320 - eyeOffsetX, 275, 23);
  
  // 오른쪽 눈
  circle(320 + eyeOffsetX, 275, 23);
  
   // 핑크 입
  if (mouseY > 375) { // 마우스 Y가 흰색 입 아래에 있을 때만
    mouthHeight = map(mouseY, 375, height, 0, 60); // 마우스 Y에 따라 입 높이 조절
  } else {
    mouthHeight = 0; // 마우스 Y가 흰색 입 위에 있을 때는 입 높이 0
  }
  
  fill(255, 105, 180);
  stroke(0);
  strokeWeight(2);
  ellipse(320, 395 + mouthHeight / 2, mouthWidth, mouthHeight); 
 
  // 오른쪽 입 회전 코드 
  pushMatrix();  // 현재 좌표계 저장
  translate(360, 385);  // 입의 중심을 이동
  rotate(radians(50));  
  
  // 오른쪽 입 그림자
  noStroke();
  fill(213, 230, 240);
  ellipse(0, 0, 95, 75);  // 중심이 (0, 0) 기준으로 타원을 그림
  popMatrix();  // 이전 좌표계로 복구
  
  
  // 오른쪽 입 회전
  pushMatrix();  // 현재 좌표계 저장
  translate(360, 385);  // 입의 중심을 이동
  rotate(radians(50));  
  
  // 오른쪽 입   
  fill(255);
  ellipse(-5, 0, 85, 75);  // 중심이 (0, 0) 기준으로 타원을 그림
  popMatrix();  // 이전 좌표계로 복구
  noStroke();
  
  // 왼쪽 입 회전 코드
  pushMatrix();  // 현재 좌표계 저장
  translate(285, 385);  // 입의 중심을 이동
  rotate(radians(-50));  
  
  // 왼쪽 입 그림자
  fill(213, 230, 240);
  ellipse(0, 0, 95, 75);  // 중심이 (0, 0) 기준으로 타원을 그림
  popMatrix();  // 이전 좌표계로 복구
  noStroke();
  
  // 왼쪽 입 회전
  pushMatrix();  // 현재 좌표계 저장
  translate(285, 385);  // 입의 중심을 이동
  rotate(radians(-50)); 
  
  // 왼쪽 입
  fill(255);
  ellipse(5, 0, 85, 75);  // 중심이 (0, 0) 기준으로 타원을 그림
  popMatrix();  // 이전 좌표계로 복구
  
  
  // 왼쪽 입 회전
  pushMatrix();  // 현재 좌표계 저장
  translate(285, 385);  // 입의 중심을 이동
  rotate(radians(-50)); 
  
  // 왼쪽 입
  noFill();  
  ellipse(0, 0, 95, 75);  // 중심이 (0, 0) 기준으로 타원을 그림
  popMatrix();  // 이전 좌표계로 복구
  
  // 오른쪽 입 회전 
  pushMatrix();  // 현재 좌표계 저장
  translate(360, 385);  // 입의 중심을 이동
  rotate(radians(50)); 
  
  // 오른쪽 입 
  stroke(0);
  strokeWeight(2);
  noFill();
  ellipse(0, 0, 95, 75);  // 중심이 (0, 0) 기준으로 타원을 그림
  popMatrix();  // 이전 좌표계로 복구
  
  // 왼쪽 입 회전
  pushMatrix();  // 현재 좌표계 저장
  translate(285, 385);  // 입의 중심을 이동
  rotate(radians(-50));  
  
  // 왼쪽 입
  fill(255);
  noStroke();
  ellipse(5, 0, 85, 75);  // 중심이 (0, 0) 기준으로 타원을 그림
  popMatrix();  // 이전 좌표계로 복구
  
  // 왼쪽 입 회전
  pushMatrix();  // 현재 좌표계 저장
  translate(285, 385);  // 입의 중심을 이동
  rotate(radians(-50));  
  
  // 왼쪽 입
  noFill();
  stroke(0);
  strokeWeight(2);
  ellipse(0, 0, 95, 75);  // 중심이 (0, 0) 기준으로 타원을 그림
  popMatrix();  // 이전 좌표계로 복구
   
  // 코
  fill(0); 
  ellipse(320, 340, 50, 50); 
  
  // 수염
  stroke(0); 
  strokeWeight(2);
  line(275, 370, 220, 350); // 왼쪽 수염1
  line(275, 385, 220, 384); // 왼쪽 수염2
  line(275, 400, 220, 418); // 왼쪽 수염3
  line(365, 370, 410, 350); // 오른쪽 수염1
  line(365, 385, 410, 384); // 오른쪽 수염2
  line(365, 400, 410, 418); // 오른쪽 수염3
}

// 마우스 클릭 시 배경색을 무지개색
void mousePressed() {
  currentColorIndex = (currentColorIndex + 1) % rainbowColors.length;
  background(rainbowColors[currentColorIndex]);
}
