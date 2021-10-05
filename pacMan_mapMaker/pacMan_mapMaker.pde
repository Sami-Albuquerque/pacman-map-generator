int largura = 30;
int altura = 15;
int tileLargura;
int count = 0;
boolean start, end, spawned, right, left, up, down;
int pacLinha, pacColuna;
int bloquinhos [][] = new int [largura][altura];

void setup(){
  size(1200, 600);
  colorMode(HSB, 360, 100, 100);
  textAlign(CENTER);
  ellipseMode(CENTER);
  textAlign(CENTER);

  tileLargura = width/largura;
  for (int linha = 0; linha < largura; linha++) {
    for (int coluna = 0; coluna < altura; coluna++) {
      bloquinhos[linha][coluna] = 0;
    }
  }
}

void draw(){
  for (int linha = 0; linha < largura; linha++) {
    for (int coluna = 0; coluna < altura; coluna++) {
      desenhar(linha, coluna);
    }
  }
  if(spawned)
    drawPacMan();
    
  if(spawned && count == 0) {
    end = true;
    fill(284, 100, 100);
    textSize(25);
    rect(width/10, height/4, (width/3 * 2) + width/7.5, height/2 + height/20);
    fill(55, 100, 100);
    text("Fim de jogo! Clique em qualquer tecla\npara continuar!", width/2, height/2);
  }
}

//Adicionei os dois para poder dar ao usuário uma melhor usabilidade
void mouseDragged(){
  int linha = mouseX/tileLargura;
  int coluna = mouseY/tileLargura;
  
  if(mouseButton == LEFT && start == false){
    bloquinhos[linha][coluna] = 1;
  }
  else if(mouseButton == RIGHT && start == false){
    bloquinhos[linha][coluna] = 0;
  }
}

void mousePressed(){
  int linha = mouseX/tileLargura;
  int coluna = mouseY/tileLargura;
  
  if(mouseButton == LEFT && start == false){
    bloquinhos[linha][coluna] = 1;
  }
  else if(mouseButton == RIGHT && start == false){
    bloquinhos[linha][coluna] = 0;
  }
}

void keyPressed(){
  if (keyCode == RIGHT && start == true){
    if (pacLinha + 1 < largura && bloquinhos[pacLinha + 1][pacColuna] != 1){
      pacLinha++;
      right = true;
      left = false;
      up = false;
      down = false;
      if(bloquinhos[pacLinha][pacColuna] == 2) {
        bloquinhos[pacLinha][pacColuna] = 0;
        count--;
      }
    }
  }
  else if (keyCode == LEFT && start == true){
    if (pacLinha - 1 >= 0 && bloquinhos[pacLinha - 1][pacColuna] != 1){
      pacLinha--;
      right = false;
      left = true;
      up = false;
      down = false;
      if(bloquinhos[pacLinha][pacColuna] == 2) {
        bloquinhos[pacLinha][pacColuna] = 0;
        count--;
      }
    }
  }
  else if (keyCode == UP && start == true){
    if (pacColuna - 1 >= 0 && bloquinhos[pacLinha][pacColuna - 1] != 1){
      pacColuna--;
      right = false;
      left = false;
      up = true;
      down = false;
      if(bloquinhos[pacLinha][pacColuna] == 2) {
        bloquinhos[pacLinha][pacColuna] = 0;
        count--;
      }
    }
  }
  else if (keyCode == DOWN && start == true){
    if (pacColuna + 1 < altura && bloquinhos[pacLinha][pacColuna + 1] != 1){
      pacColuna++;
      right = false;
      left = false;
      up = false;
      down = true;
      if(bloquinhos[pacLinha][pacColuna] == 2) {
        bloquinhos[pacLinha][pacColuna] = 0;
        count--;
      }
    }
  }
  else if (keyCode == ENTER && end == false){
    start = true;
    for (int linha = 0; linha < largura; linha++) {
      for (int coluna = 0; coluna < altura; coluna++) {
        if(bloquinhos[linha][coluna] == 0) {
          bloquinhos[linha][coluna] = 2;
          count++;
        }
      }
    }
    count = count - 1;
    spawnPacMan();
  }
  else {
    start = false;
    end = false;
    spawned = false;
    setup();
  }
}

