/*===========================
 OrbList (ALL WORK GOES HERE)
 
 Class to represent a Linked List of OrbNodes.
 
 Instance Variables:
 OrbNode front:
 The first element of the list.
 Initially, this will be null.
 
 Methods to work on:
 0. addFront
 1. populate
 2. display
 3. applySprings
 4. applyGravity
 5. run
 6. removeFront
 7. getSelected
 8. removeNode
 
 When working on these methods, make sure to
 account for null values appropraitely. When the program
 is run, no NullPointerExceptions should occur.
 =========================*/

class OrbList {

  OrbNode front;

  /*===========================
   Contructor
   Does very little.
   You do not need to modify this method.
   =========================*/
  OrbList() {
    front = null;
  }//constructor

  /*===========================
   addFront(OrbNode o)
   
   Insert o to the beginning of the list.
   =========================*/
  void addFront(OrbNode o) {
    o.next = front;
    front = o;
  }//addFront
  
 


  /*===========================
   populate(int n, boolean ordered)
   
   Clear the list.
   Add n randomly generated  orbs to the list,
   using addFront.
   If ordered is true, the orbs should all
   have the same y coordinate and be spaced
   SPRING_LEGNTH apart horizontally.
   =========================*/
  void populate(int n, boolean ordered) {
    front = null; //Removes all pointers
    
    for (int i = 0; i < n; i++) {
      if (ordered) {
        addFront(new OrbNode(i * SPRING_LENGTH * 2, height/2, random(MIN_SIZE, MAX_SIZE + 1), random(MIN_MASS, MAX_MASS + 1)));
      } else {
        addFront(new OrbNode(random(width), random(height), random(MIN_SIZE, MAX_SIZE + 1), random(MIN_MASS, MAX_MASS + 1)));
      }
    } 
  }//populate
  
  void dragPopulate(int n, boolean ordered) {
    front = null;
    for (int i = 0; i < n; i++) {
      if (ordered) {
        addFront(new OrbNode(i * SPRING_LENGTH * 2, height/2, random(MIN_SIZE, MAX_SIZE + 1), random(MIN_MASS, MAX_MASS + 1), random(0, 1), random(0, 1)));
      } else {
        addFront(new OrbNode(random(width), random(height), random(MIN_SIZE, MAX_SIZE + 1), random(MIN_MASS, MAX_MASS + 1), random(0, 1), random(0, 1)));
      }
    } 
  }//dragPopulate
  
  void electricityPopulate(int n, boolean ordered) {
    dragPopulate(n, ordered);
  }//magnetismPopulate
  
  /*===========================
   display(int springLength)
   
   Display all the nodes in the list using
   the display method defined in the OrbNode class.
   =========================*/
  void display() {
    OrbNode n = front;
    while (n != null) {
      n.display();
      n = n.next;
    }
  }//display

  /*===========================
   applySprings(int springLength, float springK)
   
   Use the applySprings method in OrbNode on each
   element in the list.
   =========================*/
  void applySprings(int springLength, float springK) {
    OrbNode n = front;
    while (n != null) {
      n.applySprings(springLength, springK);
      n = n.next;
    }
  }//applySprings

  /*===========================
   applyGravity(Orb other, float gConstant)
   
   Use the getGravity and applyForce methods
   to apply gravity crrectly.
   =========================*/
  void applyGravity(Orb other, float gConstant) {
    OrbNode n = front;
    while (n != null) {
      n.applyForce(n.getGravity(other, gConstant));
      n = n.next;
    }
  }//applySprings
  
  /* ========================
   applyDragForce(float cd)
   ===================*/
   void applyDragForce(float cd) {
     OrbNode n = front;
     while (n != null) {
       n.applyForce(n.getDragForce(cd));
       n = n.next;
     }
   }//applyDragForce
   
   /* ====================
   applyElectricForce(float electricK)
   ======================*/
 void applyElectricForce(float electricK) {
   OrbNode n = front;
   OrbNode x = front.next;
     while (n != null) {
       while (x != null) {
         if (x != n) {
           n.applyForce(n.getElectricForce(x, electricK));
         }
         x = x.next;
       }
       n = n.next;
     }
   }//applyElectricForce
  /*===========================
   run(boolean bounce)
   
   Call run on each node in the list.
   =========================*/
  void run(boolean bounce) {
    OrbNode n = front;
    while (n != null) {
      n.move(bounce);
      n.display();
      n = n.next;
    }
  }//applySprings

  /*===========================
   removeFront()
   
   Remove the element at the front of the list, i.e.
   after this method is run, the former second element
   should now be the first (and so on).
   =========================*/
  void removeFront() {
    if (front != null) {
      front = front.next;
    }
  }//removeFront


  /*===========================
   getSelected(float x, float y)
   
   If there is a node at (x, y), return
   a reference to that node.
   Otherwise, return null.
   
   See isSlected(float x, float y) in
   the Orb class (line 115).
   =========================*/
  OrbNode getSelected(int x, int y) {
    OrbNode n = front;
    while (n != null) {
      if (n.isSelected(x, y)) {
        return n;
      }
      n = n.next;
    }
    return null;
  }//getSelected

  /*===========================
   removeNode(OrbNode o)
   
   Removes o from the list. You can
   assume o is an OrbNode in the list.
   You cannot assume anything about the
   position of o in the list.
   =========================*/
  void removeNode(OrbNode o) {
    if (o == front) {
      removeFront();
      return; //to exit the function
    }
    
    OrbNode n = front;
    while (n != null && n.next != o) {
      n = n.next;
    }
    
    if (n.next == o) { // n can never be null at this point because o has to be an orb in the linked list that I'm clicking on.
      n.next = o.next; //Skip over o to remove it from the linked list
    }
  
  }
  /*================
  displayMasses() 
  Displays the mass of each orb as text.
  ========*/
  void displayMasses(boolean yes) {
    if (yes) {
      OrbNode n = front;
      while (n != null) {
        n.displayMass();
        n = n.next;
      }
    }
  }
  
  /*================
  displayCharges() 
  Displays the charge of each orb as text.
  ========*/
  void displayCharges(boolean yes) {
    if (yes) {
      OrbNode n = front;
      while (n != null) {
        n.displayCharge();
        n = n.next;
      }
    }
  } //displayCharges()
  
  /*================
  displayVelocities() 
  Displays the velocity of each orb as text.
  ========*/
  void displayVelocities(boolean yes) {
    if (yes) {
      OrbNode n = front;
      while (n != null) {
        n.displayVelocity();
        n = n.next;
      }
    }
  } //displayVelocities()
    
}//OrbList
