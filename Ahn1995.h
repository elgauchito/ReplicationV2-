#import "DDP"
/** The goal of this project is to replicate some results from the 1995 ReStud paper "Measuring the Value of Children by Sex and Age Using a Dynamic Programming Model" by Namkee Ahn. The main contribution of this paper is that it was the first attempt to estimate the "economic value" (in terms of money) of the children to the parent in a dyanmic discrete choice framework. The basic idea is that the parent face a known income profile of their life, in each period of their life cycle, they receive utility from their income and also from the number of children they have which is age and gender dependent. Therefore during the fertile periods, the parent decide whether to have a children or not by maximising their expected total life cycle utility. The age and gender dependent value of the children are then estimated from fertility data of Korean couple in the 1980s.<br>
For our project, we use the estimated values of the children from the paper to estimate the choice probability to give birth by college educated women using the niqlow DDP solver. More specifically, we aim to replicate the results from panel c and d from table 5b on p. 374 of the paper. Panel c shows the choice probabilities if the boys and girls have the same values. Panel d shows the choice probabilities if the averaged value of boys and girls are used in the estimation. The main reason to choose these panels is that niqlow does not have the feature required to keep track of both the ages and gender of the children at this moment. However, niqlow can keep track of the actions taken using the ChoiceAtTbar class and this together with a separate state varibale for the number of boys allow us to keep track of the total number of children, the total number of boys and girls and the age of the children (but not the age of each gender) in each period. In the Utility() method, setting the local variable bg=1 will give estimated probabilities for panel c and setting bg=0.5 will give the estimate probabilities for panel d. <br>
 <table border="1">
  <tr>
    <th>Period</th><th>Panel c (Actual)</th> <th> Panel c (niqlow)</th> <th>c (niqlow)</th><th>d (niqlow)</th>
  </tr>
  <tr>
    <td>0</td><td>1.00</td><td>0.54</td><td>1.00</td><td>0.58</td>
  </tr>
  <tr>
    <td>1</td><td>0.03</td><td>0.41</td><td>0.95</td><td>0.53</td>
  </tr>
<tr>
    <td>2</td><td>0.41</td><td>0.32</td><td>0.53</td><td>0.47</td>
    </tr>
<tr>
    <td>3</td><td>0.13</td><td>0.23</td><td>0.15</td><td>0.40</td>
  </tr>
<tr>
    <td>4</td><td>0.05</td><td>0.13</td><td>0.05</td><td>0.27</td>
  </tr>
<tr>
    <td>5</td><td>0.04</td><td>0.11</td><td>0.01</td><td>0.20</td>
  </tr>
  <tr>
    <td>6</td><td>0.00</td><td>0.00</td><td>0.00</td><td>0.00</td>
  </tr>


</table> 
  
@author Ken Chow, David Rose **/



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

	static const decl /** Probability that a birth is a boy (from p.337 1st paragraph). **/ BoyRatio = 0.515, 
		     /** Discount factor. **/ delt=0.95, 
		     /** Smoothing parameter. **/ rho=1;   
 	
	static const decl /** Income parameter for each period. **/  Y=<365.11, 406.79,448.57,489.56,528.79,565.29,598.10,626.29,649.06,665.73,675.79,678.94,675.08,664.33,644.92,606.82,552.07,448.44,311.77,164.49,115.41,112.05,112.05,112.05,112.05>; 	
	static const decl /** Value of boys for different age brackets. **/  ValBoy=<49.33,-45.61,-196.5,131.7>; 
	static const decl /** Value of girls for differen age brackets.. **/ ValGirl=<50.35,-33.96,-56.37,4.77>;	
	
	
	static ItsABoy(A);	
        static Run();	
	static Reachable();	    // Static methods can be called anything.		
	Utility();		  	//Automatic methods
	FeasibleActions(Alpha);
			
	}
