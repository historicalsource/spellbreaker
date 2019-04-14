"VERBS for
				MAGE
	(c) Copyright 1985 Infocom, Inc. All Rights Reserved."

;"stuff to try to save space"

<GLOBAL PERIOD ".|">
<GLOBAL REFERRING "I don't see what you're referring to.">
<GLOBAL I-DONT-THINK-THAT "I don't think that ">
<GLOBAL DOESNT-FIT "It doesn't fit.|">
<GLOBAL NOW-BLACK "It is pitch black.">
<GLOBAL IT-LOOKS-LIKE "It looks like ">
<GLOBAL IT-IS-ALREADY "It's already ">
<GLOBAL TOO-DARK "It's too dark to see!|">
<GLOBAL LOOK-AROUND-YOU "Look around you.|">
<GLOBAL NOTHING-HAPPENS "Nothing happens.|">
<GLOBAL TAKEN "Taken.|">
<GLOBAL WASTE-OF-TIME "That would be a waste of time.|">
<GLOBAL THERE-IS-NOTHING "There is nothing ">
<GLOBAL NO-ROOM "There's no room.">
<GLOBAL THERES-NOTHING-TO "There's nothing to ">
<GLOBAL WHILE-FLYING "While flying?|">
<GLOBAL YOU-ARE "You already are">
<GLOBAL YOU-HAVE "You already have ">
<GLOBAL YOU-ARE-NOW "You are now ">
<GLOBAL YOU-ARENT "You aren't ">
<GLOBAL YOU-CANT "You can't ">
<GLOBAL YOU-CANT-REACH "You can't reach ">
<GLOBAL YOU-CANT-SEE "You can't see ">
<GLOBAL YOU-DONT-HAVE "You don't have ">
<GLOBAL YOU-HIT "You hit your head against ">
<GLOBAL MORE-SPECIFIC "You'll have to be more specific">
<GLOBAL YOU-HAVE-TO "You'll have to">

<ROUTINE DONT-HAVE-THAT ()
	 <TELL ,YOU-DONT-HAVE "that" ,PERIOD>>

<ROUTINE CANT-GO ()
	 <TELL ,YOU-CANT "go that way." CR>>

<ROUTINE NOT-HOLDING (OBJ)
	 <TELL ,YOU-ARENT "holding " THE .OBJ ,PERIOD>>

<ROUTINE ITS-EMPTY ()
	 <TELL CTHE ,PRSO " is empty" ,PERIOD>>

<ROUTINE ALREADY-OPEN ()
	 <TELL ,IT-IS-ALREADY "open" ,PERIOD>>

<ROUTINE ALREADY-CLOSED ()
	 <TELL ,IT-IS-ALREADY "closed" ,PERIOD>>

<ROUTINE MAKE-OUT ()
	 <TELL ,YOU-CANT "make out anything." CR>>

<ROUTINE WITH-PRSI? ()
	 <TELL "With "><A-PRSI?>>

<ROUTINE TELL-OPEN-CLOSED ("OPTIONAL" (OBJ <>))
	 <COND (.OBJ <TELL CTHE .OBJ>)
	       (ELSE
		<SET OBJ ,PRSO>
		<TELL THE ,PRSO>)>
	 <TELL " is ">
	 <COND (<FSET? .OBJ ,OPENBIT>
		<TELL "open">)
	       (ELSE
		<TELL "closed">)>
	 <TELL ,PERIOD>>

<ROUTINE THE-PRSO () <TELL THE ,PRSO ,PERIOD>>

<ROUTINE A-PRSO () <TELL A ,PRSO ,PERIOD>>

<ROUTINE A-PRSO? () <TELL A ,PRSO "?" CR>>

<ROUTINE THE-PRSI () <TELL THE ,PRSI ,PERIOD>>

<ROUTINE A-PRSI () <TELL A ,PRSI ,PERIOD>>

<ROUTINE A-PRSI? () <TELL A ,PRSI "?" CR>>

<ROUTINE YOU-CANT-X-THAT (STR)
	 <TELL ,YOU-CANT .STR " that!" CR>>

<ROUTINE YOU-CANT-X-PRSO (STR)
	 <TELL ,YOU-CANT .STR " ">
	 <COND (,PRSO <TELL THE ,PRSO>)
	       (ELSE <TELL "that">)>
	 <TELL ,PERIOD>>

<ROUTINE YOU-CANT-X-PRSI (STR)
	 <TELL ,YOU-CANT .STR " ">
	 <COND (,PRSI <TELL THE ,PRSI>)
	       (ELSE <TELL "that">)>
	 <TELL ,PERIOD>>

<ROUTINE UNINTERESTED (OBJ)
	 <COND (<EQUAL? .OBJ ,ME>
		<TELL-YUKS>)
	       (ELSE
		<TELL CTHE .OBJ " is uninterested." CR>)>>

<ROUTINE CANT-REACH-THAT ()
	 <TELL ,YOU-CANT-REACH "that." CR>>

<ROUTINE CANT-REACH-IT ()
	 <TELL ,YOU-CANT-REACH "it." CR>>

;"end of space saving stuff"

;"subtitle game commands"

<GLOBAL VERBOSITY 1>

<GLOBAL DESCRIPTIONS " descriptions">

<ROUTINE V-VERBOSE ()
	 <SETG VERBOSITY 2>
	 <TELL "Verbose" ,DESCRIPTIONS ,PERIOD CR>
	 <V-LOOK>>

<ROUTINE V-BRIEF ()
	 <SETG VERBOSITY 1>
	 <TELL "Brief" ,DESCRIPTIONS ,PERIOD>>

<ROUTINE V-SUPER-BRIEF ()
	 <SETG VERBOSITY <>>
	 <TELL "Super-brief" ,DESCRIPTIONS ,PERIOD>>

<ROUTINE V-DIAGNOSE ()
	 <TELL "You are ">
	 <COND (,SMALL-FLAG <TELL "shrunken, ">)>
	 <COND (,CHANGED? <TELL "transformed into a " 'CHANGED? ", ">)>
	 <COND (<L? ,AWAKE 0>
		<TELL "wide awake">)
	       (T
		<TELL <GET ,TIRED-TELL ,AWAKE>>)>
	 <TELL ", and in ">
	 <COND (<G? ,FREEZE-COUNT 4>
		<TELL "danger of freezing to death">)
	       (ELSE
		<TELL "good health">)>
	 <TELL ,PERIOD>>

<GLOBAL TIRED-TELL
       <PTABLE
	"beginning to tire"
	"feeling tired"
	"getting more and more tired"
	"worn out"
	"dead tired"
	"so tired you can barely concentrate"
	"moving on your last reserves of strength"
	"practically asleep"
	"barely able to keep your eyes open"
	"about to keel over from exhaustion">>

<ROUTINE V-INVENTORY ()
	 <COND (<FIRST? ,WINNER>
		<PRINT-CONT ,WINNER>)
	       (T
		<TELL "You are empty-handed." CR>)>>

<ROUTINE V-QUIT ("OPTIONAL" (ASK? T) "AUX" SCOR)
	 %<DEBUG-CODE <TELL-C-INTS>>
	 <V-SCORE>
	 <COND (<OR <AND .ASK?
			 <TELL
"Do you wish to leave the game">
			 <YES?>>
		    <NOT .ASK?>>
		<QUIT>)
	       (T
		<TELL ,OKAY>)>>

<ROUTINE V-RESTART ()
	 %<DEBUG-CODE <TELL-C-INTS>>
	 <V-SCORE T>
	 <TELL "Do you wish to restart">
	 <COND (<YES?>
		<TELL "Restarting." CR>
		<RESTART>
		<TELL ,FAILED>)>>

<GLOBAL OKAY "Okay.|">

<GLOBAL FAILED "Failed.|">

<ROUTINE FINISH ("OPTIONAL" (REPEATING <>))
	 <CRLF>
	 %<DEBUG-CODE <TELL-C-INTS>>
	 <COND (<NOT .REPEATING>
		<V-SCORE>
		<CRLF>)>
	 <TELL
"Would you like to restart the game from the beginning, restore a saved
game position, or end this session of the game?|
(Type RESTART, RESTORE, or QUIT):|
>">
	 <READ ,P-INBUF ,P-LEXV>
	 <COND (<EQUAL? <GET ,P-LEXV 1> ,W?RESTAR>
	        <RESTART>
		<TELL ,FAILED>
		<FINISH T>)
	       (<EQUAL? <GET ,P-LEXV 1> ,W?RESTOR>
		<COND (<RESTORE>
		       <TELL ,OKAY>)
		      (T
		       <TELL ,FAILED>
		       <FINISH T>)>)
	       (T
		<QUIT>)>>

<ROUTINE YES? ()
	 <PRINTI "?|
(Y is affirmative): >">
	 <READ ,P-INBUF ,P-LEXV>
	 <COND (<EQUAL? <GET ,P-LEXV 1> ,W?YES ,W?Y>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE V-RESTORE ()
	 <COND (<RESTORE> <RTRUE>)
	       (T
		<TELL ,FAILED>)>>

<ROUTINE V-SAVE ("AUX" X)
	 <PUTB ,OOPS-INBUF 1 0>
	 <SET X <SAVE>>
	 <COND (<ZERO? .X>
	        <TELL ,FAILED>)
	       (ELSE
		<TELL ,OKAY>)>>

<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
	 <TELL
"Your score is " N ,SCORE " of a possible 600, in " N ,MOVES " move">
	 <COND (<NOT <1? ,MOVES>> <TELL "s">)>
	 <TELL ". This puts you in the class of ">
	 <COND (<L? ,SCORE 0>
		<TELL "Menace to Society">)
	       (T
		<TELL <GET ,RANKINGS </ ,SCORE 50>>>)>
	 <TELL ,PERIOD>
	 ,SCORE>

<GLOBAL RANKINGS
	<PTABLE
	 "Charlatan"		;"0-49"
	 "Parlor Magician"	;"50-99"
	 "Magician"		;"100-149"
	 "Novice Enchanter"	;"150"
	 "Enchanter"		;"200-249"
	 "Expert Enchanter"
	 "Novice Sorcerer"	;"300-349"
         "Sorcerer"
	 "Expert Sorcerer"	;"400-449"
	 "Novice Mage"
	 "Mage"			;"500-549"
	 "Archimage"
	 "Scientist" ;"600">>

<ROUTINE V-SCRIPT ()
	<PUT 0 8 <BOR <GET 0 8> 1>>
	<TELL "Here begins" ,COPR-NOTICE CR>
	<V-VERSION>>

<ROUTINE V-UNSCRIPT ()
	<TELL "Here ends" ,COPR-NOTICE CR>
	<V-VERSION>
	<PUT 0 8 <BAND <GET 0 8> -2>>
	<RTRUE>>

<GLOBAL COPR-NOTICE
" a transcript of interaction with SPELLBREAKER.">

<ROUTINE V-VERSION ("AUX" (CNT 17))
	 <TELL <COND (<PROB 99> "SPELLBREAKER")
		     (ELSE "MAGE")>
"|
An Interactive Fantasy|
Copyright (c) 1985 by Infocom, Inc. All rights reserved.|
SPELLBREAKER is a trademark of Infocom, Inc.|
Release ">
	 <PRINTN <BAND <GET 0 1> *3777*>>
	 <TELL " / Serial number ">
	 <REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> 23>
			<RETURN>)
		       (T
			<PRINTC <GETB 0 .CNT>>)>>
	 <CRLF>>

<ROUTINE V-$VERIFY ()
	 <COND (<AND <EQUAL? ,PRSO ,INTNUM>
		     <EQUAL? ,P-NUMBER 1066>>
		<TELL N ,SERIAL CR>)
	       (,PRSO
		<TELL ,NOT-RECOGNIZED CR>)
	       (ELSE
		<TELL "Verifying..." CR>
		<COND (<VERIFY> <TELL "The disk is correct." CR>)
		      (T <TELL CR "** Disk Failure **" CR>)>)>>
^\L

;"subtitle real verbs"

<ROUTINE V-ALARM ()
	 <COND (<EQUAL? ,PRSO ,ROOMS>
		<PERFORM ,V?ALARM ,ME>
		<RTRUE>)
	       (<EQUAL? ,PRSO ,ESPNIS?>
		<TELL
"It would take more than that to awaken "><THE-PRSO>)
	       (T
		<TELL
,I-DONT-THINK-THAT THE ,PRSO " is sleeping." CR>)>>

<ROUTINE V-ANSWER ()
	 <TELL "Nobody is awaiting your answer." CR>
	 <END-QUOTE>>

"V-ASK-ABOUT -- transform into PRSO, TELL ME ABOUT PRSI"

<ROUTINE PRE-ASK-ABOUT ("AUX" P)
	 <COND (<AND <NOT ,PRSI>
		     <SET P <FIND-IN ,HERE ,PERSON>>>
		<PERFORM ,PRSA .P ,PRSO>
		<RTRUE>)>>

<ROUTINE V-ASK-ABOUT ("AUX" OWINNER)
	 <COND (<EQUAL? ,PRSO ,ME>
		<PERFORM ,V?TELL ,ME>
		<RTRUE>)
	       (<FSET? ,PRSO ,PERSON>
		<SET OWINNER ,WINNER>
		<SETG WINNER ,PRSO>
		<PERFORM ,V?TELL-ME-ABOUT ,PRSI>
		<SETG WINNER .OWINNER>
		<RTRUE>)
	       (T
		<PERFORM ,V?TELL ,PRSO>
		<RTRUE>)>>

<ROUTINE FIND-IN (WHERE WHAT "AUX" W)
	 <SET W <FIRST? .WHERE>>
	 <REPEAT ()
		 <COND (<NOT .W> <RFALSE>)
		       (<AND <FSET? .W .WHAT>
			     <VISIBLE? .W>>
			<RETURN .W>)>
		 <SET W <NEXT? .W>>>>

"V-ASK-FOR -- transform into PRSO, GIVE PRSI TO ME"

<ROUTINE PRE-ASK-FOR ()
	 <PRE-ASK-ABOUT>>

<ROUTINE V-ASK-FOR ("AUX" OWINNER)
	 <COND (<EQUAL? ,PRSO ,ME>
		<PERFORM ,V?TAKE ,PRSI>
		<RTRUE>)
	       (<FSET? ,PRSO ,PERSON>
		<SET OWINNER ,WINNER>
		<SETG WINNER ,PRSO>
		<PERFORM ,V?GIVE ,PRSI ,ME>
		<SETG WINNER .OWINNER>
		<RTRUE>)
	       (T
		<TELL
"It's unlikely that " THE ,PRSO " will oblige." CR>)>>

<ROUTINE V-ATTACK ()
	 <IKILL "attack">>

<ROUTINE V-BITE ()
	 <HACK-HACK "Biting">>

<ROUTINE PRE-BOARD ("AUX" AV)
	 <SET AV <LOC ,WINNER>>
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<COND (<EQUAL? .AV ,PRSO>
		       <TELL ,YOU-ARE ,PERIOD>)
		      (<AND <FSET? .AV ,VEHBIT>
			    <HELD? ,PRSO .AV>>
		       <TELL ,YOU-HAVE-TO " leave " THE .AV " first" ,PERIOD>)
		      (T
		       <RFALSE>)>)
	       (T
		<TELL ,YOU-CANT "get into " THE ,PRSO "!" CR>)>
	 <RFATAL>>

