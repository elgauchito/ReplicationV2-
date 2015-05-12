#include "Ahn1995.h"

/** Need to specify the Reachable and  Utility functions**/


Ahn::Utility()  {
// eqn(12) with a substition for x_k ( from eqn(2) )?
	decl val_ind, u;
	if (I::t<13) { val_ind=0;}
	else if (I::t<18) { val_ind=1;}
	else if (I::t<22) { val_ind=2;}
	else {val_ind=3;};
	//print(nc.v);
	//print(" kids ", nc.v);
	//print(" b ",nb.v);

	u=(Y[I::t] +CV(nb)*ValBoy[val_ind]+(CV(nc)-CV(nb))*ValGirl[val_ind]) + 300.0;
	//print(" u ", u);
	return log(u);	  
	//return setbounds(log(u), 1.0, +.Inf);	
}

/** Setup and solve the model.
**/	
Ahn::Run(){
	
	Initialize(pho,Reachable);
	SetClock(NormalAging,T);
	SetDelta(delt);   // set discount factor eqn (12) of Ahn 
	Actions(d = new BinaryChoice()); // d=1 to have a child
	EndogenousStates(nc= new ActionCounter("nc",tau+1,d)); // added total number of kids;
	EndogenousStates(nb = new RandomUpDown("nb",tau+1,ItsABoy)); // number of boys
	
	CreateSpaces();
	EMax = new ValueIteration();
	EMax.vtoler = 1E-1; 
	EMax->Solve();
	EMax.Volume = NOISY;   // trying to get that step-by-step info
    }

Ahn::FeasibleActions(Alpha) { 

return 1|(I::t<tau) ;  // DR: change <tau+1> to <tau>?  (Fertile for the first tau periods.)

}

Ahn::Reachable(){
	 CV(nc) <= tau;
	 CV(nc) >= CV(nb);
	return new Ahn();
}

Ahn::ItsABoy(A) {
	decl birth = A[][d.pos];
	return  0  ~ (1-birth)+birth*(1-BoyRatio) ~ birth*BoyRatio;

}

/*Ahn::ItsABirth(A) {
	decl birth = A[][d.pos];
	return  0  ~ 0 ~ 1;
  
}*/
