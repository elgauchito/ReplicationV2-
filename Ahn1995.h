#import "DDP"



/** T is the total number of living periods, **/
enum{T=25};
/** tau is the total number of fertile periods. **/
enum{tau=7};  

struct Ahn : ExtremeValue {
	static decl /** Action variable of whether to have a child or not. **/ d, 
		/** Total number children in the period. **/  nc, 
		/**  State variable for total number of boys in the period. **/ nb, 
		/** Array of state variables recording the decision made in the fertile periods.**/ dvals, 
		/**  Solver class. **/ EMax, 
		/** Dummy variable for loop. **/ i;	  

	static const decl /** Probability that a birth is a boy (from page 337 1st paragraph). **/ BoyRatio = 0.515, 
		     /** Discount factor.&nbsp; Equation 12 on page 368. **/ delt=0.95, 
		     /** Smoothing parameter.&nbsp; Set to 1 for no smoothing. **/ rho=1;   
 	
	static const decl /** Income parameter for each period.&nbsp; Table 2 from page  370. **/  Y=<365.11, 406.79,448.57,489.56,528.79,565.29,598.10,626.29,649.06,665.73,675.79,678.94,675.08,664.33,644.92,606.82,552.07,448.44,311.77,164.49,115.41,112.05,112.05,112.05,112.05>; 	
	static const decl /** Value of boys for different age brackets.&nbsp; Table 3 from page 371. **/  ValBoy=<49.33,-45.61,-196.5,131.7>; 
	static const decl /** Value of girls for different age brackets.&nbsp; Table 3 from page 371. **/ ValGirl=<50.35,-33.96,-56.37,4.77>;	
	
	
	static ItsABoy(A);	
        static Run();	
	static Reachable();	    // Static methods can be called anything.		
	Utility();		  	//Automatic methods
	FeasibleActions(Alpha);
			
	}
