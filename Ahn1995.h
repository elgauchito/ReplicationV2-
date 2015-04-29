#import "DDP"


enum{T=25,tau=7};  /** State space dimensions. @names dimens **/

struct Ahn : ExtremeValue {
	
	static decl d, nb, nbp, EMax;	  // list action variables, state variables, other things.
	static const decl BoyRatio = 0.499, delt=0.9;   // ratio of births that are boys
	static decl Noff, p ; // placeholders for variables that maynot be needed
	static const decl
		/* estimated parameters from Table 5*/ pars ; 
 	static const decl Y=1; // income variables	
	
	static ItsABoy(A);	
        static Run();	
	static Reachable();	    // Static methods can be called anything.		
	static Utility();		  	//Automatic methods
	static FeasibleActions(Alpha);
			
	}
