//The neighbours function cycles through each neighbouring lattice point and checks if it is on.
//It then sets 'count' to the number of neighbours

void neighbours(int x, int y, int z)
{
  int posX = x;
  int posY = y;
  int posZ = z;
  count = 0;
  
  //Note that the neighbour positions are different for odd and even Z values. 

  if (posZ%2 == 0) {
    if (lattice      [posX      ]  [posY      ]  [posZ  +2  ]  .on == true) {count = count + 1;} //1
    if (lattice      [posX  -1  ]  [posY  -1  ]  [posZ  +1  ]  .on == true) {count = count + 1;} //2
    if (lattice      [posX      ]  [posY  -1  ]  [posZ  +1  ]  .on == true) {count = count + 1;} //3
    if (lattice      [posX  -1  ]  [posY      ]  [posZ  +1  ]  .on == true) {count = count + 1;} //4
    if (lattice      [posX      ]  [posY      ]  [posZ  +1  ]  .on == true) {count = count + 1;} //5
    if (lattice      [posX  -1  ]  [posY      ]  [posZ      ]  .on == true) {count = count + 1;} //6
    if (lattice      [posX      ]  [posY  -1  ]  [posZ      ]  .on == true) {count = count + 1;} //7
    if (lattice      [posX  +1  ]  [posY      ]  [posZ      ]  .on == true) {count = count + 1;} //8
    if (lattice      [posX      ]  [posY  +1  ]  [posZ      ]  .on == true) {count = count + 1;} //9
    if (lattice      [posX  -1  ]  [posY  -1  ]  [posZ  -1  ]  .on == true) {count = count + 1;} //10
    if (lattice      [posX      ]  [posY  -1  ]  [posZ  -1  ]  .on == true) {count = count + 1;} //11
    if (lattice      [posX  -1  ]  [posY      ]  [posZ  -1  ]  .on == true) {count = count + 1;} //12
    if (lattice      [posX      ]  [posY      ]  [posZ  -1  ]  .on == true) {count = count + 1;} //13
    if (lattice      [posX      ]  [posY      ]  [posZ  -2  ]  .on == true) {count = count + 1;} //14
  } 
  else {
    if (lattice      [posX      ]  [posY      ]  [posZ  +2  ]  .on == true) {count = count + 1;} //1
    if (lattice      [posX  +1  ]  [posY  +1  ]  [posZ  +1  ]  .on == true) {count = count + 1;} //2
    if (lattice      [posX      ]  [posY  +1  ]  [posZ  +1  ]  .on == true) {count = count + 1;} //3
    if (lattice      [posX  +1  ]  [posY      ]  [posZ  +1  ]  .on == true) {count = count + 1;} //4
    if (lattice      [posX      ]  [posY      ]  [posZ  +1  ]  .on == true) {count = count + 1;} //5
    if (lattice      [posX  -1  ]  [posY      ]  [posZ      ]  .on == true) {count = count + 1;} //6
    if (lattice      [posX      ]  [posY  -1  ]  [posZ      ]  .on == true) {count = count + 1;} //7
    if (lattice      [posX  +1  ]  [posY      ]  [posZ      ]  .on == true) {count = count + 1;} //8
    if (lattice      [posX      ]  [posY  +1  ]  [posZ      ]  .on == true) {count = count + 1;} //9
    if (lattice      [posX  +1  ]  [posY  +1  ]  [posZ  -1  ]  .on == true) {count = count + 1;} //10
    if (lattice      [posX      ]  [posY  +1  ]  [posZ  -1  ]  .on == true) {count = count + 1;} //11
    if (lattice      [posX  +1  ]  [posY      ]  [posZ  -1  ]  .on == true) {count = count + 1;} //12
    if (lattice      [posX      ]  [posY      ]  [posZ  -1  ]  .on == true) {count = count + 1;} //13
    if (lattice      [posX      ]  [posY      ]  [posZ  -2  ]  .on == true) {count = count + 1;} //14
  } 
}

//The grow function grows a new cell in a random direction, with the probablility for different 
//directions set by weighting. 

