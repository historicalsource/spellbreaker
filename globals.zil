"GLOBALS for
			      MAGE
	(c) Copyright 1985 Infocom, Inc. All Rights Reserved."

<DIRECTIONS ;"Do not change the order of the first 8 without consulting MARC!"
 	    NORTH NE EAST SE SOUTH SW WEST NW UP DOWN IN OUT>

<SYNONYM NORTH N>
<SYNONYM SOUTH S>
<SYNONYM EAST E>
<SYNONYM WEST W>
<SYNONYM DOWN D>
<SYNONYM UP U>
<SYNONYM NE NORTHEAST>
<SYNONYM NW NORTHWEST>
<SYNONYM SE SOUTHEAST>
<SYNONYM SW SOUTHWEST>

<GLOBAL HERE <>>

<GLOBAL LIT <>>

<GLOBAL MOVES 0>

<GLOBAL SCORE 0>

<GLOBAL INDENTS
	<PTABLE ""
	        "  "
	        "    "
	        "      "
	        "        "
	        "          ">>

<GLOBAL DIR-TABLE
	<PLTABLE 1 P?NORTH "north"
		 2 P?EAST "east"
		 4 P?WEST "west"
		 8 P?SOUTH "south"
		 16 P?NE "northeast"
		 32 P?NW "northwest"
		 64 P?SE "southeast"
		 128 P?SW "southwest">>

<CONSTANT DIR-BIT 1>
<CONSTANT DIR-DIR 2>
<CONSTANT DIR-NAME 3>

<ROUTINE DIR-BASE (DIR I O "AUX" (L <GET ,DIR-TABLE 0>))
	 <DO (CNT 0 .L 3)
	     <COND (<EQUAL? <GET ,DIR-TABLE <+ .CNT .I>> .DIR>
		    <RETURN <GET ,DIR-TABLE <+ .CNT .O>>>)>>>

"global objects and associated routines"

<OBJECT GLOBAL-OBJECTS
	(FLAGS AN
	       BRIEFBIT
	       CONTBIT
	       DOORBIT
	       INVISIBLE
	       LOCKED
	       NDESCBIT
	       NOABIT
	       NOTHEBIT
	       ONBIT
	       OPENBIT
	       PERSON
	       RAIRBIT
	       READBIT
	       RLANDBIT
	       RMUNGBIT
	       RWATERBIT
	       SCROLLBIT
	       SEARCHBIT
	       SPELLBIT
	       SURFACEBIT
	       TAKEBIT
	       THE
	       TOOLBIT
	       TOUCHBIT
	       TRANSBIT
	       TRYTAKEBIT
	       VEHBIT
	       WEAPONBIT)>

<OBJECT LOCAL-GLOBALS
	(IN GLOBAL-OBJECTS)
	(SYNONYM ZZMGCK) ;"Yes, this needs to exist."
	;(DESCFCN 0)
        ;(GLOBAL GLOBAL-OBJECTS)
	;(FDESC "F")
	;(LDESC "F")
	;(PSEUDO "FOOBAR" V-WALK)
	;(SIZE 0)
	;(TEXT "")
	;(EXITS 0)
	;(CAPACITY 0)>

<OBJECT ROOMS
	(IN TO ROOMS)>

<OBJECT INTNUM
	(IN GLOBAL-OBJECTS)
	(DESC "number")
	(SYNONYM INTNUM)
	(ADJECTIVE NUMBER)>

<OBJECT PSEUDO-OBJECT
	(IN GLOBAL-OBJECTS)
	(DESC "pseudo")
	(ACTION ME-F)>

<OBJECT IT
	(IN GLOBAL-OBJECTS)
	(SYNONYM IT THEM OBJECT HIM)
	(ADJECTIVE HER)
	(DESC "it")
	(FLAGS AN NOABIT NOTHEBIT NDESCBIT TOUCHBIT)>

<OBJECT NOT-HERE-OBJECT
	(DESC "it")
	(FLAGS NOABIT NOTHEBIT)
	(ACTION NOT-HERE-OBJECT-F)>

<ROUTINE NOT-HERE-OBJECT-F ("AUX" TBL (PRSO? T) OBJ (X <>))
	 <COND (<AND <PRSO? ,NOT-HERE-OBJECT>
		     <PRSI? ,NOT-HERE-OBJECT>>
		<TELL "Those things aren't here!" CR>
		<RTRUE>)
	       (<PRSO? ,NOT-HERE-OBJECT>
		<SET TBL ,P-PRSO>
		<COND (<OR <VERB? FOLLOW LEARN WHAT>
			   <VERB? WHERE WHO WAIT-FOR>
			   <VERB? CAST WALK-TO FIND>>
		       <SET X T>)>
		%<DEBUG-CODE
		  <COND (<VERB? $BLORPLE $TAKE>
			 <SET X T>)>>)
	       (T
		<SET TBL ,P-PRSI>
		<COND (<VERB? ASK-ABOUT ASK-FOR TELL-ABOUT>
		       <SET X T>)>
		<SET PRSO? <>>)>
	 <COND (.X
		<COND (<SET OBJ <FIND-NOT-HERE .TBL .PRSO?>>
		       <COND (<NOT <EQUAL? .OBJ ,NOT-HERE-OBJECT>>
			      <RTRUE>)>)
		      (T
		       <RFALSE>)>
		<COND (<AND <NOT <VERB? FIND FOLLOW WHERE>>
			    <NOT <VERB? LEARN CAST>>>
		       <TELL ,MORE-SPECIFIC ", I'm afraid." CR>
		       <RTRUE>)>)>
	 ;"Here is the default 'cant see any' printer"
	 <COND (<EQUAL? ,WINNER ,PLAYER>
		<TELL "You">)
	       (ELSE
		<TELL CTHE ,WINNER>)>
	 <TELL " can't see">
	 <COND (<NOT <NAME? ,P-XNAM>> <TELL " any">)>
	 <NOT-HERE-PRINT .PRSO?>
	 <TELL " here." CR>
	 <END-QUOTE>>

