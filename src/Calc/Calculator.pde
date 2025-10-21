// Franklin Roth | 25 Sept 2025 | Calculator

Button[] buttons = new Button[12];
Button[] numButtons = new Button[10];

float l, r, result;
boolean left;
String dVal;
String op;

void setup() {
  size(460, 330);
  background(#CCDBA8);
  left = true;
  l = 0.0;
  r = 0.0;
  result = 0.0;
  dVal = "0.0";
  op = "";

  buttons[0] = new Button(65, 40, 90, 40, 'C', #FF0000, #C60000);

  buttons[1] = new Button(140, 40, 40, 40, '±', 255, 225);
  buttons[2] = new Button(190, 40, 40, 40, '%', 255, 225);
  buttons[3] = new Button(40, 290, 40, 40, '.', 255, 225);
  buttons[4] = new Button(40, 90, 40, 40, '^', 255, 225);
  buttons[5] = new Button(90, 90, 40, 40, '√', 255, 225);
  buttons[6] = new Button(140, 90, 40, 40, 'π', 255, 225);

  buttons[7] = new Button(190, 90, 40, 40, '÷', #FFE200, #E8CD00);
  buttons[8] = new Button(190, 140, 40, 40, '*', #FFE200, #E8CD00);
  buttons[9] = new Button(190, 190, 40, 40, '-', #FFE200, #E8CD00);
  buttons[10] = new Button(190, 240, 40, 40, '+', #FFE200, #E8CD00);
  buttons[11] = new Button(165, 290, 90, 40, '=', #FF6200, #D34E00);

  numButtons[9] = new Button(140, 140, 40, 40, '9', #BCBCBC, #D1D1D1);
  numButtons[8] = new Button(90, 140, 40, 40, '8', #BCBCBC, #D1D1D1);
  numButtons[7] = new Button(40, 140, 40, 40, '7', #BCBCBC, #D1D1D1);
  numButtons[6] = new Button(140, 190, 40, 40, '6', #BCBCBC, #D1D1D1);
  numButtons[5] = new Button(90, 190, 40, 40, '5', #BCBCBC, #D1D1D1);
  numButtons[4] = new Button(40, 190, 40, 40, '4', #BCBCBC, #D1D1D1);
  numButtons[3] = new Button(140, 240, 40, 40, '3', #BCBCBC, #D1D1D1);
  numButtons[2] = new Button(90, 240, 40, 40, '2', #BCBCBC, #D1D1D1);
  numButtons[1] = new Button(40, 240, 40, 40, '1', #BCBCBC, #D1D1D1);
  numButtons[0] = new Button(90, 290, 40, 40, '0', #BCBCBC, #D1D1D1);
}

void draw() {
  background(#CCDBA8);
  for (int i=0; i<buttons.length; i++) {
    buttons[i].display();
    buttons[i].hover(mouseX, mouseY);
  }

  for (int i=0; i<numButtons.length; i++) {
    numButtons[i].display();
    numButtons[i].hover(mouseX, mouseY);
  }

  updateDisplay();
}

void mousePressed() {
  for (int i = 0; i<buttons.length; i++) {
    if (buttons[i].over && buttons[i].val == '+') {
      left = false;
      op = "+";
      dVal = "0.0";
    } else if (buttons[i].over && buttons[i].val == '=') {
      performCalculation();
    } else if (buttons[i].over && buttons[i].val == '.') {
      if (dVal.contains(".") == false) {
        dVal += ".";
      }
    } else if (buttons[i].over && buttons[i].val == '-') {
      op = "-";
      left = false;
      dVal = "0.0";
    } else if (buttons[i].over && buttons[i].val == '*') {
      op = "*";
      left = false;
      dVal = "0.0";
    } else if (buttons[i].over && buttons[i].val == '÷') {
      op = "÷";
      left = false;
      dVal = "0.0";
    } else if (buttons[i].over && buttons[i].val == '^') {
      op = "^";
      left = false;
      dVal = "0.0";
    } else if (buttons[i].over && buttons[i].val == 'π') {
      if (left) {
        l = PI;
        dVal = str(l);
      } else {
        r = PI;
        dVal = str(r);
      }
    } else if (buttons[i].over && buttons[i].val == '√') {
      if (left) {
        l = sqrt(l);
        dVal = str(l);
      } else if (!left) {
        l = sqrt(r);
        dVal = str(r);
      }
    } else if (buttons[i].over && buttons[i].val == '%') {
      if (left) {
        l = l*0.01;
        dVal = str(l);
      } else if (!left) {
        l = r*0.01;
        dVal = str(r);
      }
    } else if (buttons[i].over && buttons[i].val == '±') {
      if (left) {
        l = l*-1;
        dVal = str(l);
      } else if (!left) {
        l = r*-1;
        dVal = str(r);
      }
    } else if (buttons[i].over && buttons[i].val == 'C') {
      l = 0.0;
      r = 0.0;
      result = 0.0;
      dVal = "0.0";
      op = "";
      left = true;
    }
  }


  for (int i = 0; i<numButtons.length; i++) {
    if (dVal.length()<19) {
      if (numButtons[i].over && left) {
        if (dVal.equals("0.0")) {
          dVal = str(numButtons[i].val);
          l = float(dVal);
        } else {
          dVal += str(numButtons[i].val);
          l = float(dVal);
        }
      } else if (numButtons[i].over && !left) {
        if (dVal.equals("0.0")) {
          dVal = str(numButtons[i].val);
          r = float(dVal);
        } else {
          dVal += str(numButtons[i].val);
          r = float(dVal);
        }
      }
    }
    println("L:"+l);
    println("R:"+r);
    println("Result:"+result);
    println("Op:"+op);
    println("Left:"+left);
  }
}

void updateDisplay() {
  rectMode(CENTER);
  fill(255);
  rect(335, 165, 220, 290, 10);
  fill(0);
  textSize(20);
  textAlign(RIGHT);
  if (dVal.length()>14) {
    textSize(15);
  } 
  text(dVal, width-30, height-35);
}

void performCalculation() {
  if (op.equals("+")) {
    result = l + r;
  } else if (op.equals("-")) {
    result = l - r;
  } else if (op.equals("*")) {
    result = l * r;
  } else if (op.equals("÷")) {
    result = l / r;
  } else if (op.equals("^")) {
    result = pow(l, r);
  }
  dVal = str(result);
}
