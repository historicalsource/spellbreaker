"MISC for
			      MAGE
	     (c) 1985 by Infocom, Inc. All Rights Reserved."

;"former MACROS.ZIL stuff"

<SETG C-NORTH 1>
<SETG C-EAST 2>
<SETG C-WEST 4>
<SETG C-SOUTH 8>
<SETG C-NE 16>
<SETG C-NW 32>
<SETG C-SE 64>
<SETG C-SW 128>

<CONSTANT C-NORTH 1>
<CONSTANT C-EAST 2>
<CONSTANT C-WEST 4>
<CONSTANT C-SOUTH 8>
<CONSTANT C-NE 16>
<CONSTANT C-NW 32>
<CONSTANT C-SE 64>
<CONSTANT C-SW 128>

;"SUSPECT tell macro and friends"

<COND (<GASSIGNED? ZILCH> ;"version for when compiling"
       <DEFMAC TELL ("ARGS" A)
	       <FORM PROG ()
		     !<MAPF ,LIST
			    <FUNCTION ("AUX" E P O)
				 <COND (<EMPTY? .A> <MAPSTOP>)
				       (<SET E <NTH .A 1>>
					<SET A <REST .A>>)>
				 <COND (<TYPE? .E ATOM>
					<COND (<OR <=? <SET P <SPNAME .E>>
						       "CRLF">
						   <=? .P "CR">>
					       <MAPRET '<CRLF>>)
					      ;(<=? .P "V">
						<MAPRET '<VPRINT>>)
					      (<EMPTY? .A>
					       <ERROR INDICATOR-AT-END? .E>)
					      (ELSE
					       <SET O <NTH .A 1>>
					       <SET A <REST .A>>
					       <COND (<OR <=? <SET P <SPNAME .E>>
							      "DESC">
							  <=? .P "D">
							  <=? .P "OBJ">
							  <=? .P "O">>
						      <MAPRET
						       <PFORM DPRINT .O>>)
						     (<=? .P "CD">
						      <MAPRET
						       <PFORM CDPRINT .O>>)
						     (<=? .P "THE">
						      <MAPRET
						       <PFORM THE-PRINT .O>>)
						     (<=? .P "CTHE">
						      <MAPRET
						       <PFORM CTHE-PRINT .O>>)
						     (<OR <=? .P "A">
							  <=? .P "AN">>
						      <MAPRET
						       <PFORM PRINTA .O>>)
						     (<OR <=? .P "NUM">
							  <=? .P "N">>
						      <MAPRET
						       <FORM PRINTN .O>>)
						     (<OR <=? .P "CHAR">
							  <=? .P "CHR">
							  <=? .P "C">>
						      <MAPRET
						       <FORM PRINTC
							     <CHTYPE .O FIX>>>)
						     (ELSE
						      <MAPRET
						       <FORM PRINT
							     <FORM GETP .O .E>>>)>)>)
				       (<TYPE? .E STRING ZSTRING>
					<MAPRET
					 <COND (<==? <LENGTH .E> 1>
						<FORM PRINTC
						      <CHTYPE <1 .E> FIX>>)
					       (ELSE
						<FORM PRINTI .E>)>>)
				       (<AND <TYPE? .E FORM>
					     <==? <NTH .E 1> QUOTE>>
					<MAPRET
					 <FORM PRINTD
					       <MAKE-GVAL <NTH .E 2>>>>)
				       (<TYPE? .E FORM LVAL GVAL>
					<MAPRET <FORM PRINT .E>>)
				       (ELSE <ERROR UNKNOWN-TYPE .E>)>>>>>)
      (ELSE ;"version for when interpreting"
       <DEFINE TELL ("TUPLE" A)
	       <MAPR <>
		     <FUNCTION ("AUX" E P O)
			  <COND (<EMPTY? .A> <MAPLEAVE>)
				(<SET E <NTH .A 1>>
				 <SET A <REST .A>>)>
			  <COND (<TYPE? .E ATOM>
				 <COND (<OR <=? <SET P <SPNAME .E>>
						"CRLF">
					    <=? .P "CR">>
					<CRLF>)
				       ;(<=? .P "V"> <VPRINT>)
				       (<AND <GASSIGNED? .E>
					     <TYPE? ,.E OBJECT>>
					<PRINTD ,.E>)
				       (<EMPTY? .A>
					<ERROR INDICATOR-AT-END? .E>)
				       (ELSE
					<SET O <NTH .A 1>>
					<SET A <REST .A>>
					<COND (<OR <=? <SET P <SPNAME .E>>
						       "DESC">
						   <=? .P "D">
						   <=? .P "OBJ">
						   <=? .P "O">>
					       <DPRINT .O>)
					      (<=? .P "CD">
					       <DPRINT .O T>)
					      ;(<=? .P "HE/SHE">
						<HE/SHE-PRINT .O>)
					      ;(<=? .P "HIM/HER">
						<HIM/HER-PRINT .O>)
					      ;(<=? .P "HIS/HER">
						<HIM/HER-PRINT .O T>)
					      (<=? .P "THE">
					       <THE-PRINT .O>)
					      (<=? .P "CTHE">
					       <CTHE-PRINT .O>)
					      (<OR <=? .P "A">
						   <=? .P "AN">>
					       <PRINTA .O>)
					      (<OR <=? .P "NUM">
						   <=? .P "N">>
					       <PRINTN .O>)
					      (<OR <=? .P "CHAR">
						   <=? .P "CHR">
						   <=? .P "C">>
					       <PRINTC .O>)
					      (ELSE
					       <PRINT <GETP .O .E>>)>)>)
				(<TYPE? .E STRING ZSTRING>
				 <PRINTI .E>)
				(<AND <TYPE? .E FORM>
				      <==? <NTH .E 1> QUOTE>>
				 <PRINTD <GVAL <NTH .E 2>>>)
				(<TYPE? .E FORM LVAL GVAL>
				 <PRINT .E>)
				(ELSE <ERROR UNKNOWN-TYPE .E>)>>>>
)>

<DEFINE PFORM (APP OBJ "AUX" A)
	<COND (<AND <TYPE? .OBJ LVAL GVAL>
		    <MEMQ <SET A <CHTYPE .OBJ ATOM>> '[PRSO PRSI]>>
	       <COND (<==? .APP DPRINT>
		      <COND (<==? .A PRSO> <FORM DPRINT-PRSO>)
			    (ELSE <FORM DPRINT-PRSI>)>)
		     (<==? .APP CDPRINT>
		      <COND (<==? .A PRSO> <FORM CDPRINT-PRSO>)
			    (ELSE <FORM CDPRINT-PRSI>)>)
		     (<==? .APP THE-PRINT>
		      <COND (<==? .A PRSO> <FORM THE-PRINT-PRSO>)
			    (ELSE <FORM THE-PRINT-PRSI>)>)
		     (<==? .APP CTHE-PRINT>
		      <COND (<==? .A PRSO> <FORM CTHE-PRINT-PRSO>)
			    (ELSE <FORM CTHE-PRINT-PRSI>)>)
		     (<==? .APP PRINTA>
		      <COND (<==? .A PRSO> <FORM PRINTA-PRSO>)
			    (ELSE <FORM PRINTA-PRSI>)>)
		     (ELSE <ERROR .APP .OBJ>)>)
	      (<ASSIGNED? EXT>
	       <FORM .APP .OBJ .EXT>)
	      (ELSE
	       <FORM .APP .OBJ>)>>

<DEFINE MAKE-GVAL (E)
	<COND (<OR <GASSIGNED? MUDDLE>
		   <NOT <TYPE? .E ATOM>>>
	       <FORM GVAL .E>)
	      (ELSE
	       <CHTYPE .E GVAL>)>>

<ROUTINE CTHE-PRINT-PRSO ()
	 <THE-PRINT ,PRSO T>>

<ROUTINE CTHE-PRINT-PRSI ()
	 <THE-PRINT ,PRSI T>>

<ROUTINE CTHE-PRINT (O)
	 <THE-PRINT .O T>>

<ROUTINE THE-PRINT-PRSO ()
	 <THE-PRINT ,PRSO>>

<ROUTINE THE-PRINT-PRSI ()
	 <THE-PRINT ,PRSI>>

<ROUTINE THE-PRINT (O "OPTIONAL" (CAP? <>))
	 <DPRINT .O .CAP? <NOT <FSET? .O ,NOTHEBIT>>>>

<ROUTINE PRINTA-PRSO ()
	 <PRINTA ,PRSO>>

<ROUTINE PRINTA-PRSI ()
	 <PRINTA ,PRSI>>

<ROUTINE PRINTA (O)
	 <COND (<FSET? .O ,THE> <PRINTI "the ">)
	       (<NOT <FSET? .O ,NOABIT>>
		<COND (<FSET? .O ,AN> <PRINTI "an ">)
		      (ELSE <PRINTI "a ">)>)>
	 <IPRINT .O>>

;<ROUTINE CDPRINT-PRSO ()
	 <DPRINT ,PRSO T>>

;<ROUTINE CDPRINT-PRSI ()
	 <DPRINT ,PRSI T>>

;<ROUTINE CDPRINT (O)
	 <DPRINT .O T>>

<ROUTINE DPRINT (O "OPTIONAL" (CAP? <>) (THE? <>) "AUX" S)
	 <COND (<OR .THE? <FSET? .O ,THE>>
		<COND (.CAP? <PRINTI "The ">)
		      (T <PRINTI "the ">)>)>
	 <IPRINT .O>>

<ROUTINE IPRINT (O)
	 <COND (<AND <EQUAL? .O ,PSEUDO-OBJECT>
		     <NOT ,P-MERGED>
		     <EQUAL? .O ,PRSO ,PRSI>>
		<THING-PRINT ,PSEUDO-PRSO ;"<EQUAL? .O ,PRSO>">)
	       (<AND <EQUAL? .O ,WEED>
		     <FSET? .O ,RWATERBIT>>
		<TELL "weed cutting">)
	       (<EQUAL? .O ,SPELL-COPY>
		<PRINTD .O>
		<PRINTI " ">
		<PRINTD <GETP .O ,P?WALLS>>)
	       (ELSE
		<COND (<NOT <ZERO? <GETP .O ,P?NAME>>>
		       <CUBE-NAME .O>
		       <PRINTI " ">)
		      (<AND <FSET? .O ,RWATERBIT>
			    <GETPT .O ,P?COUNT>>
		       <PRINTI "duplicate ">)>
		<PRINTD .O>)>>

<COND (<GASSIGNED? ZILCH>
<DEFMAC VERB? ("ARGS" ATMS)
	<MULTIFROB PRSA .ATMS>>

<DEFMAC PRSO? ("ARGS" ATMS)
	<MULTIFROB PRSO .ATMS>>

<DEFMAC PRSI? ("ARGS" ATMS)
	<MULTIFROB PRSI .ATMS>>

<DEFMAC ROOM? ("ARGS" ATMS)
	<MULTIFROB HERE .ATMS>>

<DEFINE MULTIFROB (X ATMS "AUX" (OO (OR)) (O .OO) (L ()) ATM) 
	<REPEAT ()
		<COND (<EMPTY? .ATMS>
		       <RETURN!- <COND (<LENGTH? .OO 1> <ERROR .X>)
				       (<LENGTH? .OO 2> <NTH .OO 2>)
				       (ELSE <CHTYPE .OO FORM>)>>)>
		<REST
		 <PUTREST
		  .O
		  <SET O (<REPEAT ((LL <FORM EQUAL? <MAKE-GVAL .X>>)
				   (L <REST .LL>))
				  <COND (<OR <EMPTY? .ATMS>
					     <==? <LENGTH <REST .LL 2>> 3>>
					 <RETURN!- .LL>)>
				  <SET ATM <NTH .ATMS 1>>
				  <PUTREST .L
					   <SET L
						(<COND
						  (<TYPE? .ATM ATOM>
						   <MAKE-GVAL
						    <COND (<==? .X PRSA>
							   <PARSE
							    <STRING
							     "V?"
							     <SPNAME .ATM>>>)
							  (ELSE .ATM)>>)
						  (ELSE .ATM)>)>>
				  <SET ATMS <REST .ATMS>>>)>>>>>)
(ELSE
 <DEFINE VERB? ("TUPLE" ATMS)
	 <MAPF <>
	       <FUNCTION (A "AUX" ATM)
		    <COND (<NOT <TYPE? .A ATOM>> <ERROR MULTIFROB>)
			  (<NOT <SET ATM
				     <LOOKUP <STRING "V?" <SPNAME .A>>
					     <MOBLIST INITIAL>>>>
			   <ERROR NOT-A-VERB? .A>)
			  (<EQUAL? ,PRSA ,.ATM>
			   <MAPLEAVE T>)>>
	       .ATMS>>
 <DEFINE PRSO? ("TUPLE" ATMS)
	 <MULTIFROB ,PRSO .ATMS>>
 <DEFINE PRSI? ("TUPLE" ATMS)
	 <MULTIFROB ,PRSI .ATMS>>
 <DEFINE ROOM? ("TUPLE" ATMS)
	 <MULTIFROB HERE .ATMS>>
 <DEFINE MULTIFROB (X ATMS) 
	 <MAPF <>
	       <FUNCTION (A)
		    <COND (<TYPE? .A ATOM> <SET A ,.A>)>
		    <COND (<EQUAL? .X .A>
			   <MAPLEAVE T>)>>
	       .ATMS>>)>

<COND (<GASSIGNED? ZILCH>
<DEFMAC BSET ('OBJ "ARGS" BITS)
	<MULTIBITS FSET .OBJ .BITS>>

<DEFMAC BCLEAR ('OBJ "ARGS" BITS)
	<MULTIBITS FCLEAR .OBJ .BITS>>

<DEFMAC BSET? ('OBJ "ARGS" BITS)
	<MULTIBITS FSET? .OBJ .BITS>>

<DEFINE MULTIBITS (X OBJ ATMS
		   "AUX" (OT <COND (<==? .X FSET?> <FORM OR>)
				   (ELSE <FORM PROG ()>)>)
		         (OO <COND (<LENGTH? .OT 1> .OT)
				   (ELSE <REST .OT>)>)
			 (O .OO)
			 ATM) 
	<REPEAT ()
		<COND (<EMPTY? .ATMS>
		       <RETURN!- .OT>)>
		<SET ATM <NTH .ATMS 1>>
		<SET ATMS <REST .ATMS>>
		<PUTREST .O
			 <SET O
			      (<FORM .X
				     .OBJ
				     <COND (<TYPE? .ATM FORM> .ATM)
					   (ELSE <MAKE-GVAL .ATM>)>>)>>>>)
(ELSE
<DEFINE BSET (OBJ "TUPLE" BITS)
	<MULTIBITS ,FSET .OBJ .BITS>>

<DEFINE BCLEAR (OBJ "TUPLE" BITS)
	<MULTIBITS ,FCLEAR .OBJ .BITS>>

<DEFINE BSET? (OBJ "TUPLE" BITS)
	<MAPF <>
	      <FUNCTION (A)
		   <COND (<FSET? .OBJ ,.A> <MAPLEAVE T>)>>
	      .BITS>>

<DEFINE MULTIBITS (X OBJ ATMS) 
	<MAPF <>
	      <FUNCTION (A)
		   <APPLY!- .X .OBJ ,.A>>
	      .ATMS>>)>

<DEFMAC RFATAL ()
	'<PROG () <PUSH 2> <RSTACK>>>

<COND (<GASSIGNED? ZILCH>
       <DEFMAC PROB ('BASE?)
	       <FORM NOT <FORM L? .BASE? '<RANDOM 100>>>>)
      (ELSE
       <DEFINE PROB (BASE?)
	       <NOT <L? .BASE? <RANDOM 100>>>>)>

<ROUTINE PICK-ONE (FROB
		   "AUX" (L <GET .FROB 0>) (CNT <GET .FROB 1>) RND MSG RFROB)
	 <SET L <- .L 1>>
	 <SET FROB <REST .FROB 2>>
	 <SET RFROB <REST .FROB <* .CNT 2>>>
	 <SET RND <RANDOM <- .L .CNT>>>
	 <SET MSG <GET .RFROB .RND>>
	 <PUT .RFROB .RND <GET .RFROB 1>>
	 <PUT .RFROB 1 .MSG>
	 <SET CNT <+ .CNT 1>>
	 <COND (<==? .CNT .L> <SET CNT 0>)>
	 <PUT .FROB 0 .CNT>
	 .MSG>

<ROUTINE RANDOM-ELEMENT (FROB)
	 <GET .FROB <RANDOM <GET .FROB 0>>>>



;"former MAIN.ZIL stuff"

<GLOBAL P-WON <>>

<CONSTANT M-FATAL 2>

<CONSTANT M-BEG 1>
<CONSTANT M-END 2>
<CONSTANT M-ENTER 3>
<CONSTANT M-LEAVE 4>
<CONSTANT M-LOOK 5>
<CONSTANT M-FLASH 6>
<CONSTANT M-OBJDESC 7>
<CONSTANT M-CONTAINER 8>

<ROUTINE GO () 
	 <INITIALIZE-CUBES>
	 <PUTB ,P-LEXV 0 59>
;"put interrupts on clock chain"
	 <SETG CLOCK-HAND <REST ,C-TABLE ,C-TABLELEN>>
	 <QUEUE I-TIRED 80>
	 <QUEUE I-ORATION -1>
;"set up and go"
	 <SETG MAGIC-BOX-CUBE ,WATER-CUBE>
	 <SETG WINNER ,PLAYER>
	 <SETG HERE ,COUNCIL-CHAMBER>
	 <SETG LIT <LIT? ,HERE>>
	 <SETG ORATOR ,SNEFFLE>
	 <V-VERSION>
	 <CRLF>
	 <V-LOOK>
	 <MAIN-LOOP>
	 <AGAIN>>    

<ROUTINE MAIN-LOOP ("AUX" TRASH)
	<REPEAT ()
	     <SET TRASH <MAIN-LOOP-1>>>>

<ROUTINE MAIN-LOOP-1 ("AUX" ICNT OCNT NUM CNT OBJ TBL (V <>) PTBL OBJ1 TMP)
     <SET CNT 0>
     <SET OBJ <>>
     <SET PTBL T>
     <COND (<SETG P-WON <PARSER>>
	    <SET ICNT <GET ,P-PRSI ,P-MATCHLEN>>
	    <SET OCNT <GET ,P-PRSO ,P-MATCHLEN>>
	    <COND (<AND ,P-IT-OBJECT <ACCESSIBLE? ,P-IT-OBJECT>>
		   <SET TMP <>>
		   <REPEAT ()
			   <COND (<G? <SET CNT <+ .CNT 1>> .ICNT>
				  <RETURN>)
				 (T
				  <COND (<EQUAL? <GET ,P-PRSI .CNT> ,IT>
					 <PUT ,P-PRSI .CNT ,P-IT-OBJECT>
					 <SET TMP T>
					 <RETURN>)>)>>
		   <COND (<NOT .TMP>
			  <SET CNT 0>
			  <REPEAT ()
			   <COND (<G? <SET CNT <+ .CNT 1>> .OCNT>
				  <RETURN>)
				 (T
				  <COND (<EQUAL? <GET ,P-PRSO .CNT> ,IT>
					 <PUT ,P-PRSO .CNT ,P-IT-OBJECT>
					 <RETURN>)>)>>)>
		   <SET CNT 0>)>
	    <SET NUM
		 <COND (<ZERO? .OCNT> .OCNT)
		       (<G? .OCNT 1>
			<SET TBL ,P-PRSO>
			<COND (<ZERO? .ICNT> <SET OBJ <>>)
			      (T <SET OBJ <GET ,P-PRSI 1>>)>
			.OCNT)
		       (<G? .ICNT 1>
			<SET PTBL <>>
			<SET TBL ,P-PRSI>
			<SET OBJ <GET ,P-PRSO 1>>
			.ICNT)
		       (T 1)>>
	    <COND (<AND <NOT .OBJ>
			<1? .ICNT>>
		   <SET OBJ <GET ,P-PRSI 1>>)>
	    <COND (<EQUAL? ,PRSA ,V?WALK> <SET V <PERFORM ,PRSA ,PRSO>>)
		  (<ZERO? .NUM>
		   <COND (<ZERO? <BAND <GETB ,P-SYNTAX ,P-SBITS> ,P-SONUMS>>
			  <SET V <PERFORM ,PRSA>>
			  <SETG PRSO <>>)
			 (<NOT ,LIT>
			  <TELL ,TOO-DARK>
			  <END-QUOTE>)
			 (T
			  <TELL "There isn't anything to ">
			  <SET TMP <GET ,P-ITBL ,P-VERBN>>
			  <COND (<VERB? TELL>
				 <TELL "talk to">)
				(<OR ,P-OFLAG ,P-MERGED>
				 <PRINTB <GET .TMP 0>>)
				(T
				 <WORD-PRINT <GETB .TMP 2>
					     <GETB .TMP 3>>)>
			  <TELL "!" CR>
			  <SET V <>>
			  <END-QUOTE>)>)
		  (T
		   <SETG P-NOT-HERE 0>
		   <SETG P-MULT <>>
		   <COND (<G? .NUM 1> <SETG P-MULT 1>)>
		   <SET TMP <>>
		   <REPEAT ()
			   <COND (<G? <SET CNT <+ .CNT 1>> .NUM>
				  <COND (<G? ,P-NOT-HERE 0>
					 <TELL "The ">
					 <COND (<NOT <EQUAL? ,P-NOT-HERE .NUM>>
						<TELL "other ">)>
					 <TELL "object">
					 <COND (<NOT <EQUAL? ,P-NOT-HERE 1>>
						<TELL "s">)>
					 <TELL " that you mentioned ">
					 <COND (<NOT <EQUAL? ,P-NOT-HERE 1>>
						<TELL "are">)
					       (T <TELL "is">)>
					 <TELL "n't here." CR>)
					(<NOT .TMP>
					 <TELL ,REFERRING CR>)>
				  <RETURN>)

(T ;"REFORMATTED AREA"
 <COND (.PTBL <SET OBJ1 <GET ,P-PRSO .CNT>>)
       (T <SET OBJ1 <GET ,P-PRSI .CNT>>)>
 <SETG PRSO <COND (.PTBL .OBJ1) (T .OBJ)>>
 <SETG PRSI <COND (.PTBL .OBJ) (T .OBJ1)>>
 <COND (<OR <G? .NUM 1>
	    <EQUAL? <GET <GET ,P-ITBL ,P-NC1> 0> ,W?ALL>>
	<COND (<MULTIPLE-EXCEPTION? .OBJ1> <AGAIN>)
	      (T
	       <COND (<EQUAL? .OBJ1 ,IT>
		      <TELL D ,P-IT-OBJECT>)
		     (ELSE
		      <TELL D .OBJ1>)>
	       <TELL ": ">)>)>
 <SET TMP T>
 <SETG PSEUDO-PRSO <COND (<EQUAL? ,PRSO ,PSEUDO-OBJECT>)>>
 <SET V <PERFORM ,PRSA ,PRSO ,PRSI>>
 <COND (<EQUAL? .V ,M-FATAL> <RETURN>)>
 <COND (,P-MULT <SETG P-MULT <+ ,P-MULT 1>>)>) ;"END REFORMATTING"

				 >>)>
	    <COND (<NOT <EQUAL? .V ,M-FATAL>>
		   <COND (<VERB? TELL BRIEF SUPER-BRIEF VERBOSE
				 SAVE VERSION RESTORE SCRIPT UNSCRIPT>
			  T)
			 (T
			  <SET V
			       %<DEBUG-CODE
				 <D-APPLY "End"
					  <GETP <LOC ,WINNER> ,P?ACTION>
					  ,M-END>
				 <APPLY <GETP <LOC ,WINNER> ,P?ACTION>
					,M-END>>>)>)>
	    <COND (<VERB? SAVE RESTORE SCRIPT UNSCRIPT
			  VERBOSE BRIEF SUPER-BRIEF>
		   T)
		  (,P-OFLAG T)>
	    <COND (<EQUAL? .V ,M-FATAL>
		   <SETG P-CONT <>>)>)
	   (T
	    <SETG P-CONT <>>)>
     <COND (,P-WON
	    %<DEBUG-CODE
	      <COND (<VERB? $DEBUG>
		     <AGAIN>)>>
	    <COND (<NO-CLOCK-VERB?> T)
		  (T
		   <SET V <CLOCKER>>)>
	    <SETG PRSA <>>
	    <SETG PRSO <>>
	    <SETG PRSI <>>)>>

<GLOBAL PSEUDO-PRSO <>> ;"T IF ORIGINAL PRSO WAS PSEUDO-OBJECT"

<ROUTINE NO-CLOCK-VERB? ()
	 <COND (<AND <VERB? TELL> ,P-CONT> <RTRUE>)
	       (<VERB? BRIEF SUPER-BRIEF VERBOSE VERSION QUIT SCORE
		       SAVE RESTORE SCRIPT UNSCRIPT HELP RESTART $VERIFY
		       TIME $RANDOM $COMMAND $RECORD $UNRECORD>
		<RTRUE>)>>

"MULTIPLE-EXCEPTION? -- return true if an object found by all should not
be include when the crunch comes."

<ROUTINE MULTIPLE-EXCEPTION? (OBJ1 "AUX" (L <LOC .OBJ1>))
	 <COND (<EQUAL? .OBJ1 ,NOT-HERE-OBJECT>
		<SETG P-NOT-HERE <+ ,P-NOT-HERE 1>>
		<RTRUE>)
	       (<AND <VERB? TAKE>
		     ,PRSI
		     <NOT <IN? ,PRSO ,PRSI>>>
		;"TAKE X FROM Y and x not in y"
		<RTRUE>)
	       (<NOT <ACCESSIBLE? .OBJ1>>
		;"can't get at object"
		<RTRUE>)
	       (<EQUAL? ,P-GETFLAGS ,P-ALL>
		;"cases for ALL"
		<COND (<AND <VERB? TAKE>
			    <OR <AND <NOT <EQUAL? .L ,WINNER ,HERE ,PRSI>>
				     <NOT <EQUAL? .L <LOC ,WINNER>>>
				     <NOT <FSET? .L ,SURFACEBIT>>
				     <NOT <FSET? .L ,SEARCHBIT>>>
				<AND <NOT <FSET? .OBJ1 ,TAKEBIT>>
				     <NOT <FSET? .OBJ1 ,TRYTAKEBIT>>>>>
		       ;"TAKE ALL and object not accessible or takeable"
		       <RTRUE>)
		      (<AND <VERB? TAKE>
			    <NOT ,PRSI>
			    <HELD? ,PRSO>>
		       ;"TAKE ALL and one object has others in it"
		       <RTRUE>)
		      (<AND <VERB? DROP>
			    <NOT <IN? .OBJ1 ,WINNER>>>
		       ;"DROP ALL and object not held"
		       <RTRUE>)
		      (<AND ,PRSI
			    <EQUAL? ,PRSO ,PRSI>>
		       ;"VERB ALL and prso = prsi"
		       <RTRUE>)
		      (<AND <VERB? PUT>
			    <NOT <IN? ,PRSO ,WINNER>>
			    <HELD? ,PRSO ,PRSI>>
		       ;"PUT ALL IN X and object already in x"
		       <RTRUE>)
		      (<AND <FSET? ,PRSO ,SPELLBIT>
			    <NOT <VERB? LEARN GNUSTO CAST>>
			    <NOT <VERB? READ>>>
		       ;"normally ignore spells in ALL"
		       <RTRUE>)>)>>

;<ROUTINE SAVE-INPUT (TBL "AUX" (OFFS 0) CNT TMP)
	 <SET CNT <+ <GETB ,P-LEXV <SET TMP <* 4 ,P-INPUT-WORDS>>>
		     <GETB ,P-LEXV <+ .TMP 1>>>>
	 <COND (<EQUAL? .CNT 0> ;"failed"
		<RFALSE>)>
	 <SET CNT <- .CNT 1>>
	 <REPEAT ()
		 <COND (<EQUAL? .OFFS .CNT>
			<PUTB .TBL .OFFS 0>
			<RETURN>)
		       (T
			<PUTB .TBL .OFFS <GETB ,P-INBUF <+ .OFFS 1>>>)>
		 <SET OFFS <+ .OFFS 1>>>
	 <RTRUE>>

;<ROUTINE RESTORE-INPUT (TBL "AUX" CHR)
	 <REPEAT ()
		 <COND (<EQUAL? <SET CHR <GETB .TBL 0>> 0>
			<RETURN>)
		       (T
			<PRINTC .CHR>
			<SET TBL <REST .TBL>>)>>>

<GLOBAL P-MULT <>>

<GLOBAL P-NOT-HERE 0>


<ROUTINE FAKE-ORPHAN ("AUX" TMP)
	 <ORPHAN ,P-SYNTAX <>>
	 <TELL "What do you want to ">
	 <SET TMP <GET ,P-OTBL ,P-VERBN>>
	 <COND (<EQUAL? .TMP 0>
		<TELL "tell">)
	       (<ZERO? <GETB ,P-VTBL 2>>
		<PRINTB <GET .TMP 0>>)
	       (T
		<WORD-PRINT <GETB .TMP 2> <GETB .TMP 3>>
		<PUTB ,P-VTBL 2 0>)>
	 <SETG P-OFLAG T>
	 <SETG P-WON <>>
	 <PREP-PRINT
	     <GETB ,P-SYNTAX ,P-SPREP1>>
	 <TELL "?" CR>>

<ROUTINE PERFORM (A "OPTIONAL" (O <>) (I <>) "AUX" V OA OO OI CNT)
	%<DEBUG-CODE
	  <COND (,ZDEBUG
		 <TELL "[Perform: ">
		 %<COND (<GASSIGNED? ZILCH> '<TELL N .A>)
			(T '<PRINT <SPNAME <NTH ,ACTIONS <+ <* .A 2> 1>>>>)>
		 <COND (.O
			<COND (<AND <EQUAL? .A ,V?WALK>
				    ,P-WALK-DIR>
			       <TELL "/" N .O>)
			      (ELSE
			       <TELL "/" D .O>)>)>
		 <COND (.I <TELL "/" D .I>)>
		 <TELL "]" CR>)>>
	<SET OA ,PRSA>
	<SET OO ,PRSO>
	<SET OI ,PRSI>
	<SETG PRSA .A>
	<COND (<EQUAL? ,IT .I .O>
	       <COND (<NOT .I>
		      <FAKE-ORPHAN>)
		     (T
		      <TELL ,REFERRING CR>)>
	       <RFATAL>)
	      (<AND .O
		    <NOT <VERB? WALK>>
		    <NOT <EQUAL? .O ,NOT-HERE-OBJECT>>>
	       <THIS-IS-IT .O>)>
	<SETG PRSO .O>
	<SETG PRSI .I>
	<COND (<AND <NOT <EQUAL? .A ,V?WALK>>
		    <EQUAL? ,NOT-HERE-OBJECT ,PRSO ,PRSI>
		    <SET V
			 %<DEBUG-CODE
			   <D-APPLY "Not Here" ,NOT-HERE-OBJECT-F>
			   <APPLY ,NOT-HERE-OBJECT-F>>>>
	       <SETG P-WON <>>
	       .V)
	      (T
	       <SET O ,PRSO>
	       <SET I ,PRSI>
	       <COND (<SET V
			   %<DEBUG-CODE
			     <DD-APPLY "Actor" ,WINNER
				       <GETP ,WINNER ,P?ACTION>>
			     <APPLY <GETP ,WINNER ,P?ACTION>>>>
		      .V)
		     (<AND <NOT <EQUAL? <LOC ,WINNER> ,HERE>>
			   <SET V
				%<DEBUG-CODE
				  <D-APPLY "Begin"
					   <GETP <LOC ,WINNER> ,P?ACTION>
					   ,M-BEG>
				  <APPLY <GETP <LOC ,WINNER> ,P?ACTION>
					 ,M-BEG>>>>
		      .V)
		     (<SET V
			   %<DEBUG-CODE
			     <D-APPLY "Begin"
				      <GETP ,HERE ,P?ACTION>
				      ,M-BEG>
			     <APPLY <GETP ,HERE ,P?ACTION>
				    ,M-BEG>>>
		      .V)
		     (<SET V
			   %<DEBUG-CODE
			     <D-APPLY "Preaction"
				      <GET ,PREACTIONS .A>>
			     <APPLY <GET ,PREACTIONS .A>>>>
		      .V)
		     (<AND .I
			   <SET V
				%<DEBUG-CODE
				  <D-APPLY "PRSI" <GETP .I ,P?ACTION>>
				  <APPLY <GETP .I ,P?ACTION>>>>>
		      .V)
		     (<AND .O
			   <NOT <EQUAL? .A ,V?WALK>>
			   <LOC .O>
			   <GETP <LOC .O> ,P?CONTFCN>
			   <SET V
				%<DEBUG-CODE
				  <D-APPLY "Container"
					   <GETP <LOC .O> ,P?CONTFCN>
					   ,M-CONTAINER>
				  <APPLY <GETP <LOC .O> ,P?CONTFCN>
					 ,M-CONTAINER>>>>
		      .V) 
		     (<AND .O
			   <NOT <EQUAL? .A ,V?WALK>>
			   <SET V
				%<DEBUG-CODE
				  <D-APPLY "PRSO"
					   <GETP .O ,P?ACTION>>
				  <APPLY <GETP .O ,P?ACTION>>>>>
		      .V)
		     (<SET V
			   %<DEBUG-CODE
			     <D-APPLY <>
				      <GET ,ACTIONS .A>>
			     <APPLY <GET ,ACTIONS .A>>>>
		      .V)>)>
	<COND (,SPELL-CAST
	       <COND (<G? <SET CNT <GETP ,SPELL-CAST ,P?COUNT>> 0>
		      <PUTP ,SPELL-CAST ,P?COUNT <- .CNT 1>>)>
	       <COND (<L? ,SPELL-ROOM ,SPELL-MAX>
		      <SETG SPELL-ROOM <+ ,SPELL-ROOM 1>>)>
	       <SETG SPELL-CAST <>>)>
	<SETG PRSA .OA>
	<SETG PRSO .OO>
	<SETG PRSI .OI>
	.V>

%<COND (,ZDEBUGGING?
	<COND (<GASSIGNED? ZILCH>
	       <ROUTINE II-APPLY (STR FCN)
			<COND (,ZDEBUG
			       <TELL "[I- " N <* .FCN 2> " ">)>
			<D-APPLY .STR .FCN>>)
	      (ELSE
	       <ROUTINE II-APPLY (STR FCN)
			<D-APPLY <COND (<TYPE? .FCN ATOM> <SPNAME .FCN>)
				       (ELSE .STR)>
				 .FCN>>)>)>

%<DEBUG-CODE
  <ROUTINE DD-APPLY (STR OBJ FCN)
	   <COND (,ZDEBUG <TELL "[" D .OBJ "=]">)>
	   <D-APPLY .STR .FCN>>>

%<DEBUG-CODE
  <ROUTINE D-APPLY (STR FCN "OPTIONAL" (FOO <>) "AUX" RES)
	<COND (<NOT .FCN> <>)
	      (T
	       <COND (,ZDEBUG
		      <COND (<NOT .STR>
			     <TELL "[Action:]" CR>)
			    (T <TELL "[" .STR ": ">)>)>
	       <SET RES
		    <COND (.FOO <APPLY .FCN .FOO>)
			  (T <APPLY .FCN>)>>
	       %<DEBUG-CODE
		 <COND (<AND ,ZDEBUG .STR>
			<COND (<EQUAL? .RES ,M-FATAL>
			       <TELL "Fatal]" CR>)
			      (<NOT .RES>
			       <TELL "Not handled]" CR>)
			      (T <TELL "Handled]" CR>)>)>>
	       .RES)>>>

;"former CLOCK.ZIL stuff"

<GLOBAL CLOCK-WAIT <>>

<GLOBAL C-TABLE %<COND (<GASSIGNED? ZILCH>
			'<ITABLE NONE 26>)
		       (T
			'<ITABLE NONE 52>)>>

<CONSTANT C-TABLELEN 52>
<GLOBAL C-INTS 52>
%<DEBUG-CODE <GLOBAL C-MAXINTS 52>>

<CONSTANT C-INTLEN 4>	;"length of an interrupt entry"
<CONSTANT C-RTN 0>	;"offset of routine name"
<CONSTANT C-TICK 1>	;"offset of count"

<ROUTINE DEQUEUE (RTN)
	 <COND (<SET RTN <QUEUED? .RTN>>
		<PUT .RTN ,C-RTN 0>)>>

<ROUTINE QUEUED? (RTN "AUX" C E)
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
		 <COND (<EQUAL? .C .E> <RFALSE>)
		       (<EQUAL? <GET .C ,C-RTN> .RTN>
			<COND (<ZERO? <GET .C ,C-TICK>>
			       <RFALSE>)
			      (T <RETURN .C>)>)>
		 <SET C <REST .C ,C-INTLEN>>>>

"this version of QUEUE automatically enables as well"

<ROUTINE QUEUE (RTN TICK "AUX" C E (INT <>))
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
		 <COND (<EQUAL? .C .E>
			<COND (.INT
			       <SET C .INT>)
			      (ELSE
			       %<DEBUG-CODE
				 <COND (<L? ,C-INTS ,C-INTLEN>
					<TELL
					  "[**Too many interrupts!**]" CR>)>>
			       <SETG C-INTS <- ,C-INTS ,C-INTLEN>>
			       %<DEBUG-CODE
				 <COND (<L? ,C-INTS ,C-MAXINTS>
					<SETG C-MAXINTS ,C-INTS>)>>
			       <SET INT <REST ,C-TABLE ,C-INTS>>)>
			<PUT .INT ,C-RTN .RTN>
			<RETURN>)
		       (<EQUAL? <GET .C ,C-RTN> .RTN>
			<SET INT .C>
			<RETURN>)
		       (<ZERO? <GET .C ,C-RTN>>
			<SET INT .C>)>
		 <SET C <REST .C ,C-INTLEN>>>
	 <COND (%<COND (<GASSIGNED? ZILCH>
			'<G? .INT ,CLOCK-HAND>)
		       (ELSE
			'<L=? <LENGTH .INT> <LENGTH ,CLOCK-HAND>>)>
		<SET TICK <- <+ .TICK 3>>>)>
	 <PUT .INT ,C-TICK .TICK>
	 .INT>

<GLOBAL CLOCK-HAND <>>

<ROUTINE CLOCKER ("AUX" E TICK RTN (FLG <>) (Q? <>) OWINNER)
	 <COND (,CLOCK-WAIT <SETG CLOCK-WAIT <>> <RFALSE>)>
	 <SETG CLOCK-HAND <REST ,C-TABLE ,C-INTS>>
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET OWINNER ,WINNER>
	 <SETG WINNER ,PLAYER>
	 <REPEAT ()
		 <COND (<EQUAL? ,CLOCK-HAND .E>
			<SETG CLOCK-HAND .E>
			<SETG MOVES <+ ,MOVES 1>>
			<SETG WINNER .OWINNER>
			<RETURN .FLG>)
		       (<NOT <ZERO? <GET ,CLOCK-HAND ,C-RTN>>>
			<SET TICK <GET ,CLOCK-HAND ,C-TICK>>
			<COND (<L? .TICK -1>
			       <PUT ,CLOCK-HAND ,C-TICK <- <- .TICK> 3>>
			       <SET Q? ,CLOCK-HAND>)
			      (<NOT <ZERO? .TICK>>
			       <COND (<G? .TICK 0>
				      <SET TICK <- .TICK 1>>
				      <PUT ,CLOCK-HAND ,C-TICK .TICK>)>
			       <COND (<NOT <ZERO? .TICK>>
				      <SET Q? ,CLOCK-HAND>)>
			       <COND (<NOT <G? .TICK 0>>
				      <SET RTN
					   %<COND (<GASSIGNED? ZILCH>
						   '<GET ,CLOCK-HAND ,C-RTN>)
						  (ELSE
						   '<NTH ,CLOCK-HAND
							 <+ <* ,C-RTN 2>
							    1>>)>>
				      <COND (<ZERO? .TICK>
					     <PUT ,CLOCK-HAND ,C-RTN 0>)>
				      <COND (%<COND
					       (,ZDEBUGGING?
						'<II-APPLY "Int" .RTN>)
					       (ELSE
						'<APPLY .RTN>)>
					     <SET FLG T>)>
				      <COND (<AND <NOT .Q?>
						  <NOT
						   <ZERO?
						    <GET ,CLOCK-HAND
							 ,C-RTN>>>>
					     <SET Q? T>)>)>)>)>
		 <SETG CLOCK-HAND <REST ,CLOCK-HAND ,C-INTLEN>>
		 <COND (<NOT .Q?>
			<SETG C-INTS <+ ,C-INTS ,C-INTLEN>>)>>>

<DEFINE PSEUDO ("TUPLE" V)
	<MAPF ,PLTABLE
	      <FUNCTION (OBJ)
		   <COND (<N==? <LENGTH .OBJ> 3>
			  <ERROR BAD-THING .OBJ>)>
		   <MAPRET <COND (<NTH .OBJ 2>
				  <VOC <SPNAME <NTH .OBJ 2>>>)>
			   <COND (<NTH .OBJ 1>
				  <VOC <SPNAME <NTH .OBJ 1>> ADJECTIVE>)>
			   <3 .OBJ>>>
	      .V>>
