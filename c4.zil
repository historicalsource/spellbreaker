"C4 for
				MAGE
	(c) Copyright 1985 Infocom, Inc. All Rights Reserved."

"ROCK CHASING"

<ROOM PLAIN-ROOM
      (IN ROOMS)
      (DESC "Plain")
      (ACTION PLAIN-ROOM-F)
      (FLAGS ONBIT RLANDBIT)
      (GLOBAL LINES)
      (THINGS
       <PSEUDO (FEATURELESS PLAIN PLAIN-PSEUDO)
	       (DISTANT MOUNTAIN MOUNTAIN-PSEUDO)>)>

<ROUTINE MOUNTAIN-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The mountains are tall and volcanic." CR>)
	       (<VERB? CLIMB-FOO CLIMB-UP>
		<DO-WALK ,P?UP>)
	       (<VERB? CLIMB-DOWN>
		<DO-WALK ,P?DOWN>)>>

<ROUTINE PLAIN-PSEUDO ()
	 <REDIRECT ,PSEUDO-OBJECT ,GROUND>>

<ROUTINE PLAIN-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a flat plain punctuated by boulders. The boulders
are all identical and slide to and fro on the eerie surface,
propelled by an unknown mechanism. The ground is scratched by many
intersecting lines which seem to have a regular pattern. ">
		<DESCRIBE-PLAIN>
		<TELL " Far in the
