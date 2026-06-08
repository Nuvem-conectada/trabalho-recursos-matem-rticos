int mapaAtualX = 0;
int mapaAtualY = 0;

int sizeTile = 50;
PVector posPlayer;

color corChao = color(184, 91, 12);
color corParede = color(27, 69, 16);
color corJogador = color(50, 205, 50);
color corAgua = color(32, 56, 236);
color corCaverna = color(0, 0, 0);
color corInimigo = color(200, 30, 30);

int moedinhas=0;
color corMoedinha = color(250, 250, 0);

ArrayList<Inimigo> inimigos;

// Cópias originais dos mapas pra resetar quando entrar na sala
int[][] mapCentroOrig, mapCimaOrig, mapBaixoOrig, mapEsquerdaOrig, mapDireitaOrig;
int[][] mapDireitaDireitaOrig, mapDireitaCimaOrig, mapEsquerdaBaixoOrig, mapEsquerdaEsquerdaOrig, mapEsquerdaCimaOrig;

class Inimigo {
  PVector pos;
  int spawnX, spawnY;
  int ultimaMov = 0;
  int intervalo = 2000;

  Inimigo(int x, int y) {
    pos = new PVector(x, y);
    spawnX = x;
    spawnY = y;
    ultimaMov = millis();
  }

  void mover() {
    if (millis() - ultimaMov < intervalo) return;
    ultimaMov = millis();

    int distX = abs(int(pos.x) - int(posPlayer.x));
    int distY = abs(int(pos.y) - int(posPlayer.y));

    if (distX > 3 || distY > 3) return;

    int[][] mapa = getMapaAtual();
    int nx = int(pos.x);
    int ny = int(pos.y);

    if (pos.x < posPlayer.x) nx++;
    else if (pos.x > posPlayer.x) nx--;
    else if (pos.y < posPlayer.y) ny++;
    else if (pos.y > posPlayer.y) ny--;

    if (nx >= 0 && nx < 15 && ny >= 0 && ny < 15) {
      int bloco = mapa[ny][nx];
      if (bloco == 0 || bloco == 3 || bloco == 4) {
        pos.x = nx;
        pos.y = ny;
      }
    }
  }

  void desenhar() {
    fill(corInimigo);
    noStroke();
    rect(pos.x * sizeTile, pos.y * sizeTile, sizeTile, sizeTile);
  }
}

// Grids dos mapas - coloca 5 onde quiser spawnar inimigo
int[][] mapCentro = {
  {1,1,1,1,1,1,1,0,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,0,0,0,1,1,1,1,1,1},
  {1,1,1,1,1,0,0,0,0,1,1,1,1,1,1},
  {1,1,1,0,0,0,0,0,0,0,1,1,1,1,1},
  {1,1,1,0,0,0,0,0,0,0,5,1,1,1,1},
  {1,1,0,0,0,0,0,0,0,0,0,1,1,1,1},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {1,1,1,1,1,1,0,0,0,0,0,0,0,0,1},
  {1,1,1,1,1,0,0,0,0,0,0,0,0,0,1},
  {1,1,1,1,0,0,0,0,0,0,0,0,0,1,1},
  {1,1,1,1,0,0,0,0,0,0,0,1,1,1,1},
  {1,1,1,1,0,0,0,0,0,0,0,1,1,1,1},
  {1,1,1,1,1,1,0,0,0,0,0,1,1,1,1},
  {1,1,1,1,1,1,0,0,0,1,1,1,1,1,1},
  {1,1,1,1,1,1,0,0,0,1,1,1,1,1,1}
};