<ROUTINE YOU-ARE-IN (AV)
	 <TELL ,YOU-ARE
	       <COND (<FSET? .AV ,SURFACEBIT> " on ")
		     (ELSE " in ")>
	       THE .AV "!" CR>>

<ROUTINE V-BOARD ("AUX" AV)
	 <TELL ,YOU-ARE-NOW "in ">
	 <THE-PRSO>
	 <MOVE ,WINNER ,PRSO>
	 %<DEBUG-CODE <D-APPLY "Get in" <GETP ,PRSO ,P?ACTION> ,M-ENTER>
		      <APPLY <GETP ,PRSO ,P?ACTION> ,M-ENTER>>
	 <RTRUE>>

<ROUTINE V-BURN ()
	 <COND (<NOT ,PRSI>
		<TELL "Your blazing gaze is insufficient." CR>)
	       (T
		<WITH-PRSI?>)>>

<ROUTINE V-CHASTISE ()
	 <TELL
"Use prepositions instead: LOOK AT the object, LOOK INSIDE it,
LOOK UNDER it, etc." CR>>

<ROUTINE V-CLIMB-DOWN ()
	 <COND (<EQUAL? ,PRSO ,ROOMS>
		<DO-WALK ,P?DOWN>)
	       (T
		<V-SQUEEZE>)>>

<ROUTINE V-CLIMB-FOO ()
	 <COND (<EQUAL? ,PRSO ,ROOMS>
		<DO-WALK ,P?UP>)
	       (T
		<V-SQUEEZE>)>>

<ROUTINE V-CLIMB-ON ()
	 <COND (<AND <FSET? ,PRSO ,VEHBIT>
		     <FSET? ,PRSO ,SURFACEBIT>>
		<PERFORM ,V?BOARD ,PRSO>
		<RTRUE>)
	       (T
		<TELL ,YOU-CANT "climb onto "><A-PRSO>)>>

<ROUTINE V-CLIMB-OVER ()
	 <YOU-CANT-X-THAT "do">>

<ROUTINE V-CLIMB-UP ()
	 <COND (<EQUAL? ,PRSO ,ROOMS>
		<DO-WALK ,P?UP>)
	       (T
		<V-SQUEEZE>)>>

<ROUTINE PRE-CLOSE ()
	 <COND (<IMMOBILIZED?> <RTRUE>)>>

<ROUTINE V-CLOSE ()
	 <COND (<FSET? ,PRSO ,SURFACEBIT>
		<TELL "There's no way to close "><THE-PRSO>)
	       (<AND <NOT <FSET? ,PRSO ,CONTBIT>>
		     <NOT <FSET? ,PRSO ,DOORBIT>>>
		<PERFORM ,V?OPEN ,PRSO>
		<RTRUE>)
	       (<FSET? ,PRSO ,PERSON>
		<TELL "Huh?" CR>)
	       (<AND <NOT <FSET? ,PRSO ,SURFACEBIT>>
		     <NOT <EQUAL? <GETP ,PRSO ,P?CAPACITY> 0>>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <FCLEAR ,PRSO ,OPENBIT>
		       <TELL "Closed.">
		       <SETG LIT <LIT? ,HERE>>
		       <COND (<NOT ,LIT>
			      <TELL " ">
			      <TELL ,NOW-BLACK>)>
		       <CRLF>)
		      (T
		       <ALREADY-CLOSED>)>)
	       (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <OKAY-THE-PRSO-IS-NOW "closed">
		       <FCLEAR ,PRSO ,OPENBIT>)
		      (T
		       <ALREADY-CLOSED>)>)
	       (T
		<TELL "You cannot close that." CR>)>>

<ROUTINE OKAY-THE-PRSO-IS-NOW (STR)
	 <TELL "Okay, " THE ,PRSO " is now " .STR ,PERIOD>>

<ROUTINE V-COMPARE ()
	 <TELL ,WASTE-OF-TIME>>

<ROUTINE V-COUNT ()
	 <TELL ,WASTE-OF-TIME>>

<ROUTINE V-CROSS ()
	 <YOU-CANT-X-THAT "cross">>

<ROUTINE V-CURSE ()
	 <TELL
"Moral turpitude is grounds for expulsion from the Circle!" CR>>

<ROUTINE V-CUT ()
	 <COND (<FSET? ,PRSO ,PERSON>
		<PERFORM ,V?KILL ,PRSO ,PRSI>
		<RTRUE>)
	       (<AND <FSET? ,PRSI ,WEAPONBIT>
		     <OR <FSET? ,PRSO ,SCROLLBIT>
			 <EQUAL? ,PRSO ,CARPET-LABEL>>>
		<REMOVE ,PRSO>
		<TELL
"Skillfully wielding the " 'PRSI ", you slice "
THE ,PRSO " into slivers, which vanish." CR>)
	       (<NOT <FSET? ,PRSI ,WEAPONBIT>>
		<TELL
"I doubt that the \"cutting edge\" of " THE ,PRSI " is adequate." CR>)
	       (T
		<TELL
"Strange concept, cutting "> <A-PRSO>)>>

<ROUTINE V-DIG ()
	 <COND (<AND <IN? ,WINNER ,MAGIC-CARPET>
		     <G? ,UD-COUNT 0>>
		<TELL ,WHILE-FLYING>)
	       (T
		<TELL ,WASTE-OF-TIME>)>>

<ROUTINE V-DISEMBARK ("AUX" AV)
	 <SET AV <LOC ,WINNER>>
	 <COND (<OR <NOT ,PRSO>
		    <EQUAL? ,PRSO ,ROOMS>>
		<COND (<AND .AV <FSET? .AV ,VEHBIT>>
		       <PERFORM ,V?DISEMBARK .AV>
		       <RTRUE>)
		      (<FSET? ,HERE ,RWATERBIT>
		       <DO-WALK ,P?UP>)
		      (ELSE
		       <TELL ,YOU-ARENT "in anything." CR>)>)
	       (<AND .AV
		     <FSET? .AV ,VEHBIT>>
		<COND (<AND <NOT <EQUAL? .AV ,PRSO>>
			    <NOT <HELD? .AV ,PRSO>>>
		       <YOU-ARE-IN .AV>
		       <RFATAL>)
		      (T
		       <MOVE ,WINNER <LOC ,PRSO>> ;"for vehicle in vehicle"
		       <TELL ,YOU-ARE-NOW "on your feet." CR>)>)
	       (<LOC ,PRSO>
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)
	       (ELSE
		<TELL "It's not in anything." CR>)>>

<ROUTINE V-DRINK ("AUX" S)
	 <YOU-CANT-X-THAT "drink">>

<ROUTINE V-DRINK-FROM ("AUX" X)
	 <COND (<EQUAL? ,PRSO ,WATER>
		<PERFORM ,V?DRINK ,PRSO>
		<RTRUE>)
	       (T
		<HOW-DO-YOU>
		<A-PRSO?>)>>

<ROUTINE PRE-DROP ()
	 <COND (<EQUAL? ,PRSO <LOC ,WINNER>>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)>>

<ROUTINE V-DROP ()
	 <COND (<IDROP>
		<TELL "Dropped." CR>)
	       (ELSE <RTRUE>)>>

<ROUTINE V-EAT ("AUX" OLIT)
	 <COND (<EQUAL? ,PRSO ,FISH ,BREAD>
		<SET OLIT ,LIT>
		<REMOVE ,PRSO>
		<TELL
"Yum! That was pretty good, considering that it's a leftover from
the luncheon.">
		<GOT-DARK? .OLIT>
		<CRLF>)
	       (ELSE
		<TELL
"Did they teach you to eat that in survival school?" CR>)>>

<ROUTINE GOT-DARK? (OLIT)
	 <SETG LIT <LIT? ,HERE>>
	 <COND (<AND .OLIT <NOT ,LIT>>
		<TELL " ">
		<COND (<OR <EQUAL? ,HERE ,DARK-CAVE ,GRUE-CAVE ,LIGHT-POOL>
			   <EQUAL? ,HERE ,PILLAR-ROOM>>
		       <TELL "It's now darker.">)
		      (ELSE
		       <TELL ,NOW-BLACK>)>)>>

<ROUTINE V-ENTER ("AUX" VEHICLE)
	 <COND (<SET VEHICLE <FIND-IN ,HERE ,VEHBIT>>
		<PERFORM ,V?BOARD .VEHICLE>
		<RTRUE>)
	       (<GETPT ,HERE ,P?IN>
		<DO-WALK ,P?IN>)
	       (ELSE <V-WALK-AROUND>)>>

<ROUTINE PRE-EXAMINE ()
	 <COND (<NOT ,LIT>
		<TELL ,TOO-DARK>)>>

