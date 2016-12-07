# LeThProve
Theorem-prover for Lewis condtional logics

This program is a theorem-prover for the Lewis conditional logics, implemented by Q. Vitalis, Second Lieutenant at the French Officer School of St-Cyr.

It was designed to be used with Swipl (www.swi-prolog.org).


##############################################################################

/* HOW TO USE IT: */

In order to use this program under swipl, first "consult" the file, then,
 use the function "prove":
   -prove has 4 arguments: 1. A list of formulae, the left part of the sequent

   	      		   		       2. Another list of formulae, the right part of the sequent

			                     3. The tree representing the rules used through the derivation
			  
						               4. A list of the sequents in each node


     -the syntax is the following: - ->	 for the material implication

   	       	      				    	   - <   for the comparative plausibility
				
 						    	                 - <<	  for the blocks (L << a, with "a" a formula, and L a list of formulae. 
								                            It is the contraction for multiple plausible comparative formulae)
				 
							                     - bot, top   to represent the "false", and "true" atoms

			     			              	   - atoms are written in lowercase (to not be missinterpreted with variables) 				 		

   
		-the rules: - axbot    represents the axiom considering "bot" in the left part

   	       		 - axtop    represents the axiom considering "top" in the right part
	       
					     - axini    represents the initiation axiom, considering the same formula in the both parts of the sequent
			   
   	           - impR    represents the material implication in the right part
   	   
    					 - impL    represents the material implication in the left part
	   
    					 - plR	  represents the comparative plausibility in the right part
	
      				 - plL	  represents the comparative plausibility in the left part
	
     	         - com	  represents the commutation rule for the blocks
	 
     					 - jump	   represents the jump rule
	  

     
		   -Extensions: To not use an extension or to use it, comment or uncomment the corresponding line
 						          in the /* Extension */ part of the file. They appear in lowercase in the resulting tree. 



  		 -Example of utilisation to prove the identity (a -> a): 
            				 ?- prove([],[a->a],X,[]).
                      (answer from the program: X=impR,axini)

##############################################################################
