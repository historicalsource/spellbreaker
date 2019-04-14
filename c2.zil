"C2 for
				MAGE
	(c) Copyright 1985 Infocom, Inc. All Rights Reserved."

"WATER"

<OBJECT WATER-CUBE
	(IN MAGIC-BOX)
	(DESC "cube")
	(SYNONYM CUBE CUBES)
	(ADJECTIVE BQ ;C2 SMALL FEATURELESS WHITE)
	(NAME 0)
	(TEXT "dolphins")
	(FLAGS TAKEBIT)
	(ACTION CUBE-F)
	(DESCFCN CUBE-DESC)
        (GENERIC GENERIC-CUBE-F)
	(CUBE WATER-ROOM)>

<ROOM WATER-ROOM
      (IN ROOMS)
      (DESC "Water Room")
      (CUBE WATER-CUBE)
      (NORTH TO OUBLIETTE)
      (EAST PER MAGIC-BOX-EXIT)
      (SOUTH TO OCEAN-ROOM)
      (ACTION WATER-ROOM-F)
      (FLAGS RLANDBIT)
      (GLOBAL WATER)
      (THINGS
       <PSEUDO (<> CORAL RANDOM-PSEUDO)
	       (DAMP MOSS RANDOM-PSEUDO)
	       (<> MUD RANDOM-PSEUDO)
	       (SHIMMERING FILM RANDOM-PSEUDO)
	       (<> BUBBLE RANDOM-PSEUDO)>)>

<ROUTINE WATER-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a damp, mossy room. Its floor is mud, and its walls and ceiling are
coral. In the gaps in the coral you can see a shimmering film which you
realize is actually the outer edge of a huge bubble of air enclosing you.
On the north, east and south sides of the room are curtains of bubbles."
CR>)
	       (<EQUAL? .RARG ,M-LEAVE>
		<RECOVER-CUBE>)>>

"OCEAN PROBLEM -- SAVE LOST CUBE AND GET ONE FROM GROUPER"

<ROOM OCEAN-ROOM
      (IN ROOMS)
      (DESC "Mid-Ocean")
      (ACTION OCEAN-ROOM-F)
      (FLAGS RWATERBIT OUTSIDE ONBIT)
      (GLOBAL WATER)>

<ROUTINE OCEAN-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are swimming in mid-ocean.">
		<CLEVER-CONTENTS ,HERE " Floating nearby" ,GROUPER>
		<CRLF>)
	       (<EQUAL? .RARG ,M-ENTER>
		<COND (<EQUAL? ,OHERE ,WATER-ROOM>
		       <MOVE ,GROUPER ,HERE>
		       <QUEUE I-GROUPER 2>
		       <QUEUE I-CUBE-SINKS 3>
		       <MOVE ,WATER-CUBE ,HERE>
		       <FSET ,WATER-CUBE ,NDESCBIT>
		       <TELL
"You step out of the room and drop precipitously into the Flathead Ocean,
making a terrific splash. " CTHE ,WATER-CUBE ", lost in the shock of the
fall, makes a smaller splash. It is a little less buoyant than you and
begins to sink slowly beneath the waves.">
		       <SOAK-PLAYER>
		       <CRLF>
		       <CRLF>)>)
	       (<EQUAL? .RARG ,M-BEG>
		<FUN-IN-OCEAN>)
	       (<EQUAL? .RARG ,M-END>
		<SOAK-IF-OPENED>)>>

<ROUTINE FUN-IN-OCEAN ()
	 <COND (<VERB? WALK SWIM>
		<COND (<EQUAL? ,HERE ,LOST-IN-OCEAN>
		       <GOTO ,LOST-IN-OCEAN>)
		      (<EQUAL? ,P-WALK-DIR ,P?DOWN>
		       <COND (<EQUAL? ,CHANGED? ,GROUPER>
			      <YOU-SWIM>
			      <GOTO ,OCEAN-FLOOR>)
			     (ELSE
			      <HOLD-BREATH>)>)
		      (<EQUAL? ,P-WALK-DIR ,P?UP>
		       <TELL
"Only if you sprout wings first." CR>)
		      (ELSE
		       <GOTO ,LOST-IN-OCEAN>)>)
	       (<VERB? TAKE>
		<COND (<EQUAL? ,CHANGED? ,GROUPER>
		       <TELL
"Your fins are not well designed to hold things." CR>)
		      (<G? ,P-MULT 1>
		       <TELL
"They were floating in opposite directions, and you get a chance
at only one of them." CR>
		       <RFATAL>)>)
	       (<AND <VERB? DROP> <HELD? ,PRSO>>
		<QUEUE I-FLOTSAM 2>
		<MOVE ,PRSO ,HERE>
		<FSET ,PRSO ,NDESCBIT>
		<SOAK-OBJ? ,PRSO>
		<TELL CTHE ,PRSO>
		<COND (<EQUAL? ,PRSO ,BOTTLE>
		       <TELL
" is now floating nearby">)
		      (ELSE
		       <TELL
" begins to sink beneath the waves">)>
		<TELL ,PERIOD>)
	       (<AND <VERB? EAT>
		     <EQUAL? ,CHANGED? ,GROUPER>
		     <FSET? ,PRSO ,TAKEBIT>>
		<SETG ATE-AS-GROUPER? T>
		<REMOVE ,PRSO>
		<TELL
"Opening your maw, you swallow "><THE-PRSO>)>>

<ROUTINE HOLD-BREATH ()
	 <TELL
"You take a deep breath and swim downward, but you can't hold it long enough
to reach the bottom." CR>>

<ROUTINE YOU-SWIM ()
	 <TELL "You swim ">
	 <COND (<EQUAL? ,HERE ,OCEAN-ROOM>
		<TELL "downward">)
	       (ELSE <TELL "upward">)>
	 <COND (<IN? ,GROUPER ,HERE>
		<COND (<EQUAL? ,HERE ,OCEAN-ROOM>
		       <MOVE ,GROUPER ,OCEAN-FLOOR>
		       <TELL ", followed">)
		      (ELSE <TELL ", watched">)>
		<TELL " by the nervous grouper">)>
	 <TELL ,PERIOD CR>>

<ROOM LOST-IN-OCEAN
      (IN ROOMS)
      (DESC "Open Ocean")
      (FLAGS RWATERBIT OUTSIDE ONBIT)
      (ACTION LOST-IN-OCEAN-F)
      (GLOBAL WATER)>

<ROUTINE LOST-IN-OCEAN-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are lost in the middle of the open ocean. There is no land in sight.">
		<CLEVER-CONTENTS ,HERE " Floating nearby">
		<CRLF>)
	       (<EQUAL? .RARG ,M-BEG>
		<FUN-IN-OCEAN>)
	       (<EQUAL? .RARG ,M-END>
		<SOAK-IF-OPENED>)>>

<ROOM OCEAN-FLOOR
      (IN ROOMS)
      (DESC "Ocean Floor")
      (UP TO OCEAN-ROOM)
      (ACTION OCEAN-FLOOR-F)
      (FLAGS RWATERBIT ONBIT)
      (GLOBAL WATER)>