<ROUTINE V-EXAMINE ()
	 <COND (<AND <OR <FSET? ,PRSO ,READBIT>
			 <FSET? ,PRSO ,SPELLBIT>>
		     <GETP ,PRSO ,P?TEXT>>
		<PERFORM ,V?READ ,PRSO>
		<RTRUE>)
	       (<FSET? ,PRSO ,DOORBIT>
		<V-LOOK-INSIDE>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <V-LOOK-INSIDE>)
		      (T
		       <TELL "It's closed." CR>)>)
	       (<FSET? ,PRSO ,ONBIT>
		<TELL
"Someone must have cast " THE ,FROTZ-SPELL " on " THE ,PRSO ", because it
is glowing brightly." CR>)
	       (T
		<PRSO-NOTHING-SPECIAL>)>>

<ROUTINE PRSO-NOTHING-SPECIAL ()
	 <TELL "You see nothing special about "><THE-PRSO>>

<ROUTINE V-EXIT ()
	 <COND (<AND ,PRSO <FSET? ,PRSO ,VEHBIT>>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)
	       (<GETPT ,HERE ,P?OUT>
		<DO-WALK ,P?OUT>)
	       (ELSE
		<V-WALK-AROUND>)>>

;<ROUTINE V-EXORCISE ()
	 <TELL ,YOU-CANT "do that with mere words!" CR>>

<ROUTINE V-FILL ()
	 <COND (<NOT ,PRSI>
		<COND (<GLOBAL-IN? ,WATER ,HERE>
		       <PERFORM ,V?FILL ,PRSO ,WATER>
		       <RTRUE>)
		      (T
		       <TELL ,THERES-NOTHING-TO "fill it with" ,PERIOD>)>)
	       (T
		<TELL "Huh?" CR>)>>

<ROUTINE V-FIND ("OPTIONAL" (WHERE <>) "AUX" (L <LOC ,PRSO>))
	 <COND (<EQUAL? ,PRSO ,ME ,HANDS ,EYES>
		<TELL
"Somewhere nearby, I'm sure">)
	       (<IN? ,PRSO ,PLAYER>
		<TELL "You have it">)
	       (<OR <IN? ,PRSO ,HERE>
		    <EQUAL? ,PRSO ,PSEUDO-OBJECT>>
		<COND (<FSET? ,PRSO ,PERSON>
		       <COND (<EQUAL? ,PRSO ,ROC>
			      <TELL "She">)
			     (ELSE
			      <TELL "He">)>)
		      (T
		       <TELL "It">)>
		<TELL "'s right in front of you">)
	       (<IN? ,PRSO ,LOCAL-GLOBALS>
		<TELL "You're the magician">)
	       (<AND <FSET? .L ,PERSON>
		     <VISIBLE? .L>>
		<TELL "I think " THE .L " has it">)
	       (<AND <FSET? .L ,CONTBIT>
		     <VISIBLE? .L>>
		<TELL "It's in " THE .L>)
	       (.WHERE
		<TELL "Beats me">)
	       (T
		<TELL ,YOU-HAVE-TO " do that yourself">)>
	 <TELL ,PERIOD>>

<ROUTINE V-FLY ()
	 <COND (<EQUAL? ,PRSO <> ,ME>
		<COND (<AND <IN? ,WINNER ,MAGIC-CARPET>
			    <G? ,UD-COUNT 0>>
		       <TELL "You are!" CR>)
	              (T
		       <TELL "Perhaps some magical assistance?" CR>)>)
	       (<EQUAL? ,PRSO ,P-WALK-DIR>
		<DO-WALK ,PRSO>
		<RTRUE>)
	       (T
		<TELL ,YOU-CANT "make " A ,PRSO " fly!" CR>)>>

<ROUTINE V-FOLLOW ()
	 <COND (<AND ,PRSO <IN? ,PRSO ,HERE>>
		<TELL "But " THE ,PRSO " is right here!" CR>)
	       (T
		<TELL ,WASTE-OF-TIME>)>>

<ROUTINE V-FORGET ()
	 <TELL
"You can never forget, uh, whatever it was." CR>>

<ROUTINE PRE-GIVE ()
	 <COND (<AND <EQUAL? ,PRSO ,INTNUM>
		     <HELD? ,ZORKMID>>
		<RFALSE>)
	       (<NOT <HELD? ,PRSO>>
		<TELL
,YOU-HAVE-TO " get it first." CR>)
	       (<FSET? ,PRSO ,SPELLBIT>
		<TELL
"Spells are intangible." CR>)>>

<ROUTINE V-GIVE ()
	 <COND (<NOT <FSET? ,PRSI ,PERSON>>
		<TELL ,YOU-CANT "give " A ,PRSO " to " A ,PRSI "!" CR>)
	       (T
		<UNINTERESTED ,PRSI>)>>

<ROUTINE V-HELLO ("AUX" OWINNER)
       <COND (,PRSO
	      <COND (<FSET? ,PRSO ,PERSON>
		     <SET OWINNER ,WINNER>
		     <SETG WINNER ,PRSO>
		     <PERFORM ,V?HELLO>
		     <SETG WINNER .OWINNER>)
		    (T
		     <TELL
"Mages never say \"Hello\" to "><A-PRSO>)>)
	     (T
	      <TELL "Cheery, aren't you?" CR>)>>

<ROUTINE V-HELP ()
	 <TELL
"If you're really stuck, you can order maps and InvisiClues Hint
Booklets using the order form that came in your package." CR>>

<ROUTINE V-HIDE ()
	 <COND (<NOT ,PRSO>
		<TELL "There's no place to hide here." CR>
		<RFATAL>)
	       (<AND ,PRSI <FSET? ,PRSI ,PERSON>>
		<UNINTERESTED ,PRSI>)
	       (<NOT ,PRSI>
		<V-SQUEEZE> ;"useless")>>

<ROUTINE V-HIDE-FROM ()
	 <TELL ,YOU-HAVE-TO " decide where." CR>>

<ROUTINE V-INFLATE ()
	 <HOW-DO-YOU> <A-PRSO?>>

<ROUTINE V-KICK ()
	 <HACK-HACK "Kicking">>

<ROUTINE V-KILL ()
	 <IKILL "kill">>

<ROUTINE IKILL (STR)
	 <COND (<NOT ,PRSO>
		<TELL ,THERES-NOTHING-TO .STR " here." CR>)
	       (<AND <NOT ,PRSI>
		     <IN? ,KNIFE ,WINNER>>
		<SETG PRSI ,KNIFE>
		<TELL "(with " THE ,PRSI ")" CR>
		<PERFORM ,V?KILL ,PRSO ,PRSI>
		<RTRUE>)>
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<TELL
"Pounding on a door is of little use." CR>)
	       (<NOT <FSET? ,PRSO ,PERSON>>
		<TELL
"How strange. Fighting "> <A-PRSO?>)
	       (<OR <EQUAL? ,PRSI <> ,HANDS>
		    <NOT <FSET? ,PRSI ,WEAPONBIT>>>
		<TELL
"Trying to " .STR " " THE ,PRSO " with ">
		<COND (<NOT <EQUAL? ,PRSI <> ,HANDS>>
		       <TELL A ,PRSI>)
		      (ELSE <TELL "your bare hands">)>
		<TELL " is suicidal." CR>)
	       (<NOT <IN? ,PRSI ,WINNER>>
		<NOT-HOLDING ,PRSI>)
	       (T
		<NOT-TRAINED>)>>

<ROUTINE NOT-TRAINED ()
	 <TELL
"You miss. (Mages aren't given a lot of training in this sort of thing.)" CR>>

<ROUTINE V-KNOCK ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<TELL "Nobody's home." CR>)
	       (T
		<TELL "Why knock on "> <A-PRSO?>)>>

<ROUTINE V-KISS ()
	 <COND (<FSET? ,PRSO ,PERSON>
		<UNINTERESTED ,PRSO>)
	       (ELSE <V-SQUEEZE>)>>

<ROUTINE V-LAMP-OFF ()
	 <COND (<FSET? ,PRSO ,ONBIT>
		<FCLEAR ,PRSO ,ONBIT>
		<COND (<EQUAL? ,PRSO ,ME>
		       <FCLEAR ,PLAYER ,ONBIT>)>
		<TELL "The magical glow fades">
		<SETG LIT <LIT? ,HERE>>
		<COND (<NOT ,LIT>
		       <TELL ", leaving you in the dark">)>
		<TELL ,PERIOD>)
	       (T
		<HOW-DO-YOU> <A-PRSO?>)>>

<ROUTINE V-LAMP-ON ()
	 <HOW-DO-YOU> <A-PRSO?>>

<ROUTINE V-LAND ()
	 <COND (<IN? ,WINNER ,MAGIC-CARPET>
		<DO-WALK ,P?DOWN>)
	       (T
		<TELL ,LOOK-AROUND-YOU>)>>

<ROUTINE V-LEAN-ON ()
	 <TELL "Tired?" CR>>

<ROUTINE V-LEAP ()
	 <COND (<AND <IN? ,WINNER ,MAGIC-CARPET>
		     <G? ,UD-COUNT 0>>
		<TELL ,WHILE-FLYING>)
	       (<AND <EQUAL? ,PRSO <> ,ROOMS>
		     <EQUAL? ,HERE ,CLIFF-MIDDLE ,BOULDER-1 ,BOULDER-2>>
		<JIGS-UP
"This was not a safe place to try jumping. You should have looked
before you leaped.">)
	       (<AND ,PRSO <IN? ,PRSO ,HERE>>
		<V-SKIP>)
	       (T
		<TELL "That would be a good trick." CR>)>>

<ROUTINE V-LEAVE ()
	 <DO-WALK ,P?OUT>>

<ROUTINE V-LISTEN ()
	 <COND (<AND <EQUAL? ,PRSO <> ,GLOBAL-ROCKS>
		     <QUEUED? I-AVALANCHE>
		     <NOT <TIME-FROZEN?>>
		     <OR <EQUAL? ,HERE ,MOUNTAIN-TOP ,CAVE-ENTRANCE ,CLIFF-TOP>
			 <EQUAL? ,HERE ,CLIFF-MIDDLE ,CLIFF-BOTTOM>>>
		<HEAR-AVALANCHE>)
	       (ELSE
		<TELL "At the moment, ">
		<COND (<NOT ,PRSO>
		       <TELL
			"you hear nothing unsettling">)
		      (ELSE
		       <TELL
			THE ,PRSO " makes no sound">)>)>
	 <TELL ,PERIOD>>

<ROUTINE V-LOCK ()
	 <COND (<AND <FSET? ,PRSO ,DOORBIT>
		     <EQUAL? ,PRSI ,KEY>>
		<TELL ,DOESNT-FIT>)
	       (ELSE
		<TELL-YUKS>)>>

<ROUTINE V-FIRST-LOOK ()
	 <COND (<DESCRIBE-ROOM>
		<COND (,VERBOSITY <DESCRIBE-OBJECTS>)>)>>

<ROUTINE V-LOOK ()
	 <COND (<DESCRIBE-ROOM T>
		<DESCRIBE-OBJECTS T>)>>

<ROUTINE V-LOOK-BEHIND ()
	 <TELL ,THERE-IS-NOTHING "behind "><THE-PRSO>>

<ROUTINE V-LOOK-DOWN ()
	 <COND (<NOT ,LIT>
		<TELL ,TOO-DARK>)
	       (<EQUAL? ,PRSO <> ,ROOMS ,GLOBAL-HOLE>
		<COND (<GLOBAL-IN? ,GLOBAL-HOLE ,HERE>
		       <PERFORM ,V?LOOK-INSIDE ,GLOBAL-HOLE>)
		      (ELSE
		       <PERFORM ,V?EXAMINE ,GROUND>)>
		<RTRUE>)>>

<ROUTINE WHAT-CONTENTS ()
	 <COND (<NOT <PRINT-CONTENTS ,PRSO>>
		<TELL "nothing">
		<COND (<IN? ,PLAYER ,PRSO>
		       <TELL " (other than you)">)>)>
	 <TELL ,PERIOD>>

<ROUTINE V-LOOK-INSIDE ()
	 <COND (<FSET? ,PRSO ,PERSON>
		<PRSO-NOTHING-SPECIAL>)
	       (<FSET? ,PRSO ,SURFACEBIT>
		<TELL "On " THE ,PRSO " is ">
		<WHAT-CONTENTS>)
	       (<FSET? ,PRSO ,DOORBIT>
		<THIS-IS-IT ,PRSO>
		<TELL "All you can tell is that ">
		<TELL-OPEN-CLOSED>)
	       (<FSET? ,PRSO ,SCROLLBIT>
		<PERFORM ,V?READ ,PRSO>
		<RTRUE>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<EQUAL? ,PRSO <LOC ,WINNER>>
		       <MOVE ,PLAYER ,ROOMS>
		       <TELL "Aside from you, there's ">
		       <WHAT-CONTENTS>
		       <MOVE ,PLAYER ,PRSO>)
		      (<SEE-INSIDE? ,PRSO>
		       <TELL CTHE ,PRSO " contains ">
		       <WHAT-CONTENTS>)
		      (<AND <NOT <FSET? ,PRSO ,OPENBIT>>
			    <FIRST? ,PRSO>>
		       <PERFORM ,V?OPEN ,PRSO>
		       <RTRUE>)
		      (T
		       <THIS-IS-IT ,PRSO>
		       <TELL "It seems ">
		       <TELL-OPEN-CLOSED>)>)
	       (T
		<YOU-CANT-X-PRSO "look inside">)>>

