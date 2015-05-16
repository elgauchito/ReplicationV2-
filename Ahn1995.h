#import "DDP"


enum{T=25,tau=7};  /** State space dimensions. @names dimens **/

struct Ahn : ExtremeValue {
	
	static decl d, nc, nb, nbp, dvals, EMax, i;	  // list action variables, state variables, other things.
	static const decl BoyRatio = 0.501, delt=0.95, pho=1;   // ratio of births that are boys
	static decl Noff, p ; // placeholders for variables that maynot be needed
	static const decl
		/* estimated parameters from Table 5*/ pars ; 
 	static const decl Y=<365.11, 406.79,448.57,489.56,528.79,565.29,598.10,626.29,649.06,665.73,675.79,678.94,675.08,664.33,644.92,606.82,552.07,448.44,311.77,164.49,115.41,112.05,112.05,112.05,112.05>; // income variables for college women	
	static const decl ValBoy=<49.33,-45.61,-196.5,131.7>; // values of boys in the 4 age brackets
	static const decl ValGirl=<50.35,-33.96,-56.37,4.77>;	
	static ItsABoy(A);	
	static ItsABirth(A);	
	
        static Run();	
	static Reachable();	    // Static methods can be called anything.		
	Utility();		  	//Automatic methods
	FeasibleActions(Alpha);
			
	}