<ROUTINE OCEAN-FLOOR-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are deep beneath the waves, near a small pile of rocks and broken
coral that make up the nest of a grouper." CR>)
	       (<EQUAL? .RARG ,M-ENTER>
		<COND (<NOT <EQUAL? ,CHANGED? ,GROUPER>>
		       <JIGS-UP
"You have reemerged beneath the ocean. There is no air here.
You drown.">)>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<VERB? WALK SWIM>
		       <COND (<EQUAL? ,CHANGED? ,GROUPER>
			      <COND (<EQUAL? ,P-WALK-DIR ,P?UP>
				     <YOU-SWIM>
				     <GOTO ,OCEAN-ROOM>)
				    (<EQUAL? ,P-WALK-DIR ,P?DOWN>
				     <TELL
"You hit your nose against the sand." CR>)
				    (ELSE
				     <TELL
"You swim in circles for a while." CR>)>)
			     (<OR <NOT ,PRSO>
				  <EQUAL? ,PRSO ,P?UP>
				  <EQUAL? ,P-WALK-DIR ,P?UP>>
			      <TELL
"You swim upward, desperately trying to hold your breath until you
reach the surface. It's a losing battle. " ,YOU-CANT "hold it any
longer, take a breath, and it's pure, sweet air! You have reached the
surface." CR CR>
			      <GOTO ,OCEAN-ROOM>)
			     (ELSE
			      <TELL
"You swim about for a short distance." CR>)>)
		      (<VERB? DROP> <RFALSE>)
		      (<EQUAL? ,CHANGED? ,GROUPER>
		       <FUN-IN-OCEAN>)>)>>

<GLOBAL ATE-AS-GROUPER? <>>

<OBJECT GROUPER-NEST
	(IN OCEAN-FLOOR)
	(DESC "grouper nest")
	(SYNONYM NEST CORAL ROCKS PILE)
	(ADJECTIVE GROUPER BROKEN PILE)
	(FLAGS NDESCBIT OPENBIT CONTBIT SEARCHBIT TRYTAKEBIT)
	(CAPACITY 20)>

<OBJECT BOTTLE
	(IN OCEAN-ROOM)
	(DESC "bottle")
	(SYNONYM BOTTLE)
	(ADJECTIVE FLOATING)
	(FLAGS NDESCBIT TAKEBIT CONTBIT TRANSBIT SEARCHBIT)
	(CAPACITY 6)
	(ACTION BOTTLE-F)>

<ROUTINE BOTTLE-F ("AUX" F)
	 <COND (<VERB? FILL>
		<COND (<NOT <IN? ,BOTTLE ,WINNER>>
		       <NOT-HOLDING ,BOTTLE>)
		      (<IN? ,LOCAL-WATER ,BOTTLE>
		       <TELL ,IT-IS-ALREADY "full" ,PERIOD>)
		      (<EQUAL? ,PRSI <> ,WATER>
		       <COND (<NOT <GLOBAL-IN? ,WATER ,HERE>>
			      <TELL "There's no water here." CR>
			      <RTRUE>)>
		       <MOVE ,LOCAL-WATER ,BOTTLE>
		       <TELL
CTHE ,BOTTLE " is now full of ">
		       <COND (<EQUAL? ,HERE
				      ,OCEAN-ROOM
				      ,OCEAN-FLOOR
				      ,LOST-IN-OCEAN>
			      <FSET ,LOCAL-WATER ,RMUNGBIT>
			      <TELL "salt ">)
			     (ELSE
			      <FCLEAR ,LOCAL-WATER ,RMUNGBIT>)>
		       <TELL "water">
		       <COND (<NOT <FSET? ,BOTTLE ,OPENBIT>>
			      <TELL ", and it's closed again">)>
		       <COND (<SET F <SOAK-STUFF ,BOTTLE>>
			      <TELL
". The water has ruined something in the bottle">)>
		       <TELL ,PERIOD>)
		      (ELSE
		       <YOU-CANT-X-PRSI "fill the bottle with">)>)
	       (<AND <VERB? POUR>
		     <EQUAL? ,PRSO ,BOTTLE>
		     <IN? ,LOCAL-WATER ,BOTTLE>>
		<REMOVE ,LOCAL-WATER>
		<TELL
CTHE ,BOTTLE " is now empty of water." CR>)
	       (<VERB? LOOK-INSIDE OPEN>
		<FCLEAR ,LISKON-SCROLL ,NDESCBIT>
		<RFALSE>)>>

<OBJECT GROUPER
	(IN OCEAN-ROOM)
	(DESC "grouper")
	(LDESC
"A large grouper swims nearby.")
	(SYNONYM FISH GROUPER)
	(ADJECTIVE LARGE)
	(FLAGS PERSON THE)
	(SIZE 100)
	(ACTION GROUPER-F)>