distance are mountains which quiver itchily as they belch forth purple
fire." CR>)
	       (<EQUAL? .RARG ,M-BEG>
		<SETG ROCK-MOVED? <>>
		<COND (<AND <EQUAL? ,WINNER ,PLAYER> <VERB? WALK>>
		       <COND (<IN? ,PLAYER ,HERE>
			      <TELL
"You find that the surface is too smooth. Your feet
slip out from under you, and you crash to the ground." CR>)
			     (<EQUAL? ,P-WALK-DIR ,P?DOWN>
			      <PERFORM ,V?DISEMBARK>
			      <RTRUE>)
			     (ELSE
			      <TELL
,YOU-HAVE-TO " get down off the rock if you want to walk." CR>)>)>)
	       (<EQUAL? .RARG ,M-ENTER>
		<SETG ROCK-LOC 5>
		<SETG YOU-LOC 5>)
	       (<EQUAL? .RARG ,M-LEAVE>
		<SETG ROCK-BRIBED? <>>
		<DEQUEUE I-OTHER-ROCK>)>>

<ROUTINE PLAIN-SPELL-FAIL ()
	 <COND (<VERB? BLORPLE> <RFALSE>)>
	 <TELL
"A bright purple ball of light issues from your fingers and collapses
like a deflated balloon on the ground.">
	 <COND (<NOT <IN? ,PLAYER ,OTHER-ROCK>>
		<SETG ROCK-TALKED? T>
		<TELL
" \"Great effect!\" says the " 'ROCK ". \"That's better than most of you soft
ones can do here.\"">)>
	 <CRLF>>

<GLOBAL ROCK-MOVED?:FLAG <>>

<GLOBAL YOU-LOC:NUMBER 5>
<GLOBAL ROCK-LOC:NUMBER 5>
<GLOBAL OTHER-ROCK-LOC:NUMBER 7>

<ROUTINE DESCRIBE-PLAIN ("OPTIONAL" (ROCKS? T))
	 <COND (<HELD? ,PLAYER ,ROCK>
		<TELL "You are on a large, green eyed rock. ">)>
	 <TELL
"From where you are " <COND (<OR <HELD? ,PLAYER ,ROCK>
				 <HELD? ,PLAYER ,OTHER-ROCK>>
			     "perched")
			    (T "standing")>
" you can see lines radiating ">
	 <TELL-WALLS <GETB ,PLAIN-WALLS ,YOU-LOC>>
	 <TELL ".">
	 <COND (<NOT .ROCKS?> <RTRUE>)>
	 <COND (<OR <NOT <EQUAL? ,YOU-LOC ,ROCK-LOC>>
		    <NOT <IN? ,PLAYER ,ROCK>>>
		<TELL " There is a large green eyed rock">
		<COND (<NOT <IN? ,PLAYER ,ROCK>>
		       <TELL " here">)
		      (ELSE 
		       <ROCK-DIRECTION ,ROCK-LOC>)>
		<TELL ".">)>
	 <COND (<NOT <IN? ,PLAYER ,OTHER-ROCK>>
		<TELL " Also, there is a large brown eyed rock ">
		<COND (<IN? ,DARK-CUBE ,OTHER-ROCK>
		       <TELL "with a " ,WHITE-CUBE " on its back ">)>
		<COND (<EQUAL? ,YOU-LOC ,OTHER-ROCK-LOC>
		       <TELL "here">)
		      (ELSE
		       <ROCK-DIRECTION ,OTHER-ROCK-LOC>)>
		<TELL ".">)>>

<GLOBAL PLAIN-WALLS:TABLE
	<TABLE #BYTE 0
	       #BYTE %<+ 2 8 128>	;"1 -- E, S, SW"
	       #BYTE %<+ 2 4 8>		;"2 -- E, W, S"
	       #BYTE %<+ 4 8>		;"3 -- W, S"
	       #BYTE %<+ 2 8 16>	;"4 -- E, S, NE"
	       #BYTE %<+ 1 2 4 8>	;"5 -- N, E, W, S"
	       #BYTE %<+ 1 2 4 8>	;"6 -- N, E, W, S"
	       #BYTE %<+ 1 4 8>		;"7 -- N, W, S"
	       #BYTE %<+ 1 2 8>		;"8 -- N, E, S"
	       #BYTE %<+ 1 2 4 8>	;"9 -- N, E, W, S"
	       #BYTE %<+ 1 2 4 8>	;"10 --N, E, W, S"
	       #BYTE %<+ 1 4 8>		;"11 -- N, W, S"
	       #BYTE %<+ 1 2>		;"12 -- N, E"
	       #BYTE %<+ 1 2 4>		;"13 -- N, W, E"
	       #BYTE %<+ 1 2 4>		;"14 -- N, W, E"
	       #BYTE %<+ 1 4>		;"15 -- N, W">>

<ROUTINE ROCK-DIRECTION (R "AUX" ROW COL RROW RCOL (DROW 0) (DCOL 0))
	 <SET ROW </ ,YOU-LOC 4>>
	 <SET COL <BAND ,YOU-LOC 3>>
	 <SET RROW </ .R 4>>
	 <SET RCOL <BAND .R 3>>
	 <SET DROW
	      <COND (<G? .RROW .ROW> <- .RROW .ROW>)
		    (ELSE <- .ROW .RROW>)>>
	 <SET DCOL
	      <COND (<G? .RCOL .COL> <- .RCOL .COL>)
		    (ELSE <- .COL .RCOL>)>>
	 <COND (<AND <L? .DROW 2> <L? .DCOL 2>>
		<TELL "nearby and off">)
	       (<AND <L? .DROW 3> <L? .DCOL 3>>
		<TELL "some distance">)
	       (ELSE <TELL "quite a ways off">)>
	 <TELL " to the ">
	 <COND (<G? .RROW .ROW>
		<COND (<G? .RCOL .COL> <TELL "southeast">)
		      (<L? .RCOL .COL> <TELL "southwest">)
		      (<EQUAL? .RCOL .COL> <TELL "south">)>)
	       (<L? .RROW .ROW>
		<COND (<G? .RCOL .COL> <TELL "northeast">)
		      (<L? .RCOL .COL> <TELL "northwest">)
		      (<EQUAL? .RCOL .COL> <TELL "north">)>)
	       (ELSE
		<COND (<G? .RCOL .COL> <TELL "east">)
		      (ELSE <TELL "west">)>)>>

<OBJECT LINES
	(IN LOCAL-GLOBALS)
	(DESC "lines")
	(SYNONYM LINES SCRATCH LINE)
	(ADJECTIVE REGULAR INTERSECTING)
	(FLAGS NDESCBIT NOABIT)
	(ACTION LINES-F)>

<ROUTINE LINES-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"These lines appear to be discolorations in the surface, perhaps a different
mineral permeating the rock. They form a usually rectangular grid.
The boulders, as far as you can tell, always follow the lines. ">
		<DESCRIBE-PLAIN <>>
		<CRLF>)
	       (<VERB? RUB>
		<TELL
"The lines aren't raised or lowered with respect to the plain. They are
most likely just discolorations in the surface." CR>)>>

<OBJECT ROCK
	(IN PLAIN-ROOM)
	(DESC "green eyed rock")
	(SYNONYM ROCK BOULDER)
	(ADJECTIVE GREEN EYED LARGE ;GREEN-EYED FLAT)
	(FLAGS NDESCBIT THE PERSON VEHBIT CONTBIT OPENBIT TAKEBIT SURFACEBIT)
	(GENERIC GENERIC-ROCK-F)
	(SIZE 400)
	(CAPACITY 200)
	(CONTFCN ROCK-F)
	(ACTION ROCK-F)>

<ROUTINE ROCK-SPEECHES ()
	 <COND (,ROCK-TALKED?
		<COND (,ROCK-BRIBED?
		       <TELL
"\"That was pretty good food. A little light on the phosphorus for my taste,
but some have been known to disagree.\" It snorts good-naturedly." CR>)
		      (ELSE
		       <TELL
"\"You know, I could do with a little food. The paths are sort of bare this
time of year; everyone's scraped them pretty thin. Yes, a little food would
be nice. Something crunchy. Then you could watch me eat. I'm really at my
best then.\"" CR>)>)
	       (ELSE
		<SETG ROCK-TALKED? T>
		<TELL
"The rock seems somewhat surprised to see you, and looks you over
carefully before answering. ">
		<COND (<NOT <VERB? HELLO>>
		       <TELL "It doesn't pay much attention to you. ">)>
		<TELL "\"Hello. You're certainly an odd-looking
one, though not as odd as the last. It was
as unprepossessing as you. Of course, I am the most handsome.\"" CR>)>>

<GLOBAL ROCK-TALKED?:FLAG <>>
<GLOBAL ROCK-BRIBED?:FLAG <>>
<GLOBAL TRIED-BOARDING?:FLAG <>>

<ROUTINE ROCK-F ("OPTIONAL" (RARG <>))
	 <COND (<EQUAL? ,WINNER ,ROCK>
		<COND (<AND <VERB? TELL-ABOUT>
			    <EQUAL? ,PRSO ,ME>>
		       <RFALSE>) 	
		      (<VERB? WALK WALK-TO>
		       <COND (<AND <VERB? WALK> <HELD? ,PLAYER ,ROCK>>
			      <ROCK-WALK ,P-WALK-DIR>)
			     (,ROCK-BRIBED?
			      <TELL
"\"Do you want to ride along? ">
			      <COND (,TRIED-BOARDING?
				     <TELL
"That's what you seemed to want. ">)>
			      <TELL
"Do you have any more food?\"" CR>)
			     (ELSE
			      <WHATS-IN-IT-FOR-ME?>)>)
		      (<VERB? TELL-ME-ABOUT>
		       <COND (<EQUAL? ,PRSO ,BREAD ,FISH>
			      <TELL
"\"Yummy food? Food is crunchy and nice. I like it with lots of
phosphorus!\"" CR>)
			     (<EQUAL? ,PRSO ,OTHER-ROCK>
			      <TELL
"\"It's not as pretty as me.\"" CR>)
			     (ELSE
			      <TELL
"\"I don't know much about that.\"" CR>)>)
		      (<VERB? EAT>
		       <TELL "\"You have food?\"" CR>)
		      (ELSE
		       <ROCK-SPEECHES>)>
		<SETG ROCK-TALKED? T>)
	       (<EQUAL? .RARG ,M-CONTAINER>
		<COND (<NOT <HELD? ,PLAYER ,ROCK>>
		       <CANT-REACH-THAT>)>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<AND <VERB? DISEMBARK CLIMB-DOWN LEAP>
			    <EQUAL? ,PRSO <> ,ROOMS ,ROCK>>
		       <MOVE ,PLAYER ,HERE>
		       <SETG ROCK-BRIBED? <>>
		       <TELL
"\"That was fun! I'm kind of tired from carrying you, though. Do you have
any more food?\"" CR>)>)
	       (<NOT .RARG>
		<COND (<VERB? EXAMINE>
		       <TELL
"This is a rather large boulder with a flat bottom. Something
prevents it from touching the ground, as it moves about quite nimbly,
watching you with lovely green eyes.">
		       <CLEVER-CONTENTS ,ROCK " On the rock">
		       <CRLF>)
		      (<VERB? ADMIRE>
		       <SETG ROCK-TALKED? T>
		       <TELL
"\"You're very perceptive.\" The rock has no false modesty." CR>)
		      (<VERB? MOVE PUSH>
		       <SETG ROCK-TALKED? T>
		       <TELL ,IT-TICKLES>)
		      (<VERB? RUB>
		       <SETG ROCK-TALKED? T>
		       <TELL "\"Aren't I smooth?\" says the rock." CR>)
		      (<AND <VERB? GIVE SHOW>
			    <EQUAL? ,PRSI ,ROCK>>
		       <SETG ROCK-TALKED? T>
		       <COND (<EQUAL? ,PRSO ,BREAD ,FISH>
			      <TELL
"\"What's that? Dead animal or vegetable matter! You won't fool me!
Horrible! It would ruin my complexion!\"" CR>)
			     (<EQUAL? ,PRSO ,LAVA-ROCK>
			      <COND (<VERB? GIVE>
				     <REMOVE ,LAVA-ROCK>
				     <SETG ROCK-BRIBED? T>
				     <TELL
"\"Mmm. That looks good. Just the right size, too.\" It slides happily over the
piece of lava and settles comfortably to the ground. You hear a sound like
a rasp for a while. The rock blinks contentedly and rises into the air
again." CR>)
				    (ELSE
				     <TELL
"\"Oh, yum! Give it to me, please!\"" CR>)>)
			     (ELSE
			      <TELL
"\"That doesn't look very appetizing.\"" CR>)>)
		      (<VERB? BOARD SIT CLIMB-ON CLIMB-FOO CLIMB-UP>
		       <SETG ROCK-TALKED? T>
		       <SETG TRIED-BOARDING? T>
		       <COND (<IN? ,PLAYER ,ROCK>
			      <TELL ,IT-TICKLES>)
			     (,ROCK-BRIBED?
			      <MOVE ,PLAYER ,ROCK>
			      <TELL
"You climb the rock and perch precariously on top. From here you can see that
the long scratches in the ground form a rectangular grid that fills a
rather small valley. \"My back is the most hemispheric of all my friends',\"
remarks the rock." CR>)
			     (ELSE
			      <TELL
"The rock spins in place, preventing you from getting on. ">
			      <WHATS-IN-IT-FOR-ME?>)>)
		      (<VERB? LOOK-UNDER>
		       <SETG ROCK-TALKED? T>
		       <TELL
"The rock's underside is perfectly smooth. When you look under it, the
rock says, \"Hey! What is this? What about my privacy?\"">
		       <COND (,ROCK-BRIBED?
			      <TELL
" There is no sign of the lava.">)>
		       <CRLF>)>)>>

<ROUTINE WHATS-IN-IT-FOR-ME? ()
	 <TELL
"\"What's in it for me? For example, if you had some food, that might be
nice. Then you could ride on top and admire me from that angle. It's a
rare privilege.\"" CR>>

<GLOBAL IT-TICKLES:STRING "The rock bobs in place. \"That tickles!\"|">

<ROUTINE ROCK-WALK (DIR "AUX" ROW COL)
	 <QUEUE I-OTHER-ROCK -1>
	 <COND (<AND <EQUAL? ,ROCK-LOC 4> <EQUAL? .DIR ,P?NE>>
		<SETG ROCK-LOC 1>)
	       (<AND <EQUAL? ,ROCK-LOC 1> <EQUAL? .DIR ,P?SW>>
		<SETG ROCK-LOC 4>)
	       (ELSE
		<SET ROW </ ,ROCK-LOC 4>>
		<SET COL <BAND ,ROCK-LOC 3>>
		<COND (<AND <EQUAL? .DIR ,P?NORTH>
			    <OR <G? .ROW 1>
				<AND <G? .ROW 0>
				     <G? .COL 0>>>>
		       <SET ROW <- .ROW 1>>)
		      (<AND <EQUAL? .DIR ,P?SOUTH> <L? .ROW 3>>
		       <SET ROW <+ .ROW 1>>)
		      (<AND <EQUAL? .DIR ,P?EAST> <L? .COL 3>>
		       <SET COL <+ .COL 1>>)
		      (<AND <EQUAL? .DIR ,P?WEST>
			    <OR <G? .COL 1>
				<AND <G? .COL 0>
				     <G? .ROW 0>>>>
		       <SET COL <- .COL 1>>)
		      (ELSE
		       <TELL
"The rock says, \"There isn't a line there. Do you want me to starve
to death? Besides, what would my friends think if I was out of line?\"" CR>
		       <RTRUE>)>
		<SETG ROCK-LOC <+ <* .ROW 4> .COL>>)>
	 <COND (<HELD? ,PLAYER ,ROCK>
		<SETG YOU-LOC ,ROCK-LOC>)>
	 <SETG ROCK-MOVED? T>
	 <TELL
"The rock glides smoothly, carefully following the line on the plain.
\"Yum!\" it remarks, parenthetically. ">
	 <DESCRIBE-PLAIN>
	 <REMOVE ,OTHER-ROCK>
	 <COND (<ROB ,HERE <> ,ROCK>
		<TELL
" Something you left behind on the ground has been crushed by the rock.">)>
	 <MOVE ,OTHER-ROCK ,HERE>
	 <CRLF>
	 %<DEBUG-CODE <COND (,ZDEBUG
<TELL "[Green: " N ,ROCK-LOC "]" CR>)>>
	 <RTRUE>>

<OBJECT OTHER-ROCK
	(IN PLAIN-ROOM)
	(DESC "brown eyed rock")
	(SYNONYM ROCK BOULDER)
	(ADJECTIVE BROWN EYED LARGE FLAT)
	(FLAGS NDESCBIT THE PERSON VEHBIT CONTBIT OPENBIT TAKEBIT SURFACEBIT)
	(GENERIC GENERIC-ROCK-F)
	(SIZE 400)
	(CAPACITY 200)
	(CONTFCN OTHER-ROCK-F)
	(ACTION OTHER-ROCK-F)>

<ROUTINE OTHER-ROCK-F ("OPTIONAL" (RARG <>))
	 <COND (<EQUAL? ,WINNER ,OTHER-ROCK>
		<COND (<NOT <EQUAL? ,OTHER-ROCK-LOC ,YOU-LOC>>
		       <TELL ,TOO-FAR>)
		      (ELSE
		       <TELL
CTHE ,OTHER-ROCK " doesn't respond. It acts sulky and peevish." CR>)>
		<END-QUOTE>)
	       (<EQUAL? .RARG ,M-CONTAINER>
		<COND (<NOT <HELD? ,PLAYER ,OTHER-ROCK>>
		       <CANT-REACH-THAT>)>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<AND <VERB? DISEMBARK CLIMB-DOWN LEAP>
			    <EQUAL? ,PRSO <> ,ROOMS ,OTHER-ROCK>>
		       <MOVE ,PLAYER ,HERE>
		       <SETG OTHER-ROCK-LOC
			     <COND (<NOT <EQUAL? ,OTHER-ROCK-LOC 3>>
				    3)
				   (ELSE 12)>>
		       <TELL
"You jump down, and the " 'OTHER-ROCK " zooms away in a huff." CR>)>)
	       (<NOT .RARG>
		<COND (<VERB? EXAMINE LOOK-INSIDE>
		       <TELL
"This rock looks just like the other, except that it has brown eyes.">
		       <CLEVER-CONTENTS ,OTHER-ROCK " On the rock">
		       <CRLF>)
		      (<VERB? BOARD SIT CLIMB-ON CLIMB-FOO CLIMB-UP LEAP>
		       <COND (<NOT <EQUAL? ,OTHER-ROCK-LOC ,YOU-LOC>>
			      <TELL ,TOO-FAR>
			      <RTRUE>)>
		       <COND (<IN? ,PLAYER ,ROCK>
			      <SETG ROCK-MOVED? <>>
			      <SETG ROCK-BRIBED? <>>
			      <MOVE ,PLAYER ,OTHER-ROCK>
			      <TELL
"You leap gracefully to the " 'OTHER-ROCK ", almost slide off, and finally
settle yourself carefully on top. ">
			      <COND (<IN? ,DARK-CUBE ,OTHER-ROCK>
				     <FCLEAR ,DARK-CUBE ,NDESCBIT>
				     <TELL
"Right in front of you is a " ,WHITE-CUBE ". ">)>)>
		       <TELL ,ROCK-IRRITATION>)
		      (<VERB? TELL ASK-ABOUT TELL-ME-ABOUT>
		       <RFALSE>)
		      (<NOT <EQUAL? ,OTHER-ROCK-LOC ,YOU-LOC>>
		       <TELL ,TOO-FAR>)>)>>

<GLOBAL ROCK-IRRITATION:STRING 
"The rock grumbles in irritation. \"Go away,\" it says.|">

<GLOBAL TOO-FAR:STRING "It's too far away.|">

"LIGHT"

<OBJECT LIGHT-CUBE
	(IN GROUPER-NEST)
	(DESC "cube")
	(SYNONYM CUBE CUBES)
	(ADJECTIVE GQ ;C7 SMALL FEATURELESS WHITE)
	(NAME 0)
	(TEXT "fireflies")
	(FLAGS TAKEBIT)
	(ACTION CUBE-F)
	(DESCFCN CUBE-DESC)
        (GENERIC GENERIC-CUBE-F)
	(CUBE LIGHT-ROOM)>

<ROOM LIGHT-ROOM
      (IN ROOMS)
      (DESC "Light Room")
      (SOUTH PER MAGIC-BOX-EXIT)
      (WEST TO VOLCANO-BASE)
      (CUBE LIGHT-CUBE)
      (ACTION LIGHT-ROOM-F)
      (FLAGS ONBIT RLANDBIT)>

<ROUTINE LIGHT-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This place is bright and glaring. The very materials of which it is made
blaze with light so bright that their forms are obscured. There are glowing
archways to the west and south." CR>)
	       (<EQUAL? .RARG ,M-LEAVE>
		<RECOVER-CUBE>)>>

"LIFE"

<OBJECT LIFE-CUBE
	(IN HUT-ROOM)
	(DESC "cube")
	(SYNONYM CUBE CUBES)
	(ADJECTIVE HQ ;C8 SMALL FEATURELESS WHITE)
	(NAME 0)
	(TEXT "rabbits")
	(FLAGS NDESCBIT TAKEBIT)
	(ACTION CUBE-F)
	(DESCFCN CUBE-DESC)
        (GENERIC GENERIC-CUBE-F)
	(CUBE LIFE-ROOM)>

<ROOM LIFE-ROOM
      (IN ROOMS)
      (DESC "Soft Room")
      (EAST PER MAGIC-BOX-EXIT)
      (SOUTH TO MEADOW-ROOM)
      (CUBE LIFE-CUBE)
      (ACTION LIFE-ROOM-F)
      (FLAGS RLANDBIT)>

<ROUTINE LIFE-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This place is soft, warm and slightly spongy. It glistens in
the light. There are passages leading east and south." CR>)
	       (<EQUAL? .RARG ,M-LEAVE>
		<RECOVER-CUBE>)>>

<ROOM MEADOW-ROOM
      (IN ROOMS)
      (DESC "Meadow")
      (ACTION MEADOW-ROOM-F)
      (FLAGS RLANDBIT OUTSIDE ONBIT)
      (THINGS
       <PSEUDO (<> RABBIT RABBIT-PSEUDO)
	       (<> GRASS GRASS-PSEUDO)
	       (<> FLOWERS FLOWERS-PSEUDO)
	       (<> WILDFLOWERS FLOWERS-PSEUDO)
	       (PUFFY CLOUD CLOUD-PSEUDO)
	       (PUFFY CLOUDS CLOUD-PSEUDO)
	       (<> BIRD RANDOM-PSEUDO)
	       (<> BIRDS PLURAL-PSEUDO)
	       (<> INSECT PLURAL-PSEUDO)>)>

<ROUTINE FLOWERS-PSEUDO ()
	 <COND (<VERB? SMELL>
		<TELL "Taking time to stop and smell the flowers?" CR>)
	       (ELSE
		<PLANTS-PSEUDO>)>>

<ROUTINE GRASS-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL "It's well maintained." CR>)
	       (ELSE
		<PLANTS-PSEUDO>)>>

<ROUTINE PLANTS-PSEUDO ()
	 <COND (<AND <VERB? CUT>
		     <EQUAL? ,PRSI ,KNIFE ,SHEARS>>
		<TELL "Doing a little gardening?" CR>)
	       (<VERB? PICK>
		<TELL "You shouldn't pick that." CR>)
	       (ELSE
		<RANDOM-PSEUDO>)>>

<ROUTINE CLOUD-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The clouds are puffy and white, perfect for a lazy summer's day." CR>)
	       (<VERB? LESOCH> <LESOCH-CLOUDS>)>>

<ROUTINE LESOCH-CLOUDS ()
	 <TELL "The clouds clear away.">
	 <COND (<EQUAL? ,HERE ,LOST-IN-CLOUDS>
		<CRLF>
		<CRLF>
		<GOTO ,MIDAIR>)
	       (ELSE <CRLF>)>>

<ROUTINE RABBIT-PSEUDO ()
	 <COND (<OR <VERB? EXAMINE FOLLOW FIND>
		    <SPELL-VERB?>>
		<TELL
"What rabbit? I guess he was late for something." CR>)>>

<ROUTINE MEADOW-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a warm, sunny meadow nestled among low hills. Wildflowers abound,
and insects buzz lazily through the air. The grass is soft and thick.
Birds drift serenely through the sky, where puffy white clouds decorate
the bright blue background." CR>)
	       (<EQUAL? .RARG ,M-END>
		<COND (<AND <NOT ,RABBIT-FLAG> <PROB 20>>
		       <SETG RABBIT-FLAG T>
		       <TELL CR
"A rabbit hops across the meadow, twitches its nose at you, and
then scampers away." CR>)>)>>

<GLOBAL RABBIT-FLAG:FLAG <>>

<OBJECT SHEARS
	(IN MEADOW-ROOM)
	(DESC "pair of pruning shears")
	(SYNONYM SHEARS)
	(ADJECTIVE PRUNING PAIR)
	(FLAGS TAKEBIT TOOLBIT WEAPONBIT)
	(ACTION SHEARS-F)>

<ROUTINE SHEARS-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"This is a very nice pair of pruning shears, such as a gardener
would own." CR>)
	       ;(<AND <VERB? CUT>
		     <NOT <HELD? ,SHEARS>>>
		<NOT-HOLDING ,SHEARS>)>>

<OBJECT WEED
	(IN MEADOW-ROOM)
	(DESC "weed")
	(SYNONYM WEED TREE PLANT RAGWEED)
	(ADJECTIVE UGLY YELLOW SMALL CUTTING)
	(DESCFCN WEED-DESC)
	(SIZE 2)
	(FLAGS TAKEBIT)
	(ACTION WEED-F)>

<ROUTINE WEED-DESC (RARG OBJ)
	 <WEED-DETAILS .RARG>>

<ROUTINE WEED-DETAILS (RARG)
	 <COND (.RARG <TELL "There is a weed ">)
	       (ELSE <TELL "This is a ragweed ">)>
	 <COND (<FSET? ,WEED ,RWATERBIT>
		<TELL "cutting">)
	       (ELSE
		<TELL "plant">)>
	 <COND (.RARG <TELL " here">)>
	 <TELL ". It's tall">
	 <COND (<AND <FSET? ,WEED ,RMUNGBIT>
		     <NOT <EQUAL? ,SHRINK-FLAG ,WEED>>>
		<TELL " as a tree">)>
	 <TELL ", with yellow blossoms dripping pollen.">
	 <COND (<AND <NOT .RARG>
		     <EQUAL? ,HERE ,MEADOW-ROOM>>
		<TELL " This is the only weed you can see anywhere
in the meadow. It's like a well-kept garden.">)>
	 <CRLF>>

<GLOBAL WEED-PLANTED?:NUMBER 2>

<ROUTINE WEED-F ()
	 <COND (<VERB? EXAMINE>
		<WEED-DETAILS <>>)
	       (<VERB? TAKE PICK MOVE>
		<COND (<AND <FSET? ,WEED ,RMUNGBIT>
			    <NOT <EQUAL? ,SHRINK-FLAG ,WEED>>>
		       <TELL
"I suppose you have the logging equipment to do this? If so, I don't see
it anywhere." CR>)
		      (<NOT <HELD? ,PRSO>>
		       <COND (<EQUAL? ,WEED-PLANTED? 2>
			      <COND (<EQUAL? <ITAKE> T>
				     <MOVE ,WEED ,HERE>
				     <SETG WEED-PLANTED? 1>
				     <TELL
"The weed pulls partly out of the ground." CR>)>
			      <RTRUE>)
			     (<EQUAL? ,WEED-PLANTED? 1>
			      <COND (<EQUAL? <ITAKE> T>
				     <SETG WEED-PLANTED? <>>
				     <TELL
"The weed pulls out of the ground, taking a good-sized ball of
earth with it." CR>)>
			      <RTRUE>)>)>)
	       (<AND <VERB? CUT>
		     <EQUAL? ,PRSI ,KNIFE ,SHEARS>>
		<COND (<AND <FSET? ,WEED ,RMUNGBIT>
			    <NOT <EQUAL? ,SHRINK-FLAG ,WEED>>>
		       <TELL
"You would need an axe." CR>)
		      (ELSE
		       <MOVE ,WEED ,WINNER>
		       <FSET ,WEED ,RWATERBIT>
		       <TELL
"You now have a weed cutting." CR>)>)
	       (<AND <VERB? PLANT>
		     <OR <EQUAL? ,PRSI ,GROUND ,GLOBAL-CAVE>
			 <AND <EQUAL? ,PRSI ,PSEUDO-OBJECT>
			      <EQUAL? ,P-PNAM ,W?DIRT>>
			 <AND <NOT ,PRSI>
			      <OR <FSET? ,HERE ,OUTSIDE>
				  <EQUAL? ,HERE ,OGRE-CAVE ,OGRE-BEDROOM>>>>>
		<COND (<AND <FSET? ,HERE ,RLANDBIT>
			    <NOT <GETP ,HERE ,P?CUBE>>
			    <IN? ,WINNER ,HERE>>
		       <COND (<FSET? ,WEED ,RWATERBIT> ;"MEANS YOU CUT IT"
			      <TELL
,YOU-CANT "expect it to grow from such a cutting." CR>)
			     (ELSE
			      <SETG WEED-PLANTED? 2>
			      <MOVE ,WEED ,HERE>
			      <TELL
"You plant the weed. " ,IT-LOOKS-LIKE "it might even thrive if
it gets some attention." CR>)>)
		      (ELSE
		       <TELL
,I-DONT-THINK-THAT "even a weed can grow here." CR>)>)
	       (<VERB? THROCK>
		<COND (<FSET? ,WEED ,RWATERBIT> ;"CUT?"
		       <TELL
"The weed shivers, tries very hard to grow in its mutilated
state and then gives up." CR>)
		      (<NOT ,WEED-PLANTED?>
		       <TELL
"The spell envelops the weed, quests around its roots looking for
something, fails to find it and fades." CR>)
		      (<FSET? ,WEED ,RMUNGBIT>
		       <TELL
"The weed grows a few more inches and then stops." CR>)
		      (ELSE
		       <PUTP ,WEED ,P?SIZE 200>
		       <FSET ,WEED ,RMUNGBIT>
		       <TELL
"With a spurt of explosive growth, the weed expands to spectacular size.
It is now as large as a small tree!">
		       <COND (<EQUAL? ,HERE ,CAVE-ENTRANCE>
			      <OGRE-SNEEZING>
			      <TELL
" After a few seconds, you hear a muffled exclamation from within the cave,
and then a volley of sneezes.">)
			     (<EQUAL? ,HERE ,OGRE-CAVE>
			      <OGRE-SNEEZING>
			      <TELL
" As the weed grows, the ogre watches in horror. \"Ragweed!\" he screams,
and then his further comments are cut off by a volley of sneezes like the
reports of a small cannon. The ogre begins to rub his
eyes, which are
watering horrifically, and his sneezes are monumental. He is totally
oblivious to your presence.">)>
		       <CRLF>)>)
	       (<VERB? CASKLY>
		<TELL ,NOTHING-HAPPENS>)
	       (<VERB? LISKON>
		<COND (<PRE-LISKON> <RTRUE>)
		      (<FSET? ,WEED ,RMUNGBIT>
		       <SETG SHRINK-FLAG ,WEED>
		       <PUTP ,WEED ,P?SIZE 3>
		       <QUEUE I-LISKON 15>
		       <TELL
"The weed shrinks back to almost exactly its former size." CR>)>)
	       (<AND <VERB? SHAKE>
		     <EQUAL? ,HERE ,OGRE-CAVE>>
		<PERFORM ,V?WAVE-AT ,PRSO ,OGRE>
		<RTRUE>)>>

<ROUTINE OGRE-SNEEZING ()
	 <QUEUE I-STOP-SNEEZING 10>
	 <SETG SNEEZY? T>>

"DEATH"

<OBJECT DEATH-CUBE
	(IN PRISON)
	(DESC "cube")
	(SYNONYM CUBE CUBES)
	(ADJECTIVE IQ ;C9 SMALL FEATURELESS WHITE)
	(NAME 0)
	(TEXT "worms")
	(FLAGS TAKEBIT)
	(ACTION CUBE-F)
	(DESCFCN CUBE-DESC)
        (GENERIC GENERIC-CUBE-F)
	(CUBE DEATH-ROOM)>

<ROOM DEATH-ROOM
      (IN ROOMS)
      (DESC "Boneyard")
      (CUBE DEATH-CUBE)
      (OUT TO BELWIT-SQUARE)
      (NORTH TO BELWIT-SQUARE)
      (WEST PER MAGIC-BOX-EXIT)
      (ACTION DEATH-ROOM-F)
      (FLAGS ONBIT RLANDBIT)
      (THINGS <PSEUDO (<> BONES PLURAL-PSEUDO)>)>

<ROUTINE DEATH-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a room of bones. Shoulder blades make up the floor, skulls the
walls and leg bones the door frames. The west exit leads into darkness,
but the doorway to the north opens onto a seemingly normal street
scene." CR>)
	       (<EQUAL? .RARG ,M-LEAVE>
		<RECOVER-CUBE>)>>

"CHANGE"

<OBJECT CHANGE-CUBE
	(IN CHUNK)
	(DESC "cube")
	(SYNONYM CUBE CUBES)
	(ADJECTIVE JQ ;C10 SMALL FEATURELESS WHITE)
	(NAME 0)
	(TEXT "butterflies")
	(FLAGS TAKEBIT NDESCBIT)
	(ACTION CUBE-F)
	(DESCFCN CUBE-DESC)
        (GENERIC GENERIC-CUBE-F)
	(CUBE CHANGE-ROOM)>

<ROOM CHANGE-ROOM
      (IN ROOMS)
      (DESC "Changing Room")
      (NORTH TO BARE-ROOM)
      (WEST TO MAZE-ANTEROOM)
      (EAST PER MAGIC-BOX-EXIT)
      (CUBE CHANGE-CUBE)
      (ACTION CHANGE-ROOM-F)
      (FLAGS RLANDBIT)>

<ROOM BARE-ROOM
      (IN ROOMS)
      (DESC "Bare Room")
      (LDESC
"This is a room of smooth bare marble. It has no exits.")
      (FLAGS RLANDBIT)
      (THINGS <PSEUDO (BARE MARBLE MARBLE-PSEUDO)>)>

<ROUTINE MARBLE-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL ,IT-LOOKS-LIKE "bare, smooth marble." CR>)>>

<ROUTINE CHANGE-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The scene here shifts and changes constantly. For example, the exit to
the west is always an exit, but one moment it is an oak door, and the next
a flimsy curtain of beads. The details are impossible to pin down for
longer than a second or two. The eastern and northern exits are equally
fluid." CR>)
	       (<EQUAL? .RARG ,M-LEAVE>
		<RECOVER-CUBE>)>>

<ROOM MAZE-ANTEROOM
      (IN ROOMS)
      (DESC "Carving Room")
      (NORTH TO MAZE-9 IF MAZE-EXIT-FLAG)
      (ACTION MAZE-ANTEROOM-F)
      (EXITS 0)
      (FLAGS RLANDBIT)
      (THINGS <PSEUDO (BLACK MARBLE MARBLE-PSEUDO)>)>

<GLOBAL MAZE-EXIT-FLAG:FLAG <>>

<ROUTINE MAZE-ANTEROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This room is a perfectly carved, smoothed and shaped cube of black marble. ">
		<COND (,MAZE-EXIT-FLAG
		       <TELL
"There is a smallish " ,OCT-HOLE " in the north wall.">)
		      (ELSE
		       <TELL
"There are no exits, but inset in the north wall is a carving of a compass
rose.">)>
		<CRLF>)
	       (<AND <EQUAL? .RARG ,M-LEAVE>
		     <NOT <VERB? BLORPLE>>>
		<SETG MAZE-EXIT-FLAG <>>
		<PUTP ,MAZE-ANTEROOM ,P?EXITS 0>
		<OCT-HOLE-DISAPPEARS>)>>

<ROUTINE OCT-HOLE-DISAPPEARS ()
	 <REMOVE ,OCTAGONAL-HOLE>
	 <TELL
"You slide through the " ,OCT-HOLE ", which constricts and disappears as
soon as you are through it." CR CR>>

<OBJECT COMPASS-CARVING
	(IN MAZE-ANTEROOM)
	(DESC "carving")
	(SYNONYM CARVING ENGRAVE INSET)
	(FLAGS NDESCBIT CONTBIT OPENBIT SEARCHBIT)
	(CAPACITY 10)
	(ACTION COMPASS-CARVING-F)>

<ROUTINE COMPASS-CARVING-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<IN? ,COMPASS-ROSE ,COMPASS-CARVING>
		       <TELL
"The carving is hidden by the real compass rose, which resembles it in
every particular." CR>)
		      (ELSE
		       <TELL
"This carving of a compass rose was made by a master craftsman. All the
delicate filigree one might expect on a real but ornamental counterpart is
here. As though that challenge was not enough, the artist set the carving deep
in the stone of the wall." CR>)>)
	       (<VERB? OPEN REZROV>
		<YOU-CANT-X-PRSO "open">)
	       (<VERB? CLOSE>
		<YOU-CANT-X-PRSO "close">)
	       (<AND <VERB? PUT>
		     <EQUAL? ,COMPASS-CARVING ,PRSO ,PRSI>>
		<COND (<EQUAL? ,COMPASS-ROSE ,PRSO ,PRSI>
		       <MOVE ,COMPASS-ROSE ,COMPASS-CARVING>
		       <COND (,MAZE-EXIT-FLAG
			      <TELL ,NOTHING-HAPPENS>)
			     (ELSE
			      <SETG MAZE-EXIT-FLAG T>
			      <PUTP ,MAZE-ANTEROOM ,P?EXITS ,C-NORTH>
			      <TELL
"The silver rose fits the carving perfectly. As it slides in, an " ,OCT-HOLE 
" appears below the carving. It is small, but large enough to squeeze
through. You notice that the arm pointing north is now dull pot-metal.">
			      <COND (<G? ,COMPASS-ROSE-ARMS 1>
				     <TELL
" Further, all the other arms are silver again!">)>
			      <MOVE ,OCTAGONAL-HOLE ,HERE>
			      <SETG COMPASS-ROSE-ARMS 1>
			      <SETG COMPASS-ROSE-STATE ,C-NORTH>
			      <CRLF>)>)
		      (ELSE
		       <TELL "It won't fit." CR>)>)>>

<OBJECT COMPASS-ROSE
	(IN BARE-ROOM)
	(DESC "compass rose")
	(SYNONYM ROSE ARM ARMS KNOB)
	(ADJECTIVE COMPASS SILVER LEAD)
	(FLAGS TAKEBIT MAGICBIT)
	(DESCFCN COMPASS-ROSE-DESC)
	(ACTION COMPASS-ROSE-F)>

<ROUTINE COMPASS-ROSE-DESC (RARG OBJ)
	 <COND (<NOT <FSET? .OBJ ,TOUCHBIT>>
		<TELL "A " 'COMPASS-ROSE " lies discarded in a corner">)
	       (T
		<TELL "There is a " 'COMPASS-ROSE " here">)>
	 <TELL ,PERIOD>>

<GLOBAL COMPASS-ROSE-STATE:NUMBER 0>
<GLOBAL COMPASS-ROSE-ARMS:NUMBER 0>

<ROUTINE ARM-DIRECTION (N "AUX" (L <GET ,DIR-TABLE 0>))
	 <DO (CNT 1 .L 3)
	     <COND (<EQUAL? <GET ,DIR-TABLE .CNT> .N>
		    <RETURN <GET ,DIR-TABLE <+ .CNT 2>>>)>>>

<ROUTINE COMPASS-ROSE-F ("AUX" (N 1) (1ST? T))
	 <COND (<VERB? EXAMINE>
		<TELL
"Ornate arms indicating the directions grace this lovely silver compass
rose. The central knob tells which arm goes with which
direction. The arms are decorated with mythological scenes">
		<COND (<L? ,COMPASS-ROSE-ARMS 8>
		       <COND (<ZERO? ,COMPASS-ROSE-ARMS>
			      <TELL " in">)
			     (ELSE
			      <TELL ". Oddly, some of the arms are">)>
		       <TELL " finely
wrought silver chased with gold">)>
		<COND (<G? ,COMPASS-ROSE-ARMS 0>
		       <COND (<G? ,COMPASS-ROSE-ARMS 1>
			      <COND (<L? ,COMPASS-ROSE-ARMS 8>
				     <TELL ", while some of the arms (">
				     <REPEAT ()
				      <COND (<EQUAL? .N 256> <RETURN>)
					    (<NOT <EQUAL?
						   <BAND ,COMPASS-ROSE-STATE
							 .N>
						   0>>
					     <COND (.1ST?
						    <SET 1ST? <>>)
						   (ELSE
						    <TELL ", ">)>
					     <TELL <ARM-DIRECTION .N>>)>
				      <SET N <* .N 2>>>
				     <TELL ")">)
				    (ELSE
				     <TELL ". Oddly, all of the arms">)>
			      <TELL " are">)
			     (ELSE
			      <TELL ", while the "
				    <ARM-DIRECTION ,COMPASS-ROSE-STATE>
				    " arm is">)>
		       <TELL " made of ornate lead or
pot-metal chased with brass">)>
		<TELL ".">
		<COND (<AND <EQUAL? ,HERE ,MAZE-ANTEROOM>
			    <NOT <IN? ,COMPASS-ROSE ,COMPASS-CARVING>>>
		       <TELL
" The compass rose exactly fits the carving of a compass rose on
the north wall of the room.">)>
		<CRLF>)
	       (<AND <VERB? COMPARE>
		     <EQUAL? ,COMPASS-ROSE ,PRSO ,PRSI>
		     <EQUAL? ,COMPASS-CARVING ,PRSO ,PRSI>>
		<TELL
"The " 'COMPASS-CARVING " is a carving of the " 'COMPASS-ROSE ,PERIOD>)
	       (<VERB? TURN MOVE RUB SPIN>
		<TELL ,NOTHING-HAPPENS>)>>

<OBJECT NORTH-RUNE
	(IN LOCAL-GLOBALS)
	(DESC "north rune")
	(SYNONYM RUNE RUNES)
	(ADJECTIVE NORTH SILVER LEAD)
	(FLAGS NDESCBIT READBIT)
	(EXITS %,C-NORTH)
	(GENERIC GENERIC-RANDOM-F)
	(ACTION RUNE-F)>

<OBJECT EAST-RUNE
	(IN LOCAL-GLOBALS)
	(DESC "east rune")
	(SYNONYM RUNE RUNES)
	(ADJECTIVE EAST SILVER LEAD)
	(FLAGS NDESCBIT READBIT)
	(EXITS %,C-EAST)
	(GENERIC GENERIC-RANDOM-F)
	(ACTION RUNE-F)>

<OBJECT WEST-RUNE
	(IN LOCAL-GLOBALS)
	(DESC "west rune")
	(SYNONYM RUNE RUNES)
	(ADJECTIVE WEST SILVER LEAD GOLD)
	(FLAGS NDESCBIT READBIT)
	(EXITS %,C-WEST)
	(GENERIC GENERIC-RANDOM-F)
	(ACTION RUNE-F)>

<OBJECT SOUTH-RUNE
	(IN LOCAL-GLOBALS)
	(DESC "south rune")
	(SYNONYM RUNE RUNES)
	(ADJECTIVE SOUTH SILVER LEAD)
	(FLAGS NDESCBIT READBIT)
	(EXITS %,C-SOUTH)
	(GENERIC GENERIC-RANDOM-F)
	(ACTION RUNE-F)>

<OBJECT NE-RUNE
	(IN LOCAL-GLOBALS)
	(DESC "northeast rune")
	(SYNONYM RUNE RUNES)
	(ADJECTIVE NE SILVER LEAD)
	(FLAGS NDESCBIT READBIT)
	(EXITS %,C-NE)
	(GENERIC GENERIC-RANDOM-F)
	(ACTION RUNE-F)>

<OBJECT NW-RUNE
	(IN LOCAL-GLOBALS)
	(DESC "northwest rune")
	(SYNONYM RUNE RUNES)
	(ADJECTIVE NW SILVER LEAD)
	(FLAGS NDESCBIT READBIT)
	(EXITS %,C-NW)
	(GENERIC GENERIC-RANDOM-F)
	(ACTION RUNE-F)>

<OBJECT SE-RUNE
	(IN LOCAL-GLOBALS)
	(DESC "southeast rune")
	(SYNONYM RUNE RUNES)
	(ADJECTIVE SE SILVER LEAD)
	(FLAGS NDESCBIT READBIT)
	(EXITS %,C-SE)
	(GENERIC GENERIC-RANDOM-F)
	(ACTION RUNE-F)>

<OBJECT SW-RUNE
	(IN LOCAL-GLOBALS)
	(DESC "southwest rune")
	(SYNONYM RUNE RUNES)
	(ADJECTIVE SW SILVER LEAD)
	(FLAGS NDESCBIT READBIT)
	(EXITS %,C-SW)
	(GENERIC GENERIC-RANDOM-F)
	(ACTION RUNE-F)>

<ROUTINE RUNE-F ("AUX" DIR)
	 <COND (<VERB? EXAMINE READ>
		<SET DIR <GETP ,PRSO ,P?EXITS>>
		<TELL
"This is the rune for \"" <ARM-DIRECTION .DIR> ",\" made
of inlaid ">
		<COND (<ZERO? <BAND <GETP ,HERE ,P?WALLS> .DIR>>
		       <COND (<AND <EQUAL? ,HERE ,MAZE-2>
				   <EQUAL? .DIR ,C-WEST>>
			      <TELL "gold">)
			     (ELSE
			      <TELL "silver">)>)
		      (ELSE <TELL "lead">)>
		<TELL ,PERIOD>)>>

<ROOM MAZE-1
      (IN ROOMS)
      (DESC "Octagonal Room")
      (ACTION MAZE-F)
      (SOUTH TO MAZE-4)
      (SE TO MAZE-5)
      (EAST TO MAZE-2)
      (EXITS 0)
      (WALLS -1)
      (GLOBAL NORTH-RUNE NE-RUNE EAST-RUNE SE-RUNE
              SOUTH-RUNE SW-RUNE WEST-RUNE NW-RUNE)
      (FLAGS RLANDBIT)
      (THINGS <PSEUDO (BLACK MARBLE MARBLE-PSEUDO)>)>

<OBJECT OCTAGONAL-HOLE
	(IN MAZE-2)
	(SYNONYM HOLE DOOR)
	(ADJECTIVE OCTAGONAL)
	(DESC "octagonal hole")
	(FLAGS DOORBIT NDESCBIT AN CONTBIT OPENBIT VEHBIT)
	(GENERIC GENERIC-HOLE-F)
	(ACTION OCTAGONAL-HOLE-F)>

<ROUTINE OCTAGONAL-HOLE-F ("AUX" E PT PTS)
	 <COND (<AND <EQUAL? ,HERE ,MAZE-2>
		     <IN? ,MAZE-2-DOOR ,HERE>>
		<MAZE-2-DOOR-F>)
	       (<VERB? REZROV>
		<TELL ,IT-IS-ALREADY "open." CR>)
	       (<VERB? LOOK-INSIDE>
		<TELL ,NOW-BLACK CR>)
	       (<VERB? EXAMINE>
		<TELL "It looks like an " ,OCT-HOLE ,PERIOD>)
	       (<AND <VERB? PUT THROW DROP>
		     <HELD? ,PRSO>
		     <EQUAL? ,PRSI ,OCTAGONAL-HOLE>>
		<SET E <GETP ,HERE ,P?EXITS>>
		<SET E <DIR-BASE .E ,DIR-BIT ,DIR-DIR>>
		<SET PT <GETPT ,HERE .E>>
		<SET PTS <PTSIZE .PT>>
		<COND (<OR <EQUAL? .PTS ,UEXIT>
			   <AND <EQUAL? .PTS ,CEXIT>
				<VALUE <GETB .PT ,CEXITFLAG>>>>
		       <MOVE ,PRSO <GETB .PT ,REXIT>>
		       <TELL CTHE ,PRSO " disappears into the hole." CR>)
		      (ELSE
		       <TELL "It won't go." CR>)>)
	       (<VERB? THROUGH BOARD>
		<SET E <GETP ,HERE ,P?EXITS>>
		<COND (<L? .E 256>
		       <DO-WALK <DIR-BASE .E ,DIR-BIT ,DIR-DIR>>)>)>>

<OBJECT MAZE-2-DOOR
	(IN MAZE-2)
	(SYNONYM PLUG)
	(ADJECTIVE ALABASTER)
	(DESC "alabaster plug")
	(FLAGS AN NDESCBIT TAKEBIT TRYTAKEBIT)
	(ACTION MAZE-2-DOOR-F)>

<GLOBAL OCT-HOLE:STRING "octagonal hole">

<ROUTINE DESCRIBE-PLUG ()
	 <TELL
"On the west wall just under the rune is an " ,OCT-HOLE>
	 <COND (<IN? ,MAZE-2-DOOR ,HERE>
		<TELL
" plugged with a perfectly fitting piece of alabaster">)>
	 <TELL ".">>

<ROUTINE MAZE-2-DOOR-F ("AUX" (OPEN? <NOT <IN? ,MAZE-2-DOOR ,HERE>>))
	 <COND (<VERB? EXAMINE>
		<DESCRIBE-PLUG>
		<CRLF>)
	       (<VERB? TAKE MOVE>
		<COND (<NOT <FSET? ,PRSO ,OPENBIT>>
		       <TELL
"You can't budge it." CR>)>)
	       (<VERB? PUSH>
		<COND (.OPEN?
		       <TELL
,THERE-IS-NOTHING "there to push on anymore." CR>)
		      (ELSE
		       <TELL ,NOTHING-HAPPENS>)>)
	       (<VERB? OPEN>
		<TELL
"There is no apparent lock or handle." CR>)
	       (<VERB? CLOSE>
		<COND (.OPEN?
		       <NO-DOOR>)
		      (ELSE
		       <TELL ,IT-IS-ALREADY "closed" ,PERIOD>)>)
	       (<VERB? THROUGH>
		<COND (.OPEN?
		       <DO-WALK ,P?WEST>)
		      (ELSE
		       <NO-DOOR>)>)
	       (<VERB? REZROV>
		<PUTP ,HERE ,P?EXITS 4 ;"WEST">
		<FSET ,OCTAGONAL-HOLE ,OPENBIT>
		<REMOVE ,MAZE-2-DOOR>
		<TELL
"The alabaster melts away, leaving an " ,OCT-HOLE " leading west." CR>)>>

<ROUTINE NO-DOOR ()
	 <TELL "There's no door there." CR>>

<ROOM MAZE-2
      (IN ROOMS)
      (DESC "Octagonal Room")
      (ACTION MAZE-F)
      (WEST TO MAZE-1 IF OCTAGONAL-HOLE IS OPEN)
      (SW TO MAZE-4)
      (SOUTH TO MAZE-5)
      (SE TO MAZE-6)
      (EAST TO MAZE-3)
      (EXITS 0)
      (WALLS %<+ ,C-NW ,C-NORTH ,C-NE>)
      (GLOBAL NORTH-RUNE NE-RUNE EAST-RUNE SE-RUNE
              SOUTH-RUNE SW-RUNE WEST-RUNE NW-RUNE)
      (FLAGS RLANDBIT)
      (THINGS <PSEUDO (BLACK MARBLE MARBLE-PSEUDO)>)>

<ROOM MAZE-3
      (IN ROOMS)
      (DESC "Octagonal Room")
      (ACTION MAZE-F)
      (WEST TO MAZE-2)
      (SW TO MAZE-5)
      (SOUTH TO MAZE-6)
      (EXITS 0)
      (WALLS %<+ ,C-NW ,C-NORTH ,C-NE ,C-EAST ,C-SE>)
      (GLOBAL NORTH-RUNE NE-RUNE EAST-RUNE SE-RUNE
              SOUTH-RUNE SW-RUNE WEST-RUNE NW-RUNE)
      (FLAGS RLANDBIT)
      (THINGS <PSEUDO (BLACK MARBLE MARBLE-PSEUDO)>)>

<ROOM MAZE-4
      (IN ROOMS)
      (DESC "Octagonal Room")
      (ACTION MAZE-F)
      (NORTH TO MAZE-1)
      (NE TO MAZE-2)
      (EAST TO MAZE-5)
      (SE TO MAZE-8)
      (SOUTH TO MAZE-7)
      (EXITS 0)
      (WALLS %<+ ,C-NW ,C-WEST ,C-SW>)
      (GLOBAL NORTH-RUNE NE-RUNE EAST-RUNE SE-RUNE
              SOUTH-RUNE SW-RUNE WEST-RUNE NW-RUNE)
      (FLAGS RLANDBIT)
      (THINGS <PSEUDO (BLACK MARBLE MARBLE-PSEUDO)>)>

<ROOM MAZE-5
      (IN ROOMS)
      (DESC "Octagonal Room")
      (ACTION MAZE-F)
      (NORTH TO MAZE-2)
      (EAST TO MAZE-6)
      (SOUTH TO MAZE-8)
      (WEST TO MAZE-4)
      (EXITS 0)
      (WALLS %<+ ,C-NE ,C-NW ,C-SE ,C-SW>)
      (GLOBAL NORTH-RUNE NE-RUNE EAST-RUNE SE-RUNE
              SOUTH-RUNE SW-RUNE WEST-RUNE NW-RUNE)
      (FLAGS RLANDBIT)
      (THINGS <PSEUDO (BLACK MARBLE MARBLE-PSEUDO)>)>

<ROOM MAZE-6
      (IN ROOMS)
      (DESC "Octagonal Room")
      (ACTION MAZE-F)
      (EXITS 0)
      (NORTH TO MAZE-3)
      (SOUTH TO MAZE-9)
      (SW TO MAZE-8)
      (WEST TO MAZE-5)
      (NW TO MAZE-2)
      (WALLS %<+ ,C-NE ,C-EAST ,C-SE>)
      (GLOBAL NORTH-RUNE NE-RUNE EAST-RUNE SE-RUNE
              SOUTH-RUNE SW-RUNE WEST-RUNE NW-RUNE)
      (FLAGS RLANDBIT)
      (THINGS <PSEUDO (BLACK MARBLE MARBLE-PSEUDO)>)>

<ROOM MAZE-7
      (IN ROOMS)
      (DESC "Octagonal Room")
      (ACTION MAZE-F)
      (EXITS 0)
      (NORTH TO MAZE-4)
      (NE TO MAZE-5)
      (EAST TO MAZE-8)
      (WALLS %<+ ,C-NW ,C-WEST ,C-SW ,C-SOUTH ,C-SE>)
      (GLOBAL NORTH-RUNE NE-RUNE EAST-RUNE SE-RUNE
              SOUTH-RUNE SW-RUNE WEST-RUNE NW-RUNE)
      (FLAGS RLANDBIT)
      (THINGS <PSEUDO (BLACK MARBLE MARBLE-PSEUDO)>)>

<ROOM MAZE-8
      (IN ROOMS)
      (DESC "Octagonal Room")
      (ACTION MAZE-F)
      (EXITS 0)
      (WEST TO MAZE-7)
      (NW TO MAZE-4)
      (NORTH TO MAZE-5)
      (NE TO MAZE-6)
      (EAST TO MAZE-9)
      (WALLS %<+ ,C-SOUTH ,C-SW ,C-SE>)
      (GLOBAL NORTH-RUNE NE-RUNE EAST-RUNE SE-RUNE
              SOUTH-RUNE SW-RUNE WEST-RUNE NW-RUNE)
      (FLAGS RLANDBIT)
      (THINGS <PSEUDO (BLACK MARBLE MARBLE-PSEUDO)>)>

<ROOM MAZE-9
      (IN ROOMS)
      (DESC "Octagonal Room")
      (ACTION MAZE-F)
      (WEST TO MAZE-8)
      (NW TO MAZE-5)
      (NORTH TO MAZE-6)
      (SOUTH TO MAZE-ANTEROOM)
      (EXITS 0)
      (WALLS %<+ ,C-SE ,C-EAST ,C-NE ,C-SW>)
      (GLOBAL NORTH-RUNE NE-RUNE EAST-RUNE SE-RUNE
              SOUTH-RUNE SW-RUNE WEST-RUNE NW-RUNE)
      (FLAGS RLANDBIT)
      (THINGS <PSEUDO (BLACK MARBLE MARBLE-PSEUDO)>)>

<ROUTINE DESCRIBE-MAZE-WALLS ("AUX" (EXITS <GETP ,HERE ,P?EXITS>)
			      (CNT 1) (E 1))
	 <REPEAT ()
		 <COND (<==? .E 256> <RETURN>)
		       (<NOT <EQUAL? <BAND .EXITS .E> 0>>
			<TELL
" The " <ARM-DIRECTION .E> <COND (<G? .E 8> " corner") (ELSE " wall")>
" has a perfect " ,OCT-HOLE " in it, just under the ">
			<COND (<EQUAL? ,HERE ,MAZE-ANTEROOM>
			       <TELL "carving">)
			      (ELSE <TELL "rune">)>
			<TELL ".">)>
		 <SET CNT <+ .CNT 1>>
		 <SET E <* .E 2>>>>

<ROUTINE MAZE-F (RARG "AUX" DIR OEXITS)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This room is in the shape of an octagonal solid carved from marble. The
floor and ceiling are the octagons and each wall is a rectangle. On each
wall is inlaid a rune indicating a direction: the north wall has \"north\"
carved on it, and so on. The ">
		<COND (<EQUAL? ,HERE ,MAZE-1>
		       <TELL "runes are all of lead.">)
		      (ELSE
		       <COND (<EQUAL? ,HERE ,MAZE-2>
			      <TELL "west rune is gold, the ">)>
		       <TELL-WALLS>
		       <TELL " runes are lead, the rest are of silver.">)>
		<COND (<NOT <ZERO? <GETP ,HERE ,P?EXITS>>>
		       <DESCRIBE-MAZE-WALLS>)>
		<COND (<AND <EQUAL? ,HERE ,MAZE-2>
			    <IN? ,MAZE-2-DOOR ,HERE>>
		       <TELL " ">
		       <DESCRIBE-PLUG>)>
		<CRLF>)
	       (<EQUAL? .RARG ,M-ENTER>
		<COND (<EQUAL? ,HERE ,MAZE-2>
		       <MOVE ,OCTAGONAL-HOLE ,HERE>
		       <FCLEAR ,OCTAGONAL-HOLE ,OPENBIT>)>
		<FCLEAR ,HERE ,TOUCHBIT>)
	       (<EQUAL? .RARG ,M-LEAVE>
		<COND (<EQUAL? ,HERE ,MAZE-2>
		       <MOVE ,MAZE-2-DOOR ,MAZE-2>
		       <FCLEAR ,OCTAGONAL-HOLE ,OPENBIT>)>
		<PUTP ,HERE ,P?EXITS 0>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<VERB? WALK>
		       <SET DIR <DIR-BASE ,P-WALK-DIR ,DIR-DIR ,DIR-BIT>>
		       <COND (<NOT <EQUAL? <BAND <GETP ,HERE ,P?EXITS> .DIR>
					   0>>
			      <OCT-HOLE-DISAPPEARS>
			      <V-WALK>)
			     (ELSE
			      <TELL "There is no exit ">
			      <COND (<EQUAL? ,P-WALK-DIR ,P?UP ,P?DOWN>
				     <TELL "there">)
				    (ELSE
				     <TELL "on that wall">)>
			      <TELL ,PERIOD>)>)
		      (<AND <VERB? PUT PUT-ON>
			    <EQUAL? ,PRSO ,COMPASS-ROSE>>
		       <COND (<GLOBAL-IN? ,PRSI ,HERE>
			      <PERFORM ,V?RUB ,PRSI ,PRSO>
			      <RTRUE>)
			     (<AND <IN? ,PRSI ,GLOBAL-OBJECTS>
				   <GETP ,PRSI ,P?EXITS>>
			      <TELL ,THERE-IS-NOTHING "to hang it on." CR>)>)
		      (<AND <VERB? RUB>
			    <EQUAL? ,PRSI ,COMPASS-ROSE>>
		       <SET DIR <GETP ,PRSO ,P?EXITS>>
		       <COND (<AND <EQUAL? ,HERE ,MAZE-2>
				   <EQUAL? .DIR 4>>
			      <TELL ,NOTHING-HAPPENS>)
			     (<AND .DIR
				   <EQUAL? <BAND <GETP ,HERE ,P?WALLS> .DIR>
					   0>
				   <EQUAL? <BAND <GETP ,HERE ,P?EXITS> .DIR>
					   0>
				   <EQUAL? <BAND ,COMPASS-ROSE-STATE .DIR>
					   0>>
			      <SETG COMPASS-ROSE-ARMS
				    <+ ,COMPASS-ROSE-ARMS 1>>
			      <SETG COMPASS-ROSE-STATE
				    <BOR ,COMPASS-ROSE-STATE .DIR>>
			      <SET OEXITS <GETP ,HERE ,P?EXITS>>
			      <PUTP ,HERE ,P?EXITS .DIR>
			      <MOVE ,OCTAGONAL-HOLE ,HERE>
			      <TELL
"As the compass rose touches the " 'PRSO ", the arm of the
rose labelled \"" <ARM-DIRECTION .DIR> "\" turns dull and leaden,
and an " ,OCT-HOLE " large enough for you to squeeze through
appears in the wall below the rune.">
			      <COND (<NOT <ZERO? .OEXITS>>
				     <TELL " The other hole disappears.">)>
			      <CRLF>)
			     (ELSE
			      <TELL ,NOTHING-HAPPENS>)>)>)>>

<ROUTINE TELL-WALLS ("OPTIONAL" (N <>)
		     "AUX" (L <GET ,DIR-TABLE 0>) (1ST? T) (OLD <>))
	 <COND (<NOT .N> <SET N <GETP ,HERE ,P?WALLS>>)>
	 <DO (CNT 1 .L 3)
	     (<TELL " and " .OLD>)
	     <COND (<NOT <ZERO? <BAND <GET ,DIR-TABLE .CNT> .N>>>
		    <COND (.OLD
			   <COND (.1ST? <SET 1ST? <>>)
				 (ELSE <TELL ", ">)>
			   <TELL .OLD>)>
		    <SET OLD <GET ,DIR-TABLE <+ .CNT 2>>>)>>>

"MAGIC"

<OBJECT MAGIC-CUBE
	(IN OUTCROPPING-ROOM)
	(DESC "cube")
	(SYNONYM CUBE CUBES)
	(ADJECTIVE MQ ;C13 SMALL FEATURELESS WHITE)
	(NAME 0)
	(TEXT "unicorns")
	(FLAGS TAKEBIT)
	(ACTION CUBE-F)
	(DESCFCN CUBE-DESC)
        (GENERIC GENERIC-CUBE-F)
	(CUBE MAGIC-ROOM)>

<ROOM MAGIC-ROOM
      (IN ROOMS)
      (DESC "Magic Room")
      (CUBE MAGIC-CUBE)
      (NORTH TO MEADOW-ROOM)
      (EAST PER MAGIC-DOOR-EXIT)
      (SOUTH PER MAGIC-BOX-EXIT)
      (ACTION MAGIC-ROOM-F)
      (FLAGS RLANDBIT)
      (THINGS
       <PSEUDO (<> MIRROR MIRROR-PSEUDO)
	       (BIRD NESTS PLURAL-PSEUDO)
	       (BIRD NEST RANDOM-PSEUDO)
	       (<> WEED PLANTS-PSEUDO)
	       (<> WEEDS PLANTS-PSEUDO)
	       (<> GRASS PLANTS-PSEUDO)
	       (BIRD DROPPINGS PLURAL-PSEUDO)>)>

<ROUTINE MIRROR-PSEUDO ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<PERFORM ,V?EXAMINE ,ME>
		<RTRUE>)
	       (<VERB? RUB>
		<TELL "Nothing happens here." CR>)>>

<ROUTINE MAGIC-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This place is odd indeed. Nothing that you look at is what it seems. If
you look at something carefully enough it turns out to be something
entirely different. The room is cluttered with objects and obviously
hasn't been cleaned in a long time. The floor is overgrown with grass
and weeds, and rabbits have chewed them. There are bird nests around the
ceiling and droppings here and there. A very untidy and unsettling
place. Much of the walls, ceiling and floor is covered in mirrors.
There are empty, mirrorless square areas at north and south and a round
black emptiness to the east." CR>)
	       (<EQUAL? .RARG ,M-LEAVE>
		<RECOVER-CUBE>)>>

<ROUTINE GOT? (CUBE)
	 <OR <EQUAL? .CUBE ,BLORPLE-OBJECT>
	     <HELD? .CUBE>
	     <IN? .CUBE ,CASTLE>>>

<ROUTINE HAS-ALL-CUBES? ()
	 <COND (<EQUAL? <COUNT-CUBES> 13> <RTRUE>)
	       (ELSE <RFALSE>)>>

<ROUTINE COUNT-CUBES ("AUX" (N 0))
	 <DO (CNT 0 12)
	     <COND (<GOT? <GET ,CUBE-LIST <* .CNT 2>>>
		    <SET N <+ .N 1>>)>>
	 .N>

<ROUTINE MAGIC-DOOR-EXIT ()
	 <COND (<HAS-ALL-CUBES?>
		,CASTLE)
	       (ELSE
		<TELL ,YOU-CANT "push your way through." CR>
		<RFALSE>)>>

"TIME CUBE"

<OBJECT TIME-CUBE
	(DESC "cube")
	(SYNONYM CUBE CUBES)
	(ADJECTIVE KQ ;C11 SMALL WHITE)
	(NAME 0)
	(TEXT "turtles")
	(FLAGS TAKEBIT NDESCBIT THE)
	(ACTION CUBE-F)
	(DESCFCN CUBE-DESC)
        (GENERIC GENERIC-CUBE-F)
	(CUBE TIME-ROOM)>

<ROOM TIME-ROOM
      (IN ROOMS)
      (DESC "Sand Room")
      (UP TO PAST-RUINS-ROOM)
      (DOWN TO PAST-CELL-EAST)
      (CUBE TIME-CUBE)
      (ACTION TIME-ROOM-F)
      (FLAGS RLANDBIT)
      (GLOBAL GLOBAL-HOLE)
      (THINGS <PSEUDO (<> SAND SAND-PSEUDO)>)>

<ROUTINE SAND-PSEUDO ()
	 <REDIRECT ,PSEUDO-OBJECT ,GROUND>>

<ROUTINE TIME-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"A thin trickle of sand flows down from an exit in the ceiling of this
circular room to a pile of sand on the floor. The walls of the room are
glass, but you can see nothing through them. In the sand is a hole through
which, oddly enough, no sand is pouring out." CR>)
	       (<EQUAL? .RARG ,M-LEAVE>
		<RECOVER-CUBE>)>>

<ROOM PAST-RUINS-ROOM
      (IN ROOMS)
      (DESC "Ruins Room")
      (NORTH "The water is too deep and cold.")
      (SOUTH "The water is too deep and cold.")
      (ACTION PAST-RUINS-ROOM-F)
      (FLAGS RLANDBIT)
      (GLOBAL WATER)
      (THINGS
       <PSEUDO (<> CHANNEL CHANNEL-PSEUDO)
	       (MOULDERING RUIN RUINS-PSEUDO)
	       (BROKEN PILLAR RUINS-PSEUDO)
	       (FALLEN PILLAR RUINS-PSEUDO)
	       (COLLAPSED PORTICO RUINS-PSEUDO)>)>

<ROUTINE CHANNEL-PSEUDO ()
	 <COND (<VERB? EXAMINE THROUGH>
		<TELL "The channel is buried under rubble." CR>)>>

<ROUTINE PAST-RUINS-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is the south end of a vast chamber filled with partially ruined
structures. Here the portico of a building is collapsing. The pillars
holding it up are starting to crumble. One has recently fallen and
smashed the pavement. The fall exposed and the rubble blocked a small
channel filled with swiftly rushing water which is rapidly inundating
the area. " <GET ,WATER-TABLE ,PAST-WATER-FLAG> CR>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<AND <VERB? PUT>
			    <EQUAL? ,PRSI ,WATER>>
		       <REMOVE ,PRSO>
		       <TELL CTHE ,PRSO " is borne away by the flood." CR>)
		      (<AND <VERB? THROUGH>
			    <OR <EQUAL? ,PRSO ,WATER>
				<EQUAL? ,P-PNAM ,W?CHANNEL>>>
		       <COND (<G? ,PAST-WATER-FLAG 2>
			      <TELL ,YOU-ARE ,PERIOD>)
			     (ELSE
			      <TELL "It's cold and icy." CR>)>)>)
	       (<EQUAL? .RARG ,M-ENTER>
		<COND (<G? ,PAST-WATER-FLAG 0>
		       <SETG DEATHS 3>
		       <JIGS-UP
"You emerge underwater, amidst a dim and blurry vision of drowned columns.
You drown as well.">)
		      (ELSE
		       <MOVE ,GIRGOL-SCROLL ,SACK>
		       <FSET ,GIRGOL-SCROLL ,TOUCHBIT>
		       <QUEUE I-WATER-RISING 3>)>)
	       (<EQUAL? .RARG ,M-LEAVE>
		<REMOVE ,PLAYER>
		<DEQUEUE I-WATER-RISING>
		<COND (<AND <NOT ,DEAD?>
			    <ONLY? ,ZIPPER ,HERE>
			    <ONLY? ,GIRGOL-SCROLL ,ZIPPER>
			    <NOT <FSET? ,ZIPPER ,OPENBIT>>>
		       <MOVE ,PLAYER ,HERE>
		       <SETG SCORE <+ ,SCORE ,RUINS-SCORE>>
		       <SETG RUINS-SCORE 0>)
		      (ELSE
		       <MOVE ,PLAYER ,HERE>
		       <MOVE ,GIRGOL-SCROLL ,SACK>
		       <MOVE ,SACK ,HERE>
		       <TELL
,TIME-SICK "You feel that you are being pummelled by huge
rocks and boulders">
		       <SETG DEATHS 3>
		       <JIGS-UP
", again and again. Finally, you succumb.">)>)>>

<GLOBAL RUINS-SCORE:NUMBER 25>

<GLOBAL TIME-SICK:STRING
"As you leave, your consciousness is wrenched as though your memories
were being torn apart. ">

<ROUTINE ONLY? (OBJ CON)
	 <COND (<NOT <IN? .OBJ .CON>> <RFALSE>)
	       (<NOT <SET CON <FIRST? .CON>>> <RFALSE>)
	       (<NOT <EQUAL? .OBJ .CON>> <RFALSE>)
	       (<NEXT? .CON> <RFALSE>)
	       (ELSE <RTRUE>)>>

<OBJECT SACK
	(IN PAST-RUINS-ROOM)
	(DESC "sack")
	(SYNONYM SACK BAG)
	(ADJECTIVE BURLAP)
	(ACTION SACK-F)
	(FLAGS TAKEBIT CONTBIT SEARCHBIT)
	(CAPACITY 200)>

<ROUTINE SACK-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"This is a burlap sack of medium size. ">
		<TELL-OPEN-CLOSED ,SACK>)
	       (<AND <VERB? OPEN>
		     <NOT <FSET? ,SACK ,OPENBIT>>>
		<FSET ,SACK ,OPENBIT>
		<TELL
"Opening the " 'SACK " reveals ">
		<WHAT-CONTENTS>)
	       (<VERB? LOOK-INSIDE>
		<TELL CTHE ,SACK " is ">
		<COND (<FSET? ,SACK ,OPENBIT>
		       <TELL "dim inside, but you can see ">
		       <COND (<NOT <PRINT-CONTENTS ,SACK>>
			      <TELL "that it's empty">)>
		       <TELL ".">)
		      (ELSE
		       <TELL "closed.">)>
		<CRLF>)>>

<GLOBAL WATER-TABLE:TABLE
	<PTABLE
"You are in a small area not yet flooded."
"The water has left only a tiny area dry."
"The water has covered the entire floor. Your feet are wet."
"The water is up to your waist."
"You are in water over your head.">>

<ROOM PAST-CELL-EAST
      (IN ROOMS)
      (DESC "Dungeon Cell")
      (SOUTH PER PAST-CELL-EAST-EXIT)
      (ACTION PAST-CELL-EAST-F)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL CELL-DOOR)
      (THINGS
       <PSEUDO (<> CELL CELL-PSEUDO)
	       (BURLY GUARDS CASTLE-GUARDS-PSEUDO)
	       (RICH HANGINGS PLURAL-PSEUDO)
	       (ORNAMENTED FURNITURE RANDOM-PSEUDO)>)>

<ROUTINE PAST-CELL-EAST-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a luxurious cell, obviously for the imprisonment of a
highborn or powerful person. Its rich hangings and heavily ornamented
furniture speak of a prisoner whose comfort is important even during
imprisonment. A massive oak cabinet dominates one wall. ">
		<TELL-OPEN-CLOSED ,PAST-CABINET>
		<TELL-OPEN-CLOSED ,CELL-DOOR>)
	       (<EQUAL? .RARG ,M-LEAVE>
		<DEQUEUE I-PRISON-GUARDS>
		<REMOVE ,PLAYER>
		<COND (<AND <NOT ,DEAD?>
			    <NOT <FSET? ,PAST-CABINET ,RMUNGBIT>>
			    <FSET? ,PAST-CABINET ,LOCKED>
			    <FSET? ,CELL-DOOR ,OPENBIT>
			    <ONLY? ,SPELL-BOOK ,PAST-CABINET>
			    <ONLY? ,PAST-CABINET ,HERE>>
		       <SETG SCORE <+ ,SCORE 25>>
		       <MOVE ,PLAYER ,HERE>)
		      (ELSE
		       <MOVE ,PLAYER ,HERE>
		       <MOVE ,BLANK-SCROLL ,PAST-CABINET>
		       <COND (<NOT ,DEAD?>
			      <TIME-SICK-CELL-EAST>)>)>)
	       (<EQUAL? .RARG ,M-ENTER>
		<COND (<IN? ,SPELL-BOOK ,PAST-CABINET>
		       <JIGS-UP ,PAST-CELL-GUARDS-KILL-YOU>)>)>>

<ROUTINE TIME-SICK-CELL-EAST ()
	 <TELL
,TIME-SICK "You feel that you are being devoured by monsters
and pulled screaming beneath the water simultaneously">
	 <SETG DEATHS 3>
	 <JIGS-UP
", again and again. Finally, you succumb.">>

<OBJECT CELL-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "cell door")
	(SYNONYM DOOR)
	(ADJECTIVE CELL)
	(ACTION CELL-DOOR-F)
	(FLAGS LOCKED DOORBIT)>

<ROUTINE CELL-DOOR-F ()
	 <COND (<VERB? OPEN>
		<TELL "The door is locked." CR>)
	       (<VERB? THROUGH>
		<DO-WALK <COND (<EQUAL? ,HERE ,PAST-CELL-EAST ,CELL-EAST>
				,P?SOUTH)
			       (ELSE ,P?NORTH)>>)
	       (<VERB? REZROV>
		<COND (<HELD? ,MAGIC-CUBE>
		       <FCLEAR ,CELL-DOOR ,LOCKED>
		       <FSET ,CELL-DOOR ,OPENBIT>
		       <QUEUE I-PRISON-GUARDS 2>
		       <TELL
"The door bursts outward in an explosion of power! Immediately, you hear
the shouts of guards and the rattle of weapons." CR>)
		      (ELSE
		       <REZROV-TOUGH-DOOR>)>)>>

<ROUTINE PAST-CELL-EAST-EXIT ()
	 <COND (<FSET? ,CELL-DOOR ,OPENBIT>
		<JIGS-UP ,PAST-CELL-GUARDS-KILL-YOU>
		<RFALSE>)
	       (ELSE
		<TELL ,DOOR-LOCKED>
		<TELL ,PERIOD>
		<RFALSE>)>>

<GLOBAL PAST-CELL-GUARDS-KILL-YOU:STRING
"You exit into a tangle of guards, who promptly dispatch you for escaping
and resisting arrest.">

<GLOBAL DOOR-LOCKED:STRING "The door is closed and locked">

"CONNECTIVITY CUBE"

<OBJECT CONNECTIVITY-CUBE
	(IN ROC-NEST)
	(DESC "cube")
	(SYNONYM CUBE CUBES)
	(ADJECTIVE LQ ;C12 SMALL FEATURELESS WHITE)
	(NAME 0)
	(TEXT "spiders")
	(FLAGS TAKEBIT TRYTAKEBIT NDESCBIT)
	(ACTION CUBE-F)
	(DESCFCN CUBE-DESC)
        (GENERIC GENERIC-CUBE-F)
	(CUBE CONNECTIVITY-ROOM)>

<ROOM CONNECTIVITY-ROOM
      (IN ROOMS)
      (DESC "String Room")
      (EAST PER MAGIC-BOX-EXIT)
      (SOUTH TO RETREAT)
      (CUBE CONNECTIVITY-CUBE)
      (ACTION CONNECTIVITY-ROOM-F)
      (FLAGS RLANDBIT)>

<ROUTINE CONNECTIVITY-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is the nexus of a web of multicolored strings and threads of
light. They come in from the far distance in graceful curves or tangled,
jagged paths. In the center of the room they tie together into a ball
that looks like gossamer yarn or glowing cotton candy. One bright set of
threads points south to a gap in the weave and another points east to
a similar gap." CR>)
	       (<EQUAL? .RARG ,M-LEAVE>
		<RECOVER-CUBE>)>>

<ROUTINE CUBE-NAME (CUBE "AUX" WRD CNT CHR)
	 <SET WRD <GETP .CUBE ,P?NAME>>
	 <COND (<NOT <ZERO? .WRD>>
		<SET CNT <GET .WRD 1>>
		<SET WRD <REST .WRD 4>>
		<TELL "\"">
		<REPEAT ()
			<COND (<ZERO? <SET CHR <GETB .WRD 0>>>
			       <RETURN>)>
			<PRINTC .CHR>
			<SET WRD <REST .WRD>>
			<SET CNT <- .CNT 1>>
			<COND (<EQUAL? .CNT 0>
			       <RETURN>)>>
		<TELL "\"">)
	       (ELSE <TELL "no word">)>>

<OBJECT QWORD
	(IN GLOBAL-OBJECTS)
	(DESC "handwritten word")
	(SYNONYM QWORD)
	(FLAGS NDESCBIT)>

<GLOBAL CUBE-LIST:TABLE
	<PTABLE EARTH-CUBE <VOC "AQ" ADJECTIVE>
		WATER-CUBE <VOC "BQ" ADJECTIVE>
		AIR-CUBE <VOC "CQ" ADJECTIVE>
		FIRE-CUBE <VOC "DQ" ADJECTIVE>
		DARK-CUBE <VOC "EQ" ADJECTIVE>
		MIND-CUBE <VOC "FQ" ADJECTIVE>
		LIGHT-CUBE <VOC "GQ" ADJECTIVE>
		LIFE-CUBE <VOC "HQ" ADJECTIVE>
		DEATH-CUBE <VOC "IQ" ADJECTIVE>
		CHANGE-CUBE <VOC "JQ" ADJECTIVE>
		TIME-CUBE <VOC "KQ" ADJECTIVE>
		CONNECTIVITY-CUBE <VOC "LQ" ADJECTIVE>
		MAGIC-CUBE <VOC "MQ" ADJECTIVE>
		CUBE-1 <VOC "AZ" ADJECTIVE>
		CUBE-2 <VOC "BZ" ADJECTIVE>
		CUBE-3 <VOC "CZ" ADJECTIVE>
		CUBE-4 <VOC "DZ" ADJECTIVE>
		CUBE-5 <VOC "EZ" ADJECTIVE>
		CUBE-6 <VOC "FZ" ADJECTIVE>
		CUBE-7 <VOC "GZ" ADJECTIVE>
		CUBE-8 <VOC "HZ" ADJECTIVE>
		CUBE-9 <VOC "IZ" ADJECTIVE>
		CUBE-10 <VOC "JZ" ADJECTIVE>
		CUBE-11 <VOC "KZ" ADJECTIVE>>>

<ROUTINE CUBE-ADJ (OBJ "AUX" TBL)
	 <COND (<SET TBL <ZMEMQ .OBJ ,CUBE-LIST 47>>
		<GET .TBL 1>)>>

<ROUTINE WRITE-ON-CUBE (OBJ "AUX" ADJ PTR F)
	 <COND (<SET ADJ <CUBE-ADJ .OBJ>>
		<COND (<ZERO? <SET PTR <GETP .OBJ ,P?NAME>>>
		       <SET F <GETPT .OBJ ,P?ADJECTIVE>>
		       <PUTB .F 1 <GETB .F 2>> ;"REMOVE 'FEATURELESS' AS ADJ."
		       <SET PTR ,P-QNEXT>
		       <SETG P-QNEXT <REST ,P-QNEXT 10>>
		       <PUT ,P-QNEXT 0 <>>)>
		<PUTP .OBJ
		      ,P?NAME
		      %<COND (<GASSIGNED? ZILCH> '.PTR)
			     (ELSE '<CHTYPE .PTR TABLE>)>>
		<FSET .OBJ ,THE>
		<QCOPY .ADJ ,P-QWORD .PTR>
		.ADJ)>>


