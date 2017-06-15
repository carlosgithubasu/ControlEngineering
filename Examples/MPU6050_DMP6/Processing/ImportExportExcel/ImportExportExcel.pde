import java.io.*;
import org.apache.poi.ss.usermodel.Sheet;

String[][] saving;

void setup() {
  // import excel data to a 2d string:
  saving = importExcel("PLACE FILEPATH & FILE NAME HERE");
}
void draw() {
  // manipulate data
}

void keyPressed() {
  //export a 2d string to an excel file:
  // exportExcel(a 2D string, a new filepath/name);
  exportExcel(saving, "PLACE FILEPATH & FILE NAME HERE");
}