void grow(int x, int y, int z) {
  int posX = x;
  int posY = y;
  int posZ = z;
  float dir = random(1);
  
  float W1 = 5;
  
  float W2 = 3;
  float W3 = 3;
  float W4 = 3;
  float W5 = 3;
  
  float W6 = 1;
  float W7 = 1;
  float W8 = 1;
  float W9 = 1;
  
  float W10 = 3;
  float W11 = 3;
  float W12 = 3;
  float W13 = 3;
  
  float W14 = 5;
  
  float sumW = W1 + W2 + W3 + W4 + W5 + W6 + W7 + W8 + W9 + W10 + W11 + W12 + W13 + W14;
  
  if (dir<(W1/sumW)) {
    lattice[posX      ]  [posY      ]  [posZ  +2  ].on = true; //1
  }
  else if (dir<((W1+W2)/sumW) && posZ%2 == 0) {
    lattice[posX  -1  ]  [posY  -1  ]  [posZ  +1  ].on = true; //2
  }
  else if (dir<((W1+W2)/sumW)) {
    lattice[posX  +1  ]  [posY  +1  ]  [posZ  +1  ].on = true; //2
  }
  else if (dir<((W1+W2+W3)/sumW) && posZ%2 == 0) {
    lattice[posX      ]  [posY  -1  ]  [posZ  +1  ].on = true; //3
  }
  else if (dir<((W1+W2+W3)/sumW)) {
    lattice[posX      ]  [posY  +1  ]  [posZ  +1  ].on = true; //3
  }
  else if (dir<((W1+W2+W3+W4)/sumW) && posZ%2 == 0) {
    lattice[posX  -1  ]  [posY      ]  [posZ  +1  ].on = true; //4
  }
  else if (dir<((W1+W2+W3+W4)/sumW)) {
    lattice[posX  +1  ]  [posY      ]  [posZ  +1  ].on = true; //4
  }
  else if (dir<((W1+W2+W3+W4+W5)/sumW)) {
    lattice[posX      ]  [posY      ]  [posZ  +1  ].on = true; //5
  }
  else if (dir<((W1+W2+W3+W4+W5+W6)/sumW)) {
    lattice[posX  -1  ]  [posY      ]  [posZ      ].on = true; //6
  }
  else if (dir<((W1+W2+W3+W4+W5+W6+W7)/sumW)) {
    lattice[posX      ]  [posY  -1  ]  [posZ      ].on = true; //7
  }
  else if (dir<((W1+W2+W3+W4+W5+W6+W7+W8)/sumW)) {
    lattice[posX  +1  ]  [posY      ]  [posZ      ].on = true; //8
  }
  else if (dir<((W1+W2+W3+W4+W5+W6+W7+W8+W9)/sumW)) {
    lattice[posX      ]  [posY  +1  ]  [posZ      ].on = true; //9
  }
  else if (dir<((W1+W2+W3+W4+W5+W6+W7+W8+W9+W10)/sumW) && posZ%2 == 0) {
    lattice[posX  -1  ]  [posY  -1  ]  [posZ  -1  ].on = true; //10
  }
  else if (dir<((W1+W2+W3+W4+W5+W6+W7+W8+W9+W10)/sumW)) {
    lattice[posX  +1  ]  [posY  +1  ]  [posZ  -1  ].on = true; //10
  }
  else if (dir<((W1+W2+W3+W4+W5+W6+W7+W8+W9+W10+W11)/sumW) && posZ%2 == 0) {
    lattice[posX      ]  [posY  -1  ]  [posZ  -1  ].on = true; //11
  }
  else if (dir<((W1+W2+W3+W4+W5+W6+W7+W8+W9+W10+W11)/sumW)) {
    lattice[posX      ]  [posY  +1  ]  [posZ  -1  ].on = true; //11
  }
  else if (dir<((W1+W2+W3+W4+W5+W6+W7+W8+W9+W10+W11+W12)/sumW) && posZ%2 == 0) {
    lattice[posX  -1  ]  [posY      ]  [posZ  -1  ].on = true; //12
  }
  else if (dir<((W1+W2+W3+W4+W5+W6+W7+W8+W9+W10+W11+W12)/sumW)) {
    lattice[posX  +1  ]  [posY      ]  [posZ  -1  ].on = true; //12
  }
  else if (dir<((W1+W2+W3+W4+W5+W6+W7+W8+W9+W10+W11+W12+W13)/sumW)) {
    lattice[posX      ]  [posY      ]  [posZ  -1  ].on = true; //13
  }
  else if (dir<((W1+W2+W3+W4+W5+W6+W7+W8+W9+W10+W11+W12+W13+W14)/sumW)) {
    lattice[posX      ]  [posY      ]  [posZ  -2  ].on = true; //14
  }
}

