

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined

public static final int NUM_ROWS = 20;
public static final int NUM_COLS = 20;

private static final boolean DEBUG_F = true; 


void setup (){
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    buttons = new MSButton[NUM_ROWS][NUM_COLS]; 
    for(int r=0;r<NUM_ROWS;r++){
      for(int c=0;c<NUM_COLS;c++){
        buttons[r][c] = new MSButton(r,c);
      }
    }

    bombs = new ArrayList <MSButton>();

    //declare and initialize buttons
    setBombs();
}
public void setBombs(){
    //your code
    int row = (int)(Math.random()*NUM_ROWS);
    int col = (int)(Math.random()*NUM_COLS);
    
    if(!bombs.contains(buttons[row][col])){
      bombs.add(buttons[row][col]); 
      if(DEBUG_F){
        System.out.println("adding bomb in rol:\t"+row+"\tcol:\t"+col);}
    }
}

public void draw (){
    background( 0 );
    if(isWon()){
        displayWinningMessage();}
}
public boolean isWon(){
    //your code here
    return false;
}
public void displayLosingMessage(){
    //your code here
}
public void displayWinningMessage(){
    //your code here
}

public class MSButton{
    private int r, c;
    private float x,y, B_width, B_height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc ){
        B_width = width/NUM_COLS;
        B_height = height/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*B_width;
        y = r*B_height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked(){
        return marked;
    }
    public boolean isClicked(){
        return clicked;
    }
    // called by manager
    
    public void mousePressed () {
        clicked = true;
        int bCnt = countBombs(r,c);
        if(keyPressed){
          marked = !marked; //toggles marked boolean
        } else if(bombs.contains(this)){
          displayLosingMessage();
        } else if(bCnt > 0){
          label = Integer.toString(bCnt);
        } else {
          //recursively call mousePressed() on neighbor buttons
          //which are unclicked and valid.

        }
    }

    public void draw () {    
        if (marked){
            fill(0);}
        else if( clicked && bombs.contains(this) ){ 
            fill(255,0,0);}
        else if(clicked){
            fill( 200 );}
        else {
            fill( 100 );}

        rect(x, y, B_width, B_height);
        fill(0);
        text(label,x+B_width/2,y+B_height/2);
    }
    public void setLabel(String newLabel){
        label = newLabel;
    }
    public boolean isValid(int r, int c){
        //your code here
        if((r<NUM_ROWS)&&(c<NUM_COLS)){
          return true;
        }
        return false;
    }
    public int countBombs(int row, int col){
        int numBombs = 0;
        //loops through the neighbor buttons checking
        //for bombs and incrementing the count as it finds them.
        for(int R=(row-1);R<3;R++){
          for(int C=(col-1);C<3;C++){
            if((R!=row)&&(C!=col)){
              if(isValid(R,C)){
                if(bombs.contains(buttons[R][C])){
                  numBombs++;
                }
              }
            }
          }
        }
        return numBombs;
    }
}