<ROUTINE V-LOOK-UNDER ()
	 <COND (<HELD? ,PRSO>
		<TELL "You're already holding it!" CR>)
	       (T
		<TELL ,THERE-IS-NOTHING "there." CR>)>>

<ROUTINE V-LOWER ()
	 <V-RAISE>>

<ROUTINE V-LOWER-INTO ()
	 <V-RAISE>>

<ROUTINE V-MELT ()
	 <TELL "I'm not sure that " THE ,PRSO " can be melted." CR>>

<ROUTINE V-MOVE ()
	 <COND (<HELD? ,PRSO>
		<TELL "Why juggle objects?" CR>)
	       (<AND <FSET? ,PRSO ,TAKEBIT>
		     <NOT <FSET? ,PRSO ,PERSON>>>
		<V-TURN-OVER>)
	       (T
		<YOU-CANT-X-PRSO "move">)>>

<ROUTINE HOSTILE-VERB? ()
	 <VERB? ATTACK BITE KICK KILL MUNG RUB PUSH MOVE THROW>>

<ROUTINE V-MUNG ()
	 <HACK-HACK "Trying to break">>

<ROUTINE PRE-OPEN ()
	 <COND (<IMMOBILIZED?>
		<RTRUE>)
	       (<FSET? ,PRSO ,PERSON>
		<TELL "What a grisly idea." CR>)>>

<ROUTINE V-OPEN ("AUX" F STR)
	 <COND (<OR <AND <NOT <FSET? ,PRSO ,CONTBIT>>
		         <NOT <FSET? ,PRSO ,DOORBIT>>>
		    <FSET? ,PRSO ,SCROLLBIT>>
		<TELL "You must tell me how to do that to ">
		<A-PRSO>)
	       (<NOT <EQUAL? <GETP ,PRSO ,P?CAPACITY> 0>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <ALREADY-OPEN>)
		      (T
		       <FSET ,PRSO ,OPENBIT>
		       <FSET ,PRSO ,TOUCHBIT>
		       <COND (<OR <NOT <FIRST? ,PRSO>>
				  <FSET? ,PRSO ,TRANSBIT>>
			      <TELL "Opened." CR>)
			     ;(<AND <SET F <FIRST? ,PRSO>>
				   <NOT <NEXT? .F>>
				   <SET STR <GETP .F ,P?FDESC>>>
			      <OKAY-THE-PRSO-IS-NOW "open">
			      <TELL .STR CR>)
			     (T
			      <TELL "Opening ">
			      <TELL THE ,PRSO " reveals ">
			      <WHAT-CONTENTS>)>)>)
	       (T ;"door"
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <ALREADY-OPEN>)
		      (<FSET? ,PRSO ,LOCKED>
		       <TELL "It's locked." CR>)
		      (T
		       <FSET ,PRSO ,OPENBIT>
		       <OKAY-THE-PRSO-IS-NOW "open">)>)>>

<ROUTINE V-PAY ()
	 <COND (<NOT ,PRSI>
		<TELL "Pay with what?" CR>
		<RTRUE>)
	       (T
		<WITH-PRSI?>)>>

<ROUTINE V-PICK ()
	 <YOU-CANT-X-THAT "pick">>

<ROUTINE V-PLAY ()
         <TELL "How peculiar!" CR>>

<ROUTINE V-PLUG ()
	 <V-TURN> ;"no effect">

<ROUTINE V-POINT ()
	 <TELL "It's impolite to point." CR>>

<ROUTINE V-POUR ()
	 <COND (<AND <FSET? ,PRSO ,CONTBIT>
		     <HELD? ,PRSO>>
		<EMPTY-ALL ,PRSO ,PRSI>)
	       (ELSE
		<YOU-CANT-X-THAT "pour">)>>

<ROUTINE EMPTY-ALL (FROM TO "AUX" (F <FIRST? .FROM>) N R)
	 <COND (<NOT .F>
		<TELL CTHE .FROM " is empty." CR>)
	       (ELSE
		<REPEAT ()
			<COND (.F
			       <SET N <NEXT? .F>>
			       <TELL D .F ": ">
			       <SET R
				    <COND (.TO
					   <PERFORM ,V?PUT .F .TO>)
					  (ELSE
					   <PERFORM ,V?DROP .F>)>>
			       <COND (<EQUAL? .R ,M-FATAL> <RTRUE>)
				     (ELSE <SET F .N>)>)
			      (T
			       <RTRUE>)>>)>>

<ROUTINE V-PUMP ()
	 <TELL "It's not clear how." CR>>

<ROUTINE V-PUSH ()
	 <HACK-HACK "Pushing">>

<ROUTINE V-PUSH-TO ()
	 <YOU-CANT-X-THAT "push things to">>

<ROUTINE PRE-PUT ("AUX" (L <LOC ,PRSO>))
	 <COND (<OR <IN? ,PRSO ,GLOBAL-OBJECTS>
		    <NOT <FSET? ,PRSO ,TAKEBIT>>>
		<TELL "Nice try." CR>)
	       (<AND <VERB? PUT>
		     <FSET? ,PRSO ,WEAPONBIT>
		     <FSET? ,PRSI ,PERSON>>
		<PERFORM ,V?ATTACK ,PRSI ,PRSO>
		<RTRUE>)
	       (<IN? ,PRSO ,PRSI>
		<TAKE-OUT-FIRST ,PRSO ,PRSI>)
	       (<IN? ,PRSI ,PRSO>
		<TAKE-OUT-FIRST ,PRSI ,PRSO>)
	       (<AND <FSET? .L ,CONTBIT>
		     <NOT <FSET? .L ,OPENBIT>>>
		<TAKE-OUT-FIRST ,PRSO .L>)>>

<ROUTINE TAKE-OUT-FIRST (OBJ CONT)
	 <TELL
"You should take " THE .OBJ " out of " THE .CONT " first." CR>>

<ROUTINE V-PUT ("AUX" W)
	 <COND (<AND <NOT <FSET? ,PRSI ,OPENBIT>>
		     <NOT <FSET? ,PRSI ,DOORBIT>>
		     <NOT <FSET? ,PRSI ,CONTBIT>>
		     <NOT <FSET? ,PRSI ,SURFACEBIT>>
		     <NOT <FSET? ,PRSI ,VEHBIT>>>
		<YOU-CANT-X-THAT "do">
		<RTRUE>)
	       (<AND <FSET? ,PRSI ,DOORBIT>
		     <EQUAL? ,PRSO ,KEY>>
		<PERFORM ,V?UNLOCK ,PRSI ,PRSO>
		<RTRUE>)
	       (<AND <NOT <FSET? ,PRSI ,OPENBIT>>
		     <NOT <FSET? ,PRSI ,SURFACEBIT>>>
		<TELL "Inspection reveals that ">
		<TELL THE ,PRSI " isn't open." CR>
		<THIS-IS-IT ,PRSI>)
	       (<EQUAL? ,PRSI ,PRSO>
		<HOW-DO-YOU> <A-PRSO?>)
	       (<IN? ,PRSO ,PRSI>
		<TELL "I think ">
		<TELL THE ,PRSO " is already in ">
		<THE-PRSI>)
	       (<AND <FSET? <SET W <LOC ,PRSI>> ,PERSON>
		     <NOT <EQUAL? .W ,WINNER>>>
		<TELL
"Don't you think you should ask " THE .W " first?" CR>)
	       (<G? <- <+ <WEIGHT ,PRSI> <WEIGHT ,PRSO>>
		       <GETP ,PRSI ,P?SIZE>>
		    <GETP ,PRSI ,P?CAPACITY>>
		<TELL ,NO-ROOM CR>)
	       (<AND <NOT <HELD? ,PRSO>>
		     <EQUAL? <ITAKE> ,M-FATAL <>>>
		<RTRUE>)
	       (T
		<MOVE ,PRSO ,PRSI>
		<FSET ,PRSO ,TOUCHBIT>
		<TELL "Done." CR>)>>

<ROUTINE V-PUT-BEHIND ()
	 <TELL "That hiding place is too obvious." CR>>

<ROUTINE V-PUT-ON ()
	 <COND (<EQUAL? ,PRSI ,ME>
		<PERFORM ,V?WEAR ,PRSO>
		<RTRUE>)
	       (<EQUAL? ,PRSI ,GROUND>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<FSET? ,PRSI ,SURFACEBIT>
		<V-PUT>)
	       (T
		<TELL "There's no good surface on ">
		<THE-PRSI>)>>

<ROUTINE V-PUT-UNDER ()
         <YOU-CANT-X-THAT "put anything under">>

<ROUTINE V-RAISE ()
	 <HACK-HACK "Lifting">>

<ROUTINE V-REACH-IN ("AUX" OBJ)
	 <COND (<OR <NOT <FSET? ,PRSO ,CONTBIT>>
		    <FSET? ,PRSO ,PERSON>>
		<HOW-DO-YOU> <A-PRSO?>)
	       (<NOT <FSET? ,PRSO ,OPENBIT>>
		<TELL "It's not open." CR>)
	       (<OR <NOT <SET OBJ <FIRST? ,PRSO>>>
		    <FSET? .OBJ ,INVISIBLE>
		    <NOT <FSET? .OBJ ,TAKEBIT>>>
		<ITS-EMPTY>)
	       (T
		<TELL
"You reach into " THE ,PRSO " and feel something." CR>
		<RTRUE>)>>

<ROUTINE PRE-READ ()
	 <COND (<EQUAL? ,PRSO ,SPELL-BOOK>
		<RFALSE> ;"special case")
	       (<AND <FSET? ,PRSO ,SPELLBIT>
		     <IN? ,PRSO ,SPELL-BOOK>>
		<RFALSE> ;"same special case")
	       (<NOT ,LIT>
		<TELL "You can't read in the dark." CR>)
	       (<AND ,PRSI <NOT <FSET? ,PRSI ,TRANSBIT>>>
		<HOW-DO-YOU> <A-PRSI?>)>>

<ROUTINE HOW-DO-YOU ()
	 <TELL "How do you do that with ">>

<ROUTINE V-READ ()
	 <COND (<OR <FSET? ,PRSO ,READBIT>
                    <FSET? ,PRSO ,SPELLBIT>>
		<TELL <GETP ,PRSO ,P?TEXT> CR>)
               (T
                <HOW-DO-YOU> <A-PRSO?>)>>

<ROUTINE V-REPLY ()
	 <COND (<AND <EQUAL? ,HERE ,RETREAT>
		     <NOT <EQUAL? ,PRSO ,BELBOZ>>
		     <NOT ,PRSI>>
		<PERFORM ,V?REPLY ,BELBOZ ,PRSO>
		<RTRUE>)
	       (ELSE
		<TELL "Your reply is ignored." CR>
		<END-QUOTE>)>>

<ROUTINE PRE-SRUB ()
	 <PERFORM ,V?RUB ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SRUB ()
	 <RTRUE>>

<ROUTINE V-RUB ()
	 <HACK-HACK "Fiddling with">>

<ROUTINE V-SAY ("AUX" V)
	 <COND (<SET V <FIND-IN ,HERE ,PERSON>>
		<TELL "You must address ">
		<TELL THE .V " directly." CR>
		<END-QUOTE>)
	       (<EQUAL? <GET ,P-LEXV ,P-CONT> ,W?HELLO>
		<SETG QUOTE-FLAG <>>
		<RTRUE>)
	       (T
		<PERFORM ,V?TELL ,ME>
		<END-QUOTE>)>>

<ROUTINE V-SEARCH ()
	 <COND (<AND <FSET? ,PRSO ,PERSON>
		     <NOT <EQUAL? ,ESPNIS? ,PRSO>>
		     <NOT <TIME-FROZEN?>>>
		<TELL
CTHE ,PRSO " refuses to let you search him." CR>)
	       (ELSE
		<TELL ,THERE-IS-NOTHING "there" ,PERIOD>)>>