void desenhar(int linha, int coluna){
  if (bloquinhos[linha][coluna] == 0) {
    elemento(311, 45, 0, 0, linha, coluna);
  }
  else if (bloquinhos[linha][coluna] == 1){
    elemento(325, 95, 100, 1, linha, coluna);
  }
  else if (bloquinhos[linha][coluna] == 2){
    elemento(311, 45, 0, 2, linha, coluna);
  }
}

void elemento(int H, int S, int B, int tipo, int linha, int coluna){
  stroke(284, 100, 100);
  if(tipo == 0){
    fill(H, S, B);
    rect(linha * tileLargura, coluna * tileLargura, (linha + 1) * tileLargura, (linha + 1) * tileLargura);
  }
  else if(tipo == 1){
    fill(H, S, B);
    rect(linha * tileLargura, coluna * tileLargura, (linha + 1) * tileLargura, (linha + 1) * tileLargura);
  }
  else {
    fill(H, S, B);
    rect(linha * tileLargura, coluna * tileLargura, (linha + 1) * tileLargura, (linha + 1) * tileLargura);
    fill(310, 50, 100);
    noStroke();
    circle(linha * tileLargura + tileLargura/2, coluna * tileLargura + tileLargura/2, (tileLargura/10) * 2);
    stroke(0);
  }
  stroke(0);
}

void spawnPacMan(){
  if(start){
    boolean stop = false;
    boolean found = false;
    for (int linha = 0; linha < largura; linha++) {
      for (int coluna = 0; coluna < altura; coluna++) {
        if(bloquinhos[linha][coluna] == 2){
          if(!found){
            bloquinhos[linha][coluna] = 0;
            pacLinha = linha;
            pacColuna = coluna;
            spawned = true;
            found = true;
            right = true;
          }
          stop = true;
          break;
        }
        if(stop)
          break;
      }
    }
  }
}

void drawPacMan(){
  noStroke();
  fill(57, 100, 100);
  circle(pacLinha * tileLargura + tileLargura/2, pacColuna * tileLargura + tileLargura/2, (tileLargura/2.8) * 2);
  
  if(right){
    fill(43, 95, 91);
    circle(pacLinha * tileLargura + (tileLargura/3.5 * 1.8), pacColuna * tileLargura + tileLargura/2 - tileLargura/8.5 * 2, (tileLargura/15) * 2);
    arc(pacLinha * tileLargura + tileLargura/2, pacColuna * tileLargura + tileLargura/2, tileLargura/1.4, tileLargura/1.4, 0 - QUARTER_PI, PI - HALF_PI - QUARTER_PI);
  }
  else if(left){
    fill(43, 95, 91);
    circle(pacLinha * tileLargura + (tileLargura/3.5 * 1.8), pacColuna * tileLargura + tileLargura/2 - tileLargura/8.5 * 2, (tileLargura/15) * 2);
    arc(pacLinha * tileLargura + tileLargura/2, pacColuna * tileLargura + tileLargura/2, tileLargura/1.4, tileLargura/1.4, PI - QUARTER_PI, PI + QUARTER_PI);
  }
  else if(up){
    fill(43, 95, 91);
    circle(pacLinha * tileLargura + (tileLargura/3.5 * 2.5), pacColuna * tileLargura + tileLargura/2, (tileLargura/15) * 2);
    arc(pacLinha * tileLargura + tileLargura/2, pacColuna * tileLargura + tileLargura/2, tileLargura/1.4, tileLargura/1.4, 0 + PI + QUARTER_PI, PI + HALF_PI + QUARTER_PI);
  }
  else if(down){
    fill(43, 95, 91);
    circle(pacLinha * tileLargura + (tileLargura/3.5 * 2.5), pacColuna * tileLargura + tileLargura/2, (tileLargura/15) * 2);
    arc(pacLinha * tileLargura + tileLargura/2, pacColuna * tileLargura + tileLargura/2, tileLargura/1.4, tileLargura/1.4, 0 + QUARTER_PI, PI - QUARTER_PI);
  }
  stroke(0);
}