<ROUTINE FIND-NOT-HERE (TBL PRSO? "AUX" M-F OBJ)
;"Special-case code goes here. <MOBY-FIND .TBL> returns # of matches. If 1,
then P-MOBY-FOUND is it. You can treat the 0 and >1 cases alike or differently.
Always return RFALSE (not handled) if you have resolved the problem."
	<SET M-F <MOBY-FIND .TBL>>
	%<DEBUG-CODE
	  <COND (,ZDEBUG
		 <TELL "[Found " N .M-F " obj]" CR>)>>
	<COND (<EQUAL? 1 .M-F>
	       %<DEBUG-CODE
		 <COND (,ZDEBUG
			<TELL "[Namely: " D ,P-MOBY-FOUND "]" CR>)>>
	       <COND (.PRSO?
		      <SETG PRSO ,P-MOBY-FOUND>)
		     (T
		      <SETG PRSI ,P-MOBY-FOUND>)>
	       <RFALSE>)
	      (T
	       ,NOT-HERE-OBJECT)>>

<ROUTINE NOT-HERE-PRINT (PRSO?)
	 <TELL " ">
	 <COND (,P-OFLAG
	        <COND (,P-XADJ
		       <PRINTB ,P-XADJN>)>
	        <COND (,P-XNAM
		       <PRINTB ,P-XNAM>)>)
               (ELSE
	        <THING-PRINT .PRSO?>)>>

<OBJECT LIGHT
	(IN GLOBAL-OBJECTS)
	(DESC "light")
	(SYNONYM LIGHT LIGHTS PHOTONS)
	(ADJECTIVE PILE)
        (ACTION LIGHT-F)>