<ROUTINE V-SEND ()
	 <COND (<FSET? ,PRSO ,PERSON>
		<TELL "Why would you send for ">
		<A-PRSO?>)
	       (T
		<TELL-YUKS>)>>

<ROUTINE PRE-SGIVE ()
	 <PERFORM ,V?GIVE ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SGIVE ()
	 <RTRUE>>

<ROUTINE V-SHAKE ("AUX" X)
	 <COND (<FSET? ,PRSO ,PERSON>
		<TELL "Be real." CR>)
	       (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<TELL ,YOU-CANT "take it; thus, you can't shake it!" CR>)
	       (T
		<TELL "There's no point in shaking that." CR>)>>

<ROUTINE V-SHARPEN ()
	 <TELL "You'll never sharpen anything with that!" CR>>

<ROUTINE V-SHOOT ()
	 <TELL
"Don't ever bother applying for a job as an armaments expert." CR>>

<ROUTINE V-SHOW ()
	 <UNINTERESTED ,PRSI>>

<ROUTINE V-SIT ()
	 <TELL ,WASTE-OF-TIME>>

<ROUTINE V-SKIP ()
	 <TELL "Wasn't that fun?" CR>>

<ROUTINE IMPOSSIBLE-TO-SLEEP ()
	 <TELL
"It's impossible to sleep at a time like this!" CR>>