<ROUTINE GROUPER-F ()
	 <COND (<EQUAL? ,WINNER ,GROUPER>
		<END-QUOTE>
		<TELL
"The grouper stares at you, goggle-eyed and interested, but wary." CR>)
	       (<VERB? EXAMINE>
		<TELL
"The grouper is a large fish with an enormous mouth. This specimen
is large but not exceptional. It probably weighs about as much as you." CR>)
	       (<VERB? FOLLOW>
		<COND (<AND <IN? ,GROUPER ,OCEAN-FLOOR>
			    <IN? ,PLAYER ,OCEAN-ROOM>>
		       <DO-WALK ,P?DOWN>)>)
	       (<VERB? WAVE-AT GIVE SHOW>
		<TELL
"The grouper looks interested but is afraid to come close." CR>)
	       (<AND <VERB? LISKON>
		     <NOT <PRE-LISKON>>>
		<REMOVE ,GROUPER>
		<DEQUEUE I-GROUPER>
		<DEQUEUE I-GROUPER-IN-NEST>
		<TELL
"The grouper dwindles to the size of a sea bass. Startled and upset,
it swims rapidly away." CR>)
	       (<VERB? SNAVIG>
		<SETG CHANGED? ,GROUPER>
		<SETG ATE-AS-GROUPER? <>>
		<QUEUE I-SNAVIG 12>
		<TELL
"You change.">
		<COND (<ROB ,PLAYER ,OCEAN-FLOOR>
		       <TELL " You can no longer carry anything.">)>
		<TELL
" The grouper stares at you with fishy eyes like yours, twiddles
fins like yours, opens a huge mouth like yours, and flicking a
tail like yours, swims suspiciously around you." CR>)
	       (<VERB? ESPNIS>
		<TELL
"As groupers rarely if ever sleep, this has no effect." CR>)
	       (<VERB? YOMIN>
		<TELL
"The mind of a grouper is hard to focus on, but you get a vision of ">
		<COND (<OR <IN? ,BREAD ,GROUPER>
			   <IN? ,FISH ,GROUPER>>
		       <TELL
"curiosity and expectation: is there any more food to be had?">)
		      (ELSE
		       <TELL
"hunger and curiosity. The last time the grouper saw something like
you, it was interesting.">)>
		<CRLF>)
	       (<HOSTILE-VERB?>
		<TELL
"The grouper is startled but returns after
a few moments, its curiosity unsated." CR>)>>

\

"OUBLIETTE PROBLEM - GET OUT ONE OF TWO WAYS!"

<ROOM OUBLIETTE
      (IN ROOMS)
      (DESC "Oubliette")
      (DOWN PER OUBLIETTE-DOWN-EXIT)
      (UP PER OUBLIETTE-UP-EXIT) ;"PRISON"
      (ACTION OUBLIETTE-F)
      (FLAGS RLANDBIT)
      (GLOBAL TRAP-DOOR WATER)>

<GLOBAL WATER-FLAG 0> ;"how full is oubliette?"
<GLOBAL FREEZE-FLAG 0> ;"how much ice is there?"
<GLOBAL FREEZE-COUNT 0> ;"how near death from hypothermia?"

<ROUTINE OUBLIETTE-DOWN-EXIT ()
	 <COND (,SMALL-FLAG 
		<COND (,WATER-FLAG
		       <TELL "The channel is frozen over." CR>
		       <RFALSE>)
		      (ELSE ,IN-CHANNEL)>)
	       (,WATER-FLAG
		<COND (<IN? ,WINNER ,ICEBERG>
		       <TELL ,YOU-HAVE-TO " get in the water first" ,PERIOD>)
		      (ELSE
		       <HOLD-BREATH>)>
		<RFALSE>)
	       (ELSE
		<TELL "You'd never fit." CR>
		<RFALSE>)>>

<ROUTINE OUBLIETTE-UP-EXIT ()
	 <COND (<G? ,WATER-FLAG 3>
		<COND (<FSET? ,TRAP-DOOR ,OPENBIT>
		       <COND (<IN? ,PLAYER ,ICEBERG>
			      <MOVE ,PLAYER ,HERE>
			      ,PRISON)
			     (ELSE
			      <TELL
"You still can't quite reach the trap door opening. " ,YOU-CANT "get enough
momentum thrusting upward out of the water." CR>
			      <RFALSE>)>)
		      (ELSE
		       <THIS-IS-IT ,TRAP-DOOR>
		       <TELL-OPEN-CLOSED ,TRAP-DOOR>
		       <RFALSE>)>)
	       (ELSE
		<COND (<G? ,WATER-FLAG 0>
		       <TELL
"The oubliette is only " <GET ,WATER-HEIGHTS ,WATER-FLAG> " full. ">)>
		<TELL
CTHE ,TRAP-DOOR " is far over your head. ">
		<CANT-REACH-IT>
		<RFALSE>)>>

<ROUTINE OUBLIETTE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is an oubliette. ">
		<COND (<G? ,WATER-FLAG 0>
		       <TELL
"It is " <GET ,WATER-HEIGHTS ,WATER-FLAG> " full of icy water. Sheer walls
enclose it on all sides. In the ceiling is">)
		      (ELSE
		       <TELL
"Sheer walls rise for twenty feet above you and lean
inward to">)>
		<TELL " a narrow opening">
		<COND (<NOT <FSET? ,TRAP-DOOR ,OPENBIT>>
		       <TELL " covered with wooden planks">)>
		<COND (<ZERO? ,WATER-FLAG>
		       <COND (<ZERO? ,FREEZE-FLAG>
			      <TELL ". A small but fast-flowing ">)
			     (<EQUAL? ,FREEZE-FLAG 1>
			      <TELL ". A partially frozen ">)
			     (ELSE
			      <TELL ". A completely frozen ">)>
		       <TELL
"channel of water runs along the bottom of the chamber between two pipes">)
		      (<L? ,WATER-FLAG 4>
		       <TELL ". The water level is ">
		       <COND (<QUEUED? I-OUBLIETTE-FILLS>
			      <TELL "rising">)
			     (ELSE <TELL "falling">)>)>
		<TELL ,PERIOD>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<AND <VERB? PUT>
			    <ZERO? ,WATER-FLAG>
			    <EQUAL? ,PRSI ,WATER>>
		       <PERFORM ,PRSA ,PRSO ,OUBLIETTE-CHANNEL>
		       <RTRUE>)
		      (<AND <G? ,WATER-FLAG 0>
			    <OR <VERB? DROP THROW>
				<AND <VERB? PUT>
				     <EQUAL? ,PRSI ,WATER>>>>
		       <COND (<IDROP>
			      <REMOVE ,PRSO>
			      <TELL "Splash! Dropped." CR>)
			     (ELSE <RTRUE>)>)
		      (<AND <G? ,WATER-FLAG 0>
			    <OR <EQUAL? ,PRSO
					,INFLOW ,OUTFLOW ,OUBLIETTE-CHANNEL>
				<EQUAL? ,PRSI
					,INFLOW ,OUTFLOW ,OUBLIETTE-CHANNEL>>>
		       <TELL "It's under water!" CR>)
		      (<AND <VERB? THROUGH BOARD>
			    <EQUAL? ,PRSO ,WATER>>
		       <COND (<IN? ,PLAYER ,ICEBERG>
			      <PERFORM ,V?DISEMBARK ,ICEBERG>)
			     (<G? ,WATER-FLAG 0>
			      <TELL ,YOU-ARE ,PERIOD>)
			     (ELSE
			      <PERFORM ,PRSA ,OUBLIETTE-CHANNEL>)>
		       <RTRUE>)
		      (<AND <VERB? CLIMB-ON>
			    <EQUAL? ,PRSO ,TRAP-DOOR>>
		       <DO-WALK ,P?UP>
		       <RTRUE>)
		      (<AND <VERB? LEAP>
			    <EQUAL? ,PRSO ,WATER>
			    <IN? ,PLAYER ,ICEBERG>>
		       <PERFORM ,V?DISEMBARK>
		       <RTRUE>)>)
	       (<EQUAL? .RARG ,M-ENTER>
		<COND (<G? ,WATER-FLAG 0>
		       <TELL "You ">
		       <COND (<EQUAL? ,OHERE ,WATER-ROOM>
			      <TELL "emerge in">)
			     (ELSE
			      <TELL "plunge into the">)>
		       <TELL
" freezing water and frantically swim to the surface.">
		       <SOAK-PLAYER>
		       <CRLF>
		       <CRLF>)>
		<SETG FREEZE-COUNT 0>
		<RFALSE>)
	       (<EQUAL? .RARG ,M-LEAVE>
		<SETG FREEZE-COUNT 0>)
	       (<EQUAL? .RARG ,M-END>
		<COND (<AND <G? ,WATER-FLAG 0>
			    <NOT <IN? ,PLAYER ,ICEBERG>>>
		       <SOAK-PLAYER T>
		       <SETG FREEZE-COUNT <+ ,FREEZE-COUNT 1>>
		       <COND (<EQUAL? ,FREEZE-COUNT 5>
			      <TELL CR
"Your body is becoming numb from the cold of the water." CR>)
			     (<EQUAL? ,FREEZE-COUNT 10>
			      <HYPOTHERMIA>)>)>)>>

<ROUTINE HYPOTHERMIA ()
	 <CRLF>
	 <JIGS-UP
"The nearly freezing water has overcome you. You die of
hypothermia.">>

<OBJECT ICEBERG
	(DESC "ice floe")
	(SYNONYM ICEFLOE FLOE ICEBERG BERG)
	(ADJECTIVE ICE SMALL FLAT)
	(ACTION ICEBERG-F)
	(FLAGS AN VEHBIT OPENBIT CONTBIT SURFACEBIT)
	(CAPACITY 200)>

<ROUTINE ICEBERG-F ("OPTIONAL" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-BEG>
		<COND (<OR <VERB? CLIMB-DOWN DISEMBARK>
			   <AND <VERB? LEAP>
				<EQUAL? ,PRSO ,WATER>>>
		       <MOVE ,WINNER ,HERE>
		       <TELL
"You reenter the freezing water." CR>)>)
	       (<NOT .RARG>
		<COND (<AND <VERB? BOARD SIT CLIMB-FOO CLIMB-ON STAND-ON>
			    <NOT <IN? ,WINNER ,ICEBERG>>>
		       <SETG FREEZE-COUNT 0>
		       <MOVE ,WINNER ,ICEBERG>
		       <TELL
"You scramble onto the ice floe." CR>)
		      (<VERB? RUB>
		       <TELL "It's cold." CR>)>)>>

<GLOBAL WATER-HEIGHTS
	<PLTABLE "one-quarter" "half" "three-quarters" "completely">>

<OBJECT INFLOW
	(IN OUBLIETTE)
	(DESC "inflow pipe")
	(SYNONYM PIPE PIPES)
	(ADJECTIVE INFLOW INPUT)
	(FLAGS NDESCBIT AN)
	(ACTION INFLOW-F)>

<ROUTINE TELL-ABOUT-PIPE ()
	 <TELL
CTHE ,PRSO " is ceramic, about a foot in diameter, and ">>

<ROUTINE INFLOW-F ()
	 <COND (<VERB? EXAMINE>
		<TELL-ABOUT-PIPE>
		<COND (<EQUAL? ,HERE ,OUBLIETTE ,IN-CHANNEL>
		       <TELL "is here
to let water into the channel, presumably for drinking and sanitary
purposes">)
		      (ELSE
		       <TELL "water is rushing through it">)>
		<TELL ,PERIOD>)
	       (<AND <VERB? THROUGH BOARD>
		     ,SMALL-FLAG>
		<TELL
"The current is too swift." CR>)
	       (ELSE
		<FLOW-HACKS>)>>

<ROUTINE FLOW-HACKS ()
	 <COND (<VERB? THROUGH BOARD>
		<TELL
"It's much too small for you to fit." CR>)
	       (<VERB? LOOK-INSIDE>
		<TELL
"It's dark and filled with rushing water, so you can't see much." CR>)
	       (<VERB? REACH-IN>
		<TELL
"The pipe extends as far as you can reach." CR>)
	       (<AND <VERB? PUT>
		     <HELD? ,PRSO>>
		<SWEPT-AWAY ,PRSO>)
	       (<AND <VERB? PLUG>
		     <HELD? ,PRSI>>
		<SWEPT-AWAY ,PRSI>)>>

<OBJECT OUTFLOW
	(IN OUBLIETTE)
	(DESC "outflow pipe")
	(SYNONYM PIPE PIPES)
	(ADJECTIVE OUTFLOW OUTPUT)
	(FLAGS NDESCBIT AN VEHBIT)
	(ACTION OUTFLOW-F)>

<ROUTINE OUTFLOW-F ("AUX" OUB?)
	 <SET OUB? <EQUAL? ,HERE ,IN-CHANNEL ,OUBLIETTE>>
	 <COND (<VERB? EXAMINE>
		<TELL-ABOUT-PIPE>
		<COND (.OUB?
		       <TELL
"permits water in the channel to exit the oubliette">)
		      (ELSE
		       <TELL "has water flowing out of it">)>
		<TELL ,PERIOD>)
	       (<AND <VERB? THROUGH BOARD>
		     ,SMALL-FLAG>
		<COND (<NOT <EQUAL? ,HERE ,OUBLIETTE ,RUINS-ROOM>>
		       <TELL
"It's almost inevitable, given the speed of the current." CR CR>)>
		<GOTO <COND (.OUB? ,IN-PIPE)
			    (ELSE ,IN-SEWER)>>)
	       (ELSE <FLOW-HACKS>)>>

<ROOM IN-CHANNEL
      (IN ROOMS)
      (DESC "In Channel")
      (UP TO OUBLIETTE)
      (WEST TO IN-PIPE)
      (EAST "The current is too strong." ;IN-PIPE-2)
      (ACTION IN-CHANNEL-F)
      (FLAGS RWATERBIT)
      (GLOBAL WATER WATER-PIPE)>

<ROUTINE IN-CHANNEL-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are in a fast flowing stream of very cold water. " ,LONG-PIPE-DESC-2 CR>)
	       (<EQUAL? .RARG ,M-ENTER>
		<FUN-IN-PIPE>)
	       (<EQUAL? .RARG ,M-END>
		<SOAK-IF-OPENED>)>>

<ROUTINE SOAK-PLAYER ("OPTIONAL" (END? <>))
	 <COND (<SOAK-STUFF ,PLAYER>
		<COND (<NOT .END?> <TELL " ">)>
		<TELL
"Some of your possessions have been damaged by the water.">
		<COND (.END? <CRLF>)>
		<RTRUE>)>>

<ROUTINE SOAK-IF-OPENED ()
	 <COND (<AND <VERB? OPEN>
		     <SOAK-STUFF ,PRSO>>
		<TELL
"Oh, no! Something has been damaged as water rushed into ">
		<THE-PRSO>)>>

<OBJECT WATER-PIPE
	(IN LOCAL-GLOBALS)
	(DESC "pipe")
	(SYNONYM PIPE CHANNEL)
	(ADJECTIVE CERAMIC INFLOW OUTFLOW)
	(FLAGS NDESCBIT VEHBIT)
	(ACTION WATER-PIPE-F)>

<ROUTINE WATER-PIPE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL-ABOUT-PIPE>
		<TELL "water flows from one end of it to the other.">
		<COND (<EQUAL? ,HERE ,IN-PIPE-2>
		       <TELL " A chunk has broken out of the pipe here.">)>
		<CRLF>)
	       (<AND <VERB? PUT>
		     <HELD? ,PRSO>
		     <EQUAL? ,PRSI ,WATER-PIPE>>
		<SWEPT-AWAY ,PRSO>)
	       (<AND <VERB? PLUG>
		     <HELD? ,PRSI>>
		<SWEPT-AWAY ,PRSI>)
	       (<VERB? THROUGH BOARD>
		<TELL ,YOU-ARE>
		<TELL ,PERIOD>)
	       (<VERB? DISEMBARK LEAVE>
		<COND (<EQUAL? ,HERE ,IN-CHANNEL ,RUINED-PIPE>
		       <DO-WALK ,P?UP>
		       <RTRUE>)
		      (ELSE
		       <TELL "There is no way out here." CR>)>)>>

<ROUTINE SWEPT-AWAY (OBJ)
	 <REMOVE .OBJ>
	 <TELL
"It drops into the water and is swept away by the current." CR>>

<OBJECT OUBLIETTE-CHANNEL
	(IN OUBLIETTE)
	(DESC "channel")
	(SYNONYM CHANNEL)
	(ADJECTIVE CERAMIC)
	(FLAGS NDESCBIT VEHBIT OPENBIT)
	(ACTION CHANNEL-F)>

<ROUTINE CHANNEL-F ()
	 <COND (<VERB? EXAMINE>
		<TELL-ABOUT-PIPE>
		<COND (<EQUAL? ,PRSO ,OUBLIETTE-CHANNEL>
		       <TELL "water rushes
through it from an inflow pipe at one end to an outflow pipe at the
other">)
		      (ELSE
		       <TELL "smashed at the
top where a huge pillar destroyed the paving above it">)>
		<TELL ,PERIOD>)
	       (<VERB? THROUGH BOARD>
		<COND (,SMALL-FLAG
		       <GOTO <COND (<EQUAL? ,PRSO ,OUBLIETTE-CHANNEL>
				    ,IN-CHANNEL)
				   (ELSE ,RUINED-PIPE)>>)
		      (ELSE
		       <TELL
"Trying to wet your tootsies, eh? Well, you dabble your feet in the water
for a while, but they get pretty cold, and water splashes on the floor." CR>)>)
	       (<AND <VERB? PUT> <HELD? ,PRSO>>
		<SWEPT-AWAY ,PRSO>)
	       (<AND <VERB? PLUG> <HELD? ,PRSI>>
		<SWEPT-AWAY ,PRSI>)
	       (<AND <VERB? CASKLY> <EQUAL? ,PRSO ,RUINS-CHANNEL>>
		<TELL
"This channel was made as perfectly as the technology of the times allowed,
and even as a ruin, its essence is still perfect." CR>)>>

<ROOM IN-PIPE
      (IN ROOMS)
      (DESC "In Pipe")
      (EAST "The current is too strong." ;IN-CHANNEL)
      (WEST TO IN-PIPE-2)
      (ACTION IN-PIPE-F)
      (FLAGS RWATERBIT)
      (GLOBAL WATER WATER-PIPE)
      (THINGS <PSEUDO (MOSSY SLIME MOSS-PSEUDO)
		      (<> MOSS MOSS-PSEUDO)>)>

<ROUTINE MOSS-PSEUDO ()
	 <COND (<VERB? EXAMINE RUB>
		<TELL "It's green and slimy." CR>)>>

<ROUTINE IN-PIPE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL ,LONG-PIPE-DESC ,LONG-PIPE-DESC-2 CR>)
	       (<EQUAL? .RARG ,M-ENTER>
		<FUN-IN-PIPE>)
	       (<EQUAL? .RARG ,M-END>
		<SOAK-IF-OPENED>)>>

<ROOM IN-PIPE-2
      (IN ROOMS)
      (DESC "In Pipe")
      (EAST "The current is too strong." ;IN-PIPE)
      (WEST TO RUINED-PIPE)
      (ACTION IN-PIPE-2-F)
      (FLAGS RWATERBIT)
      (GLOBAL WATER WATER-PIPE)
      (THINGS <PSEUDO (MOSSY SLIME MOSS-PSEUDO)
		      (<> MOSS MOSS-PSEUDO)>)>

<GLOBAL LONG-PIPE-DESC
"You are inside a small ceramic pipe nearly filled with fast-flowing cold
water. The walls of the pipe are slippery and overgrown with mossy slime
wherever an irregularity shields the growth from the force of the water. ">

<GLOBAL LONG-PIPE-DESC-2
"Going east (against the current) would be nearly impossible. Going west
is almost unavoidable.">

<ROUTINE IN-PIPE-2-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL ,LONG-PIPE-DESC
"On the north side of the pipe is such an irregularity: a large chunk has
been knocked out of the pipe, and the slime and moss grows abundantly. ">
		<COND (<IN? ,CHANGE-CUBE ,CHUNK>
		       <TELL
"Inside, covered with moss and slime, is something large, white, and
apparently cubical. ">)>
		<TELL ,LONG-PIPE-DESC-2 CR>)
	       (<EQUAL? .RARG ,M-ENTER>
		<FUN-IN-PIPE>)
	       (<EQUAL? .RARG ,M-END>
		<SOAK-IF-OPENED>)>>

<OBJECT CHUNK
	(IN IN-PIPE-2)
	(DESC "crack")
	(SYNONYM CRACK CHUNK)
	(ADJECTIVE MOSSY SLIMY)
	(FLAGS NDESCBIT OPENBIT CONTBIT TRANSBIT SEARCHBIT)
	(ACTION CHUNK-F)>

<ROUTINE CHUNK-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"A weak spot in the pipe has broken away here, making a smallish crack that
has filled with slime and moss.">
		<COND (<IN? ,CHANGE-CUBE ,CHUNK>
		       <TELL
" There is a large white object partially obscured by the growth. It
is held in the crack by the force of the current.">)>
		<CRLF>)
	       (<VERB? REACH-IN RUB>
		<TELL "You reach into the crack and touch ">
		<COND (<IN? ,CHANGE-CUBE ,CHUNK>
		       <TELL
"the cube. Don't you want to take it, too?">)
		      (ELSE <TELL "moss.">)>
		<CRLF>)
	       (<VERB? THROUGH BOARD>
		<TELL
"It's too small to enter. It's large enough to reach into, though." CR>)
	       (<AND <VERB? PUT> <EQUAL? ,PRSI ,CHUNK>>
		<COND (<FIRST? ,PRSI>
		       <TELL ,NO-ROOM CR>)
		      (<GETPT ,PRSO ,P?NAME>
		       <REMOVE ,PRSO>
		       <TELL
"You put " THE ,PRSO " in the crack, but the moss won't hold it in any
longer, and the current carries it away before you can retrieve it." CR>)>)>>	

<ROOM RUINED-PIPE
      (IN ROOMS)
      (DESC "Ruined Pipe")
      (EAST "The current is too strong." ;IN-PIPE-2)
      (WEST TO IN-SEWER)
      (UP TO RUINS-ROOM)
      (OUT TO RUINS-ROOM)
      (ACTION RUINED-PIPE-F)
      (FLAGS RWATERBIT)
      (GLOBAL WATER WATER-PIPE)>

<ROUTINE RUINED-PIPE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The pipe here is smashed from the top where a huge pillar has toppled
over onto it. Cyclopean ruins are all around you. The cracks and fissures
in the pipe might make it possible to climb out here. The water is fast
and loud around you." CR>)
	       (<EQUAL? .RARG ,M-ENTER>
		<FUN-IN-PIPE>)
	       (<EQUAL? .RARG ,M-END>
		<SOAK-IF-OPENED>)>>

<ROUTINE FUN-IN-PIPE ()
	 <QUEUE I-DOWNSTREAM 3>
	 <COND (<EQUAL? ,OHERE ,OUBLIETTE ,RUINS-ROOM>
		<TELL "You enter the cold, fast-flowing water.">
		<SOAK-PLAYER>
		<CRLF>
		<CRLF>)>>

<ROOM IN-SEWER
      (IN ROOMS)
      (DESC "In Pipe")
      (EAST "The current is too strong." ;RUINED-PIPE)
      (ACTION IN-SEWER-F)
      (FLAGS RWATERBIT)
      (GLOBAL WATER WATER-PIPE)>

<ROUTINE IN-SEWER-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<JIGS-UP
"The water swirls down the pipe, its angle of descent increasing until
it tumbles over a precipice. You are buffeted back and forth, flipping
over, headfirst one second, feetfirst the next. At last, dizzy and
confused, you are dashed against the rocks at the bottom of the cistern.">)>>

<ROOM PRISON
      (IN ROOMS)
      (DESC "Dungeon")
      (DOWN PER PRISON-DOWN-EXIT ;OUBLIETTE)
      (UP TO GUARD-TOWER)
      (EAST TO CELL-HALL-EAST)
      (ACTION PRISON-F)
      (FLAGS RLANDBIT)
      (GLOBAL TRAP-DOOR STAIRS EAST-WALL)
      (THINGS <PSEUDO (<> SLIME MOSS-PSEUDO)
		      (<> MOSS MOSS-PSEUDO)
		      (<> FUNGUS MOSS-PSEUDO)>)>

<ROUTINE PRISON-DOWN-EXIT ()
	 <COND (<FSET? ,TRAP-DOOR ,OPENBIT>
		<COND (,WATER-FLAG ,OUBLIETTE)
		      (ELSE
		       <JIGS-UP
"You fall to your death on the stones below.">
		       <RFALSE>)>)
	       (ELSE
		<TELL-OPEN-CLOSED ,TRAP-DOOR>
		<RFALSE>)>>

<ROUTINE PRISON-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a dark, dank, forgotten dungeon. It is overgrown with moss, fungus,
and slime. The floor is slippery. At your feet ">
		<COND (<FSET? ,TRAP-DOOR ,OPENBIT>
		       <TELL "an open trap door leads down into blackness.">)
		      (ELSE
		       <TELL "is a closed trap door.">)>
		<TELL
" A corridor leads east and stairs lead up." CR>)>>

<OBJECT TRAP-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "trap door")
	(SYNONYM DOOR OPENING)
	(ADJECTIVE TRAP OAK NARROW)
	(FLAGS DOORBIT)
	(ACTION TRAP-DOOR-F)>

<ROUTINE TRAP-DOOR-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"This is a sturdy oak trap door, but it is obviously rarely used, as it
is covered with mold, cobwebs, and dirt. ">
		<TELL-OPEN-CLOSED ,TRAP-DOOR>)
	       (<VERB? OPEN CLOSE>
		<COND (<NOT <EQUAL? ,HERE ,OUBLIETTE>> <RFALSE>)
		      (<OR <L? ,WATER-FLAG 4>
			   <NOT <IN? ,PLAYER ,ICEBERG>>>
		       <CANT-REACH-IT>)
		      (ELSE
		       <OPEN-CLOSE>)>)
	       (<AND <VERB? REZROV> <NOT <FSET? ,TRAP-DOOR ,OPENBIT>>>
		<FSET ,TRAP-DOOR ,OPENBIT>
		<TELL
"The trap door creaks open upon rusty hinges." CR>)
	       (<VERB? THROUGH BOARD>
		<DO-WALK <COND (<EQUAL? ,HERE ,PRISON>
				,P?DOWN)
			       (ELSE ,P?UP)>>)>>

<ROOM CELL-HALL-EAST
      (IN ROOMS)
      (DESC "Dungeon East End")
      (LDESC
"The hall ends at a blank wall, but a cell lies to the north. There
is no door on the cell.")
      (WEST TO PRISON)
      (NORTH TO CELL-EAST)
      (FLAGS RLANDBIT)
      (THINGS <PSEUDO (<> CELL CELL-PSEUDO)>)>

<ROOM CELL-EAST
      (IN ROOMS)
      (DESC "Dungeon Cell")
      (LDESC
"This was once a very luxurious cell, obviously for the imprisonment of a
highborn or powerful person. Its rich hangings are now rotten rags; its
furniture is smashed to kindling, except for one massive oak cabinet.
The cell door has been blown away by an explosion, or perhaps a \"rezrov\"
spell.")
      (SOUTH TO CELL-HALL-EAST)
      (FLAGS RLANDBIT)
      (THINGS <PSEUDO (<> CELL CELL-PSEUDO)
		      (ROTTEN RAGS PLURAL-PSEUDO)
		      (RICH HANGINGS PLURAL-PSEUDO)>)>

<OBJECT CABINET
	(IN CELL-EAST)
	(DESC "massive cabinet")
	(SYNONYM CABINET BUREAU)
	(ADJECTIVE MASSIVE LARGE HUGE OAK)
	(FLAGS NDESCBIT CONTBIT VEHBIT LOCKED)
	(CAPACITY 20)
	(ACTION CABINET-F)>

<OBJECT PAST-CABINET
	(IN PAST-CELL-EAST)
	(DESC "massive cabinet")
	(SYNONYM CABINET BUREAU)
	(ADJECTIVE MASSIVE LARGE HUGE OAK)
	(FLAGS NDESCBIT CONTBIT VEHBIT LOCKED)
	(CAPACITY 20)
	(ACTION CABINET-F)>

<ROUTINE CABINET-F ("OPTIONAL" (RARG <>) "AUX" L)
	 <COND (<EQUAL? .RARG ,M-BEG>
		<SET L <LOC ,WINNER>>
		<COND (<AND <VERB? LOOK>
			    <NOT <FSET? .L ,OPENBIT>>>
		       <TELL-OPEN-CLOSED .L>)
		      (<VERB? WALK>
		       <TELL
,YOU-HAVE-TO " get out of the " 'CABINET " first" ,PERIOD>)
		      (<AND <VERB? DISEMBARK>
			    <NOT <FSET? .L ,OPENBIT>>>
		       <TELL-OPEN-CLOSED .L>)
		      (<AND <VERB? OPEN>
			    <NOT <FSET? ,PRSO ,OPENBIT>>>
		       <FSET ,PRSO ,OPENBIT>
		       <TELL "Opened." CR>)>)
	       (<NOT .RARG>
		<COND (<VERB? EXAMINE>
		       <TELL
"This massive cabinet fills most of one wall. It's made of oak and looks ">
		       <COND (<EQUAL? ,HERE ,CELL-EAST>
			      <TELL
"better preserved than anything else in the room. Its lock is corroded and
unusable. ">)
			     (ELSE
			      <TELL
"quite sturdy. It has a strong lock. ">)>
		       <TELL-OPEN-CLOSED ,PRSO>)
		      (<VERB? BOARD>
		       <COND (<NOT <FSET? ,PRSO ,OPENBIT>>
			      <TELL-OPEN-CLOSED ,PRSO>)
			     (<NOT ,SHRINK-FLAG>
			      <TELL
"You're too big. It isn't very deep." CR>)>)
		      (<VERB? HIDE>
		       <TELL ,NO-ROOM CR>)
		      (<AND <VERB? OPEN>
			    <FSET? ,PRSO ,LOCKED>>
		       <TELL
"The cabinet is locked." CR>)
		      (<AND <VERB? LOCK UNLOCK>
			    <EQUAL? ,HERE ,CELL-EAST>>
		       <TELL
"The lock has corroded into a mass of rust." CR>)
		      (<AND <VERB? UNLOCK>
			    <EQUAL? ,PRSI ,KEY>>
		       <COND (,FAKE-KEY
			      <TELL
"As you insert the key into the lock, it disappears, and a vision of Belboz
materializes before you!" CR>
			      <FORLORN-ENCYSTMENT>)
			     (ELSE
			      <FCLEAR ,PRSO ,LOCKED>
			      <TELL "Unlocked." CR>)>)
		      (<AND <VERB? LOCK>
			    <EQUAL? ,PRSI ,KEY>>
		       <COND (<FSET? ,PRSO ,RMUNGBIT>
			      <TELL "The lock has been burst." CR>)
			     (<NOT <FSET? ,PRSO ,LOCKED>>
			      <FCLEAR ,CABINET ,OPENBIT>
			      <FSET ,PRSO ,LOCKED>
			      <TELL "Locked." CR>)
			     (ELSE
			      <TELL "It already is." CR>)>)
		      (<AND <VERB? REZROV>
			    <NOT <FSET? ,PRSO ,OPENBIT>>>
		       <FSET ,PRSO ,RMUNGBIT>
		       <FCLEAR ,PRSO ,LOCKED>
		       <FSET ,PRSO ,OPENBIT>
		       <TELL
"The cabinet bursts open">
		       <COND (<AND <NOT <IN? ,PLAYER ,CABINET>>
				   <FIRST? ,PRSO>>
			      <TELL ", revealing ">
			      <PRINT-CONTENTS ,PRSO>)>
		       <TELL "!" CR>)>)>>

<OBJECT KEY
	(IN BELBOZ)
	(DESC "wrought iron key")
	(SYNONYM KEY)
	(ADJECTIVE WROUGHT IRON)
	(SIZE 1)
	(FLAGS TAKEBIT TOOLBIT NDESCBIT)>

<OBJECT DEAD-BOOK
	(IN CABINET)
	(DESC "moldy book")
	(SYNONYM BOOK)
	(ADJECTIVE ROTTEN MOLDY OLD)
	(FLAGS TAKEBIT READBIT SCROLLBIT CONTBIT OPENBIT
	       SEARCHBIT RMUNGBIT MAGICBIT)
	(ACTION DEAD-BOOK-F)>

<ROUTINE DEAD-BOOK-F ("AUX" SPELL)
	 <COND (<VERB? EXAMINE READ OPEN>
		<TELL
"This book has been almost completely destroyed by mold and rot. You
can tell only that it was once a " 'SPELL-BOOK ".">
		<COND (<FSET? ,PRSO ,RMUNGBIT>
		       <TELL " None of the spells are
legible any longer.">)
		      (<IN? ,SNAVIG-SPELL ,DEAD-BOOK>
		       <TELL " Only one spell is still readable. It says
\"" 'SNAVIG-SPELL ": " <GETP ,SNAVIG-SPELL ,P?TEXT> ".\"">)>
		<CRLF>)
	       (<VERB? CASKLY>
		<COND (<FSET? ,DEAD-BOOK ,RMUNGBIT>
		       <TELL
"The book glows brightly for a moment. ">
		       <COND (<FSET? ,HERE ,RWATERBIT>
			      <TELL "The water quenches it immediately">)
			     (ELSE
			      <FCLEAR ,DEAD-BOOK ,RMUNGBIT>
			      <MOVE ,SNAVIG-SPELL ,DEAD-BOOK>
			      <SETG SCORE <+ ,SCORE ,DEAD-BOOK-SCORE>>
			      <SETG DEAD-BOOK-SCORE 0>
			      <TELL "The mold and rot retreat
as you watch. While not good as new, the book looks much better">)>
		       <TELL ,PERIOD>)>)
	       (<VERB? GNUSTO>
		<COND (<NOT <IN? ,PRSO ,WINNER>>
		       <TELL
"You must be holding the book to copy from it!" CR>)
		      (<SET SPELL <FIRST? ,PRSO>>
		       <PERFORM ,V?GNUSTO .SPELL>
		       <RTRUE>)
		      (ELSE
		       <TELL "There's no spell in ">
		       <THE-PRSO>)>)>>

<GLOBAL DEAD-BOOK-SCORE 15>

<ROUTINE CELL-PSEUDO ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<TELL ,IT-LOOKS-LIKE "a prison cell." CR>)
	       (<VERB? THROUGH>
		<DO-WALK ,P?NORTH>)
	       (<VERB? EXIT>
		<DO-WALK ,P?SOUTH>)>>

<ROOM GUARD-TOWER
      (IN ROOMS)
      (DESC "Guard Tower")
      (DOWN TO PRISON)
      (UP "You'll need to flap your wings harder than that.")
      (ACTION GUARD-TOWER-F)
      (FLAGS RLANDBIT OUTSIDE ONBIT)
      (THINGS
       <PSEUDO (<> MOUNTAIN MOUNTAIN-PSEUDO)
	       (GUARD TOWER RANDOM-PSEUDO)
	       (DISTANT VOLCANO MOUNTAIN-PSEUDO)
	       (<> TARN RANDOM-PSEUDO)
	       (<> TARNS PLURAL-PSEUDO)
	       (TWISTED TREE RANDOM-PSEUDO)
	       (LOW TREES PLURAL-PSEUDO)>)>

<ROUTINE GUARD-TOWER-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is the guard tower of a crumbling castle. It overlooks a
mountainous landscape of tarns, tumbled rock, and twisted low trees. The
vegetation is in browns, blacks, and ochres. The only real color is
provided by a distant volcano which lights the lowering clouds with
bright red and yellow coruscations. The only exit is down." CR>)
	       (<EQUAL? .RARG ,M-ENTER>
		<SETG SEEN-TOWER? T>
		<MOVE ,ROC ,HERE>
		<SETG ROC-COUNT 0>
		<QUEUE I-ROC -1>)>>

<GLOBAL SEEN-TOWER? <>>

<ROUTINE ROC-GRABS-PLAYER ("OPTIONAL" (FALL? <>))
	 <MOVE ,ROC ,HERE>
	 <MOVE ,PLAYER ,ROC>
	 <SETG ROC-FLY-COUNT 0>
	 <SETG FALLING? <>>
	 <DEQUEUE I-FALLING>
	 <QUEUE I-ROC-FLY -1>
	 <CRLF>
	 <COND (.FALL?
		<TELL
"Suddenly, from above, you are hit by a crashing blow! You twist and see that
a huge bird has taken you in its talons. The">)
	       (ELSE
		<TELL
"The bird dives for you, its talons outstretched. As it nears, you
realize that rather than vulture or even condor size, the">)>
	 <TELL " bird is nearly
the size of an elephant. It closes its huge claws gently around
you, squawks (nearly suffocating you with its fetid breath), and takes
off towards the west." CR>>

<OBJECT ROC
	(DESC "roc")
	(SYNONYM ROC BIRD DOT TALONS)
	(ADJECTIVE HUGE LARGE TINY BLACK)
	(FLAGS THE PERSON VEHBIT CONTBIT OPENBIT)
	(DESCFCN ROC-DESC)
	(ACTION ROC-F)>

<ROUTINE DESCRIBE-ROC ()
	 <TELL <GET ,ROC-DESCS <- ,ROC-COUNT 1>> CR>>

<ROUTINE ROC-DESC (RARG OBJ)
	 <COND (<EQUAL? ,HERE ,GUARD-TOWER> <RTRUE>)
	       (<EQUAL? ,HERE ,ROC-NEST>
		<TELL
"The roc perches on the side of the nest, watching you intently." CR>)>>

<ROUTINE ROC-GRIPS-YOU-FIRMLY ("OPTIONAL" (SPELL? <>))
	 <TELL
"The roc grips you firmly in its talons. Your ">
	 <COND (.SPELL? <TELL "attempts to cast a spell">)
	       (ELSE <TELL "struggles">)>
	 <TELL " just make it hold you tighter." CR>>

<ROUTINE ROC-F ("OPTIONAL" (RARG <>))
	 <COND (<EQUAL? ,WINNER ,ROC>
		<TELL
"The roc is intent upon its ">
		<COND (<EQUAL? ,HERE ,ROC-NEST>
		       <COND (<IN? ,BABY-ROC ,HERE> 
			      <TELL "chick">)
			     (ELSE <TELL "egg">)>)
		      (ELSE <TELL "mission">)>
		<TELL ,PERIOD>
		<END-QUOTE>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<VERB? DROP> <DROP-IN-AIR>)
		      (<VERB? BOARD>
		       <COND (<EQUAL? ,PRSO ,ROC>
			      <TELL "It would rather carry you." CR>)
			     (ELSE
			      <ROC-GRIPS-YOU-FIRMLY>)>)
		      (<SPELL-VERB?>
		       <ROC-GRIPS-YOU-FIRMLY T>)
		      (<VERB? WALK LEAP DISEMBARK CLIMB-DOWN SIT>
		       <ROC-GRIPS-YOU-FIRMLY>)>)
	       (<NOT .RARG>
		<COND (<AND <HOSTILE-VERB?>
			    <IN? ,PLAYER ,ROC>>
		       <TELL
"The roc twists its ugly head around, squawks at you warningly, and
continues flying." CR>)
		      (<VERB? EXAMINE>
		       <COND (<IN? ,PLAYER ,ROC>
			      <TELL
"The roc is a female of enormous size. It resembles a huge raptor, such
as an eagle or perhaps a falcon, but the size of a house. It doesn't
smell very good and is infested with fleas." CR>)
			     (<AND <EQUAL? ,HERE ,GUARD-TOWER>
				   <G? ,ROC-COUNT 0>>
			      <TELL ,IT-LOOKS-LIKE "a ">
			      <DESCRIBE-ROC>)
			     (ELSE
			      <TELL
"The roc is a huge raptor and resembles an eagle." CR>)>)
		      (<AND <EQUAL? ,HERE ,GUARD-TOWER>
			    <L? ,ROC-COUNT 4>>
		       <TELL ,TOO-FAR>)
		      (<VERB? GIVE>
		       <COND (<EQUAL? ,PRSO ,FISH>
			      <GOBBLES-IT>)
			     (ELSE
			      <UNINTERESTED ,ROC>)>)
		      (<VERB? SMELL>
		       <TELL
"The roc smells like old, rotting meat. As it's a scavenger,
this is to be expected." CR>)
		      (<VERB? BOARD SIT CLIMB-UP CLIMB-FOO>
		       <COND (<NOT <IN? ,PLAYER ,ROC>>
			      <TELL
"The roc isn't interested in carrying you any more." CR>)>)
		      (<VERB? YOMIN>
		       <TELL
"You sense a strong maternal urge." CR>)
		      (<VERB? ESPNIS SNAVIG LISKON GIRGOL>
		       <ROC-SQUAWKS>)>)>>

<ROUTINE GOBBLES-IT ()
	 <REMOVE ,PRSO>
	 <TELL
CTHE ,PRSI " gobbles it down." CR>>

<ROOM ROC-NEST
      (IN ROOMS)
      (DESC "In Roc Nest")
      (ACTION ROC-NEST-F)
      (OUT "The nest is perched on a pinnacle of rock. It's a long way down.")
      (FLAGS RLANDBIT OUTSIDE ONBIT)
      (THINGS
       <PSEUDO (<> MOUNTAIN MOUNTAIN-PSEUDO)
	       (ROC NEST NEST-PSEUDO)
	       (TREE TRUNK RANDOM-PSEUDO)
	       (SMALL BUSH RANDOM-PSEUDO)
	       (BLACK FEATHER RANDOM-PSEUDO)
	       (ROC GUANO RANDOM-PSEUDO)>)>

<ROUTINE NEST-PSEUDO ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<COND (<OR <NOT <EQUAL? ,HERE ,MIDAIR ,ROC-NEST>>
			   <NOT <ZERO? ,NS-COUNT>>
			   <NOT <ZERO? ,EW-COUNT>>>
		       <TELL
,YOU-CANT-SEE "a nest here." CR>
		       <RTRUE>)
		      (ELSE
		       <TELL ,IT-LOOKS-LIKE "a ">
		       <COND (<EQUAL? ,HERE ,ROC-NEST>
			      <TELL "huge mass of trees woven together.">)
			     (ELSE
			      <TELL "giant bird's nest.">
			      <COND (<FIRST? ,ROC-NEST>
				     <TELL
" There are some things in the nest.">)>)>
		       <CRLF>)>)
	       (<VERB? DROP DISEMBARK LEAVE>
		<DO-WALK <COND (<IN? ,PLAYER ,MAGIC-CARPET> ,P?UP)
			       (ELSE ,P?OUT)>>)>>

<ROUTINE ROC-NEST-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This nest is made from skillfully woven tree trunks, small bushes, and
large amounts of mud and roc guano for glue. Giant black feathers are
everywhere. In the center of the nest ">
		<COND (<FSET? ,EGG ,RMUNGBIT>
		       <TELL
"is a hungry baby roc and the fragments of a hatched egg">)
		      (ELSE
		       <TELL "is an egg the size of a small wagon">)>
		<COND (<AND <NOT <FSET? ,CONNECTIVITY-CUBE ,TOUCHBIT>>
			    <NOT <FSET? ,EGG ,RMUNGBIT>>>
		       <TELL
". Nestled beneath the egg is a " ,WHITE-CUBE>)>
		<TELL ,PERIOD>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<AND <VERB? LEAP>
			    <EQUAL? ,PRSO <> ,ROOMS>>
		       <DO-WALK ,P?OUT>)
		      (<VERB? LOOK-DOWN>
		       <TELL
"It's a long, unclimbable way down." CR>)
		      (<AND <VERB? TAKE>
			    <EQUAL? ,PRSO ,CONNECTIVITY-CUBE>
			    <NOT <FSET? ,EGG ,RMUNGBIT>>
			    <IN? ,ROC ,HERE>
			    <NOT <EQUAL? ,TIME-STOPPED? ,HERE>>>
		       <TELL
"The roc, convinced you are threatening its precious egg, drives you away
before you can snatch the cube." CR>)>)
	       (<EQUAL? .RARG ,M-ENTER>
		<COND (<AND <NOT <IN? ,ROC ,HERE>>
			    <NOT <FSET? ,EGG ,RMUNGBIT>>
			    <NOT <QUEUED? I-ROC-HATCHES>>>
		       <QUEUE I-ROC-HATCHES 5>)
		      (<IN? ,BABY-ROC ,HERE>
		       <JIGS-UP
"You arrive in the roc's nest. The baby roc,
ravenous like all young birds, gobbles you down.">)>)>>

<OBJECT EGG
	(IN ROC-NEST)
	(DESC "roc egg")
	(SYNONYM EGG)
	(ADJECTIVE ROC)
	(FLAGS NDESCBIT)
	(ACTION EGG-F)>

<ROUTINE EGG-F ("AUX" (MOM? <>))
	 <COND (<FSET? ,EGG ,RMUNGBIT>
		<TELL "There isn't much of the egg left to deal with." CR>)
	       (<VERB? EXAMINE>
		<TELL
,IT-LOOKS-LIKE "it's going to hatch soon." CR>)
	       (<VERB? LOOK-UNDER>
		<TELL
"There's dirt, guano, detritus, and ">
		<COND (<FSET? ,CONNECTIVITY-CUBE ,TOUCHBIT>
		       <TELL "feathers">)
		      (ELSE
		       <TELL "a " 'CONNECTIVITY-CUBE>)>
		<TELL " there." CR>)
	       (<OR <HOSTILE-VERB?> <VERB? OPEN>>
		<COND (<IMMOBILIZED?> <RTRUE>)
		      (<IN? ,ROC ,HERE>
		       <TELL
"The mother roc prevents you." CR>)
		      (ELSE
		       <DEQUEUE I-ROC-HATCHES>
		       <I-ROC-HATCHES T>)>)
	       (<VERB? ESPNIS SNAVIG LISKON GIRGOL>
		<ROC-SQUAWKS>)>>

<ROUTINE ROC-SQUAWKS ("AUX" (MOM? <>))
	 <COND (<IN? ,ROC ,HERE> <SET MOM? T>)>
	 <COND (<OR .MOM? <IN? ,BABY-ROC ,HERE>>
		<TELL
"The ">
		<COND (.MOM? <TELL "mother">)
		      (ELSE <TELL "baby">)>
		<TELL
" roc hears you preparing the spell and squawks at you so
raucously that your concentration is destroyed, and the spell misfires." CR>)>>

<OBJECT BABY-ROC
	(DESC "roc chick")
	(SYNONYM CHICK ROC)
	(ADJECTIVE ROC SMALL BABY)
	(FLAGS PERSON THE NDESCBIT)
	(ACTION BABY-ROC-F)>

<ROUTINE BABY-ROC-F ("AUX" (MOM? <>))
	 <COND (<VERB? EXAMINE>
		<TELL
"The roc chick is much larger than you, nearly featherless, and very
hungry." CR>)
	       (<VERB? TAKE>
		<TELL "It's only about three times your size." CR>)
	       (<AND <VERB? GIVE>
		     <HELD? ,PRSO>>
		<GOBBLES-IT>)
	       (<HOSTILE-VERB?>
		<TELL
"The baby roc defends itself quite successfully." CR>)
	       (<VERB? YOMIN>
		<TELL "You sense ravenous hunger." CR>)
	       (<VERB? ESPNIS SNAVIG LISKON GIRGOL>
		<ROC-SQUAWKS>)>>