int[][] mapCima = {
  {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,1,1,0,0,4,0,0,0,1,1,0,1},
  {1,0,0,1,1,0,0,0,0,0,0,1,1,0,1},
  {1,0,0,0,0,0,1,1,1,0,0,0,0,0,1},
  {1,0,0,0,0,1,1,1,1,1,0,0,0,0,1},
  {1,0,4,0,0,1,1,1,1,1,0,0,4,0,1},
  {1,0,0,0,0,1,1,1,1,1,0,0,0,0,1},
  {1,0,0,0,0,0,1,1,1,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,4,0,0,0,0,0,0,4,0,0,1},
  {1,0,0,1,1,0,0,0,0,0,0,1,1,0,1},
  {1,0,0,1,1,0,0,4,0,0,0,1,1,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,1,1,1,1,1,0,0,0,1,1,1,1,1,1}
};

int[][] mapBaixo = {
  {1,1,1,1,1,1,0,0,0,1,1,1,1,1,1},
  {1,1,0,0,0,1,1,0,1,1,0,0,0,1,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,4,4,0,4,4,0,0,0,0,0,0,0,1},
  {1,0,4,4,4,4,4,0,0,0,0,0,0,0,1},
  {1,0,0,4,4,4,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,4,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,1,1},
  {1,0,0,2,2,2,2,2,2,2,2,2,0,0,1},
  {1,0,2,2,2,2,2,2,2,2,2,2,2,0,1},
  {1,2,2,2,2,2,2,2,2,2,2,2,2,2,1},
  {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
  {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2}
};

int[][] mapEsquerda = {
  {1,1,1,1,1,1,0,1,1,1,1,1,1,1,1},
  {1,1,1,0,0,0,0,0,0,0,0,0,1,1,1},
  {1,1,0,0,0,0,0,0,0,0,0,0,0,1,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,1,1,1,1,0,0,0,0,0,1},
  {0,0,0,0,1,1,1,1,1,1,0,0,0,0,0},
  {0,0,0,0,1,1,1,1,1,1,0,0,0,0,1},
  {0,0,0,0,1,1,1,1,1,1,0,0,0,0,1},
  {1,0,0,0,0,1,1,1,1,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,1,0,0,0,0,0,0,0,0,0,0,0,1,1},
  {1,1,1,0,0,0,0,0,0,0,0,0,1,1,1},
  {1,1,1,1,1,1,3,3,3,1,1,1,1,1,1}
};

int[][] mapDireita = {
  {1,1,1,1,1,1,0,0,0,1,1,1,1,1,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,4,1,0,0,0,1,0,0,0,1,4,0,1},
  {1,0,1,1,0,0,1,4,1,0,0,1,1,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {0,0,1,0,0,0,0,1,0,0,0,0,1,0,0},
  {1,0,4,1,0,0,1,1,1,0,0,1,4,0,0},
  {1,0,1,0,0,0,0,1,0,0,0,0,1,0,0},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,1,1,0,0,1,4,1,0,0,1,1,0,1},
  {1,0,4,1,0,0,0,1,0,0,0,1,4,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
};

int[][] mapDireitaDireita = {
  {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,0,0,0,0,0,1,1,1,1,1},
  {1,1,1,1,0,0,0,0,0,0,0,1,1,1,1},
  {1,1,1,0,0,0,0,0,0,0,0,0,1,1,1},
  {1,1,0,0,0,0,0,0,0,0,0,0,0,1,1},
  {1,0,0,0,4,0,0,0,0,4,0,0,0,0,1},
  {0,0,0,0,4,0,0,0,0,4,0,0,0,0,1},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {0,0,0,4,0,0,0,0,0,0,4,0,0,0,2},
  {1,0,0,0,4,0,0,0,0,4,0,0,0,2,2},
  {1,0,0,0,0,4,4,4,4,0,0,2,2,2,2},
  {2,2,2,0,0,0,0,0,0,0,2,2,2,2,2},
  {2,2,2,2,0,0,0,0,0,2,2,2,2,2,1},
  {2,2,2,2,2,2,0,0,2,2,2,2,2,1,1},
  {2,2,2,2,2,2,2,2,2,2,2,2,1,1,1}
};

int[][] mapDireitaCima = {
  {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  {1,1,4,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,1,0,0,0,1,1,1,1,1,1,1,1},
  {1,0,0,1,0,1,1,1,0,0,0,0,0,0,1},
  {1,0,0,1,1,1,0,0,0,1,0,1,1,1,1},
  {1,1,0,0,0,0,0,1,0,1,0,0,1,4,1},
  {1,0,1,0,1,4,0,1,0,1,0,1,1,0,1},
  {1,0,0,0,1,1,1,1,0,1,0,0,1,0,1},
  {1,0,1,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,1,0,1,1,1,1,1,1,1,0,1,0,1},
  {1,0,1,0,1,1,1,1,1,1,1,0,1,0,1},
  {1,0,1,0,0,0,0,0,0,0,1,0,1,4,1},
  {1,1,1,0,1,1,0,1,1,1,1,0,1,1,1},
  {1,0,0,0,4,1,0,1,0,0,0,0,1,1,1},
  {1,1,1,1,1,1,0,0,0,1,1,1,1,1,1}
};

int[][] mapEsquerdaBaixo = {
  {1,1,1,1,1,1,0,0,0,1,1,1,1,1,1},
  {1,1,1,0,0,0,0,0,0,0,0,0,1,1,1},
  {1,1,0,0,0,0,0,0,0,0,0,0,0,1,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,1,2,2,2,1,0,0,0,0,1},
  {1,1,0,0,1,2,2,0,2,2,1,0,0,1,1},
  {1,1,0,1,2,2,0,0,0,2,2,1,0,1,1},
  {1,1,0,1,2,0,0,4,0,0,2,1,0,1,1},
  {1,1,0,1,2,2,0,0,0,2,2,1,0,1,1},
  {1,0,0,0,1,2,2,0,2,2,1,0,0,0,1},
  {1,0,0,0,0,1,2,0,2,1,0,0,0,0,1},
  {1,1,0,0,0,0,0,0,0,0,0,0,0,1,1},
  {1,1,1,0,0,0,0,0,0,0,0,0,1,1,1},
  {1,1,1,1,0,0,0,0,0,0,0,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
};

int[][] mapEsquerdaEsquerda = {
  {1,1,2,2,2,2,1,1,1,1,1,1,1,1,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,2,2,2,0,0,0,0,0,0,0,0,1},
  {1,0,0,2,2,2,0,0,0,0,0,0,0,0,1},
  {1,0,0,2,2,2,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,2,2,2,0,0,0,0,0,0,0,1},
  {1,0,0,0,2,2,2,0,0,0,0,0,0,0,0},
  {1,0,0,0,2,2,2,0,0,0,0,0,0,0,0},
  {1,0,0,0,0,2,2,2,0,0,0,0,0,0,0},
  {1,0,0,0,0,0,2,2,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,2,2,0,0,0,0,0,0,1},
  {1,4,4,4,4,4,2,2,0,0,0,0,0,0,1},
  {1,4,4,4,4,2,2,2,0,0,0,0,0,0,1},
  {1,4,4,4,2,2,2,0,0,0,0,0,0,0,1},
  {1,1,1,1,2,2,1,1,1,1,1,1,1,1,1}
};

int[][] mapEsquerdaCima = {
  {1,2,2,1,1,1,1,1,1,1,1,1,1,1,1},
  {2,2,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {2,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {2,0,0,0,0,0,0,4,4,4,0,0,0,0,1},
  {1,0,0,0,0,0,4,0,0,0,4,0,0,0,1},
  {2,0,0,0,0,0,4,0,0,0,4,0,0,0,1},
  {2,2,0,0,0,0,0,0,4,4,0,0,0,0,1},
  {2,2,0,0,0,0,0,0,4,0,0,0,0,0,1},
  {2,2,2,0,0,0,0,0,4,0,0,0,0,0,1},
  {2,2,2,0,0,0,0,0,0,0,0,0,0,0,1},
  {2,2,2,0,0,0,0,0,4,0,0,0,0,0,1},
  {1,2,2,2,0,0,0,0,0,0,0,0,0,0,1},
  {1,2,2,2,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,2,2,0,0,0,0,0,0,0,0,0,0,1},
  {1,1,1,1,1,1,0,1,1,1,1,1,1,1,1}
};

// Cola mapBaixo, mapEsquerda, mapDireita, mapDireitaDireita, mapDireitaCima,
// mapEsquerdaBaixo, mapEsquerdaEsquerda, mapEsquerdaCima aqui igual ao teu código

void setup() {
  size(750, 750);
  posPlayer = new PVector(7, 7);
  inimigos = new ArrayList<Inimigo>();

  // Salva cópias originais
  mapCentroOrig = copiarMapa(mapCentro);
  mapCimaOrig = copiarMapa(mapCima);
  mapBaixoOrig = copiarMapa(mapBaixo);
  mapEsquerdaOrig = copiarMapa(mapEsquerda);
  mapDireitaOrig = copiarMapa(mapDireita);
  mapDireitaDireitaOrig = copiarMapa(mapDireitaDireita);
  mapDireitaCimaOrig = copiarMapa(mapDireitaCima);
  mapEsquerdaBaixoOrig = copiarMapa(mapEsquerdaBaixo);
  mapEsquerdaEsquerdaOrig = copiarMapa(mapEsquerdaEsquerda);
  mapEsquerdaCimaOrig = copiarMapa(mapEsquerdaCima);

  entrarSala(); // carrega a sala inicial
}

void draw() {
  background(corChao);
  drawMap();
  drawPlayer();

  for (Inimigo e : inimigos) {
    e.mover();
    e.desenhar();

    // Se atingido: REINICIA O JOGO INTEIRO
    if (int(e.pos.x) == int(posPlayer.x) && int(e.pos.y) == int(posPlayer.y)) {
      reiniciarJogo();
    }
  }
}

int[][] copiarMapa(int[][] original) {
  int[][] copia = new int[15][15];
  for (int i = 0; i < 15; i++)
    for (int j = 0; j < 15; j++)
      copia[i][j] = original[i][j];
  return copia;
}

void reiniciarJogo() {
  mapaAtualX = 0;
  mapaAtualY = 0;
  posPlayer.x = 7;
  posPlayer.y = 7;
  moedinhas = 0;
  entrarSala();
}

void entrarSala() {
  // Restaura o mapa atual da cópia original
  int[][] orig = getMapaOriginalPorCoordenada(mapaAtualX, mapaAtualY);
  int[][] atual = getMapaPorCoordenada(mapaAtualX, mapaAtualY);
  for (int i = 0; i < 15; i++)
    for (int j = 0; j < 15; j++)
      atual[i][j] = orig[i][j];

  spawnInimigosDoMapa();
}

int[][] getMapaOriginalPorCoordenada(int x, int y) {
  if (x == 1 && y == 0) return mapDireitaOrig;
  if (x == 1 && y == -1) return mapDireitaCimaOrig;
  if (x == 2 && y == 0) return mapDireitaDireitaOrig;
  if (x == -1 && y == 0) return mapEsquerdaOrig;
  if (x == -1 && y == -1) return mapEsquerdaCimaOrig;
  if (x == -1 && y == 1) return mapEsquerdaBaixoOrig;
  if (x == -2 && y == 0) return mapEsquerdaEsquerdaOrig;
  if (x == 0 && y == -1) return mapCimaOrig;
  if (x == 0 && y == 1) return mapBaixoOrig;
  return mapCentroOrig;
}

int[][] getMapaPorCoordenada(int x, int y) {
  if (x == 1 && y == 0) return mapDireita;
  if (x == 1 && y == -1) return mapDireitaCima;
  if (x == 2 && y == 0) return mapDireitaDireita;
  if (x == -1 && y == 0) return mapEsquerda;
  if (x == -1 && y == -1) return mapEsquerdaCima;
  if (x == -1 && y == 1) return mapEsquerdaBaixo;
  if (x == -2 && y == 0) return mapEsquerdaEsquerda;
  if (x == 0 && y == -1) return mapCima;
  if (x == 0 && y == 1) return mapBaixo;
  return mapCentro;
}

int[][] getMapaAtual() {
  return getMapaPorCoordenada(mapaAtualX, mapaAtualY);
}

void spawnInimigosDoMapa() {
  inimigos.clear();
  int[][] mapa = getMapaAtual();

  for (int i = 0; i < 15; i++) {
    for (int j = 0; j < 15; j++) {
      if (mapa[i][j] == 5) {
        inimigos.add(new Inimigo(j, i));
        mapa[i][j] = 0;
      }
    }
  }
}

void drawMap() {
  int[][] mapa = getMapaAtual();
  stroke(40, 30);

  for (int i = 0; i < 15; i++) {
    for (int j = 0; j < 15; j++) {
      if (mapa[i][j] == 0) {
        fill(corChao);
        rect(j * sizeTile, i * sizeTile, sizeTile, sizeTile);
      }
      else if (mapa[i][j] == 2) {
        fill(corAgua);
        rect(j * sizeTile, i * sizeTile, sizeTile, sizeTile);
      }
      else if (mapa[i][j] == 3) {
        fill(corCaverna);
        rect(j * sizeTile, i * sizeTile, sizeTile, sizeTile);
      }
      else if (mapa[i][j] == 4) {
        fill(corMoedinha);
        ellipse(j * sizeTile + sizeTile/2, i * sizeTile + sizeTile/2, sizeTile*0.6, sizeTile*0.6);
      }
      else {
        fill(corChao);
        rect(j * sizeTile, i * sizeTile, sizeTile, sizeTile);
        fill(corParede);
        ellipse(j * sizeTile + sizeTile/2, i * sizeTile + sizeTile/2, sizeTile, sizeTile);
      }
    }
  }
  fill(255);
  textSize(20);
  text("moedas: " + moedinhas, 10, 30);
}

void drawPlayer() {
  fill(corJogador);
  noStroke();
  rect(posPlayer.x * sizeTile, posPlayer.y * sizeTile, sizeTile, sizeTile);
}

void keyPressed() {
  int nx = int(posPlayer.x);
  int ny = int(posPlayer.y);

  int proximoMapaX = mapaAtualX;
  int proximoMapaY = mapaAtualY;

  if (key == 'd' || key == 'D') nx++;
  if (key == 'a' || key == 'A') nx--;
  if (key == 'w' || key == 'W') ny--;
  if (key == 's' || key == 'S') ny++;

  if (nx > 14) { proximoMapaX++; nx = 0; }
  if (nx < 0) { proximoMapaX--; nx = 14; }
  if (ny > 14) { proximoMapaY++; ny = 0; }
  if (ny < 0) { proximoMapaY--; ny = 14; }

  int[][] mapaDestino = getMapaPorCoordenada(proximoMapaX, proximoMapaY);

  if (mapaDestino!= null) {
    int blocoAlvo = mapaDestino[ny][nx];

    if (blocoAlvo == 0 || blocoAlvo == 3 || blocoAlvo == 4) {
      if (blocoAlvo == 4) {
        moedinhas++;
        mapaDestino[ny][nx] = 0;
      }

      boolean mudouMapa = (proximoMapaX!= mapaAtualX || proximoMapaY!= mapaAtualY);

      mapaAtualX = proximoMapaX;
      mapaAtualY = proximoMapaY;
      posPlayer.x = nx;
      posPlayer.y = ny;

      if (mudouMapa) {
        entrarSala(); // reseta mapa + spawna inimigos
      }
    }
  }
}
