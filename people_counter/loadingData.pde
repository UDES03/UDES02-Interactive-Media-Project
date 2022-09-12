Table level00In, level00Out, level01In, level01Out, level02In, level02Out;
Table level10In, level10Out, level11In, level11Out;


void loadData() {
  println("Loading Data");
  level00In = loadTable("data/CB11.PC00.06.West/CB11.00.Wattle In.csv");
  level00Out = loadTable("data/CB11.PC00.06.West/CB11.00.Wattle Out.csv");
  
  level01In = loadTable("data/CB11.PC00.08.ST12/CB11.00.CR04.East In.csv");
  level01Out = loadTable("data/CB11.PC00.08.ST12/CB11.00.CR04.East Out.csv");
  
  level02In = loadTable("data/CB11.PC00.09.CR01/CB11.00.CR04.West In.csv");
  level02Out = loadTable("data/CB11.PC00.09.CR01/CB11.00.CR04.West Out.csv");
 
  /*
  println(level01In.getRowCount());
  println(level01Out.getRowCount());
  
  int inTotal = 0;
  int outTotal = 0;

  for (TableRow row : level01In.rows()) {
    inTotal += row.getInt(1);
  }

  for (TableRow row : level01Out.rows()) {
    outTotal += row.getInt(1);
  }

  for (int i = 0; i < 978; i++) {
    //inTotal += level00In.getInt(i, 1);
    //outTotal += level00Out.getInt(i, 1);
    println(level00In.getString(i, 0) + "\t" + level00In.getInt(i, 1)+ "\t" + level00Out.getString(i,0)+ "\t" + level00Out.getInt(i, 1));
  }


  println("Total In: " + inTotal);
  println("Total Out: " + outTotal);
  */
}

int getLowestAmountOfRows(){
  int min = Integer.MAX_VALUE;
  min = level00In.getRowCount() < min ? level00In.getRowCount() : min;
  min = level00Out.getRowCount() < min ? level00Out.getRowCount() : min;
  min = level01In.getRowCount() < min ? level01In.getRowCount() : min;
  min = level01Out.getRowCount() < min ? level01Out.getRowCount() : min;
  min = level02In.getRowCount() < min ? level02In.getRowCount() : min;
  min = level02Out.getRowCount() < min ? level02Out.getRowCount() : min;
  
  return min;
}


//sensors = ['CB11.PC00.06.West', 'CB11.PC00.08.ST12', 'CB11.PC00.09.CR01', 'CB11.PC02.16.JonesStEast', 'CB11.PC05.22', 'CB11.PC05.23', 'CB11.PC09.27', 'CB11.PC09.28', 'CB11.PC10.30', 'CB11.PC02.14.Broadway']
//subSensors = [['CB11.00.Wattle In', 'CB11.00.Wattle Out'],['CB11.00.CR04.East In', 'CB11.00.CR04.East Out', 'CB11.00.ST01 Down', 'CB11.00.ST01 Up'], ['CB11.00.CR04.West In', 'CB11.00.CR04.West Out'], ['CB11.02.JonesSt In', 'CB11.02.JonesSt Out'], ['CB11.04.ST18 Down', 'CB11.04.ST19 Down', 'CB11.04.ST18 Up', 'CB11.04.ST19 Up'], ['CB11.05.CR07 Out', 'CB11.05.CR07 In', 'CB11.05.CR09 Out', 'CB11.05.CR09 In'], ['CB11.09.ST22 Down', 'CB11.09.ST22 Up'], ['CB11.08.CR10 In', 'CB11.08.CR10 Out', 'CB11.09.CR12 In', 'CB11.09.CR12 Out', 'CB11.09.ST21 Up', 'CB11.09.CR14 In', 'CB11.09.CR14 Out', 'CB11.09.ST21 Down'], ['CB11.10.CR09 In', 'CB11.10.CR09 Out', 'CB11.09.CR11 Out', 'CB11.09.CR11 In'], ['CB11.02.Broadway.East In', 'CB11.02.Broadway.East Out']]
 