<ROUTINE LIGHT-F ()
	 <COND (<VERB? LAMP-ON>
		<COND (<FSET? ,HERE ,ONBIT>
		       <TELL ,IT-IS-ALREADY "light" ,PERIOD>)
		      (T
		       <TELL
"Perhaps you should \"frotz\" something?" CR>)>)
	       (<VERB? LAMP-OFF>
		<TELL ,WASTE-OF-TIME>)
	       (<VERB? THROUGH>
		<COND (<EQUAL? ,HERE ,GRUE-CAVE ,PILLAR-ROOM>
		       <GOTO ,LIGHT-POOL>)>)
	       (<VERB? EXAMINE>
		<COND (<EQUAL? ,CHANGED? ,GRUE>
		       <COND (<EQUAL? ,HERE ,LIGHT-POOL>
			      <TELL
"The light is so bright and painful you can barely stand it." CR>)
			     (ELSE
			      <TELL
"It hurts to look at light so dim you could hardly discern it
normally." CR>)>)
		      (<EQUAL? ,HERE ,DARK-CAVE ,GRUE-CAVE>
		       <TELL
"The light is in a small, dimly glowing pile." CR>)>)>>

<OBJECT GLOBAL-HOLE
	(IN LOCAL-GLOBALS)
	(FLAGS NDESCBIT TOUCHBIT)
	(DESC "hole")
	(SYNONYM HOLE)
	(ADJECTIVE MUDDY)
	(GENERIC GENERIC-HOLE-F)
	(ACTION GLOBAL-HOLE-F)>

<ROUTINE GLOBAL-HOLE-F ()
	 <COND (<VERB? THROUGH LEAP CLIMB-DOWN>
		<DO-WALK ,P?DOWN>)
	       (<AND <VERB? PUT>
		     <HELD? ,PRSO>
		     <EQUAL? ,PRSI ,GLOBAL-HOLE>>
		<MOVE ,PRSO ,LOST-ON-LAND>
		<TELL
"You drop " THE ,PRSO " through the hole, and it disappears." CR>)
	       (<VERB? LOOK-INSIDE LOOK-DOWN>
		<TELL "You see clouds!" CR>)
	       (<VERB? REACH-IN>
		<TELL "You find nothing of interest." CR>)>>

<OBJECT CEILING
	(IN GLOBAL-OBJECTS)
	(FLAGS NDESCBIT TOUCHBIT)
	(DESC "ceiling")
	(SYNONYM CEILIN ROOF)
	(ACTION CEILING-F)>

<ROUTINE CEILING-F ()
	 <COND (<VERB? LOOK-UNDER>
		<PERFORM ,V?LOOK>
		<RTRUE>)>>

<OBJECT ICE
	(IN GLOBAL-OBJECTS)
	(DESC "ice")
	(SYNONYM ICE)
	(FLAGS NOABIT)
	(ACTION ICE-F)>

<GLOBAL ICED-OBJECT <>>

<ROUTINE ICE-F ()
	 <COND (<IN? ,ICEBERG ,HERE>
		<REDIRECT ,ICE ,ICEBERG>)
	       (<AND ,ICED-OBJECT <ACCESSIBLE? ,ICED-OBJECT>>
		<COND (<VERB? EXAMINE>
		       <TELL ,IT-LOOKS-LIKE "an icy " D ,ICED-OBJECT ,PERIOD>)
		      (<VERB? RUB>
		       <TELL "It's cold." CR>)>)
	       (<NOT <EQUAL? ,HERE ,GLACIER-ROOM>>
		<TELL "There is no ice here." CR>)>>

<OBJECT AIR
	(IN GLOBAL-OBJECTS)
	(DESC "air")
	(SYNONYM AIR)
	(FLAGS AN NOABIT)>

<OBJECT HANDS
	(IN GLOBAL-OBJECTS)
	(SYNONYM HANDS)
	(ADJECTIVE BARE)
	(DESC "your hand")
	(FLAGS NDESCBIT TOOLBIT TOUCHBIT NOABIT NOTHEBIT)>

<OBJECT HEAD
	(IN GLOBAL-OBJECTS)
	(DESC "your head")
	(SYNONYM HEAD FACE)
	(ADJECTIVE YOUR MY)
	(FLAGS NOABIT NOTHEBIT)>

<OBJECT EYES
	(IN GLOBAL-OBJECTS)
	(DESC "your eyes")
	(SYNONYM EYE EYES)
	(ADJECTIVE YOUR MY)
	(FLAGS NOABIT NOTHEBIT)
	(ACTION EYES-F)>

<ROUTINE EYES-F ()
	 <COND (<VERB? OPEN>
		<TELL "They are." CR>)
	       (<VERB? CLOSE>
		<TELL "That won't help." CR>)
	       (<NOT ,LIT>
		<TELL ,TOO-DARK>)
	       (<EQUAL? ,HERE ,NORTH-SNAKE-ROOM ,SOUTH-SNAKE-ROOM>
		<COND (<VERB? EXAMINE>
		       <TELL "The eye stares balefully at you." CR>)
		      (ELSE
		       <REDIRECT ,EYES ,SNAKE>)>)>>

<OBJECT PLAYER
	(IN COUNCIL-CHAMBER)
	(SYNONYM PROTAG)
	(DESC "it")
	(FLAGS NDESCBIT INVISIBLE)
	(ACTION PLAYER-F)>

<ROUTINE PLAYER-F ()
	 <COND (<NOT ,CHANGED?> <RFALSE>)
	       (<EQUAL? ,CHANGED? ,GROUPER>
		<COND (<VERB? WRITE OPEN CLOSE TAKE DROP PUT>
		       <TELL
"Your finny fins aren't capable of that." CR>)>)
	       (<EQUAL? ,CHANGED? ,GRUE>
		<COND (<VERB? SLAVER>
		       <TELL
"You do that very well for such an inexperienced grue." CR>)
		      (<AND <VERB? EAT> <HELD? ,PRSO>>
		       <REMOVE ,PRSO>
		       <TELL
"That tasted surprisingly good." CR>)>)
	       (<EQUAL? ,CHANGED? ,OGRE>
		<COND (<VERB? SMELL>
		       <TELL
"You are completely congested and can't smell a thing. This may explain
why, in spite of their appalling sanitary habits, ogres are not
extinct." CR>)>)>>

<OBJECT ME
	(IN GLOBAL-OBJECTS)
	(SYNONYM ME MYSELF I SELF)
	(DESC "yourself")
	(FLAGS PERSON TOUCHBIT NOABIT NOTHEBIT)
	(ACTION ME-F)>

<ROUTINE ME-F ("AUX" OLIT)
	 <COND (<AND <VERB? EXAMINE>
		     <EQUAL? ,PRSO ,ME>>
		<V-DIAGNOSE>)
	       (<VERB? TELL>
		<TELL
"Talking to yourself is a sign of impending mental collapse." CR>
		<END-QUOTE>)
	       (<VERB? LISTEN>
		<TELL "Yes?" CR>)
	       (<VERB? ALARM>
		<TELL ,YOU-ARE>
		<TELL ,PERIOD>)
	       (<VERB? GIVE>
		<COND (<EQUAL? ,PRSO ,ME>
		       <V-SQUEEZE>)
		      (<EQUAL? ,PRSI ,ME>
		       <COND (<IN? ,PRSO ,PLAYER>
			      <PRE-TAKE>)
			     (T
			      <PERFORM ,V?TAKE ,PRSO>
			      <RTRUE>)>)>)
	       (<VERB? MOVE>
		<V-WALK-AROUND>)
	       (<VERB? SEARCH>
		<V-INVENTORY>
		<RTRUE>)
	       (<VERB? KILL MUNG PLANT>
		<JIGS-UP "Done.">
		<RTRUE>)
	       (<VERB? WHO>
		<V-WHAT>)
	       (<VERB? FOLLOW>
		<TELL
"You're getting ahead of yourself." CR>)
	       (<VERB? WRITE WRITE-ON>
		<TELL
,YOU-ARENT "a tattoo artist!" CR>)
	       (<VERB? TINSOT>
		<TELL
"You are covered with a thin film of ice, which shatters as soon as you
move." CR>)
	       (<VERB? CASKLY>
		<V-SQUEEZE>)
	       (<VERB? YOMIN>
		<TELL
"You would know better than I." CR>)>>

<OBJECT GLOBAL-ROOM
	(IN GLOBAL-OBJECTS)
	(DESC "room")
	(SYNONYM ROOM CHAMBER PLACE)
	(ADJECTIVE AREA)
	(ACTION GLOBAL-ROOM-F)>

<ROUTINE GLOBAL-ROOM-F ()
	 <COND (<VERB? LOOK EXAMINE LOOK-INSIDE>
		<V-LOOK>
		<RTRUE>)
	       (<VERB? THROUGH WALK-TO>
		<V-WALK-AROUND>)
	       (<VERB? DROP LEAVE EXIT>
		<DO-WALK ,P?OUT>)
	       (<VERB? WALK-AROUND>
		<TELL
"Walking around the room reveals nothing new. To move elsewhere, just type
the desired direction." CR>)
	       (<VERB? LAMP-ON>
		<PERFORM ,V?LAMP-ON ,LIGHT>
		<RTRUE>)>>

<OBJECT NORTH-WALL
	(IN GLOBAL-OBJECTS)
	(DESC "north wall")
	(SYNONYM WALL)
	(ADJECTIVE NORTH)
	(ACTION WALL-F)
	(EXITS %,C-NORTH)
	(GENERIC GENERIC-RANDOM-F)>

<OBJECT EAST-WALL
	(IN GLOBAL-OBJECTS)
	(DESC "east wall")
	(SYNONYM WALL)
	(ADJECTIVE EAST BLANK)
	(ACTION WALL-F)
	(EXITS %,C-EAST)
	(GENERIC GENERIC-RANDOM-F)>

<OBJECT WEST-WALL
	(IN GLOBAL-OBJECTS)
	(DESC "west wall")
	(SYNONYM WALL)
	(ADJECTIVE WEST)
	(ACTION WALL-F)
	(EXITS %,C-WEST)
	(GENERIC GENERIC-RANDOM-F)>

<OBJECT SOUTH-WALL
	(IN GLOBAL-OBJECTS)
	(DESC "south wall")
	(SYNONYM WALL)
	(ADJECTIVE SOUTH)
	(ACTION WALL-F)
	(EXITS %,C-SOUTH)
	(GENERIC GENERIC-RANDOM-F)>

<OBJECT NE-WALL
	(IN GLOBAL-OBJECTS)
	(DESC "northeast wall")
	(SYNONYM WALL)
	(ADJECTIVE NE)
	(ACTION WALL-F)
	(EXITS %,C-NE)
	(GENERIC GENERIC-RANDOM-F)>

<OBJECT NW-WALL
	(IN GLOBAL-OBJECTS)
	(DESC "northwest wall")
	(SYNONYM WALL)
	(ADJECTIVE NW)
	(ACTION WALL-F)
	(EXITS %,C-NW)
	(GENERIC GENERIC-RANDOM-F)>

<OBJECT SE-WALL
	(IN GLOBAL-OBJECTS)
	(DESC "southeast wall")
	(SYNONYM WALL)
	(ADJECTIVE SE)
	(ACTION WALL-F)
	(EXITS %,C-SE)
	(GENERIC GENERIC-RANDOM-F)>

<OBJECT SW-WALL
	(IN GLOBAL-OBJECTS)
	(DESC "southwest wall")
	(SYNONYM WALL)
	(ADJECTIVE SW)
	(ACTION WALL-F)
	(EXITS %,C-SW)
	(GENERIC GENERIC-RANDOM-F)>

<ROUTINE WALL-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<AND <EQUAL? ,HERE ,MAZE-ANTEROOM>
			    <EQUAL? ,PRSO ,NORTH-WALL>
			    ,MAZE-EXIT-FLAG>
		       <TELL "There is a hole there." CR>)
		      (<NOT <ZERO? <GETPT ,HERE ,P?EXITS>>>
		       <TELL
"The wall is marble.">
		       <DESCRIBE-MAZE-WALLS>
		       <CRLF>)
		      (ELSE
		       <TELL ,IT-LOOKS-LIKE "a wall." CR>)>)>>

<OBJECT DIRT
	(IN GLOBAL-OBJECTS)
	(DESC "dirt")
	(SYNONYM RUBBLE DEBRIS DUST DIRT)
	(FLAGS NOABIT)>

<OBJECT GROUND
	(IN GLOBAL-OBJECTS)
	(SYNONYM FLOOR GROUND FIELD)
	(ADJECTIVE STONE SANDY TINY LEVEL)
	(DESC "ground")
	(FLAGS NOABIT)
	(ACTION GROUND-F)>

<ROUTINE GROUND-F ()
	 <COND (<VERB? EXAMINE>
		<COND (,FALLING?
		       <TELL
"You can see the ground rushing towards you from below, or vice versa." CR>)
		      (<FSET? ,HERE ,RAIRBIT>
		       <TELL
"It's a long way down." CR>)
		      (ELSE
		       <TELL
"It's still there." CR>)>)
	       (<AND <VERB? PUT>
		     <EQUAL? ,GROUND ,PRSI>>
		<COND (<EQUAL? ,PRSO ,WEED>
		       <PERFORM ,V?PLANT ,WEED>)
		      (ELSE
		       <PERFORM ,V?DROP ,PRSO>)>
		<RTRUE>)
	       (<VERB? CLIMB-UP CLIMB-ON CLIMB-FOO BOARD>
		<TELL ,WASTE-OF-TIME>)
	       (<VERB? LOOK-UNDER>
		<TELL "You've never mastered an X-ray vision spell." CR>)>>

<OBJECT CORRIDOR
	(IN GLOBAL-OBJECTS)
	(DESC "passage")
	(SYNONYM PASSAGE CORRIDOR EXIT)
	(ADJECTIVE LONG DARK)
	(ACTION CORRIDOR-F)>

<ROUTINE CORRIDOR-F ()
	 <COND (<VERB? THROUGH WALK-TO>
		<V-WALK-AROUND>)>>

<OBJECT WALLS
	(IN GLOBAL-OBJECTS)
	(DESC "wall")
	(SYNONYM WALL WALLS)
	(FLAGS NDESCBIT TOUCHBIT)
	(ACTION WALLS-F)>

<ROUTINE WALLS-F ()
	 <COND (<FSET? ,HERE ,RAIRBIT>
		<TELL "What wall?" CR>)>>

<OBJECT GLOBAL-GRUE
	(IN GLOBAL-OBJECTS)
	(SYNONYM GRUE)
	(ADJECTIVE LURKIN SINIST SILENT)
	(DESC "lurking grue")
	(ACTION GLOBAL-GRUE-F)
	(FLAGS NDESCBIT THE PERSON)>

<GLOBAL LURKING " lurking in the darkness nearby.">

<ROUTINE GLOBAL-GRUE-F ()
	 <COND (<EQUAL? ,WINNER ,GLOBAL-GRUE>
		<TELL
"There is no answer.">
		<END-QUOTE>)
	       (<VERB? WHAT>
		<TELL
"Grues are darkness-loving, enchanterivorous monsters." CR>)
	       (<OR <HOSTILE-VERB?>
		    <VERB? EXAMINE RAISE LOWER SMELL TAKE LOOK-UNDER>>
		<CANT-SEE-GRUE>)
	       (<VERB? WHERE>
		<TELL
"There is no grue here, but I'm sure there is at least one" ,LURKING " I'd
stay near a light source if I were you!" CR>)
	       (<VERB? LISTEN>
		<TELL
"It makes no sound but is always" ,LURKING CR>)
	       (<VERB? FROTZ>
		<COND (,LIT
		       <TELL "There aren't any grues here -- it's light!" CR>)
		      (T
		       <TELL
"There's a flash of light nearby, and you glimpse a horrible, multifanged
creature, a look of sheer terror on its face. It charges away, gurgling in
agony, tearing at its glowing fur." CR>)>)
	       (<VERB? SNAVIG>
		<CANT-SEE-GRUE>)
	       (<SPELL-VERB?>
		<TELL
"Nothing happens. Either there are no grues nearby, or they were able to
dodge in time." CR>)>>

<ROUTINE CANT-SEE-GRUE ()
	 <TELL ,YOU-CANT-SEE "any grue here (thankfully)." CR>>

<OBJECT GRUE
	(IN LOCAL-GLOBALS)
	(SYNONYM GRUE GRUES TROOP SHAPES)
	(ADJECTIVE LURKIN SINIST SILENT)
	(DESC "grue")
	(FLAGS NDESCBIT THE PERSON)
	(ACTION GRUE-F)>

<ROUTINE GRUE-F ("AUX" OLIT)
	 <COND (<AND <NOT <EQUAL? ,CHANGED? ,GRUE>>
		     <NOT <EQUAL? ,HERE ,GRUE-CAVE ,PILLAR-ROOM ,LIGHT-POOL>>>
		<REDIRECT ,GRUE ,GLOBAL-GRUE>)
	       (<EQUAL? ,WINNER ,GRUE>
		<COND (<EQUAL? ,CHANGED? ,GRUE>
		       <JIGS-UP
"Your inability to speak grue, not to mention your use of a human
tongue, arouses the grues and seals your fate.">)
		      (ELSE
		       <CALLED-ATTENTION>)>
		<END-QUOTE>)
	       (<VERB? EXAMINE LOOK-UNDER>
		<COND (,LIT
		       <TELL
"The grues look exactly as you would expect, only worse." CR>)
		      (ELSE
		       <GLOBAL-GRUE-F>)>)
	       (<AND <VERB? GIVE>
		     <EQUAL? ,PRSI ,GRUE>>
		<COND (<FSET? ,PRSO ,ONBIT>
		       <GRUES-NOTICE-LIGHT>)
		      (ELSE
		       <REMOVE ,PRSO>
		       <COND (<EQUAL? ,PRSO ,BREAD ,FISH>
			      <TELL
"The grue snarls at you, but takes it anyway">)
			     (ELSE
			      <TELL
"It looks quizzically at the " 'PRSO ", then snatches it">)>
		       <TELL " and noisily wolfs it down, teeth
tearing it into tiny gobbets." CR>)>)
	       (<OR <HOSTILE-VERB?> <VERB? RAISE LOWER TAKE>>
		<COND (<EQUAL? ,CHANGED? ,GRUE>
		       <JIGS-UP
"The grue is the most evil-tempered of all creatures. When dealing
with grues, discretion and good intentions often count for
nothing. To say that grues are touchy, even with their own kind, is an
understatement. \"Sour as a grue\" is a common expression, even among the
creatures themselves. You have made a fatal mistake.">)
		      (ELSE <CALLED-ATTENTION>)>)
	       (<VERB? WHERE>
		<TELL
"There are grues all around." CR>)
	       (<VERB? LISTEN>
		<TELL
"The grues gurgle unsettlingly, intent upon their business." CR>)
	       (<VERB? SNAVIG>
		<COND (<EQUAL? ,HERE ,GRUE-CAVE ,LIGHT-POOL ,PILLAR-ROOM>
		       <TELL
"You feel yourself changing in a very unpleasant way. Your claws feel odd,
and you have an uncontrollable tendency to slaver. You gurgle vilely
to yourself, worrying about the presence of light.">
		       <COND (<FSET? ,WINNER ,ONBIT>
			      <JIGS-UP
" A justified worry, as the glow from your own body fries you to a crisp!">)
			     (ELSE
			      <COND (<EQUAL? ,HERE ,GRUE-CAVE>
				     <TELL
" Directly in front of you, a horrific creature recoils with a look of
shocked surprise. It scuttles off, perplexed.">)>
			      <COND (<SET OLIT <LIT? ,HERE>>
				     <TELL
" The light from " THE .OLIT " hurts your eyes.">)>
			      <SETG CHANGED? ,GRUE>
			      <QUEUE I-SNAVIG 12>
			      <SETG LIT <LIT? ,HERE>>
			      <TELL CR CR>
			      <PERFORM ,V?LOOK>
			      <RTRUE>)>)
		      (ELSE
		       <TELL
"You see no grues here." CR>)>)
	       (<VERB? YOMIN>
		<TELL
"You sense ravening hunger and a nasty, mean, and brutish
disposition." CR>)
	       (<SPELL-VERB?>
		<COND (<AND <NOT <EQUAL? ,CHANGED? ,GRUE>>
			    ,LIT>
		       <GLOBAL-GRUE-F>)
		      (ELSE
		       <TELL ,NOTHING-HAPPENS>)>)>>

<ROUTINE CALLED-ATTENTION ()
	 <JIGS-UP
"You've called attention to yourself. The grues invite you to dinner.">>

<OBJECT LOCAL-WATER
	(SYNONYM WATER)
	(ADJECTIVE FRESH SALT SEA)
	(DESC "water")
	(FLAGS NOABIT)
	(ACTION WATER-F)>

<OBJECT WATER
	(IN LOCAL-GLOBALS)
	(SYNONYM WATER)
	(DESC "water")
	(FLAGS NDESCBIT NOABIT)
	(ACTION WATER-F)>

<ROUTINE WATER-F ()
	 <COND (<AND <VERB? POUR THROW>
		     <EQUAL? ,PRSO ,LOCAL-WATER>>
		<COND (<AND <LOC ,PRSO>
			    <IN? <LOC ,PRSO> ,WINNER>>
		       <PERFORM ,V?POUR <LOC ,PRSO>>
		       <RTRUE>)
		      (ELSE
		       <DONT-HAVE-THAT>)>)
	       (<VERB? EAT DRINK DRINK-FROM>
	        <COND (<EQUAL? ,PRSO ,LOCAL-WATER>
		       <COND (<IN? <LOC ,PRSO> ,WINNER>
			      <COND (<FSET? <LOC ,PRSO> ,OPENBIT>
				     <REMOVE ,PRSO>)
				    (ELSE
				     <TELL-OPEN-CLOSED ,BOTTLE>
				     <RTRUE>)>)
			     (<NOT <GLOBAL-IN? ,WATER ,HERE>>
			      <TELL ,YOU-DONT-HAVE THE <LOC ,PRSO> ,PERIOD>
			      <RTRUE>)>)>
		<COND (<OR <AND <EQUAL? ,PRSO ,LOCAL-WATER>
				<FSET? ,PRSO ,RMUNGBIT>>
			   <AND <EQUAL? ,PRSO ,WATER>
				<EQUAL? ,HERE
					,OCEAN-ROOM
					,LOST-IN-OCEAN
					,OCEAN-FLOOR>>>
		       <TELL
"It's bitter and you spit it out immediately.">)
		      (ELSE
		       <TELL
"That was refreshing, but you shouldn't drink untested water.">)>
		<CRLF>)
	       (<VERB? REACH-IN RUB>
		<TELL
"It's wet." CR>)
	       (<VERB? LOOK-INSIDE LOOK-UNDER>
		<MAKE-OUT>)
	       (<VERB? THROUGH LEAP>
		<COND (<FSET? ,HERE ,RWATERBIT>
		       <TELL ,YOU-ARE ,PERIOD>)>)>>

<ROOM RETREAT
      (IN ROOMS)
      (DESC "Enchanters' Retreat")
      (ACTION RETREAT-F)
      (FLAGS RLANDBIT ONBIT OUTSIDE)
      (THINGS
       <PSEUDO (FLATHEAD MOUNTAIN MOUNTAIN-PSEUDO)
	       (ENCHANTER RETREAT RANDOM-PSEUDO)
	       (<> BARSAP ANSWER-PSEUDO)
	       (<> BARBEL ANSWER-PSEUDO)
	       (BARBEL GURTH ANSWER-PSEUDO)
	       (<> GUSTAR ANSWER-PSEUDO)
	       (GUSTAR WOOMAX ANSWER-PSEUDO)
	       (<> DIMITHIO ANSWER-PSEUDO)
	       (DIMITHIO BORPHEE ANSWER-PSEUDO)
	       (<> FORBURN ANSWER-PSEUDO)
	       (FORBURN WILY ANSWER-PSEUDO)
	       (<> BERKNIP ANSWER-PSEUDO)>)>

<ROUTINE RETREAT-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The Enchanters' Retreat is an old stone structure perched high in the
mountains. For generations, retired (or even burnt-out) enchanters have
come here to breathe the clean mountain air, watch the stars, and rest
from their exertions. The appointments are simple, the fare is unsophisticated,
but those here have a look of quiet contentment that is easy for you to envy."
CR>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<VERB? WALK>
		       <TELL
"Belboz stops you. \"You should not even be here. You will disturb
our rest.\"" CR>)
		      (<VERB? ANSWER YES NO>
		       <PERFORM ,V?REPLY ,BELBOZ>
		       <RTRUE>)
		      (<AND <VERB? SAY>
			    ,BELBOZ-ASKS
			    <NOT ,BELBOZ-CONVINCED?>>
		       <QUOTED-PHRASE <- ,P-CONT ,P-LEXELEN> ,ACT?ANSWER>
		       <ORPHAN-VERB ,W?ANSWER ,ACT?ANSWER>)>)>>

<OBJECT BELBOZ
	(IN RETREAT)
	(DESC "Belboz")
	(LDESC
"Belboz is meditating here.")
	(SYNONYM BELBOZ NECROMANCER)
	(FLAGS PERSON NOABIT NOTHEBIT OPENBIT CONTBIT)
	(ACTION BELBOZ-F)
	(CONTFCN BELBOZ-F)>

<ROUTINE BELBOZ-F ("OPTIONAL" (RARG <>))
	 <COND (<EQUAL? ,WINNER ,BELBOZ>
		<COND (<AND <VERB? TELL-ABOUT>
			    <EQUAL? ,PRSO ,ME>>
		       <RFALSE>)
		      (<VERB? HELLO>
		       <TELL
"\"Hello.\" Belboz doesn't seem pleased to see you." CR>)
		      (<NOT ,BELBOZ-CONVINCED?>
		       <TELL "Belboz looks at you suspiciously. ">
		       <COND (,BELBOZ-ASKS
			      <TELL
"\"Please answer my question, or I shall be forced to conclude you are
an imposter.\"" CR>)
			     (ELSE
			      <TELL
"\"You were here a few days ago, or
rather someone who resembled you strongly enough to be your twin was
here. This being betrayed its true nature, however, as it did not know
facts which would be trifles to even the rawest apprentice. It fled
before I could capture it. Prove to me that you are truly yourself, and
answer me a question. ">
			      <SETG BELBOZ-ASKS
				    <RANDOM <GET ,QUESTIONS 0>>>
			      <ORPHAN-VERB ,W?ANSWER ,ACT?ANSWER>
			      <TELL <GET ,QUESTIONS ,BELBOZ-ASKS> "?\"" CR>)>)
		      (<VERB? GIVE>
		       <TELL
"\"All in good time.\"" CR>)
		      (<AND <VERB? HELP>
			    <EQUAL? ,PRSO <> ,ME>>
		       <TELL
"The great mage looks tired. \"That is beyond my power,\" he says. \"I have
given up worldly affairs. My time is past, I am old, and the world is now
in the care of my successors. I am convinced you will not fail.\"" CR>)
		      (<VERB? TELL-ME-ABOUT>
		       <COND (<EQUAL? ,PRSO ,MAGIC>
			      <TELL
"\"I can tell you nothing which you do not already know. We live in
perilous times.\"" CR>)
			     (<EQUAL? ,PRSO ,SHADOW>
			      <TELL
"\"I have encountered such creatures, but this one is unfamiliar to me.
They are sometimes spirits of the dead, or demons, or even illusory
sendings.\"" CR>)
			     (<EQUAL? ,PRSO ,SNAKE>
			      <TELL
"\"This serpent brings to mind the great Ouroboros, said to encircle the
world.\"" CR>)
			     (<EQUAL? ,PRSO ,KEY>
			      <TELL
"\"It was left nearby.\"" CR>)
			     (<GETP ,PRSO ,P?CUBE>
			      <COND (<HELD? ,PRSO>
				     <TELL
"Belboz looks at the cube for a while, turning it over and over in his
hands.">)
				    (ELSE
				     <TELL
"Belboz thinks for a while.">)>
			      <TELL
" \"There is a legend about cubes. When the foundations of the
world were laid down, it is said that the elemental powers and forces
were symbolized during the making by small cubes. The cubes and the
forces were merged in a way that our knowledge no longer comprehends.
When the making was done, the cubes were hidden
away where their powers could not be tampered with. If someone has
gained access to them, or rediscovered the knowledge of their making, we
are in terrible danger. One who had power over these cubes could change
the very structure of our universe. Such a one would have powers I do
not care to contemplate.\"">
			      <COND (<HELD? ,PRSO>
				     <TELL
" Belboz gives back the cube.">)>
			      <CRLF>)
			     (<EQUAL? ,PRSO ,PSEUDO-OBJECT>
			      <TELL
"\"I know little you do not know yourself.\"" CR>)
			     (ELSE
			      <TELL
"\"I know nothing of interest about that.\"" CR>)>)
		      (ELSE
		       <TELL
"Belboz looks at you, but says nothing." CR>)>)
	       (<EQUAL? .RARG ,M-CONTAINER>
		<COND (<VERB? TAKE>
		       <FORLORN-ENCYSTMENT>)>)
	       (<NOT .RARG>
		<COND (<AND <VERB? TELL>
			    ,BELBOZ-ASKS
			    <NOT ,BELBOZ-CONVINCED?>>
		       <ORPHAN-VERB ,W?ANSWER ,ACT?ANSWER>
		       <RFALSE>)
		      (<VERB? EXAMINE>
		       <TELL
"Belboz looks the same as always, ageless at an age when most have already
departed the world. Outwardly, he seems relaxed and carefree." CR>)
		      (<VERB? SHOW>
		       <SETG WINNER ,BELBOZ>
		       <PERFORM ,V?TELL-ME-ABOUT ,PRSO>
		       <SETG WINNER ,PLAYER>
		       <RTRUE>)
		      (<VERB? ASK-FOR>
		       <SETG WINNER ,BELBOZ>
		       <PERFORM ,V?GIVE ,ME ,PRSO>
		       <SETG WINNER ,PLAYER>
		       <RTRUE>)
		      (<VERB? WHO>
		       <TELL
"Belboz the Necromancer was head of the Accardi-by-the-sea chapter of
the Guild of Enchanters until his recent retirement. You owe your position
(and your life) to him, and it is partly because he was your mentor that
you have achieved your present position. When he retired, he expressed an
interest in rest, meditation and learning to arrange flowers." CR>)
		      (<AND <NOT ,BELBOZ-CONVINCED?>
			    <AND <VERB? REPLY>
				 <EQUAL? ,PRSO ,BELBOZ>
				 <NOT ,PRSI>>>
		       <ORPHAN-VERB ,W?ANSWER ,ACT?ANSWER>
		       <TELL "\"Yes? What is the answer?\"" CR>)
		      (<VERB? REPLY>
		       <ANSWER-BELBOZ>)
		      (<VERB? YOMIN>
		       <TELL
"You sense peacefulness">
		       <COND (<NOT ,BELBOZ-CONVINCED?>
			      <TELL " overlaid upon a foundation of worry">)>
		       <TELL ,PERIOD>)
		      (<OR <HOSTILE-VERB?>
			   <VERB? ESPNIS LISKON SNAVIG>
			   <VERB? TINSOT>>
		       <TELL
"Belboz stops you with a word of power." CR>
		       <FORLORN-ENCYSTMENT>)
		      (<VERB? WHERE FIND>
		       <COND (<AND <NOT <IN? ,BELBOZ ,HERE>>
				   <NOT <FSET? ,RETREAT ,TOUCHBIT>>>
			      <TELL
"You last saw Belboz months ago, when he left for the
Enchanters' Retreat in the mountains." CR>)
			     (ELSE
			      <TELL
"I would assume he is still at the Retreat." CR>)>)>)>>

<GLOBAL FAKE-KEY <>>

<ROUTINE ANSWER-BELBOZ ()
	 <COND (<AND ,BELBOZ-ASKS
		     <NOT ,BELBOZ-CONVINCED?>>
		<COND (<AND <EQUAL? ,PRSO ,PSEUDO-OBJECT ,BELBOZ>
			    <EQUAL? ,PRSI <> ,PSEUDO-OBJECT>>
		       <COND (<NOT <CORRECT? <GET ,ANSWERS ,BELBOZ-ASKS>>>
			      <SETG FAKE-KEY T>)>
		       <SETG SCORE <+ ,SCORE 25>>
		       <SETG BELBOZ-CONVINCED? T>
		       %<DEBUG-CODE <COND (,FAKE-KEY <TELL "[Wrong]" CR>)
					  (ELSE <TELL "[Right]" CR>)>>
		       <TELL
"\"Good! I knew it was you all along. What may I do for you?\"">
		       <COND (<IN? ,KEY ,BELBOZ>
			      <FCLEAR ,KEY ,NDESCBIT>
			      <MOVE ,KEY ,WINNER>
			      <TELL " He fumbles
in his pouch for a moment. \"First, let me give you this.\" He hands you a "
'KEY ". \"It may prove useful.\"">)>
		       <CRLF>)
		      (ELSE
		       <FORLORN-ENCYSTMENT>)>)
	       (ELSE
		<TELL
"\"I asked no question,\" says Belboz." CR>)>>

<ROUTINE FORLORN-ENCYSTMENT ()
	 <SETG DEATHS 3>
	 <JIGS-UP
"\"Ah! Now I have you, charlatan! Fool me twice? Never!\" He rises to his
feet, makes a threatening gesture, and you find yourself transported to a
tiny cell deep beneath the earth, all belongings stripped from you. In
time, though it takes years and you are mad long since, you starve.">>

<ROUTINE CORRECT? (WRD)
	 <COND (<EQUAL? .WRD ,P-PNAM>
		<RTRUE>)
	       (<AND <EQUAL? .WRD ,W?BARBEL>
		     <EQUAL? ,P-PADJN ,W?BARBEL <>>
		     <EQUAL? ,P-PNAM ,W?GURTH>>
		<RTRUE>)
	       (<AND <EQUAL? .WRD ,W?GUSTAR>
		     <EQUAL? ,P-PADJN ,W?GUSTAR <>>
		     <EQUAL? ,P-PNAM ,W?WOOMAX>>
		<RTRUE>)
	       (<AND <EQUAL? .WRD ,W?DIMITHIO>
		     <EQUAL? ,P-PADJN ,W?DIMITHIO <>>
		     <EQUAL? ,P-PNAM ,W?BORPHEE>>
		<RTRUE>)
	       (<AND <EQUAL? .WRD ,W?FORBURN>
		     <EQUAL? ,P-PADJN ,W?FORBURN <>>
		     <EQUAL? ,P-PNAM ,W?WILY>>
		<RTRUE>)
	       (ELSE <RFALSE>)>>

<ROUTINE ANSWER-PSEUDO ()
	 <COND (<VERB? WHO>
		<TELL
"You studied his career while still an apprentice." CR>)
	       (<AND <VERB? REPLY>
		     <EQUAL? ,PRSO ,PSEUDO-OBJECT>
		     <EQUAL? ,HERE ,RETREAT>>
		<PERFORM ,V?REPLY ,BELBOZ ,PRSO>
		<RTRUE>)>>

<GLOBAL BELBOZ-CONVINCED? <>>

<GLOBAL BELBOZ-ASKS <>>

<GLOBAL QUESTIONS
	<PLTABLE
"Which mage had the motto, 'The hardest trick is making it look easy.'"
"Who invented the golmac spell"
"Who wrote of the Coconut of Quendor"
"In Borphee, who was famed for his skill with fireworks displays"
"Which of our esteemed colleagues was fabled for his skill at Double Fanucci"
"Of the necromancers, who other than (harumph) myself is best-known">>

<GLOBAL ANSWERS
	<PLTABLE <VOC "BARSAP">
		 <VOC "BARBEL">
		 <VOC "GUSTAR">
		 <VOC "DIMITHIO">
		 <VOC "FORBURN">
		 <VOC "BERKNIP">>>

<ROUTINE PLURAL-PSEUDO ()
	 <RANDOM-PSEUDO T>>

<ROUTINE RANDOM-PSEUDO ("OPTIONAL" (PLURAL? <>))
	 <COND (<VERB? EXAMINE>
		<COND (.PLURAL? <TELL "They look">)
		      (ELSE <TELL "It looks">)>
		<TELL " exactly as you would expect." CR>)
	       (<VERB? TAKE>
		<TELL
"You're an enchanter, not a garbage collector." CR>)>>

<ROUTINE REDIRECT (FROM TO)
	 <PERFORM ,PRSA
		  <COND (<EQUAL? ,PRSO .FROM> .TO)
			(ELSE ,PRSO)>
		  <COND (<EQUAL? ,PRSI .FROM> .TO)
			(ELSE ,PRSI)>>
	 <RTRUE>>

"sleep, hunger, etc."

<GLOBAL LAST-SLEPT 40> ;"move when you last woke-up, for purposed of V-TIME"

<OBJECT GLOBAL-SLEEP
	(IN GLOBAL-OBJECTS)
	(DESC "sleep")
	(SYNONYM SLEEP NAP)
	(FLAGS NOABIT NOTHEBIT)
	(ACTION GLOBAL-SLEEP-F)>

<ROUTINE GLOBAL-SLEEP-F ()
	 <COND (<VERB? WALK-TO TAKE>
                <PERFORM ,V?SLEEP>
		<RTRUE>)
	       (<VERB? FIND>
		<TELL "Sleep anywhere." CR>)>>

<OBJECT MAGIC
	(IN GLOBAL-OBJECTS)
	(DESC "magic")
	(SYNONYM MAGIC)
        (ACTION MAGIC-F)>

<ROUTINE MAGIC-F ()
	 <COND (<VERB? WHAT>
		<TELL
"The Guild will be surprised to hear you don't know." CR>)>>
