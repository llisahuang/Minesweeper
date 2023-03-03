import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton [NUM_ROWS][NUM_COLS];
    for (int i = 0; i < NUM_ROWS; i++){
      for (int k = 0; k < NUM_COLS; k++){
      buttons[i][k] = new MSButton (i,k);
      }
    }
    
    setMines();
}
public void setMines()
{
    int roww = 0;
    int coll = 0;
    for(int i = 0; i < 60; i++){
    roww = (int)(Math.random()*NUM_ROWS);
    coll = (int)(Math.random()*NUM_COLS);
    if(!mines.contains(buttons[roww][coll])){
    mines.add(buttons[roww][coll]);
    }
    }
    
  //your code
}

public void draw ()
{
    background( 0 );
    if(isWon() == true){
        displayWinningMessage();
        noLoop();
    }
    for(int i = 0; i < mines.size(); i++)
    if(mines.get(i).clicked == true){
    noLoop();
    }
}
public boolean isWon()
{ 
    for(int i = 0; i < NUM_ROWS; i++){
    for(int k = 0; k < NUM_COLS; k++){
    if(!buttons[i][k].clicked && !mines.contains(buttons[i][k])){
      return false;
    }
    //your code here
    }
}
    return true;
}
public void displayLosingMessage()
{
   buttons[0][0].myLabel = "Y";
  buttons[0][1].myLabel = "O";
  buttons[0][2].myLabel = "U";
  buttons[0][4].myLabel = "L";
  buttons[0][5].myLabel = "O";
  buttons[0][6].myLabel = "S";
  buttons[0][7].myLabel = "E";
  buttons[0][8].myLabel = "!";
    //your code here
   for(int i = 0; i < 60; i++){
   mines.get(i).clicked = true;
   }
}
public void displayWinningMessage()
{
  buttons[0][0].myLabel = "Y";
  buttons[0][1].myLabel = "O";
  buttons[0][2].myLabel = "U";
  buttons[0][4].myLabel = "W";
  buttons[0][5].myLabel = "I";
  buttons[0][6].myLabel = "N";
  buttons[0][7].myLabel = "!";
}
public boolean isValid(int r, int c)
{
    if(r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS)
    return true;
  return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    if(isValid(row,col) == true)  {
    if(isValid(row-1,col-1) == true && mines.contains(buttons[row-1][col-1]) )
    numMines++;
    if(isValid(row-1,col) == true && mines.contains(buttons[row-1][col]))
    numMines++;
    if(isValid(row-1,col+1) == true && mines.contains(buttons[row-1][col+1]))
    numMines++;
    if(isValid(row,col-1) == true && mines.contains(buttons[row][col-1]))
    numMines++;
    if(isValid(row,col+1) == true && mines.contains(buttons[row][col+1]))
    numMines++;
    if(isValid(row+1,col-1) == true && mines.contains(buttons[row+1][col-1]))
    numMines++;
    if(isValid(row+ 1,col) == true && mines.contains(buttons[row+1][col]))
    numMines++;
    if(isValid(row+1,col+1) == true && mines.contains(buttons[row+1][col+1]))
    numMines++;
  } 
    
    
    
    
    //your code here
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
         width = 400/NUM_COLS;
         height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        if (mouseButton == RIGHT){
        if(flagged == true)
        flagged = false;
        clicked = false;
        if(flagged == false)
        flagged = true;
        } else if(mines.contains(this)){
          displayLosingMessage();
        } else if (countMines(myRow,myCol) > 0){
         myLabel = countMines(myRow, myCol) + "";
        } else {
        if(isValid(myRow,myCol) == true)  {
    if(isValid(myRow-1,myCol-1) == true && !buttons[myRow-1][myCol-1].clicked)
    buttons[myRow-1][myCol-1].mousePressed();
    if(isValid(myRow-1,myCol) == true && !buttons[myRow-1][myCol].clicked)
    buttons[myRow-1][myCol].mousePressed();
    if(isValid(myRow-1,myCol+1) == true && !buttons[myRow-1][myCol+1].clicked)
   buttons[myRow-1][myCol+1].mousePressed();
    if(isValid(myRow,myCol-1) == true && !buttons[myRow][myCol-1].clicked )
    buttons[myRow][myCol-1].mousePressed();
    if(isValid(myRow,myCol+1) == true && !buttons[myRow][myCol+1].clicked)
    buttons[myRow][myCol+1].mousePressed();
    if(isValid(myRow+1,myCol-1) == true && !buttons[myRow+1][myCol-1].clicked)
    buttons[myRow+1][myCol-1].mousePressed();
    if(isValid(myRow+ 1,myCol) == true && !buttons[myRow+1][myCol].clicked)
  buttons[myRow+1][myCol].mousePressed();
    if(isValid(myRow+1,myCol+1) == true && !buttons[myRow+1][myCol+1].clicked)
    buttons[myRow+1][myCol+1].mousePressed();
          
        }
        
        }
        
 
        
        //your code here
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
