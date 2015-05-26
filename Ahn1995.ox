#include "Ahn1995.h"

/** Need to specify the Reachable and  Utility functions**/


Ahn::Utility()  {
	
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
	bg=1; // Set bg=1 to set boy and girls value the same.	
	// calculate utility
	for(j=0;j<bound;++j) {
		decl index=ind[j];
		u=u+CV(dvals[j])*(bg*ValBoy[index]+(1-bg)*ValGirl[index]);
		}	

	u= log(max(1,u+Y[I::t]));
	
	//println(CV(dvals[0])," ", CV(dvals[1])," ",CV(dvals[2])," ",CV(dvals[3])," ",CV(dvals[4])," ",CV(dvals[5])," ",CV(dvals[6])," u ", u, " bg ",bg);
	//println(ind[0]," ",ind[1]," ",ind[2]," ",ind[3]," ",ind[4]," ",ind[5]," ",ind[6]," nb ",CV(nb),"t ",I::t," nc ",nc," "," Y ",Y[I::t]);	
	return u;	  

}

/** Setup and solve the model.
**/	
Ahn::Run(){

 	decl mat,PD;	
	Initialize(pho,Reachable);
	SetClock(NormalAging,T);
	SetDelta(delt);   // set discount factor eqn (12) of Ahn 
	Actions(d = new BinaryChoice()); // d=1 to have a child
	
	dvals = new array[7];
	for(i=0;i<7;++i) dvals[i] = new ChoiceAtTbar("d"+sprint(i),d,i);
	EndogenousStates(dvals);
	EndogenousStates(nb = new RandomUpDown("nb",tau,ItsABoy)); // number of boys
	
	CreateSpaces();
       	DPDebug::outAllV(FALSE,&mat);
	EMax = new ValueIteration();
	//EMax.vtoler = 1E-1; 
	EMax->Solve();
	EMax.Volume = NOISY;   // trying to get that step-by-step info
	savemat("v.dta",mat,DPDebug::SVlabels);
	
	// Calculate the total probabilities
	PD = new PanelPrediction(15);
        PD -> Tracking(NotInData,d);
        PD -> Predict(6);
        PD -> Histogram(One);
       // println("%c",PD.tlabels,PD.flat[0]);



    }

Ahn::FeasibleActions(Alpha) { 

	return 1|(I::t<tau) ;   
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