<ROUTINE V-SLEEP ("OPTIONAL" (FORCE? <>))
	 <COND (<OR <EQUAL? <LOC ,WINNER> ,ROC>
		    <EQUAL? ,HERE ,ROC-NEST>>
		<COND (.FORCE?
		       <TELL
"You fall asleep and then awaken as you">
		       <COND (<FSET? <LOC ,WINNER> ,VEHBIT>
			      <TELL " and " CTHE <LOC ,WINNER>>)>
		       <TELL " are eaten by a roc chick.">
		       <JIGS-UP>)
		      (ELSE
		       <IMPOSSIBLE-TO-SLEEP>)>)
	       (<EQUAL? ,HERE ,CASTLE>
		<COND (<VERB? ESPNIS>
		       <SETG SCORE -99>
		       <TELL
"You fall asleep and miss the end of the world.">
		       <FINISH>)
		      (ELSE
		       <QUEUE I-TIRED 150>
		       <SETG AWAKE -1>
		       <IMPOSSIBLE-TO-SLEEP>)>)
	       (<AND <NOT .FORCE?> <EQUAL? ,AWAKE -1>>
		<TELL
"You settle down to sleep, but you really aren't tired, so you
thrash around for a while and then give up." CR>)
	       (<OR <EQUAL? ,HERE ,OCEAN-ROOM ,OCEAN-FLOOR ,LOST-IN-OCEAN>
		    <EQUAL? ,HERE ,IN-CHANNEL ,IN-PIPE ,IN-PIPE-2>
		    <EQUAL? ,HERE ,RUINS-CHANNEL>
		    <AND <EQUAL? ,HERE ,OUBLIETTE>
			 <G? ,WATER-FLAG 0>>>
		<COND (.FORCE?
		       <JIGS-UP
"You fall asleep and then drown.">)
		      (ELSE
		       <IMPOSSIBLE-TO-SLEEP>)>)
	       (<EQUAL? ,HERE ,OGRE-CAVE ,OGRE-BEDROOM>
		<COND (.FORCE?
		       <JIGS-UP
"You fall into a blissful sleep, yawning lazily, and while you are resting,
the ogre destroys you.">)
		      (ELSE
		       <TELL
"I'd think twice before going to sleep in an ogre's cave." CR>)>)
	       (,FALLING?
		<COND (.FORCE?
		       <JIGS-UP
"Not a good idea, but when you hit, you are asleep and
don't know how much it hurt.">)
		      (ELSE
		       <IMPOSSIBLE-TO-SLEEP>)>)
	       (T
		<COND (<EQUAL? ,HERE ,GLACIER-ROOM>
		       <SETG FREEZE-COUNT 9>)>
		<COND (<L? ,REAL-SPELL-MAX 8>
		       <SETG REAL-SPELL-MAX <+ ,REAL-SPELL-MAX 1>>)>
		<SETG SPELL-MAX ,REAL-SPELL-MAX>
		<SETG SPELL-ROOM ,SPELL-MAX>
		<SETG MOVES <+ ,MOVES 50>>
		<SETG LAST-SLEPT ,MOVES>
		<SETG LOAD-ALLOWED ,LOAD-MAX>
		<SETG FUMBLE-NUMBER 8>
		<QUEUE I-TIRED 150>
		<SETG AWAKE -1>
		<FORGET-ALL>
		<TELL
"Ah, sleep! It's been a long day, and rest will do you good. ">
		<COND (<AND <EQUAL? <LOC ,PLAYER> ,MAGIC-CARPET>
			    <G? ,UD-COUNT 0>>
		       <TELL
"It's not the best of beds, but at least it's air cushioned. You">)
		      (ELSE
		       <TELL
"You stretch out ">
		       <COND (<IN? ,PLAYER ,IDOL>
			      <TELL "in the arms of " THE ,IDOL>)
			     (<EQUAL? <LOC ,PLAYER> ,ROCK ,OTHER-ROCK>
			      <TELL "on the back of " THE <LOC ,PLAYER>>)
			     (<IN? ,PLAYER ,ZIPPER>
			      <TELL "in the nothingness">)
			     (ELSE
			      <MOVE ,PLAYER ,HERE>
			      <TELL "on the floor">)>
		       <TELL " and">)>
		<TELL " drift off, renewing your powers and
refreshing your mind. Time passes as you snore blissfully." CR CR>
		<COND (<PROB 50>
		       <TELL
"You sleep uneventfully and awake refreshed.">)
	              (T
		       <TELL "You dream of " <PICK-ONE ,DREAMS>>
		       <TELL " You awaken.">)>
		<COND (<IN? ,PLAYER ,ROCK>
		       <TELL
" The rock says, \"You've been quiet a long time. Are you estivating?\"">)
		      (<AND <EQUAL? ,HERE ,BAZAAR>
			    <PROB 75>>
		       <COND (<ROB ,PLAYER <>>
			      <TELL
" During your nap, some unscrupulous person absconded with your
possessions!">)>)>
		<CRLF>
		<WEAR-OFF-SPELLS>
		<RTRUE>)>>


<GLOBAL DREAMS
	<LTABLE 0	 
"a group of mages clustered around a magic mirror in which
scenes of terrible violence are visible."

"a great hard-eyed monster, its insectile arms dipping and
turning to the commands of a sorcerer who stands fearless in front of
it."

"an alchemist bent over his retorts, alembics, stinks and
smokes."

"strangely garbed magicians floating in midair.">>

<ROUTINE V-SMELL ()
	 <COND (,PRSO
		<TELL "It smells just like ">
		<A-PRSO>)
	       (<FSET? <LOC ,WINNER> ,VEHBIT>
		<PERFORM ,PRSA <LOC ,WINNER>>
		<RTRUE>)
	       (ELSE
		<TELL
"There's no noticeable smell here." CR>)>>

<ROUTINE V-SPAY ()
	 <PERFORM ,V?PAY ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SPIN ()
	 <YOU-CANT-X-THAT "spin">>

<ROUTINE V-SQUEEZE ()
	 <TELL "How singularly useless." CR>>

<ROUTINE PRE-SSHOW ()
	 <PERFORM ,V?SHOW ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SSHOW ()
	 <RTRUE>>

<ROUTINE V-STAND ()
	 <COND (<FSET? <LOC ,WINNER> ,VEHBIT>
		<PERFORM ,V?DISEMBARK <LOC ,WINNER>>
		<RTRUE>)
	       (<NOT <EQUAL? ,PRSO <> ,ROOMS>> 
		<HACK-HACK "Holding up">)
	       (<AND <IN? ,WINNER ,MAGIC-CARPET>
		     <G? ,UD-COUNT 0>>
		<TELL ,WHILE-FLYING>)
	       (T
		<TELL ,YOU-ARE " standing." CR>)>>

<ROUTINE V-STAND-ON ()
	 <TELL ,WASTE-OF-TIME>>

<ROUTINE V-SWING ()
	 <COND (<NOT ,PRSI>
		<TELL "Whoosh!" CR>)
	       (T
		<PERFORM ,V?ATTACK ,PRSI ,PRSO>
		<RTRUE>)>>

<ROUTINE V-SWIM ()
	 <COND (,PRSO
		<PERFORM ,V?THROUGH ,PRSO>
		<RTRUE>)
	       (<GLOBAL-IN? ,WATER ,HERE>
		<PERFORM ,V?THROUGH ,WATER>
		<RTRUE>)
	       (T
		<TELL ,THERES-NOTHING-TO "swim in" ,PERIOD>)>>

<ROUTINE IMMOBILIZED? ()
	 <COND (<AND <TIME-FROZEN?>
		     <NOT <HELD? ,PRSO>>>
		<IMMOBILE>)>>

<ROUTINE IMMOBILE ()
	 <TELL "It's immobilized." CR>>

<ROUTINE TIME-FROZEN? ()
	 <COND (<AND ,TIME-STOPPED?
		     <OR <EQUAL? ,TIME-STOPPED? ,HERE>
			 <AND <EQUAL? ,TIME-STOPPED? ,OGRE-CAVE ,OGRE-BEDROOM>
			      <EQUAL? ,HERE ,OGRE-BEDROOM ,OGRE-CAVE>>
			 <AND <EQUAL? ,TIME-STOPPED?
				      ,CLIFF-TOP ,CLIFF-MIDDLE>
			      <EQUAL? ,HERE
				      ,CLIFF-TOP ,CLIFF-MIDDLE
				      ,CLIFF-BOTTOM>>>>
		<RETURN ,HERE>)>>

<ROUTINE PRE-TAKE ()
	 <COND (<IN? ,PRSO ,WINNER>
		<TELL "You already have it." CR>)
	       (<AND <FSET? ,PRSO ,SPELLBIT>
		     <FSET? <LOC ,PRSO> ,SCROLLBIT>
		     <ACCESSIBLE? <LOC ,PRSO>>>
		<PERFORM ,V?TAKE <LOC ,PRSO>>
		<RTRUE>)
	       (<AND <NOT <FSET? <LOC ,WINNER> ,VEHBIT>>
		     <FSET? <LOC ,PRSO> ,CONTBIT>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<CANT-REACH-THAT>
		<RTRUE>)
	       (<IMMOBILIZED?> <RTRUE>)
	       (,PRSI
		<COND (<EQUAL? ,PRSO ,ME>
		       <PERFORM ,V?DROP ,PRSI>
		       <RTRUE>)
		      (<NOT <EQUAL? ,PRSI <LOC ,PRSO>>>
		       <TELL "But ">
		       <TELL THE ,PRSO " isn't in ">
		       <THE-PRSI>)
		      (T
		       <SETG PRSI <>>
		       <RFALSE>)>)
	       (<EQUAL? ,PRSO <LOC ,WINNER>>
		<TELL "You are ">
		<COND (<FSET? ,PRSO ,PERSON> <TELL "being carried by">)
		      (<FSET? ,PRSO ,SURFACEBIT> <TELL "on">)
		      (ELSE <TELL "in">)>
		<TELL " it!" CR>)>>

<ROUTINE NOT-IN-VEHICLE? ("AUX" (V <LOC ,WINNER>))
	 <AND ,PRSO
	      <NOT <EQUAL? ,PRSO .V>>
	      <NOT <HELD? ,PRSO>>
	      <NOT <HELD? ,PRSO .V>>>>

<ROUTINE V-TAKE ()
	 <COND (<EQUAL? <ITAKE> T>
		<TELL ,TAKEN>)>>

<ROUTINE V-TAKE-OFF ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)
	       (ELSE
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)>>

<ROUTINE V-TELL ()
	 <COND (<FSET? ,PRSO ,PERSON>
		<COND (,P-CONT
		       <SETG WINNER ,PRSO>
		       ;<COND (<IN? <LOC ,WINNER> ,ROOMS>
			      <SETG HERE <LOC ,WINNER>>)>)
		      (T
		       <TELL
"Hmmm ... " THE ,PRSO " waits for you to say something." CR>)>
		<RTRUE>)
	       (T
		<YOU-CANT-X-PRSO "talk to">
		<END-QUOTE>)>>

<ROUTINE V-THANK ()
	 <COND (<FSET? ,PRSO ,PERSON>
		<UNINTERESTED ,PRSO>)
	       (T
		<HOW-DO-YOU> <A-PRSO?>)>>

<ROUTINE V-THROUGH ("AUX" M)
	<COND (<FSET? ,PRSO ,VEHBIT>
	       <PERFORM ,V?BOARD ,PRSO>
	       <RTRUE>)
	      (<NOT <FSET? ,PRSO ,TAKEBIT>>
	       <TELL
,YOU-HIT THE ,PRSO " as you attempt this feat." CR>)
	      (<IN? ,PRSO ,WINNER>
	       <TELL "That would involve quite a contortion!" CR>)
	      (T
	       <TELL-YUKS>)>>

<ROUTINE V-THROW ()
	 <COND (<AND ,PRSI <FSET? ,PRSI ,PERSON>>
	        <COND (<IN? ,PRSO ,WINNER>
		       <COND (<IDROP>
			      <NOT-TRAINED>)>)
		      (ELSE
		       <PERFORM ,V?ATTACK ,PRSI ,PRSO>
		       <RTRUE>)>)
	       (<AND ,PRSI
		     <NOT <FSET? ,PRSI ,DOORBIT>>
		     <FSET? ,PRSI ,CONTBIT>>
		<PERFORM ,V?PUT ,PRSO ,PRSI>
		<RTRUE>)
	       (<IDROP>
		<TELL "Thrown." CR>)>>

<ROUTINE V-THROW-OFF ()
	 <YOU-CANT-X-THAT "throw anything off">>

<ROUTINE V-TIE ()
	 <HOW-DO-YOU> <A-PRSI?>>

<ROUTINE V-TIE-UP ()
	 <HOW-DO-YOU> <A-PRSO?>>

<ROUTINE V-TIME ("AUX" X)
	 <SET X <- ,MOVES ,LAST-SLEPT>>
	 <TELL "It's ">
	 <COND (<L? .X 15>
		<TELL "early morning">)
	       (<L? .X 30>
		<TELL "mid-morning">)
	       (<L? .X 50>
		<TELL "mid-day">)
	       (<L? .X 65>
		<TELL "late afternoon">)
	       (<L? .X 80>
		<TELL "early evening">)
	       (T
		<TELL "late evening">)>
	 <TELL ,PERIOD>>

<ROUTINE V-TORTURE ()
	 <TELL "An appalling idea!" CR>>

<ROUTINE V-TURN () ;"used by others"
	 <TELL "This has no effect." CR>>

<ROUTINE V-TURN-OVER ()
	 <TELL "Moving " THE ,PRSO " reveals nothing." CR>>

<ROUTINE V-UNLOCK ()
	 <V-LOCK>>

<ROUTINE V-UNTIE ()
	 <HOW-DO-YOU> <A-PRSO?>>

<ROUTINE V-WALK ("AUX" PT PTS STR OBJ RM)
	 <COND (<NOT ,P-WALK-DIR>
		<PERFORM ,V?WALK-TO ,PRSO>
		<RTRUE>)
	       (<SET PT <GETPT ,HERE ,PRSO>>
		<COND (<EQUAL? <SET PTS <PTSIZE .PT>> ,UEXIT>
		       <GOTO <GETB .PT ,REXIT>>)
		      (<EQUAL? .PTS ,NEXIT>
		       <TELL <GET .PT ,NEXITSTR> CR>
		       <RFATAL>)
		      (<EQUAL? .PTS ,FEXIT>
		       <COND (<SET RM <APPLY <GET .PT ,FEXITFCN>>>
			      <GOTO .RM>)
			     (T
			      <RFATAL>)>)
		      (<EQUAL? .PTS ,CEXIT>
		       <COND (<VALUE <GETB .PT ,CEXITFLAG>>
			      <GOTO <GETB .PT ,REXIT>>)
			     (<SET STR <GET .PT ,CEXITSTR>>
			      <TELL .STR CR>
			      <RFATAL>)
			     (T
			      <CANT-GO>
			      <RFATAL>)>)
		      (<EQUAL? .PTS ,DEXIT>
		       <COND (<FSET? <SET OBJ <GETB .PT ,DEXITOBJ>> ,OPENBIT>
			      <GOTO <GETB .PT ,REXIT>>)
			     (<SET STR <GET .PT ,DEXITSTR>>
			      <TELL .STR CR>
			      <THIS-IS-IT .OBJ>
			      <RFATAL>)
			     (T
			      <TELL CTHE .OBJ " is closed." CR>
			      <THIS-IS-IT .OBJ>
			      <RFATAL>)>)>)
	       ;(<AND ,FLYING
		     <EQUAL? ,PRSO ,P?UP>>
		     <TELL "You're already flying as high as you can." CR>
		     <RFATAL>)
	       (T
		<CANT-GO>
		<RFATAL>)>>

<ROUTINE V-WALK-AROUND ()
	 <TELL "Please use compass directions instead." CR>>

<ROUTINE V-WALK-TO ()
	 <COND (<AND ,PRSO
		     <OR <IN? ,PRSO ,HERE>
			 <GLOBAL-IN? ,PRSO ,HERE>>>
		<TELL "It's here!" CR>)
	       (T
		<V-WALK-AROUND>)>>

<ROUTINE V-WAIT ("OPTIONAL" (NUM 3))
	 <TELL "Time passes..." CR>
	 <REPEAT ()
		 <COND (<L? <SET NUM <- .NUM 1>> 0>
			<RETURN>)
		       (<CLOCKER>
			<RETURN>)>>
	 <SETG CLOCK-WAIT T>>

<ROUTINE V-WAIT-FOR ()
	 <COND (<EQUAL? <LOC ,PRSO> ,HERE ,WINNER>
		<TELL "It's already here!" CR>)
	       (T
		<TELL "You may well wait quite a while." CR>)>>

<ROUTINE V-WAVE ()
	 <HACK-HACK "Waving">>

<ROUTINE V-WAVE-AT ()
	 <TELL
"Despite your friendly nature, " THE ,PRSO " isn't likely to respond." CR>>

<ROUTINE V-WEAR ()
	 <YOU-CANT-X-PRSO "wear">>

<ROUTINE V-WHAT ()
	 <TELL "An excellent question." CR>>

<ROUTINE V-WHERE ()
	 <COND (<NOT ,PRSO>
		<COND (,P-IT-OBJECT
		       <PERFORM ,V?WHERE ,P-IT-OBJECT>
		       <RTRUE>)
		      (ELSE
		       <TELL "Why?" CR>)>)
	       (ELSE
		<V-FIND T>)>>

<ROUTINE V-WHO ()
	 <COND (<NOT ,PRSO> <V-WHAT>)
	       (<FSET? ,PRSO ,PERSON>
		<PERFORM ,V?WHAT ,PRSO>
		<RTRUE>)
	       (T
		<TELL "That's not a person!" CR>)>>

<ROUTINE V-YAWN ()
	 <V-LEAN-ON>>

<ROUTINE V-YELL ()
	 <TELL "Aarrrgggghhhhh!" CR>>

;"subtitle object manipulation"

<GLOBAL FUMBLE-NUMBER 8>

<ROUTINE ITAKE ("OPTIONAL" (VB T) "AUX" CNT OBJ)
	 <COND (<IMMOBILIZED?> <RFALSE>)
	       (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<COND (.VB
		       <TELL-YUKS>)>
		<RFALSE>)
	       (<IN? ,PRSO ,WINNER>
		<TELL ,YOU-HAVE "it" ,PERIOD>
		<RFALSE>)
	       (<AND <NOT <IN? <LOC ,PRSO> ,WINNER>>
		     <G? <+ <WEIGHT ,PRSO> <WEIGHT ,WINNER>> ,LOAD-ALLOWED>>
		<COND (.VB
		       <COND (<FIRST? ,PLAYER>
			      <TELL "Your load is too heavy">)
			     (T
			      <TELL "It's a little too heavy">)>
		       <COND (<L? ,LOAD-ALLOWED ,LOAD-MAX>
			      <TELL
", especially in light of your exhaustion.">)
			     (T
			      <TELL ".">)>
		       <CRLF>)>
		<RFATAL>)
	       (<G? <SET CNT <CCOUNT ,WINNER>> ,FUMBLE-NUMBER>
		<COND (.VB
		       <TELL
"You're holding too many things and can't quite get them all arranged
to take it as well." CR>)>
		<RFATAL>)
	       (T
		<MOVE ,PRSO ,WINNER>
		<COND (<NOT <EQUAL? ,PRSO ,TIME-CUBE>>
		       <SCORE-OBJECT>)>
		<FCLEAR ,PRSO ,NDESCBIT>
		<RTRUE>)>>

<ROUTINE SCORE-OBJECT ("OPTIONAL" (OBJ <>))
	 <COND (<NOT .OBJ> <SET OBJ ,PRSO>)>
	 <COND (<FSET? .OBJ ,TOUCHBIT> <RTRUE>)>
	 <FSET .OBJ ,TOUCHBIT>
	 <COND (<GETP .OBJ ,P?CUBE>
		<SETG SCORE <+ ,SCORE 25>>)
	       (<FSET? .OBJ ,SCROLLBIT>
		<SETG SCORE <+ ,SCORE 10>>)
	       (<FSET? .OBJ ,MAGICBIT>
		<SETG SCORE <+ ,SCORE 10>>)>>

<ROUTINE IDROP ()
	 <COND (<NOT <HELD? ,PRSO>>
		<TELL ,YOU-ARENT "carrying ">
		<THE-PRSO>
		<RFALSE>)
	       (<AND <NOT <IN? ,PRSO ,WINNER>>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<THIS-IS-IT ,PRSO>
		<TELL-OPEN-CLOSED <LOC ,PRSO>>
		<RFALSE>)
	       (T
		<MOVE ,PRSO <LOC ,WINNER>>
		<RTRUE>)>>

<ROUTINE CCOUNT (OBJ "AUX" (CNT 0) X)
	 <COND (<SET X <FIRST? .OBJ>>
		<REPEAT ()
			<SET CNT <+ .CNT 1>>
			<COND (<NOT <SET X <NEXT? .X>>>
			       <RETURN>)>>)>
	 .CNT>

;"WEIGHT: Gets sum of SIZEs of supplied object, recursing to nth level."

<ROUTINE WEIGHT (OBJ "AUX" CONT (WT 0))
	 <COND (<EQUAL? .OBJ ,ZIPPER ,SPELL-BOOK> T)
	       (<SET CONT <FIRST? .OBJ>>
		<REPEAT ()
			<SET WT <+ .WT <WEIGHT .CONT>>>
			<COND (<NOT <SET CONT <NEXT? .CONT>>> <RETURN>)>>)>
	 <+ .WT <GETP .OBJ ,P?SIZE>>>

^\L

;"subtitle describers"

<GLOBAL DESCRIBED-ROOM? <>>

<ROUTINE DESCRIBE-ROOM ("OPTIONAL" (LOOK? <>) "AUX" V? STR AV)
	 <COND (<AND <NOT ,LIT>
		     <NOT <EQUAL? ,HERE ,GRUE-CAVE ,LIGHT-POOL ,PILLAR-ROOM>>>
		<TELL ,NOW-BLACK CR>
		<RFALSE>)>
	 <COND (<IN? ,HERE ,ROOMS> <TELL 'HERE>)>
	 <SET AV <LOC ,WINNER>>
	 <COND (<FSET? .AV ,VEHBIT>
		<COND (<FSET? .AV ,SURFACEBIT>
		       <TELL ", on ">)
		      (ELSE
		       <TELL ", in ">)>
		<TELL THE .AV>
		<COND (<EQUAL? .AV ,ROC>
		       <TELL "'s talons">)>)>
	 <CRLF>
	 <SET V? <OR .LOOK? <EQUAL? ,VERBOSITY 2>>>
	 <COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
		<FSET ,HERE ,TOUCHBIT>
		<COND (,VERBOSITY <SET V? T>)>)>
	 <SETG DESCRIBED-ROOM? .V?>
	 <COND (.V?
		<COND (<AND <NOT <EQUAL? ,HERE .AV>>
			    <FSET? .AV ,VEHBIT>
			    <APPLY <GETP .AV ,P?ACTION> ,M-LOOK>>
		       <RTRUE>)
		      (<APPLY <GETP ,HERE ,P?ACTION> ,M-LOOK>
		       <RTRUE>)
		      (<SET STR <GETP ,HERE ,P?LDESC>>
		       <TELL .STR CR>)>)>
	 T>

<ROUTINE DESCRIBE-OBJECTS ("OPTIONAL" (V? <>) "AUX" L)
	 <COND (<AND <EQUAL? ,HERE ,BELWIT-SQUARE>
		     <NOT <FSET? ,CLOUD ,INVISIBLE>>>
		<RTRUE>)
	       (,LIT
		<COND (<IN? ,PLAYER ,ZIPPER>
		       <SET L ,ZIPPER>)
		      (ELSE <SET L ,HERE>)>
		<COND (<FIRST? .L>
		       <PRINT-CONT .L <SET V? <OR .V? ,VERBOSITY>> -1>)>)
	       (<EQUAL? ,HERE ,LIGHT-POOL ,PILLAR-ROOM ,GRUE-CAVE>
		<RTRUE>)
	       (T
		<TELL ,TOO-DARK>)>>

"DESCRIBE-OBJECT -- takes object and flag. if flag is true will print a
long description (fdesc or ldesc), otherwise will print short."

<GLOBAL DESC-OBJECT <>>

<ROUTINE DESCRIBE-OBJECT (OBJ V? LEVEL "AUX" (STR <>) AV (VEH? <>))
	 <SETG DESC-OBJECT .OBJ>
	 <COND (<AND <SET AV <LOC ,WINNER>>
		     <FSET? .AV ,VEHBIT>>
		<SET VEH? T>
		<COND (<AND <NOT <FSET? .AV ,OPENBIT>>
			    <NOT <HELD? .OBJ .AV>>>
		       <RFALSE>)>)>
	 <COND (<ZERO? .LEVEL>
		<COND (<APPLY <GETP .OBJ ,P?DESCFCN> ,M-OBJDESC .OBJ>
		       <RTRUE>)
		      (<SET STR <GETP .OBJ ,P?LDESC>>
		       ;<OR <AND <NOT <FSET? .OBJ ,TOUCHBIT>>
				 <SET STR <GETP .OBJ ,P?FDESC>>>
			    <SET STR <GETP .OBJ ,P?LDESC>>>
		       <TELL .STR>)
		      (ELSE
		       <TELL "There is ">
		       <TELL A .OBJ " here">
		       <COND (<FSET? .OBJ ,ONBIT>
			      <TELL ,PROVIDING-LIGHT>)>
		       <TELL ".">)>
		<COND (.VEH? <TELL " (outside " THE .AV ")">)>)
	       (T
		<TELL <GET ,INDENTS .LEVEL>>
		<TELL A .OBJ>
		<COND (<FSET? .OBJ ,ONBIT>
		       <TELL ,PROVIDING-LIGHT>)>)>
	 <CRLF>
	 <COND (<AND <SEE-INSIDE? .OBJ> <FIRST? .OBJ>>
		<PRINT-CONT .OBJ .V? .LEVEL>)>>

<GLOBAL PROVIDING-LIGHT " (providing light)">

<ROUTINE PRINT-CONT (OBJ "OPTIONAL" (V? <>) (LEVEL 0)
		     "AUX" Y 1ST? AV STR (PV? <>) (INV? <>))
	 <COND (<NOT <SET Y <FIRST? .OBJ>>>
		<RTRUE>)>
	 <COND (<AND <SET AV <LOC ,WINNER>>
		     <FSET? .AV ,VEHBIT>>
		T)
	       (T
		<SET AV <>>)>
	 <SET 1ST? T>
	 <COND (<EQUAL? ,WINNER .OBJ <LOC .OBJ>>
		<SET INV? T>)>
	 <SET Y <FIRST? .OBJ>>
	 <REPEAT ()
		 <COND (<NOT .Y>
			<COND (<AND .PV? .AV <FIRST? .AV>>
			       <PRINT-CONT .AV .V? .LEVEL>)>
			<RETURN <NOT .1ST?>>)
		       (<EQUAL? .Y .AV> <SET PV? T>)
		       (<EQUAL? .Y ,PLAYER>)
		       (<NOT <FSET? .Y ,INVISIBLE>>
			<COND (<OR <NOT <FSET? .Y ,NDESCBIT>>
				   <AND <FSET? .Y ,BRIEFBIT>
					<EQUAL? ,VERBOSITY 1>
					<NOT ,DESCRIBED-ROOM?>>>
			       <COND (.1ST?
				      <COND (<FIRSTER .OBJ .LEVEL>
					     <COND (<L? .LEVEL 0>
						    <SET LEVEL 0>)>)>
				      <SET LEVEL <+ 1 .LEVEL>>
				      <SET 1ST? <>>)>
			       <DESCRIBE-OBJECT .Y .V? .LEVEL>)
			      (<AND <FIRST? .Y> <SEE-INSIDE? .Y>>
			       <PRINT-CONT .Y .V? .LEVEL>)>)>
		 <SET Y <NEXT? .Y>>>>

<ROUTINE PRINT-CONTENTS (OBJ "AUX" F N (1ST? T) (IT? <>) (TWO? <>))
	 <COND (<SET F <FIRST? .OBJ>>
		<REPEAT ()
			<SET N <NEXT? .F>>
			<COND (<AND <NOT <EQUAL? .F ,PLAYER>>
				    <NOT <FSET? .F ,INVISIBLE>>>
			       <COND (.1ST? <SET 1ST? <>>)
				     (T
				      <TELL ", ">
				      <COND (<NOT .N>
					     <TELL "and ">)>)>
			       <TELL A .F>
			       <COND (<AND <NOT .IT?>
					   <NOT .TWO?>>
				      <SET IT? .F>)
				     (T
				      <SET TWO? T>
				      <SET IT? <>>)>)>
			<SET F .N>
			<COND (<NOT .F>
			       <COND (<AND .IT? <NOT .TWO?>>
				      <THIS-IS-IT .IT?>)>
			       <RETURN>)>>
		<NOT .1ST?>)>>

<ROUTINE CLEVER-CONTENTS (OBJ STR "OPTIONAL" (IGNORE <>)
			  "AUX" (F <FIRST? .OBJ>) (N <>) (1ST? T))
	 <REPEAT ()
		 <COND (<NOT .F>
			<COND (.N
			       <COND (.1ST?
				      <SET 1ST? <>>
				      <TELL .STR>
				      <TELL " is ">)
				     (ELSE
				      <TELL " and ">)>
			       <TELL A .N ".">)>
			<RETURN <NOT .1ST?>>)
		       (<AND <NOT <EQUAL? .F ,PLAYER>>
			     <NOT <FSET? .F ,INVISIBLE>>
			     <NOT <EQUAL? .F .IGNORE>>>
			<COND (.N
			       <COND (.1ST?
				      <SET 1ST? <>>
				      <TELL .STR>
				      <TELL " are ">)
				     (ELSE
				      <TELL ", ">)>
			       <TELL A .N>)>
			<SET N .F>)>
		 <SET F <NEXT? .F>>>>

<ROUTINE FIRSTER (OBJ LEVEL)
	 <COND (<EQUAL? .OBJ ,WINNER>
		<TELL "You are carrying:" CR>)
	       (<NOT <IN? .OBJ ,ROOMS>>
		<COND (<G? .LEVEL 0>
		       <TELL <GET ,INDENTS .LEVEL>>)>
		<COND (<FSET? .OBJ ,SURFACEBIT>
		       <TELL "Sitting on " THE .OBJ " you see:" CR>)
		      (<FSET? .OBJ ,PERSON>
		       <TELL CTHE .OBJ " is holding:" CR>)
		      (T
		       <TELL CTHE .OBJ " contains:" CR>)>)>>

^\L

;"subtitle movement"

<CONSTANT REXIT 0>
<CONSTANT UEXIT 1>
<CONSTANT NEXIT 2>
<CONSTANT FEXIT 3>
<CONSTANT CEXIT 4>
<CONSTANT DEXIT 5>

<CONSTANT NEXITSTR 0>
<CONSTANT FEXITFCN 0>
<CONSTANT CEXITFLAG 1>
<CONSTANT CEXITSTR 1>
<CONSTANT DEXITOBJ 1>
<CONSTANT DEXITSTR 1>

;<ROUTINE LKP (ITM TBL "AUX" (CNT 0) (LEN <GET .TBL 0>))
	 <REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> .LEN>
			<RFALSE>)
		       (<EQUAL? <GET .TBL .CNT> .ITM>
			<COND (<EQUAL? .CNT .LEN> <RFALSE>)
			      (T
			       <RETURN <GET .TBL <+ .CNT 1>>>)>)>>>

<GLOBAL OHERE <>>

<ROUTINE GOTO (RM "OPTIONAL" (V? T) "AUX" OLIT)
	 %<DEBUG-CODE <D-APPLY "Leave" <GETP ,HERE ,P?ACTION> ,M-LEAVE>
		      <APPLY <GETP ,HERE ,P?ACTION> ,M-LEAVE>>
	 <SETG OHERE ,HERE>
	 <SET OLIT ,LIT>
	 <COND (<NOT <EQUAL? <LOC ,WINNER> ,HERE>>
		<MOVE <LOC ,WINNER> .RM>)
	       (ELSE
		<MOVE ,WINNER .RM>)>
	 <SETG HERE .RM>
	 <SETG LIT <LIT? ,HERE>>
	 <COND (<AND <NOT .OLIT>
		     <NOT ,LIT>
		     <NOT <EQUAL? ,HERE ,PILLAR-ROOM ,LIGHT-POOL>>
		     <NOT <VERB? BLORPLE>>
		     <PROB 80>>
		<JIGS-UP
"Oh, no! Something lurking nearby snuck up and devoured you!">
		<RTRUE>)>
	 %<DEBUG-CODE <D-APPLY "Enter" <GETP ,HERE ,P?ACTION> ,M-ENTER>
		      <APPLY <GETP ,HERE ,P?ACTION> ,M-ENTER>>
	 <COND (<NOT <EQUAL? ,HERE .RM>>
		<RTRUE>)
	       (.V?
		<V-FIRST-LOOK>)>
	 <RTRUE>>

\

;"subtitle death and stuff"

<ROUTINE JIGS-UP ("OPTIONAL" (DESC <>))
	 <SETG WINNER ,PLAYER>
	 <COND (.DESC <TELL .DESC>)>
	 <FORGET-ALL>
	 <SETG FALLING? <>>
	 <TELL "|
|    ****  You have died  ****|" CR>
	 <WEAR-OFF-SPELLS <>>
	 <TELL
"You are floating in a dark, silent realm of nothingness. You don't know
how much time passes, but eventually you hear the sound of soft footsteps.
A figure in a dark cloak comes near. In a voice
like ashes, it speaks: \"" <GET ,DEATH-SPEECHES ,DEATHS> "\"|
|
You find yourself falling down a deep well of darkness, as the figure
recedes into infinite distances">
	 <COND (<G? <SETG DEATHS <+ ,DEATHS 1>> 3>
		<TELL
", and mocking laughter haunts you for eternity." CR>
		<FINISH>)>
	 <TELL ,PERIOD>
	 <CRLF>
	 <MOVE ,PLAYER ,HERE> ;"GET OUT OF VEHICLE"
	 <COND (<IN? ,PLAYER ,MAGIC-CARPET>
		<MOVE ,MAGIC-CARPET ,PLAYER>)>
	 <SETG DEAD? T>
	 <GOTO ,DEATH-ROOM>
	 <SETG DEAD? <>>
	 <SETG P-CONT <>>
	 <RFATAL>>

<GLOBAL DEAD? <>>

<GLOBAL DEATHS 0>

<GLOBAL DEATH-SPEECHES
	<PTABLE
"How nice to see you again.
Unfortunately, I still have need of you, so this foolishness can't be
allowed. You'll have to go back."

"You really don't seem to
be able to take care of yourself, do you? A little more circumspection and
prudence might be in order, don't you think?"

"I think I may have chosen improperly after all. I warn you, this is
your last chance."

"You're obviously not the right choice. What a waste. I'll have to
start all over with someone else. All this effort, too.">>

<ROUTINE ROB (FROM TO "OPTIONAL" (IGNORE <>)
	      "AUX" (F <FIRST? .FROM>) N (1ST? <>))
	 <REPEAT ()
		 <COND (.F
			<SET N <NEXT? .F>>
			<COND (<AND <FSET? .F ,TAKEBIT>
				    <NOT <EQUAL? .F .IGNORE>>> 
			       <SET 1ST? T>
			       <COND (.TO <MOVE .F .TO>)
				     (ELSE <REMOVE .F>)>)>
			<SET F .N>)
		       (T
			<RETURN>)>>
	 .1ST?>

^\L

;"subtitle useful utility routines"

<ROUTINE THIS-IS-IT (OBJ)
	 <COND (<NOT <EQUAL? .OBJ ,IT>>
		<SETG P-IT-OBJECT .OBJ>)>>

<ROUTINE ACCESSIBLE? (OBJ "AUX" (L <LOC .OBJ>)) ;"can player TOUCH object?"
	 ;"revised 5/2/84 by SEM and SWG"
	 <COND (<FSET? .OBJ ,INVISIBLE>
		<RFALSE>)
	       (<EQUAL? .OBJ ,PSEUDO-OBJECT>
		<COND (<EQUAL? ,LAST-PSEUDO-LOC ,HERE>
		       <RTRUE>)
		      (T
		       <RFALSE>)>)
	       (<NOT .L>
		<RFALSE>)
	       (<EQUAL? .L ,GLOBAL-OBJECTS>
		<RTRUE>)
	       (<AND <EQUAL? .L ,LOCAL-GLOBALS>
		     <GLOBAL-IN? .OBJ ,HERE>>
		<RTRUE>)
	       (<NOT <EQUAL? <META-LOC .OBJ> ,HERE <LOC ,WINNER>>>
		<RFALSE>)
	       (<EQUAL? .L ,WINNER ,HERE <LOC ,WINNER>>
		<RTRUE>)
	       (<AND <FSET? .L ,OPENBIT>
		     <ACCESSIBLE? .L>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE VISIBLE? (OBJ "AUX" (L <LOC .OBJ>)) ;"can player SEE object"
	 ;"revised 5/2/84 by SEM and SWG"
	 <COND (<ACCESSIBLE? .OBJ>
		<RTRUE>)
	       (<AND <SEE-INSIDE? .L>
		     <VISIBLE? .L>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE META-LOC (OBJ)
	 <REPEAT ()
		 <COND (<NOT .OBJ>
			<RFALSE>)
		       (<IN? .OBJ ,GLOBAL-OBJECTS>
			<RETURN ,GLOBAL-OBJECTS>)>
		 <COND (<IN? .OBJ ,ROOMS>
			<RETURN .OBJ>)
		       (T
			<SET OBJ <LOC .OBJ>>)>>>

<ROUTINE HELD? (OBJ "OPTIONAL" (WHO <>))
	 ;"is object carried, or in something carried, by player?"
	 <COND (<NOT .WHO> <SET WHO ,PLAYER>)>
	 <COND (<NOT .OBJ>
		<RFALSE>)
	       (<IN? .OBJ .WHO>
		<RTRUE>)
	       (<IN? .OBJ ,ROOMS>
		<RFALSE>)
	       (<IN? .OBJ ,GLOBAL-OBJECTS>
		<RFALSE>)
	       (T
		<HELD? <LOC .OBJ> .WHO>)>>

<ROUTINE SEE-INSIDE? (OBJ)
	 <AND .OBJ
	      <NOT <FSET? .OBJ ,INVISIBLE>>
	      <OR <FSET? .OBJ ,TRANSBIT>
	          <FSET? .OBJ ,OPENBIT>>>>

<ROUTINE GLOBAL-IN? (OBJ1 OBJ2 "AUX" TEE)
	 <COND (<AND .OBJ2
		     <SET TEE <GETPT .OBJ2 ,P?GLOBAL>>>
		<ZMEMQB .OBJ1 .TEE <- <PTSIZE .TEE> 1>>)>>

<ROUTINE DO-WALK (DIR)
	 <SETG P-WALK-DIR .DIR>
	 <PERFORM ,V?WALK .DIR>>

<ROUTINE SOAK-STUFF (OBJ "OPTIONAL" (RECURSE? T)
		     "AUX" (F <FIRST? .OBJ>) (1ST? T))
	 <REPEAT ()
		 <COND (<NOT .F> <RETURN <NOT .1ST?>>)
		       (<SOAK-OBJ? .F>
			<SET 1ST? <>>)
		       (<AND <NOT .RECURSE?>
			     <EQUAL? .F ,PLAYER>>
			T)
		       (<AND <FSET? .F ,CONTBIT>
			     <FSET? .F ,OPENBIT>
			     <FIRST? .F>>
			<COND (<SOAK-STUFF .F>
			       <SET 1ST? <>>)>)>
		 <SET F <NEXT? .F>>>>

<ROUTINE SOAK-OBJ? (F)
	 <COND (<FSET? .F ,RMUNGBIT> <RFALSE>)
	       (<OR <EQUAL? .F ,SPELL-BOOK>
		    <FSET? .F ,SCROLLBIT>>
		<FSET .F ,RMUNGBIT>
		<RTRUE>)>>

<ROUTINE HACK-HACK (STR)
	 <TELL .STR " " THE ,PRSO " has no effect." CR>>

<ROUTINE TELL-YUKS ()
	 <TELL <PICK-ONE ,YUKS> CR>>

<GLOBAL YUKS
	<LTABLE 0
	 "Not likely!"
	 "That would never work!"
	 "You can't be serious."
	 "You must have had a silliness spell cast upon you.">>

<ROUTINE OPEN-CLOSE ()
	 <COND (<AND <VERB? OPEN>
		     <FSET? ,PRSO ,OPENBIT>>
		<ALREADY-OPEN>
		<RTRUE>)
	       (<AND <VERB? CLOSE>
		     <NOT <FSET? ,PRSO ,OPENBIT>>>
		<ALREADY-CLOSED>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE PRE-SWRITE ()
	 <COND (<AND ,PRSO ,PRSI>
		<PERFORM ,V?WRITE ,PRSI ,PRSO>
		<RTRUE>)>>

<ROUTINE V-SWRITE ()
	 <TELL "Write what on " THE ,PRSO "?" CR>>

<ROUTINE PRE-WRITE-ON () ;"WRITE ON FOO WITH BAR"
	 <COND (<NOT ,PRSI>
		<TELL
,YOU-HAVE-TO " write on " THE ,PRSO " with something." CR>)
	       (<EQUAL? ,PRSI ,BURIN>
		<V-SWRITE> ;"what would you like to write?")
	       (ELSE
		<NO-BURIN>)>>

<ROUTINE V-WRITE-ON () ;"WRITE ON FOO WITH BAR"
	 <TELL
CTHE ,PRSO ,HAS-NO-SURFACE ,PERIOD>>

<GLOBAL HAS-NO-SURFACE " has no suitable surface to write on">

<ROUTINE PRE-WRITE ()
	 <COND (<NOT ,PRSI>
		<COND (<EQUAL? ,PRSO ,QWORD>
		       <TELL
,YOU-HAVE-TO " write that on something." CR>)
		      (<OR <FSET? ,PRSO ,SPELLBIT>
			   <FSET? ,PRSO ,SCROLLBIT>>
		       <TELL
"You have to copy the spell onto something." CR>)
		      (ELSE
		       <TELL
,YOU-CANT "write " A ,PRSO ". Try writing a word,
such as \"purple\", instead." CR>)>)
	       (<NOT <IN? ,BURIN ,WINNER>>
		<NO-BURIN>)
	       (<OR <FSET? ,PRSO ,SPELLBIT>
		    <FSET? ,PRSO ,SCROLLBIT>>
		<PERFORM ,V?COPY ,PRSO ,PRSI>
		<RTRUE>)>>

<ROUTINE V-WRITE ()
	 <TELL
CTHE ,PRSI ,HAS-NO-SURFACE ,PERIOD>>

<ROUTINE V-PRY ()
	 <V-TURN>>

<ROUTINE V-PLANT ()
	 <TELL
,I-DONT-THINK-THAT THE ,PRSO " is going to sprout." CR>>

<ROUTINE V-YES ()
	 <TELL "That was a rhetorical question." CR>>

<ROUTINE V-NO ()
	 <V-YES>>

<ROUTINE V-BUY ()
	 <UNINTERESTED ,PRSI>>

<ROUTINE PRE-SSELL ()
	 <PERFORM ,V?SELL ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SSELL () <RTRUE>>

<ROUTINE V-SELL ()
	 <UNINTERESTED ,PRSI>>

<ROUTINE PRE-TELL-ABOUT ()
	 <COND (<EQUAL? ,PRSO ,ME>
		<PERFORM ,V?TELL-ME-ABOUT ,PRSI>
		<RTRUE>)>>

<ROUTINE V-TELL-ABOUT ()
	 <UNINTERESTED ,PRSO>>

<ROUTINE V-TELL-ME-ABOUT ()
	 <COND (<EQUAL? ,WINNER ,PLAYER>
		<TELL "Talking to yourself?" CR>)
	       (ELSE
		<UNINTERESTED ,WINNER>)>>

<ROUTINE V-OFFER ()
	 <V-TRADE>>

<ROUTINE V-TRADE ()
	 <COND (<AND <IN? ,MERCHANT ,HERE>
		     <EQUAL? ,PRSO ,MAGIC-CARPET ,RANDOM-CARPET>
		     <HELD? ,PRSO>>
		<ASK-ABOUT-CARPET
		 <COND (<EQUAL? ,PRSO ,RANDOM-CARPET> ,MAGIC-CARPET)
		       (ELSE ,RANDOM-CARPET)>>)
	       (<AND ,PRSI <FSET? ,PRSI ,PERSON>>
		<UNINTERESTED ,PRSI>)
	       (ELSE
		<TELL "Perhaps it isn't for sale." CR>)>>

<ROUTINE V-SLAVER ()
	 <TELL "You're not very convincing." CR>>

<ROUTINE V-ERASE ()
	 <COND (<NOT <ZERO? <GETP ,PRSO ,P?NAME>>>
		<YOU-CANT-X-PRSO "erase the lettering from">)
	       (<GETPT ,PRSO ,P?NAME>
		<TELL ,THERES-NOTHING-TO "erase" ,PERIOD>)
	       (ELSE
		<TELL-YUKS>)>>

<ROUTINE V-ADMIRE ()
	 <TELL "Your taste is unusual." CR>>

<ROUTINE V-COPY ()
	 <COND (<NOT ,PRSI>
		<TELL ,YOU-HAVE-TO " copy it onto something." CR>)
	       (<EQUAL? ,PRSI ,BURIN>
		<TELL
"You should copy something onto something else." CR>)
	       (<FSET? ,PRSI ,TOOLBIT>
		<NOT-WRITING-TOOL>)
	       (<EQUAL? ,PRSI ,SPELL-BOOK>
		<TELL
"You have to \"gnusto\" spells into "> <A-PRSI>)
	       (<OR <NOT <FSET? ,PRSO ,SPELLBIT>>
		    <NOT <FSET? ,PRSO ,SCROLLBIT>>
		    <NOT <FSET? ,PRSI ,SCROLLBIT>>>
		<TELL
,YOU-CANT "copy " A ,PRSO " onto "> <A-PRSI>)
	       (<NOT <IN? ,BURIN ,WINNER>>
		<NO-BURIN>)
	       (ELSE
		<ALREADY-USED>)>>

<ROUTINE ALREADY-USED ("AUX" (F <FIRST? ,PRSI>))
	 <TELL
"That scroll already has " THE .F " written on it." CR>>

<ROUTINE NOT-WRITING-TOOL ()
	 <TELL
,I-DONT-THINK-THAT A ,PRSI " makes a very good writing instrument." CR>>

<ROUTINE NO-BURIN ()
	 <TELL ,YOU-DONT-HAVE "anything to write with." CR>>

<ROUTINE V-BARGAIN ()
	 <TELL "Perhaps you should go to a bazaar." CR>>

<ROUTINE V-REPAIR ()
	 <COND (<FSET? ,PRSO ,RMUNGBIT>
		<TELL "I don't know how." CR>)
	       (ELSE
		<TELL CTHE ,PRSO " isn't broken." CR>)>>

<ROUTINE V-LOOK-UP ()
	 <COND (<EQUAL? ,PRSO ,ROOMS>
		<TELL "Don't get a sore neck." CR>)
	       (ELSE <PERFORM ,V?WHAT ,PRSO> <RTRUE>)>>
