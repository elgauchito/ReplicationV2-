#include "Ahn1995.h"

/** Need to specify the Reachable and  Utility functions**/


Ahn::Utility()  {
// eqn(12) with a substition for x_k ( from eqn(2) )?
	decl u=0,j , nc=0, ind=zeros(1,7), div, bg=0, age, bound=0 ;

	bound=min(7,I::t+1);
	
	if (I::t<7){ // caluclate total number of childs, and age index of the child
		for(j=0;j<bound;++j) nc=nc+CV(dvals[j]);
		if (I::t > 4) {ind[0]=1;}
		if (I::t > 5){ ind[0]=1,ind[1]=1;}	
	
	}
	else {
		for(j=0;j<bound;++j) {
			nc=nc+CV(dvals[j]);
			age=(I::t-j)*2;
			div=idiv(age,10); // integer division to get the index
		 	if (div >2 ) div=3;
			ind[j]=div;	
		}
	}

	if(nc>0){ // calculate boys girls ratio
	bg=CV(nb)/nc;
	}
	
	// calculate utility
	for(j=0;j<bound;++j) {
		decl index=ind[j];
		u=u+CV(dvals[j])*(bg*ValBoy[index]+(1-bg)*ValGirl[index]);
		}	

//	println("dvals",CV(dvals[0]), "nc",nc,"u", u, "bg", bg);
	 u= log((u +Y[I::t]) - 430);  //trying out log utility , with the additive term we get to t=24 ... 
	//u= u +Y[I::t];
	return u;	  
}

/** Setup and solve the model.
**/	
Ahn::Run(){
	
	Initialize(pho,Reachable);
	SetClock(NormalAging,T);
	SetDelta(delt);   // set discount factor eqn (12) of Ahn 
	Actions(d = new BinaryChoice()); // d=1 to have a child
	dvals = new array[7];
	for(i=0;i<7;++i) dvals[i] = new ChoiceAtTbar("d"+sprint(i),d,DP::counter,i);
 	EndogenousStates(dvals);

	//EndogenousStates(nc= new ActionCounter("nc",tau+1,d)); // added total number of kids;
	EndogenousStates(nb = new RandomUpDown("nb",tau+1,ItsABoy)); // number of boys
	
	CreateSpaces();
        DPDebug::outAllV();
	EMax = new ValueIteration();
	//EMax.vtoler = 1E-1; 
	EMax->Solve();
	//EMax.Volume = NOISY;   // trying to get that step-by-step info
    }

Ahn::FeasibleActions(Alpha) { 

	return 1|(I::t<tau+1) ;   
}

Ahn::Reachable(){
	decl nc=0,j;
	for(j=0;j<7;++j) nc=nc+CV(dvals[j]);

	if (CV(nb) > nc) return 0;
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
