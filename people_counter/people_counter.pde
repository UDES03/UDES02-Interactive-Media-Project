import controlP5.*;

// Person Arrays
ArrayList<Person> persons_entering = new ArrayList();
ArrayList<Person> persons_level_0 = new ArrayList();
ArrayList<Person> persons_level_1 = new ArrayList();

// Building Variables
// changable variables
float level_left_x = 100;        // left x-value of each level
float level_right_x = 780;       // right x-value of each level
float level_height = 130;        // height of each level
float level_0_y = 700;           // y-value of level 0

// not changable variables, because they are dependent on the ones above
float level_1_y = level_0_y - level_height;      // y-value of level 1
float level_2_y = level_1_y - level_height;      // y-value of level 2
float level_3_y = level_2_y - level_height;      // y-value of level 3
float level_4_y = level_3_y - level_height;      // y-value of level 4


float level_width = (level_right_x - level_left_x)/2;      // width of each level (= width of the building)

//Stars Variables for the Background
float[] x = new float[100];
float[] y = new float[100];
float[] speed = new float[100];


//SLIDER GRAPHICS
int sliderValue = 0;
Slider slider;
ControlP5 gui;

void setup() {
  background(255);
  size(1600, 900);

  drawBackground(true);

  // create 2 persons
  createTestPerson();
  //createPersons(2);
  loadData();
  int rows = getLowestAmountOfRows();
  println(rows);
  gui = new ControlP5(this);
  gui.addSlider("sliderValue").setPosition(1000, 500).setSize(500, 50)
    .setRange(0,rows-1);
    
  textSize(40);
  
}

void draw() {

  drawBackground(false);

  drawBuilding();
  
  drawText();
  
  

  





  // PERSON
  // persons enter the building
  for (int i = 0; i < persons_entering.size(); i++) {
    person_enters(persons_entering.get(i));
  }

  // persons change to level 1
  for (int i = 0; i < persons_level_0.size(); i++) {
    person_changes_level(persons_level_0.get(i), 1);
  }

  // persons change to level 0
  for (int i = 0; i < persons_level_1.size(); i++) {
    person_changes_level(persons_level_1.get(i), 0);
  }

  // persons leave the building
  for (int i = 0; i < 2; i++) {
    if (persons_level_0.size() != 0) {
      int random_person_id = (int) random(0, persons_level_0.size()-1);
      person_leaves(persons_level_0.get(random_person_id), random_person_id);
    }
  }
}

void createTestPerson() {
  Person person = new Person(level_0_y + 30, 0, level_left_x + 130);
  persons_entering.add(person);
}

void createPersons(int amount) {                // create an amount of persons
  for (int i = 0; i < amount; i++) {
    Person person = new Person();
    persons_entering.add(person);
  }
}

void person_enters(Person p) {
  p.show();
  if (p.entered()) {
    persons_level_0.add(p);                    // add person to level 0 if it entered the building successfully
  }
}

void person_leaves(Person p, int person_id) {
  p.show();

  if (p.left()) {                              // remove person from level 0 if it left the building successfully
    persons_level_0.remove(person_id);
  };
}

void person_changes_level(Person p, int new_level) {
  int current_level = p.getLevel();

  // add person to new level
  if (new_level == 0) {
    persons_level_0.add(p);
  } else if (new_level == 1) {
    persons_level_1.add(p);
  }

  // remove person from current level
  if (current_level == 0) {
    persons_level_0.remove(p);
  } else if (current_level == 1) {
    persons_level_1.remove(p);
  }

  if (p.changeLevel(new_level)) {
    delay(3000);                                    // wait for 3sec after changed level
  };
}

class Person {
  float x, y;
  float target_x, target_y_up, target_y_down;
  int level;

  Person() {
    this.x = 10;
    this.y = random(level_1_y, level_0_y);
    this.level = 0;
    this.target_x = random(level_left_x, level_right_x);
    this.target_y_up = y - level_height;
    this.target_y_down = y + level_height;
  }

  Person(float y, int level, float target_x) {
    this.y = y;
    this.level = level;                    // TODO: change to random later
    this.target_x = target_x;              // TODO: change to random later
    //this.y = random(level_1_y, level_0_y);
    //this.target_x = random(level_left_x, level_right_x);

    this.x = 10;
    this.target_y_up = y - level_height;
    this.target_y_down = y + level_height;
  }

  void show() {
    fill(0);
    circle(x, y, 20);
  }

  boolean entered() {                      // returns true, if person entered the building
    if (x < target_x) {
      x += 2;
      return false;
    } else {
      return true;
    }
  }

  boolean left() {                          // returns true, if person left the building
    if (x < level_right_x + 100) {
      x += 2;
      return false;
    } else {
      return true;
    }
  }

  boolean changeLevel(int newLevel) {      // returns true, if person changed level in the building
    if (level < newLevel) {
      if (y > target_y_up) {
        y -= 2;
        return false;
      } else {
        this.level = newLevel;
        return true;
      }
    } else if (level > newLevel) {
      if ( y < target_y_down) {
        y += 2;
        return false;
      } else {
        this.level = newLevel;
        return true;
      }
    } else {
      return false;
    }
  }

  int getLevel() {
    return level;
  }
}

void drawBuilding() {


  stroke(0);
  strokeWeight(3);

  //Rectangle # 5 ___ floor4///

  fill(160);
  rect(level_left_x, level_4_y, level_width, level_height);

  //Rectangle # 4 ___ floor3///

  fill(150);
  rect(level_left_x, level_3_y, level_width, level_height);

  //// Rectangle #3 _____ floor2///////

  fill(140);
  rect(level_left_x, level_2_y, level_width, level_height);

  //// Rectangle #2 ______ floor 1/////

  fill(130);
  rect(level_left_x, level_1_y, level_width, level_height);

  /////Rectangle # 1 _____ floor 0/////

  fill(120);
  rect(level_left_x, level_0_y, level_width, level_height);
}


//setup: true is used in setup and false in draw loop
void drawBackground(boolean setup) {
  background(255);
  int l = 0;// Star code in Draw Start 

  if (setup) {
    stroke(255);// Stars code in setup Start 
    strokeWeight(10);
    while (l < 100) {  
      x[l] = random(0, width);
      y[l] = random(0, height);
      speed[l] = random(1, 5);
      l = l + 1;
    }
  } else {

    while (l < 100) {

      point(x[l], y[l]);

      x[l] = x[l] - speed[l];
      if (x[l] < 0) {
        x[l] = width;
      }
      l = l + 1;
    }
  }
}

void drawText(){
  
  text("Level 0 Entry 0 In: " + level00In.getInt(sliderValue, 1), 1000, 150);
  text("Level 0 Entry 0 Out:" + level00Out.getInt(sliderValue, 1), 1000, 200);
  text("Level 0 Entry 1 In: " + level01In.getInt(sliderValue, 1), 1000, 250);
  text("Level 0 Entry 1 Out:" + level01Out.getInt(sliderValue, 1), 1000, 300);
  text("Level 0 Entry 2 In: " + level02In.getInt(sliderValue, 1), 1000, 350);
  text("Level 0 Entry 2 Out:" + level02Out.getInt(sliderValue, 1), 1000, 400);
  
}
