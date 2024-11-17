// ChatGPT 기반으로 제작함

ArrayList<InteractionSource> interactionSources; 
int cols, rows;  
float[][] current, previous; // 현재 프레임의 파동 상태와 이전 프레임의 상태를 저장
float damping = 0.99; // Q. 파동이 상호작용과 만나 약해지려면? 파동의 감쇠율, 값이 작을수록 파동이 더 빨리 약해진다

void setup() {
  fullScreen(); 
  //Q. 초기 구문 ~한 인터랙션 코드를 구현하려고 한다 ~ 조건을 지켜 초기 구문을 작성해줘
  //(초기 구문 작성 시 구현 된 코드이고 몰랐던 내용들 각주)
  cols = displayWidth; // 화면의 가로 픽셀 수를 열의 수로 설정
  rows = displayHeight; // 화면의 세로 픽셀 수를 행의 수로 설정
  current = new float[cols][rows]; // 현재 상태를 저장하는 배열 초기화
  previous = new float[cols][rows]; // 이전 상태를 저장하는 배열 초기화
  interactionSources = new ArrayList<InteractionSource>(); // 상호작용 리스트 초기화
  // Q. 화면 중심에 기본 상호작용 추가 > 이후 수정
  interactionSources.add(new InteractionSource(displayWidth / 2, displayHeight / 2, 200, 0.1));
  noStroke();
}

void draw() {
  background(20);
  loadPixels(); // 화면 픽셀 데이터를 처리할 준비

  // Q. 상호작용들끼리 서로의 영향을 미치게 하는 값 계산
  for (InteractionSource is : interactionSources) {
    is.updateInfluence(current, previous); // 현재와 이전 상태에 영향을 적용
  }

  // 파동 시뮬레이션 업데이트
  for (int x = 1; x < cols - 1; x++) { // 가장자리를 제외한 열 순회
    for (int y = 1; y < rows - 1; y++) { // 가장자리를 제외한 행 순회
      // 파동 계산: 주변 픽셀의 평균 값을 사용해 새로운 상태 결정
      current[x][y] = (
        previous[x-1][y] + // 왼쪽 픽셀
        previous[x+1][y] + // 오른쪽 픽셀
        previous[x][y-1] + // 위쪽 픽셀
        previous[x][y+1]   // 아래쪽 픽셀
      ) / 2 - current[x][y]; // 중앙 값을 업데이트
      //Q. 파동이 상호작용의 영향을 받아 약해지려면?
      current[x][y] *= damping; // 감쇠율 적용
     
      float colorValue = map(current[x][y], -1, 1, 0, 255); // 픽셀의 색상 값을 계산하는데 파동 값 > 색상 값으로 매핑하기
      colorValue = constrain(colorValue, 0, 255); //
      pixels[x + y * displayWidth] = color(colorValue, colorValue * 0.7, 255 - colorValue);
    }
  }
  updatePixels(); // 업데이트된 픽셀 데이터를 화면에 반영

  // 이전 상태를 현재 상태로 갱신 (배열 교환)
  float[][] temp = previous;
  previous = current;
  current = temp;

  for (int i = interactionSources.size() - 1; i >= 0; i--) { // Q. -- 처음 구현해서 구현 코드 예문 받음. 리스트를 뒤에서부터 순회
    InteractionSource is = interactionSources.get(i);
    if (is.isExpired()) { 
      interactionSources.remove(i);
    }
  }
  fill(255);
  textSize(20);
  //Q, "Interaction Sources: " 상단 위에 출력하기
  text("Interaction Sources: " + interactionSources.size(), 20, 30);
}

void mouseDragged() {
  //Q. 드래그로 상호 작용 추가하는 코드 작성 > 이후 수정
  interactionSources.add(new InteractionSource(mouseX, mouseY, random(100, 300), random(0.05, 0.1)));
}

void mousePressed() {
  int x = mouseX; 
  int y = mouseY; 
  //Q. 화면 내부에 파동을 생성할 시 if 코드 작성 후 > 이후  GPT 수정 
  if (x > 0 && x < cols && y > 0 && y < rows) { // 클릭 위치가 화면 내부일 경우
    previous[x][y] = 255; 
  }
}

class InteractionSource {
  //Q. error 뜨는 구문 복사 >  GPT가 수정
  PVector position;
  float radius; 
  float strength; 
  int createTime; 

  
  InteractionSource(float x, float y, float radius, float strength) {
    //Q. 마찬가지 포지션 에러 > GPT 구문 수정
    this.position = new PVector(x, y); // 위치 설정
    this.radius = radius; 
    this.strength = strength; 
    this.createTime = millis();
  }

  // Q. 상호작용 요소와 파동이 서로 상호작용 할 수 있게 요소의 중심이 파동을 흡입하는 듯하 인터랙션 구현하기
  void updateInfluence(float[][] current, float[][] previous) {
    // 영향을 줄 수 있는 그리드 범위 계산
    int startX = max(1, int(position.x - radius));
    int endX = min(cols - 1, int(position.x + radius));
    int startY = max(1, int(position.y - radius));
    int endY = min(rows - 1, int(position.y + radius));

    for (int x = startX; x < endX; x++) { // X 좌표 순회
      for (int y = startY; y < endY; y++) { // Y 좌표 순회
        PVector dir = PVector.sub(position, new PVector(x, y)); // 상호작용 중심과 현재 위치 사이의 방향 벡터 값으로 계산
        float distance = dir.mag(); // 중심과의 거리 계산
        if (distance < radius) { // 상호작용 반경 안에 있는 경우에만 영향 작용하기
          float influence = map(distance, 0, radius, 1, 0); // 거리 기반 영향 계산하기
          dir.normalize(); // 방향 벡터 정규화
          current[x][y] += dir.x * strength * influence; // X축 영향을 현재 상태에 추가하기
          current[x][y] += dir.y * strength * influence; // Y축 영향을 현재 상태에 ''
          previous[x][y] += dir.x * strength * influence; // X축 영향을 이전 상태에 ''
          previous[x][y] += dir.y * strength * influence; // Y축 영향을 이전 상태에 ''
        }
      }
    }
  }

  boolean isExpired() {
    return millis() - createTime > 3000;
  }
}
