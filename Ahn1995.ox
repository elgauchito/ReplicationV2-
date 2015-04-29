#include "Ahn1995.h"

/** Need to specify the Reachable and  Utility functions**/


Ahn::Utility()  {
// eqn(12) with a substition for x_k ( from eqn(2) )?
	return Y + nb.v + (-.8)*(sumr(d)-nb.v);	   //temporary
	}

/** Setup and solve the model.
**/	
Ahn::Run(){
	
	Initialize(pho,Reachable);
	SetClock(NormalAging,T);
	SetDelta(0.95);   // matches delta in eqn(12)
	Actions(d = new BinaryChoice());
 	EndogenousStates(nb = new RandomUpDown("nb",7,ItsABoy));
	CreateSpaces();
	EMax = new ValueIteration(0);
	
    }

Ahn::FeasibleActions(Alpha) { 

return 1|(I::t<tau) ; // Fertile for the first tau periods.

}

Ahn::Reachable(){
	return (I::t<T) ? new Ahn() : FALSE;
}

Ahn::ItsABoy(A) {
	decl birth = A[][d.pos];
	return  0  ~ (1-birth)+birth*(1-BoyRatio) ~ birth*BoyRatio;

}
