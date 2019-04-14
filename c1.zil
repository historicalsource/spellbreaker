"C1 for
				MAGE
	(c) Copyright 1985 Infocom, Inc. All Rights Reserved."

<OBJECT BURIN
	(IN PLAYER)
	(DESC "magic burin")
	(SYNONYM BURIN SCRIBE ENGRAVE)
	(ADJECTIVE SHARP MAGIC)
	(FLAGS TAKEBIT MAGICBIT TOUCHBIT TOOLBIT WEAPONBIT)
	(ACTION BURIN-F)>

<ROUTINE BURIN-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"This is a magical burin, used for inscribing objects with words or runes
of magical import. Such a burin also gives you the ability to write
spell scrolls." CR>)
	       (<VERB? WHAT>
		<TELL
"A burin is an engraving and writing tool." CR>)>>

<ROOM DULL-ROOM
      (IN ROOMS)
      (DESC "Nondescript Room")
      (OUT PER DULL-ROOM-EXIT)
      (SOUTH PER DULL-ROOM-EXIT)
      (ACTION DULL-ROOM-F)
      (FLAGS RLANDBIT)>

<ROUTINE DULL-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a drab, nondescript room. The only exit leads south." CR>)
	       (<EQUAL? .RARG ,M-LEAVE>
		<RECOVER-CUBE>)>>

<ROUTINE DULL-ROOM-EXIT ()
	 <COND (<EQUAL? ,DULL-ROOM-RETURN ,CASTLE>
		<MAGIC-DOOR-EXIT>)
	       (ELSE ,DULL-ROOM-RETURN)>>

<GLOBAL DULL-ROOM-RETURN:OBJECT <>>

"EARTH"

<OBJECT EARTH-CUBE
	(DESC "cube")
	(SYNONYM CUBE CUBES)
	(ADJECTIVE AQ ;C1 SMALL FEATURELESS WHITE)
	(NAME 0)
	(TEXT "moles")
	(FLAGS INVISIBLE TAKEBIT)
	(ACTION CUBE-F)
	(DESCFCN CUBE-DESC)
        (GENERIC GENERIC-CUBE-F)
	(CUBE EARTH-ROOM)>

<ROOM EARTH-ROOM
      (IN ROOMS)
      (DESC "Packed Earth")
      (NORTH PER MAGIC-BOX-EXIT)
      (EAST TO HALL-OF-STONE)
      (WEST TO CAVE-ENTRANCE)
      (SOUTH TO CLIFF-MIDDLE)
      (DOWN PER MIDAIR-EXIT)
      (CUBE EARTH-CUBE)
      (ACTION EARTH-ROOM-F)
      (FLAGS RLANDBIT)
      (GLOBAL GLOBAL-HOLE)
      (THINGS
       <PSEUDO (PACKED EARTH RANDOM-PSEUDO)
	       (<> MUD RANDOM-PSEUDO)
	       (<> SOD RANDOM-PSEUDO)
	       (LEATHER THONG RANDOM-PSEUDO)
	       (LEATHER THONGS PLURAL-PSEUDO)>)>

<ROUTINE EARTH-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a small room crudely constructed of packed earth, mud, and sod.
Crudely framed openings of wood tied with leather thongs lead off in each
of the four cardinal directions, and a muddy hole leads down." CR>)
	       (<EQUAL? .RARG ,M-LEAVE>
		<RECOVER-CUBE>)>>

<ROOM HALL-OF-STONE
      (IN ROOMS)
      (DESC "Hall of Stone")
      (NORTH TO SOUTH-SNAKE-ROOM)
      (SOUTH TO RUINS-ROOM)
      (ACTION HALL-OF-STONE-F)
      (FLAGS RLANDBIT)
      (THINGS
       <PSEUDO (MOULDERING RUIN RUINS-PSEUDO)
	       (STONE BLOCKS RUINS-PSEUDO)
	       (DRESSED STONE RUINS-PSEUDO)>)>

<ROUTINE HALL-OF-STONE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a long hall built of crudely dressed stone. The blocks are as tall
as you and the ceiling invisible in the gloom above. Dirt trickles from gaps
in the walls and ceiling. The atmosphere is oppressive, and there is a dry,
stale smell all around. The corridor extends north and south from here." CR>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<AND <VERB? SMELL> <NOT ,PRSO>>
		       <TELL
"It smells dry and stale." CR>)>)>>

<ROOM NORTH-SNAKE-ROOM
      (IN ROOMS)
      (DESC "North of Serpent")
      (SOUTH PER SNAKE-ROOM-EXIT)
      (NORTH TO TEMPLE-ROOM)
      (EAST PER SNAKE-ROOM-EXIT)
      (WEST PER SNAKE-ROOM-EXIT)
      (ACTION SNAKE-ROOM-F)
      (FLAGS RLANDBIT)
      (GLOBAL SNAKE)
      (THINGS <PSEUDO (SNAKE EYE SNAKE-EYE-PSEUDO)
		      (SERPENT EYE SNAKE-EYE-PSEUDO)
		      (SNAKE MOUTH RANDOM-PSEUDO)
		      (SERPENT MOUTH RANDOM-PSEUDO)
		      (SNAKE SCALES SNAKE-SCALES-PSEUDO)
		      (SERPENT SCALES SNAKE-SCALES-PSEUDO)>)>

<ROUTINE SNAKE-EYE-PSEUDO ()
	 <REDIRECT ,PSEUDO-OBJECT ,EYES>>

<ROUTINE SNAKE-SCALES-PSEUDO ()
	 <COND (<OR <VERB? EXAMINE>
		    <HOSTILE-VERB?>>
		<HACK-SNAKE>)>>

<ROUTINE HACK-SNAKE ()
	 <TELL "The steel-like scales are ">
	 <COND (<VERB? RUB>
		<TELL "cool to the touch">)
	       (ELSE
		<TELL
		 "impervious to your puny strength">)>
	 <TELL ,PERIOD>>

<ROOM SOUTH-SNAKE-ROOM
      (IN ROOMS)
      (DESC "Smooth Room")
      (NORTH PER SNAKE-ROOM-EXIT)
      (SOUTH TO HALL-OF-STONE)
      (EAST PER SNAKE-ROOM-EXIT)
      (WEST PER SNAKE-ROOM-EXIT)
      (ACTION SNAKE-ROOM-F)
      (FLAGS RLANDBIT)
      (GLOBAL SNAKE)
      (THINGS <PSEUDO (SNAKE EYE SNAKE-EYE-PSEUDO)
		      (SERPENT EYE SNAKE-EYE-PSEUDO)
		      (SNAKE MOUTH RANDOM-PSEUDO)
		      (SERPENT MOUTH RANDOM-PSEUDO)
		      (SNAKE SCALES SNAKE-SCALES-PSEUDO)
		      (SERPENT SCALES SNAKE-SCALES-PSEUDO)>)>

<ROUTINE SNAKE-ROOM-EXIT ()
	 <COND (<EQUAL? ,SHRINK-FLAG ,SNAKE>
		<COND (<EQUAL? ,P-WALK-DIR ,P?NORTH ,P?SOUTH>
		       <TELL
"The snake is pleasurably stretching its
mouth and rippling its scaly body in the unaccustomed space.
It barely hisses as you go by." CR CR>
		       <COND (<EQUAL? ,HERE ,SOUTH-SNAKE-ROOM>
			      ,NORTH-SNAKE-ROOM)
			     (ELSE
			      ,SOUTH-SNAKE-ROOM)>)
		      (ELSE
		       <TELL
"Avoiding the snake, you carefully head "
 <COND (<EQUAL? ,P-WALK-DIR ,P?EAST> "east")
			   (ELSE "west")> ". The corridor is smooth
and circular. It eventually leads back to where you started." CR CR>
		       ,HERE)>)
	       (<EQUAL? ,P-WALK-DIR ,P?NORTH ,P?SOUTH>
		<TELL
"The serpent completely fills the passage." CR>
		<RFALSE>)
	       (ELSE
		<TELL
"The serpent fills the entire corridor. There is no space to
squeeze by." CR>
		<RFALSE>)>>

<ROUTINE SNAKE-ROOM-F (RARG "AUX" N?)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Here a long north-south corridor meets an east-west cross corridor
whose walls are polished to almost mirror smoothness.
Just to your ">
		<COND (<SET N? <EQUAL? ,HERE ,NORTH-SNAKE-ROOM>>
		       <TELL "south">)
		      (ELSE <TELL "north">)>
		<COND (<EQUAL? ,SHRINK-FLAG ,SNAKE>
		       <TELL
" is a large snake whose head pokes out of one side of
the cross corridor and the tip of whose tail pokes out the other side.
You can see that ahead is more of the crudely built main hall, and beyond
that is a dark area.">)
		      (ELSE
		       <TELL
" is a huge scaly mass which fills the entire cross
corridor. Its thickness is more than three times your height and
its length is unguessable.">)>
		<CRLF>)
	       (<EQUAL? .RARG ,M-ENTER>
		<COND (<NOT <FSET? ,SOUTH-SNAKE-ROOM ,TOUCHBIT>>
		       <QUEUE I-SNAKE 1>)>)>>

<OBJECT SNAKE
	(IN LOCAL-GLOBALS)
	(DESC "serpent")
	(SYNONYM SERPENT SNAKE MASS CREATURE)
	(ADJECTIVE HUGE LARGE SCALY MONSTER)
	(ACTION SNAKE-F)
	(SIZE 200)
	(FLAGS NDESCBIT PERSON THE TAKEBIT TRYTAKEBIT VEHBIT)>

<ROUTINE SNAKE-F ()
	 <COND (<EQUAL? ,WINNER ,SNAKE>
		<COND (<TIME-FROZEN?>
		       <IMMOBILE>
		       <RTRUE>)
		      (ELSE
		       <TELL
"\"Sssss...\" You can't understand the " 'SNAKE ,PERIOD>)>
		<END-QUOTE>)
	       (<VERB? EXAMINE>
		<COND (<EQUAL? ,SNAKE ,SHRINK-FLAG>
		       <TELL
"The snake is no longer gargantuan. Its tail sticks
out one side of the corridor and its head the other, no longer filling
the corridor.">)
		      (ELSE
		       <TELL
"It is huge, filling the entire corridor it occupies.">
		       <COND (<NOT <TIME-FROZEN?>>
		       <TELL " It stares at you
balefully, hissing like a small steam engine. It appears completely
unconcerned that it has swallowed its own tail.">)>)>
		<COND (<TIME-FROZEN?>
		       <TELL " ">
		       <IMMOBILE>
		       <RTRUE>)>
		<CRLF>)
	       (<VERB? BOARD CLIMB-FOO CLIMB-UP CLIMB-OVER CLIMB-ON>
		<TELL
"The scales are too slippery">
		<COND (<NOT <TIME-FROZEN?>>
		       <TELL ", and the serpent's eye fixes you with
a stare that removes much of your interest in getting that close">)
		      (ELSE
		       <TELL ". ">
		       <IMMOBILE>
		       <RTRUE>)>
		<TELL ,PERIOD>)
	       (<VERB? LISTEN>
		<TELL
"It sounds like a leaky steam engine." CR>)
	       (<HOSTILE-VERB?>
		<HACK-SNAKE>)
	       (<VERB? THROW-OFF>
		<COND (<NOT <EQUAL? ,SHRINK-FLAG ,SNAKE>>
		       <MOVE ,PRSO ,HERE>
		       <TELL
CTHE ,PRSO " hits the snake and drops to the floor." CR>)
		      (ELSE
		       <PERFORM ,V?THROW ,PRSO>
		       <RTRUE>)>)
	       (<VERB? GIVE>
		<UNINTERESTED ,SNAKE>)
	       (<VERB? RUB>
		<HACK-SNAKE>)
	       (<VERB? TAKE>
		<TELL
"The creature is taller than a house, and longer than the tallest tree
is tall." CR>)
	       (<VERB? FROTZ>
		<TELL
"The snake glows dimly as the spell stretches to cover it, but then the
glow winks out." CR>)
	       (<VERB? LISKON>
		<COND (<EQUAL? ,SHRINK-FLAG ,SNAKE>
		       <TELL ,NOTHING-HAPPENS>)
		      (<NOT <PRE-LISKON>>
		       <SETG SHRINK-FLAG ,SNAKE>
		       <QUEUE I-LISKON 15>
		       <TELL
"The serpent shrinks. You can see it thinning out, filling
less and less of the corridor. At first it doesn't seem to be growing
any shorter, but then you realize that this isn't true.
It has swallowed so much of its own tail that it makes up
the deficiency by disgorging more tail. Finally, just before the spell
stops, the tail tip slips out of the snake's mouth and almost disappears
down the western corridor." CR>)>)
	       (<VERB? SNAVIG>
		<SETG AWAKE 5>
		<QUEUE I-TIRED 5>
		<TELL
"The spell strains to change you into a serpent, but you're just too
small. Finally, you snap back to your normal appearance, and you feel
very, very tired." CR>)
	       (<VERB? GIRGOL>
		<COND (<EQUAL? ,SHRINK-FLAG ,SNAKE>
		       <TELL ,NOTHING-HAPPENS>)>)
	       (<VERB? YOMIN>
		<TELL CTHE ,SNAKE " is ">
		<COND (<EQUAL? ,SHRINK-FLAG ,SNAKE>
		       <TELL
"almost overcome by the sheer joy of being
able to writhe and stretch." CR>)
		      (ELSE
		       <TELL
"bored, constricted, and caged. It's in a surly mood, thinking of
its past. It was once a simple temple snake, well fed on sacrifices. It
was too well fed, for it grew great, and its pride grew as well. For
declaring itself the greatest of snakes, it was prisoned here, forced to
swallow its own tail in mimicry of the true master of serpents. That was an
age ago." CR>)>)
	       (<VERB? ESPNIS>
		<TELL
"The snake yawns briefly, but the spell is too attenuated by the creature's
huge mass to do more." CR>)>>

<ROOM TEMPLE-ROOM
      (IN ROOMS)
      (DESC "Temple")
      (SOUTH TO NORTH-SNAKE-ROOM)
      (ACTION TEMPLE-ROOM-F)
      (FLAGS RLANDBIT)
      (THINGS
       <PSEUDO (BLACK PILLAR RUINS-PSEUDO)
	       (BASALT PILLAR RUINS-PSEUDO)
	       (BROKEN PILLAR RUINS-PSEUDO)
	       (MOULDERING RUIN RUINS-PSEUDO)
	       (HUGE FRAGMENT RUINS-PSEUDO)
	       (<> RAFTER RUINS-PSEUDO)
	       (<> BATS PLURAL-PSEUDO)
	       (<> BAT RANDOM-PSEUDO)
	       (BAT GUANO RANDOM-PSEUDO)>)>

<ROUTINE TEMPLE-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a ruined temple to a forgotten god. Black basalt pillars
reach to the ceiling, but some are broken and lie in huge fragments on the
ground. The air is stale and filled with the odor of decay. Bats roost in
the rafters, the only remaining worshippers. Before the temple "
<COND (,IDOL-ASLEEP? "rests")(T "stands")> " a tall basalt
idol in the form of a huge rodent. Its fang-bedecked mouth is ">
		<COND (,IDOL-YAWNING?
		       <TELL "open in an embarrassing yawn.">)
		      (,IDOL-ASLEEP?
		       <TELL "closed tightly.">)
		      (ELSE
		       <TELL "open slightly, exposing teeth and tongue.">)>
		<CRLF>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<AND <VERB? SMELL>
			    <EQUAL? ,PRSO <> ,GLOBAL-ROOM>>
		       <TELL
"It smells of decay, rot, and centuries-long accumulation of bat
guano." CR>)>)>>

<OBJECT IDOL
	(IN TEMPLE-ROOM)
	(DESC "rodent idol")
	(SYNONYM IDOL GOD SCULPTURE STATUE)
	(ADJECTIVE RODENT FORGOTTEN HUGE BASALT TALL)
	(ACTION IDOL-F)
	(FLAGS NDESCBIT ;SEARCHBIT VEHBIT TAKEBIT SURFACEBIT
	       THE TRYTAKEBIT CONTBIT OPENBIT)>

<GLOBAL IDOL-SLEEPED? <>>	;"HIT WITH SLEEP SPELL?"
<GLOBAL IDOL-YAWNING? <>>	;"YAWNING?"
<GLOBAL IDOL-ASLEEP? <>>	;"SOUND ASLEEP"

<ROUTINE IDOL-F ("OPTIONAL" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-BEG>
		<FSET ,MOUTH ,SEARCHBIT>
		<COND (<OR <VERB? CLIMB-DOWN DISEMBARK>
			   <AND <VERB? WALK>
				<EQUAL? ,P-WALK-DIR ,P?DOWN>>>
		       <MOVE ,PLAYER ,HERE>
		       <TELL
"You climb off the idol." CR>)
		      (<VERB? WALK>
		       <TELL
,YOU-HAVE-TO " climb down first." CR>)
		      (<AND <VERB? BOARD CLIMB-FOO CLIMB-ON CLIMB-UP THROUGH>
			    <EQUAL? ,PRSO ,IDOL>>
		       <TELL
"You are clinging to the idol already." CR>)
		      (<VERB? LEAP>
		       <MOVE ,PLAYER ,HERE>
		       <TELL
"You carelessly leap off the idol." CR>)
		      (<AND <VERB? TAKE>
			    <FSET? ,PRSO ,TAKEBIT>
			    <NOT-IN-VEHICLE?>>
		       <CANT-REACH-THAT>)
		      (<VERB? DROP>
		       <COND (<EQUAL? ,PRSO ,OPAL ,IDOL> <RFALSE>)
			     (<IDROP>
			      <MOVE ,PRSO ,HERE>
			      <TELL "Dropped." CR>)
			     (ELSE <RTRUE>)>)>)
	       (<NOT .RARG>
		<FSET ,IDOL ,SEARCHBIT>
		<COND (<VERB? EXAMINE>
		       <TELL
"The idol is carved of black basalt. It is about twenty feet tall and
represents a gigantic and ferocious rodent-like creature with sharp teeth
and one staring">
		       <COND (<AND <IN? ,OPAL ,IDOL>
				   <NOT ,OPAL-LOOSE?>>
			      <TELL " opalescent eye">)
			     (ELSE
			      <TELL ", empty eye socket">)>
		       <TELL ".">
		       <COND (<NOT <IN? ,PLAYER ,IDOL>>
			      <TELL
" The sculpture is rough enough to offer climbing holds.">)>
		       <COND (,IDOL-YAWNING?
			      <TELL
" Oddly, the idol is yawning, its mouth gaping open.">)
			     (,IDOL-ASLEEP?
			      <TELL
" The idol is sculpted as though sound asleep.">)>
		       <CRLF>)
		      (<AND <VERB? GIVE SEARCH TELL HELLO TAKE WAVE-AT>
			    <FSET? ,IDOL ,PERSON>>
		       <COND (<VERB? TELL>
			      <END-QUOTE>)>
		       <JIGS-UP ,IDOL-CRUSHES-YOU>)
		      (<VERB? TAKE>
		       <TELL
"The idol reaches all the way to the ceiling and is made of basalt. This
is beyond your strength." CR>)
		      (<HOSTILE-VERB?>
		       <COND (<FSET? ,IDOL ,PERSON>
			      <JIGS-UP ,IDOL-CRUSHES-YOU>)
			     (ELSE
			      <TELL ,WASTE-OF-TIME>)>)
		      (<VERB? LOOK-INSIDE>
		       <PERFORM ,PRSA ,MOUTH>
		       <RTRUE>)
		      (<VERB? KISS RUB>
		       <COND (<FSET? ,IDOL ,PERSON>
			      <JIGS-UP ,IDOL-CRUSHES-YOU>)
			     (ELSE
			      <TELL
"The idol is stonelike to the touch." CR>)>)
		      (<VERB? BOARD CLIMB-FOO CLIMB-ON CLIMB-UP>
		       <COND (<FSET? ,IDOL ,PERSON>
			      <JIGS-UP ,IDOL-CRUSHES-YOU>)
			     (ELSE
			      <MOVE ,PLAYER ,IDOL>
			      <COND (,IDOL-ASLEEP?
				     <TELL
"Okay, you are now on the sleeping idol." CR>)
				    (ELSE
				     <TELL
"You can find enough holds to climb all the way up to the head, where you
gaze warily at the idol's mouth." CR>)>)>)
		      (<VERB? MALYON>
		       <COND (<FSET? ,IDOL ,PERSON>
			      <TELL "It looks pretty animated to me." CR>)
			     (ELSE
			      <FSET ,MOUTH ,SEARCHBIT>
			      <TELL
"The idol quivers, comes to life,">
			      <COND (<ROB ,MOUTH <> ,AIR-CUBE>
				     <REMOVE ,AIR-CUBE>
				     <SETG LIT <LIT? ,HERE>>
				     <TELL " swallows,">)>
			      <COND (,IDOL-ASLEEP?
				     <TELL " gets to its feet">)>
			      <TELL " and ">
			      <COND (<IN? ,PLAYER ,IDOL>
				     <TELL
"notices you climbing on it (no doubt from
the itching). It grabs for you, and you try to escape. Its razor-sharp
claws snatch you up to its greedy mouth">
				     <COND (<IN? ,AIR-CUBE ,MOUTH>
					    <TELL
", where you can see the white
cube on its tongue as you are swallowed">)>
				     <TELL ".">
				     <JIGS-UP>)
				    (ELSE
				     <SETG IDOL-SLEEPED? <>>
				     <SETG IDOL-YAWNING? <>>
				     <SETG IDOL-ASLEEP? <>>
				     <QUEUE I-UNMALYON-IDOL 4>
				     <QUEUE I-IDOL 2>
				     <QUEUE I-FULL-YAWN 0>
				     <QUEUE I-IDOL-ASLEEP 0>
				     <FSET ,IDOL ,PERSON>
				     <TELL "begins ">
				     <TELL-IDOL-ACTION>
				     <TELL
" suspiciously (and hungrily) around. Fortunately it doesn't
notice you." CR>)>)>)
		      (<VERB? LISKON>
		       <COND (<FSET? ,IDOL ,PERSON>
			      <TELL
"While the idol appears to be made of \"malyoned\" basalt, it must actually
be made of something denser, as this spell has no effect on
it." CR>)>)
		      (<VERB? ESPNIS>
		       <TELL CTHE ,IDOL>
		       <COND (<FSET? ,IDOL ,PERSON>
			      <SETG IDOL-SLEEPED? T>
			      <QUEUE I-FULL-YAWN 2>
			      <QUEUE I-IDOL-ASLEEP 3>
			      <TELL
" suddenly looks very tired and begins to yawn. You can see the idol
fighting it but losing." CR>)
			     (ELSE
			      <TELL
" doesn't seem to be very wakeful to me." CR>)>)
		      (<VERB? YOMIN>
		       <COND (<FSET? ,IDOL ,PERSON>
			      <COND (<OR ,IDOL-SLEEPED?
					 ,IDOL-YAWNING?
					 ,IDOL-ASLEEP?>
				     <TELL
"You sense a great tiredness, as though these few exertions dissipated
a thousand years of strength." CR>)
				    (ELSE
				     <TELL
"You sense a raging anger at the abandonment of its temple, a desire for
the destruction of its former worshippers, and an incandescent hatred for
bats." CR>)>)>)
		      (<AND <VERB? SNAVIG>
			    <FSET? ,IDOL ,PERSON>>
		       <JIGS-UP
"You grow huge, fanged and angry. Then you turn into basalt. The
outcome is fatal.">)>)>>

<GLOBAL IDOL-CRUSHES-YOU
"The idol notices you! It crushes you to jelly, even though you aren't a bat.">

<OBJECT TEETH
	(IN IDOL)
	(DESC "fangs")
	(SYNONYM TEETH FANGS FANG)
	(ADJECTIVE IDOL\'S RAZOR SHARP)
	(FLAGS NOABIT NDESCBIT)
	(ACTION TEETH-F)>

<ROUTINE TEETH-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "They are razor sharp." CR>)
	       (<VERB? MUNG ATTACK>
		<TELL "The teeth are stone hard." CR>)>>

<OBJECT MOUTH
	(IN IDOL)
	(DESC "mouth")
	(SYNONYM MOUTH MAW)
	(ADJECTIVE IDOL\'S GAPING)
	(ACTION MOUTH-F)
	(CONTFCN MOUTH-F)
	(CAPACITY 10)
	(FLAGS NDESCBIT ;SEARCHBIT OPENBIT CONTBIT)>

<ROUTINE MOUTH-F ("OPTIONAL" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-CONTAINER>
		<COND (<VERB? TAKE>
		       <COND (<NOT <IN? ,PLAYER ,IDOL>>
			      <TELL
,YOU-HAVE-TO " climb up to the mouth first." CR>)
			     (<FSET? ,IDOL ,PERSON>
			      <TELL
"The outcome would be fatal." CR>)
			     (,IDOL-ASLEEP?
			      <TELL
"The idol's mouth is shut tightly." CR>)
			     (<AND <EQUAL? ,PRSO ,AIR-CUBE>
				   <IN? ,AIR-CUBE ,MOUTH>>
			      <COND (,IDOL-YAWNING?
				     <COND (<EQUAL? <ITAKE> T>
					    <TELL ,TAKEN>)>
				     <RTRUE>)
				    (ELSE
				     <TELL
"You can see the cube, tantalizingly close, but your ">
				     <COND (<EQUAL? ,SHRINK-FLAG ,WINNER>
					    <TELL
"arm is too short to reach">)
					   (ELSE
					    <TELL
"hand is too big to fit between the razor-sharp teeth">)>
				     <TELL
". If only its mouth were open! Glancing at the size of the fangs, maybe
it's just as well." CR>)>)>)
		      (<VERB? MOVE PUSH>
		       <CANT-REACH-THAT>)>)
	       (<NOT .RARG>
		<FSET ,MOUTH ,SEARCHBIT>
		<COND (<VERB? EXAMINE LOOK-INSIDE>
		       <COND (<OR <IN? ,PLAYER ,IDOL>
				  ,IDOL-ASLEEP?>
			      <TELL CTHE ,MOUTH " is ">
			      <COND (<NOT <FSET? ,MOUTH ,OPENBIT>>
				     <TELL "shut tight.">)
				    (,IDOL-YAWNING?
				     <TELL
"wide open in an almost parodic yawn. The tongue stretches
out of the mouth, and the fangs are far apart.">
				     <MOUTH-CONTENTS>)
				    (ELSE
				     <TELL
"slightly open. In the narrow space between the fangs you can
see a fat, pointed tongue.">
				     <MOUTH-CONTENTS>)>)
			     (ELSE
			      <TELL
,YOU-CANT-SEE "much from here.">)>
		       <CRLF>)
		      (<VERB? CLIMB-UP>
		       <PERFORM ,V?CLIMB-UP ,IDOL>
		       <RTRUE>)
		      (<VERB? OPEN CLOSE>
		       <TELL
"Not a chance." CR>)
		      (<VERB? REACH-IN>
		       <WONT-FIT>)
		      (<AND <VERB? PUT> <EQUAL? ,MOUTH ,PRSI>>
		       <COND (<AND <NOT ,IDOL-YAWNING?>
				   <OR <G? <GETP ,PRSO ,P?SIZE> 5>
				       <GETP ,PRSO ,P?NAME>>>
			      <WONT-FIT>)
			     (ELSE
			      <FCLEAR ,AIR-CUBE ,NDESCBIT>
			      <RFALSE>)>)
		      (<VERB? REZROV>
		       <TELL
"There's no hinge there; it's not a door!" CR>)>)>>

<ROUTINE WONT-FIT ()
	 <TELL "Your hand won't fit in." CR>>

<ROUTINE MOUTH-CONTENTS ("AUX" STR)
	 <SET STR " Sitting on the tongue">
	 <COND (<IN? ,AIR-CUBE ,MOUTH>
		<TELL .STR " is " A ,AIR-CUBE ".">
		<SET STR " Also in the mouth">)>
	 <CLEVER-CONTENTS ,MOUTH .STR ,AIR-CUBE>>

<OBJECT OPAL
	(IN IDOL)
	(DESC "opal eye")
	(SYNONYM EYE)
	(ADJECTIVE OPAL)
	(ACTION OPAL-F)
	(SIZE 10)
	(FLAGS NDESCBIT TAKEBIT TRYTAKEBIT AN)>

<OBJECT OPAL-SHARD
	(DESC "opal shard")
	(SYNONYM EYE SHARD FRAGMENT)
	(ADJECTIVE OPAL BROKEN)
	(FLAGS TAKEBIT AN)>

<ROUTINE OPAL-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<IN? ,OPAL ,IDOL>
		       <TELL
"The eye glows opalescently in the light.">
		       <COND (<NOT <IN? ,PLAYER ,IDOL>>
			      <TELL
" It is near the top of the idol, nearly twenty feet up, but it still looks
large even at this distance.">)
			     (ELSE
			      <TELL
" The color may be attributed to the fact that the eye is actually
an opal of enormous size.">)>
		       <CRLF>)
		      (ELSE
		       <TELL
"This is the largest opal you have ever seen." CR>)>)
	       (<VERB? TAKE>
		<COND (,OPAL-LOOSE? <RFALSE>)
		      (<NOT <IN? ,PLAYER ,IDOL>>
		       <CANT-REACH-THAT>)
		      (<IN? ,OPAL ,IDOL>
		       <TELL
"You scratch at the setting for a while without success." CR>)>)
	       (<AND <VERB? PRY>
		     <EQUAL? ,PRSO ,OPAL>
		     <IN? ,OPAL ,IDOL>>
		<COND (<AND <NOT <IN? ,PLAYER ,IDOL>>
			    <NOT ,IDOL-ASLEEP?>>
		       <CANT-REACH-IT>)
		      (<EQUAL? ,PRSI ,KNIFE ,BURIN ,SHEARS>
		       <COND (<NOT <IN? ,PRSI ,WINNER>>
			      <NOT-HOLDING ,PRSI>)
			     (,OPAL-LOOSE?
			      <TELL ,IT-IS-ALREADY
"tottering, ready to fall, and trying to pry it again just
hastens the inevitable" ,PERIOD>)
			     (ELSE
			      <SETG OPAL-LOOSE? T>
			      <QUEUE I-OPAL-SMASHES 2>
			      <TELL
"The opal pops out of the eye socket. It is teetering on the edge of the
cruel and pointy nose of the idol, ready to fall." CR>)>)
		      (ELSE
		       <TELL
CTHE ,PRSI " doesn't appear equal to the task." CR>)>)
	       (<AND <HELD? ,OPAL>
		     <OR <VERB? THROW MUNG>
			 <AND <VERB? DROP>
			      <IN? ,WINNER ,IDOL>>>>
		<REMOVE ,OPAL>
		<MOVE ,OPAL-SHARD ,HERE>
		<TELL "Broken." CR>)>>

<GLOBAL OPAL-LOOSE? <>>

<ROUTINE RUINS-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<COND (<EQUAL? ,HERE ,PAST-RUINS-ROOM>
		       <TELL
"This place is abandoned and falling into ruin." CR>)
		      (ELSE
		       <TELL
"This place has been abandoned for centuries. It is a mouldering
ruin." CR>)>)>>

<OBJECT ZIPPER
	(IN RUINS-ROOM)
	(DESC "zipper")
	(SYNONYM ZIPPER AABBCC ;"HOLE" POCKET POUCH)
	(ADJECTIVE SILVER DIMLY LIT)
	(ACTION ZIPPER-F)
	(CONTFCN ZIPPER-F)
	(GENERIC GENERIC-HOLE-F)
	(FLAGS NDESCBIT VEHBIT TAKEBIT CONTBIT MAGICBIT)
	(CAPACITY 1000)>

<GLOBAL ZIPPER-SCROLL? <>>

<ROUTINE ZIPPER-F ("OPTIONAL" (RARG <>) "AUX" OLIT ZLIT)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are in a zipper. Clammy dark mist surrounds you. ">
		<COND (<FSET? ,ZIPPER ,OPENBIT>
		       <TELL
"The zipper is open. ">
		       <CANT-SEE-OUTSIDE>)
		      (ELSE
		       <TELL-OPEN-CLOSED ,ZIPPER>)>)
	       (<EQUAL? .RARG ,M-CONTAINER>
		<COND (<AND <VERB? TAKE PUT>
			    <NOT <IN? ,WINNER ,ZIPPER>>
			    <NOT <HELD? ,ZIPPER>>>
		       <DONT-HAVE-THAT>)
		      (<AND <VERB? READ EXAMINE>
			    <NOT <IN? ,WINNER ,ZIPPER>>>
		       <MAKE-OUT>)>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<AND <NOT-IN-VEHICLE?>
			    <NOT <VERB? FIND WHAT WHERE WHO>>>
		       <TELL "That's not in here." CR>)
		      (<AND <VERB? LOOK-INSIDE> <EQUAL? ,PRSO ,ZIPPER>>
		       <PERFORM ,V?LOOK>
		       <RTRUE>)
		      (<VERB? BOARD REACH-IN>
		       <TELL ,YOU-ARE ,PERIOD>)
		      (<VERB? SIT>
		       <TELL
"There isn't a good place to sit here." CR>)
		      (<OR <VERB? EXIT>
			   <AND <VERB? WALK> <EQUAL? ,P-WALK-DIR ,P?OUT>>
			   <AND <VERB? THROUGH> <EQUAL? ,PRSO ,ZIPPER>>>
		       <PERFORM ,V?DISEMBARK>
		       <RTRUE>)
		      (<AND <VERB? OPEN REZROV>
			    <EQUAL? ,PRSO ,ZIPPER>
			    <NOT <FSET? ,ZIPPER ,OPENBIT>>>
		       <PUT <GETPT ,ZIPPER ,P?SYNONYM> 1 ,W?HOLE>
		       <FSET ,ZIPPER ,OPENBIT>
		       <TELL "Opened. ">
		       <CANT-SEE-OUTSIDE>)
		      (<AND <VERB? CLOSE>
			    <EQUAL? ,PRSO ,ZIPPER>
			    <FSET? ,ZIPPER ,OPENBIT>>
		       <PUT <GETPT ,ZIPPER ,P?SYNONYM> 1 ,W?ZIPPER>
		       <FCLEAR ,ZIPPER ,OPENBIT>
		       <TELL
,YOU-ARE-NOW "in a private little world of your own." CR>)
		      (<VERB? WALK>
		       <TELL
"There's nowhere to go in here." CR>)
		      (<OR <VERB? DISEMBARK>
			   <AND <VERB? DROP> <EQUAL? ,PRSO ,ZIPPER>>>
		       <COND (<FSET? ,ZIPPER ,OPENBIT>
			      <COND (<NOT <LOC ,ZIPPER>>
				     <EMERGE-AND-DROWN>)
				    (ELSE
				     <SETG LIT <LIT? ,HERE>>
				     <MOVE ,PLAYER <LOC ,ZIPPER>>
				     <MOVE ,ZIPPER ,PLAYER>
				     <TELL
"You get out of the hole." CR>
				     <COND (,OGRE-MURDEROUS?
					    <I-OGRE-KILLS-YOU>)>
				     <RTRUE>)>)
			     (ELSE
			      <TELL
,YOU-HAVE-TO " open the " 'ZIPPER " first." CR>)>)>)
	       (<NOT .RARG>
		<SET OLIT ,LIT>
		<COND (<VERB? EXAMINE>
		       <TELL
"This is a silver zipper about two feet long, with very fine teeth. ">
		       <TELL-OPEN-CLOSED ,ZIPPER>)
		      (<AND <VERB? OPEN REZROV>
			    <NOT <FSET? ,ZIPPER ,OPENBIT>>>
		       <PUT <GETPT ,ZIPPER ,P?SYNONYM> 1 ,W?HOLE>
		       <FSET ,ZIPPER ,OPENBIT>
		       <COND (<NOT ,LIT> <SETG LIT <LIT? ,HERE>>)>
		       <TELL
"Opening the zipper reveals a ">
		       <COND (<LIT? ,ZIPPER <>> <TELL "bright">)
			     (ELSE <TELL "dim">)>
		       <TELL "ly lit hole.">
		       <COND (<AND <NOT .OLIT> ,LIT>
			      <TELL " Enough rays escape to dimly light
the area.">)>
		       <CRLF>)
		      (<AND <VERB? CLOSE> <FSET? ,ZIPPER ,OPENBIT>>
		       <PUT <GETPT ,ZIPPER ,P?SYNONYM> 1 ,W?ZIPPER>
		       <FCLEAR ,ZIPPER ,OPENBIT>
		       <SETG LIT <LIT? ,HERE>>
		       <TELL
"The zipper now looks like an ordinary zipper.">
		       <COND (<AND .OLIT <NOT ,LIT>>
			      <TELL " " ,NOW-BLACK>)>
		       <CRLF>)
		      (<VERB? LOOK-INSIDE>
		       <COND (<FSET? ,ZIPPER ,OPENBIT>
			      <TELL "It's ">
			      <COND (<SET ZLIT <LIT? ,ZIPPER <>>>
				     <TELL "bright">)
				    (ELSE
				     <TELL "dark">)>
			      <TELL " inside, ">
			      <COND (<FIRST? ,ZIPPER>
				     <COND (.ZLIT <TELL "and">)
					   (ELSE <TELL "but">)>
				     <TELL " you can see ">
				     <PRINT-CONTENTS ,ZIPPER>)
				    (.ZLIT <TELL "and empty">)
				    (ELSE
				     <TELL "and you can't see anything">)>
			      <TELL ,PERIOD>)
			     (ELSE
			      <TELL-OPEN-CLOSED ,ZIPPER>)>)
		      (<VERB? REACH-IN>
		       <COND (<NOT <FSET? ,ZIPPER ,OPENBIT>>
			      <TELL-OPEN-CLOSED ,ZIPPER>)
			     (<NOT ,ZIPPER-SCROLL?>
			      <SETG ZIPPER-SCROLL? T>
			      <MOVE ,GIRGOL-SCROLL ,ZIPPER>
			      <THIS-IS-IT ,GIRGOL-SCROLL>
			      <TELL
"Odd, you can't really feel anything for a moment, but then, almost as
though something was thrust into your hand, there's something there. Oops,
it slipped away again." CR>)>)
		      (<VERB? BOARD>
		       <COND (<NOT <IN? ,ZIPPER ,PLAYER>>
			      <DONT-HAVE-THAT>)
			     (<FSET? ,ZIPPER ,OPENBIT>
			      <COND (<OR <EQUAL? ,HERE
						 ,OCEAN-ROOM ,LOST-IN-OCEAN
						 ,OCEAN-FLOOR>
					 <EQUAL? ,HERE ,IN-CHANNEL ,IN-PIPE
						 ,IN-PIPE-2>
					 <EQUAL? ,HERE ,IN-SEWER ,RUINED-PIPE
						 ,PAST-CABINET>
					 <EQUAL? ,HERE ,CABINET>
					 <AND <EQUAL? ,HERE ,OUBLIETTE>
					      <G? ,WATER-FLAG 0>>>
				     <IMPOSSIBLE-MANEUVER>
				     <RTRUE>)>
			      <COND (<NOT ,ZIPPER-SCROLL?>
				     <SETG ZIPPER-SCROLL? T>
				     <MOVE ,GIRGOL-SCROLL ,ZIPPER>)>
			      <MOVE ,ZIPPER ,HERE>
			      <MOVE ,PLAYER ,ZIPPER>
			      <SET ZLIT <LIT? ,ZIPPER <>>>
			      <SETG LIT T>
			      <TELL
"It's just big enough to fit in with the zipper fully open. You crawl into
a ">
			      <COND (.ZLIT <TELL "bright">)
				    (ELSE <TELL "dark">)>
			      <TELL
", strange place almost like a big sack. You can sort of stand up, but
there isn't much room to move around. ">
			      <CANT-SEE-OUTSIDE>
			      ;<JIGS-UP
"You can just fit with the zipper fully open. You crawl into
a strange place almost like a big sack. You find that you are
in a sort of stasis, and can't move. Your mental processes move
slower and slower, and ultimately they stop.">)
			     (ELSE
			      <TELL-OPEN-CLOSED ,ZIPPER>)>)
		      (<AND <VERB? PUT>
			    <EQUAL? ,PRSI ,ZIPPER>>
		       <COND (<IN? ,ZIPPER ,BOTTLE>
			      <CANT-REACH-THAT>)
			     (<AND <NOT ,ZIPPER-SCROLL?>
				   <FSET? ,PRSO ,ONBIT>>
			      <SETG ZIPPER-SCROLL? T>
			      <MOVE ,GIRGOL-SCROLL ,ZIPPER>
			      <RFALSE>)>)>)>>

<ROUTINE CANT-SEE-OUTSIDE ()
	 <TELL
,YOU-CANT-SEE "your outside surroundings, though. It's as though a mist
was in the way." CR>>

<ROOM RUINS-ROOM
      (IN ROOMS)
      (DESC "Ruins Room")
      (NORTH TO HALL-OF-STONE)
      (SOUTH "The ruins end here.")
      (DOWN TO RUINED-PIPE IF SMALL-FLAG)
      (ACTION RUINS-ROOM-F)
      (FLAGS RLANDBIT)
      (GLOBAL WATER)
      (THINGS
       <PSEUDO (MOULDERING RUIN RUINS-PSEUDO)
	       (CYCLOPEAN BLOCKS RUINS-PSEUDO)
	       (STONE BLOCKS RUINS-PSEUDO)
	       (CARVED STATUE RUINS-PSEUDO)
	       (UNIMAGINABLE CONSTRUCT RUINS-PSEUDO)
	       (BROKEN PILLAR RUINS-PSEUDO)
	       (FALLEN PILLAR RUINS-PSEUDO)
	       (COLLAPSED PORTICO RUINS-PSEUDO)>)>

<ROUTINE RUINS-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Here the main corridor opens into a vast underground space. Your light
can barely illuminate a fraction of it. All around are cyclopean blocks
of stone, crudely carved statues, and constructs of unimaginable
purpose. Nearby the portico of a building has collapsed, and a pillar
has smashed the pavement and exposed a small channel filled with swiftly
rushing water. Water stains indicate that at one time the water flooded
the entire area.">
		<COND (<FSET? ,ZIPPER ,NDESCBIT>
		       <TELL
" Wedged against a pillar, as though by rushing water, is a zipper.">)>
		<CRLF>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<AND <VERB? PUT>
			    <EQUAL? ,PRSI ,WATER>>
		       <PERFORM ,PRSA ,PRSO ,RUINS-CHANNEL>
		       <RTRUE>)
		      (<AND <VERB? THROUGH BOARD>
			    <EQUAL? ,PRSO ,WATER>>
		       <PERFORM ,PRSA ,RUINS-CHANNEL>
		       <RTRUE>)>)>>

<OBJECT RUINS-CHANNEL
	(IN RUINS-ROOM)
	(DESC "channel")
	(SYNONYM CHANNEL)
	(ADJECTIVE CERAMIC)
	(FLAGS NDESCBIT VEHBIT OPENBIT)
	(ACTION CHANNEL-F)>

<OBJECT RUINS-INFLOW
	(IN RUINS-ROOM)
	(DESC "inflow pipe")
	(SYNONYM PIPE PIPES)
	(ADJECTIVE INFLOW RUINED INPUT)
	(FLAGS NDESCBIT AN VEHBIT)
	(ACTION INFLOW-F)>

<OBJECT RUINS-OUTFLOW
	(IN RUINS-ROOM)
	(DESC "outflow pipe")
	(SYNONYM PIPE PIPES)
	(ADJECTIVE OUTFLOW RUINED OUTPUT)
	(FLAGS NDESCBIT AN VEHBIT)
	(ACTION OUTFLOW-F)>

<GLOBAL ROCK-FLAG <>>

<ROOM CLIFF-TOP
      (IN ROOMS)
      (DESC "Cliff Top")
      (DOWN TO CLIFF-MIDDLE)
      (UP PER CLIFF-TOP-EXIT) ;"BOULDER-1"
      (ACTION CLIFF-TOP-F)
      (FLAGS RLANDBIT OUTSIDE ONBIT)
      (GLOBAL GLOBAL-ROCKS GLOBAL-CLIFF HUT)
      (THINGS <PSEUDO (<> MOUNTAIN MOUNTAIN-PSEUDO)>)>

<ROUTINE CLIFF-TOP-EXIT ("AUX" (H <>) DIR)
	 <COND (<EQUAL? ,HERE ,MOUNTAIN-TOP>
		<SET H T>
		<SET DIR "down">)
	       (ELSE
	        <SET DIR "up">)>
	 <COND (,ROCK-FLAG
		<COND (.H ,BOULDER-3)(ELSE ,BOULDER-1)>)
	       (<TIME-FROZEN?>
		<TELL
"Even frozen in place, the rocks are so jumbled that you can't climb "
.DIR " them. You would need full mountaineering equipment even to try." CR>
		<RFALSE>)
	       (,ROCK-SLIDE-COUNT
		<TELL
,I-DONT-THINK-THAT "you can climb " .DIR " an avalanche." CR>
		<RFALSE>)
	       (ELSE
		<TELL
"The pile of rocks looks so unsteady that attempting to climb over it
could set off an avalanche." CR>
		<RFALSE>)>>

<ROUTINE CLIFF-TOP-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is the upper end of a narrow, winding path up a sheer cliff. From here
you can see that any further extension of the path was destroyed by a
rock slide at some relatively recent time. There are many rocks ">
		<COND (,ROCK-FLAG
		       <TELL
"suspended in midair above you. Some are quite close.">)
		      (,ROCK-SLIDE-COUNT
		       <TELL
"tumbling towards you from above.">)
		      (ELSE
		       <TELL
"precariously
balanced above you. " ,IT-LOOKS-LIKE "the slightest disturbance could bring them
down on you.">)>
		<COND (<NOT <FSET? ,MOUNTAIN-TOP ,TOUCHBIT>>
		       <TELL
" Frustratingly, you can see the remains of a small building just
beyond the dangerous area, but there is no way to get there from here.">)
		      (ELSE
		       <TELL
" The hermit's hut is above.">)>
		<CRLF>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<AND <VERB? WALK>
			    <NOT <EQUAL? ,P-WALK-DIR
					 ,P?UP ,P?DOWN>>>
		       <TELL
"The only path leads up or down. There is only a sheer cliff elsewhere." CR>)
		      (<AND <VERB? LESOCH> <NOT ,PRSO>>
		       <PERFORM ,V?LESOCH ,GLOBAL-ROCKS>
		       <RTRUE>)>)
	       (<EQUAL? .RARG ,M-ENTER>
		<COND (<AND <EQUAL? ,ROCK-SLIDE-COUNT 0>
			    <NOT ,ROCK-FLAG>>
		       <SETG SLIDE-PROB 10>
		       <QUEUE I-AVALANCHE? -1>)>)>>

<ROUTINE STOP-AVALANCHE ()
	 <SETG TIME-STOPPED? ,HERE>
	 <SETG ROCK-FLAG T>
	 <QUEUE I-GIRGOL 12>
	 <TELL ,AT-FIRST>
	 <ROCKS-STOPPED>>

<ROUTINE ROCKS-STOPPED ()
	 <TELL "that the rocks are no
longer falling. Dust hangs suspended in the air. Rocks appear wired in place.
The mountainside that threatened to bury you floats serenely in midair." CR>>

<ROOM BOULDER-1
      (IN ROOMS)
      (DESC "Boulder")
      (UP TO BOULDER-2)
      (DOWN TO CLIFF-TOP)
      (ACTION BOULDER-ROOM-F)
      (GLOBAL GLOBAL-ROCKS)
      (FLAGS RLANDBIT)>

<ROOM BOULDER-2
      (IN ROOMS)
      (DESC "Boulder")
      (UP TO BOULDER-3)
      (DOWN TO BOULDER-1)
      (ACTION BOULDER-ROOM-F)
      (GLOBAL GLOBAL-ROCKS)
      (FLAGS RLANDBIT)>

<ROOM BOULDER-3
      (IN ROOMS)
      (DESC "Boulder")
      (UP TO MOUNTAIN-TOP)
      (DOWN TO BOULDER-2)
      (ACTION BOULDER-ROOM-F)
      (GLOBAL GLOBAL-ROCKS)
      (FLAGS RLANDBIT)>

<ROUTINE BOULDER-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are clinging to a boulder that is floating in midair.
There are many other boulders around, also floating, and lots of dust
and dirt, also not moving. ">
		<COND (<EQUAL? ,HERE ,BOULDER-1>
		       <TELL
"One particularly large boulder with good handholds is above you. Below
you is the cliff face.">)
		      (<EQUAL? ,HERE ,BOULDER-2>
		       <TELL
"A nice oblong boulder is above, and another large one is below you.">)
		      (<EQUAL? ,HERE ,BOULDER-3>
		       <TELL
"Below you is a long oblong boulder. Above you there are no more boulders,
but there is a continuation of the trail that you were on.">)>
		<CRLF>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<VERB? CLIMB-UP CLIMB-FOO>
		       <DO-WALK ,P?UP>)
		      (<VERB? CLIMB-DOWN>
		       <DO-WALK ,P?DOWN>)>)>>

<ROOM MOUNTAIN-TOP
      (IN ROOMS)
      (DESC "Mountain Top")
      (IN PER HUT-ROOM-EXIT)
      (WEST PER HUT-ROOM-EXIT)
      (DOWN PER CLIFF-TOP-EXIT ;CLIFF-TOP)
      (FLAGS RLANDBIT OUTSIDE ONBIT)
      (ACTION MOUNTAIN-TOP-F)
      (GLOBAL GLOBAL-ROCKS GLOBAL-CLIFF HUT)
      (THINGS <PSEUDO (<> MOUNTAIN MOUNTAIN-PSEUDO)>)>

<ROUTINE MOUNTAIN-TOP-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is the top of the mountain. There is ">
		<COND (,HERMIT-APPEASED?
		       <TELL "an imposing">)
		      (ELSE
		       <TELL "a crudely built">)>
		<TELL " stone hut nearby
to the west." CR>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<VERB? CLIMB-UP CLIMB-FOO>
		       <DO-WALK ,P?UP>)
		      (<VERB? CLIMB-DOWN>
		       <DO-WALK ,P?DOWN>)>)>>

<ROUTINE HUT-ROOM-EXIT ()
	 <COND (<EQUAL? ,HERE ,HUT-ROOM>
		,MOUNTAIN-TOP)
	       (ELSE
		,HUT-ROOM)>>

<ROOM HUT-ROOM
      (IN ROOMS)
      (DESC "Stone Hut")
      (OUT PER HUT-ROOM-EXIT ;MOUNTAIN-TOP)
      (EAST PER HUT-ROOM-EXIT ;MOUNTAIN-TOP)
      (FLAGS RLANDBIT ONBIT)
      (ACTION HUT-ROOM-F)
      (GLOBAL HUT)
      (THINGS
       <PSEUDO (<> KEYSTONE KEYSTONE-PSEUDO)
	       (<> MOSS RANDOM-PSEUDO)
	       (<> MUD RANDOM-PSEUDO)
	       (OLD FUR RANDOM-PSEUDO)>)>

<ROUTINE KEYSTONE-PSEUDO ()
	 <REDIRECT ,PSEUDO-OBJECT ,LIFE-CUBE>>

<ROUTINE HUT-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<PERFORM ,V?EXAMINE ,HUT>
		<TELL
"Squatting on the floor is a wild-haired, bearded hermit who is ">
		<COND (,HERMIT-APPEASED?
		       <TELL "admiring his perfect hut">)
		      (T
		       <TELL "looking at you with ill-concealed dislike">)>
		<TELL ,PERIOD>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<AND <VERB? POINT>
			    <EQUAL? ,PRSO ,HUT ,HERMIT ,LIFE-CUBE>>
		       <ASK-HERMIT-ABOUT ,PRSO>)
		      (<AND <VERB? TAKE RUB WRITE MOVE>
			    <EQUAL? ,PRSO ,LIFE-CUBE>
			    <NOT ,HERMIT-APPEASED?>>
		       <TELL
"The hermit springs between you and the cube. \"Not so fast! That thing
holds up the whole hut. It's the keystone. Don't touch it.\"" CR>)
		      (<AND <VERB? MALYON>
			    <EQUAL? ,PRSO ,LIFE-CUBE>
			    <NOT ,HERMIT-APPEASED?>>
		       <FSET ,HUT ,RMUNGBIT>
		       <FSET ,HUT-ROOM ,RMUNGBIT>
		       <JIGS-UP
"The cube comes alive, wiggles free of the wall, and the hut collapses
on top of you.">)>)>>

<OBJECT HUT
	(IN LOCAL-GLOBALS)
	(DESC "stone hut")
	(SYNONYM HUT BUILDING STONE ENTRANCE)
	(ADJECTIVE STONE CRUDE SMALL)
	(FLAGS NDESCBIT VEHBIT OPENBIT)
	(ACTION HUT-F)>

<ROUTINE HUT-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "The hut is ">
		<COND (<EQUAL? ,HERE ,CLIFF-TOP>
		       <TELL "barely visible." CR>
		       <RTRUE>)
		      (,HERMIT-APPEASED?
		       <TELL
"beautifully constructed out of carefully dressed granite blocks
and strong mortar.">)
		      (ELSE
		       <TELL "made of irregular stones">)>
		<COND (<EQUAL? ,HERE ,HUT-ROOM>
		       <COND (,HERMIT-APPEASED?
			      <TELL
" The construction of the hut is somewhat at odds with the
squalor of its contents.">)
			     (ELSE
			      <TELL
". The walls are chinked with moss, mud, small stones,">
			      <COND (<AND <IN? ,LIFE-CUBE ,HUT-ROOM>
					  <FSET? ,LIFE-CUBE ,NDESCBIT>>
				     <TELL
" a " ,WHITE-CUBE ",">)>
			      <TELL
" and an occasional old fur.">)>
		       <TELL " There is an exit to the east." CR>)
		      (ELSE
		       <COND (<NOT ,HERMIT-APPEASED?>
			      <TELL
" much like those lying all around you.">)>
		       <TELL " There is an entrance to the west." CR>)>)
	       (<EQUAL? ,HERE ,CLIFF-TOP>
		<TELL ,TOO-FAR>)
	       (<AND <VERB? LOOK-INSIDE>
		     <EQUAL? ,HERE ,MOUNTAIN-TOP>>
		<TELL
,YOU-CANT-SEE "very much from out here. Why not go in?" CR>)
	       (<AND <VERB? REACH-IN>
		     <EQUAL? ,MOUNTAIN-TOP ,HERE>>
		<TELL
"You reach in and hear a yell of surprise from inside." CR>)
	       (<VERB? THROUGH BOARD>
		<COND (<EQUAL? ,HERE ,HUT-ROOM>
		       <TELL ,YOU-ARE>
		       <TELL ,PERIOD>)
		      (ELSE
		       <GOTO ,HUT-ROOM>)>)
	       (<VERB? DISEMBARK DROP>
		<COND (<NOT <EQUAL? ,HERE ,HUT-ROOM>>
		       <TELL ,YOU-ARE>
		       <TELL ,PERIOD>)
		      (ELSE
		       <GOTO ,MOUNTAIN-TOP>)>)
	       (<VERB? CASKLY>
		<COND (<NOT ,HERMIT-APPEASED?>
		       <SETG HERMIT-APPEASED? T>
		       <FCLEAR ,LIFE-CUBE ,NDESCBIT>
		       <TELL
"The hut begins to melt, the stones dripping down like wax and the dirt
spraying in all directions. ">
		       <COND (<EQUAL? ,HERE ,HUT-ROOM>
			      <TELL
"\"Now you've done it, you meddlesome mage!\"
screams the hermit.">)
			     (ELSE
			      <TELL "You hear a scream from inside the hut.">)>
		       <TELL
" But then the stones start flowing back into place, and
the dirt speeds into place between them, and all is changed. The hut looks
considerably different">
		       <COND (<EQUAL? ,HERE ,HUT-ROOM>
			      <TELL
", and the cube, no longer necessary, sits in lonely
splendor on the ground between you and the hermit">)>
		       <TELL ,PERIOD>)>)>>

<GLOBAL HERMIT-APPEASED? <>>

<OBJECT HERMIT
	(IN HUT-ROOM)
	(DESC "hermit")
	(SYNONYM HERMIT MAN)
	(ADJECTIVE OLD)
	(FLAGS NDESCBIT PERSON THE)
	(ACTION HERMIT-F)>

<ROUTINE HERMIT-F ()
	 <COND (<EQUAL? ,WINNER ,HERMIT>
		<COND (<AND <VERB? TELL-ABOUT>
			    <EQUAL? ,PRSO ,ME>>
		       <RFALSE>)
		      (<VERB? TELL-ME-ABOUT>
		       <ASK-HERMIT-ABOUT ,PRSO>)
		      (ELSE
		       <TELL
"He's a taciturn old buzzard and doesn't respond." CR>
		<END-QUOTE>)>)
	       (<VERB? EXAMINE>
		<TELL
"The old man is clothed in goatskin rags. He has a long, tangled beard
and dirty matted hair." CR>)
	       (<VERB? SMELL>
		<TELL
"His last bath may well have been before you were born." CR>)
	       (<VERB? SHOW>
		<COND (<GETPT ,PRSO ,P?NAME>
		       <TELL
"The hermit remarks \"You've got one, too. What do you want with mine,
then?\"" CR>)
		      (<EQUAL? ,PRSO ,ZORKMID>
		       <MATERIALISM>)
		      (<EQUAL? ,PRSO ,BREAD ,FISH>
		       <TELL
"\"That looks pretty good. I eat mostly berries, moss, and goat meat.\"" CR>)
		      (ELSE
		       <UNINTERESTED ,HERMIT>)>)
	       (<VERB? GIVE>
		<COND (<EQUAL? ,PRSO ,BREAD ,FISH>
		       <REMOVE ,PRSO>
		       <TELL
"The hermit devours the " 'PRSO " with gusto. He belches. \"That
was a nice change,\" he remarks." CR>)>)
	       (<AND <VERB? ASK-FOR>
		     <EQUAL? ,PRSO ,HERMIT>
		     <EQUAL? ,PRSI ,LIFE-CUBE>>
		<COND (,HERMIT-APPEASED?
		       <TELL
"\"Sure, take it.\" He's distracted by his admiration for his newly
perfected dwelling." CR>)
		      (ELSE
		       <TELL
"\"Not on your life. It's holding up the whole hut. It's perfect
for that chink. You don't know how long it took me to find it.\"" CR>)>)
	       (<VERB? TRADE BUY>
		<MATERIALISM>)
	       (<VERB? YOMIN>
		<TELL
"The hermit is worried that you will rob him. He is very suspicious.
He's been up here on the mountain for so long that his brains are slightly
curdled." CR>)>>

<ROUTINE MATERIALISM ()
	 <TELL
"\"Materialism! That's another thing I was trying to get away from!\" The
hermit looks glum." CR>>

<ROUTINE ASK-HERMIT-ABOUT (OBJ)
	 <COND (<EQUAL? .OBJ ,GLOBAL-ROCKS>
		<TELL
"\"I like avalanches. They keep people away. Usually.\"" CR>)
	       (<EQUAL? .OBJ ,ZORKMID>
		<MATERIALISM>)
	       (<EQUAL? .OBJ ,FISH ,BREAD>
		<TELL "He perks up at the mention of food." CR>)
	       (<EQUAL? .OBJ ,LIFE-CUBE ,HUT ,HERMIT>
		<TELL
"\"I've been living up here for many years. Wanted to get
away from people. Too much noise, too much talk, too much jabber-jabber
all the time. I've been building this hut for years, too.
Couldn't find the right keystone. It would always collapse after a while,
so I never moved into it. I kept hoping to get it right some day;
no training in stonemasonry. One day there was a presence
on the mountain, like a cloud had come over. Then there was smoke,
orange smoke, I think. The next day I found that stone sitting on top
of a rock not five minutes' walk from here. It was perfect.\"" CR>)>>

<OBJECT GLOBAL-CLIFF
	(IN LOCAL-GLOBALS)
	(DESC "cliff")
	(SYNONYM CLIFF TRAIL TRACK PATH)
	(ADJECTIVE SHEER)
	(FLAGS NDESCBIT)
	(ACTION GLOBAL-CLIFF-F)>

<GLOBAL ROCKS-PRECARIOUS "The rocks look very precariously balanced">

<ROUTINE GLOBAL-CLIFF-F ()
	 <COND (<VERB? EXAMINE>
		<TELL ,ROCKS-PRECARIOUS ,PERIOD>)
	       (<VERB? CLIMB-UP CLIMB-FOO FOLLOW>
		<DO-WALK ,P?UP>)
	       (<VERB? CLIMB-DOWN>
		<DO-WALK ,P?DOWN>)>>

<OBJECT GLOBAL-ROCKS
	(IN LOCAL-GLOBALS)
	(DESC "rock")
	(SYNONYM ROCK ROCKS BOULDER AVALANCHE)
	(ADJECTIVE JUMBLED SCREE PILE MOLTEN LARGE)
	(FLAGS NDESCBIT)
	(ACTION GLOBAL-ROCKS-F)>

<ROUTINE GLOBAL-ROCKS-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<EQUAL? ,HERE ,BOULDER-1 ,BOULDER-2 ,BOULDER-3>
		       <PERFORM ,V?LOOK>
		       <RTRUE>)
		      (<EQUAL? ,HERE
			       ,VOLCANO-BASE ,VOLCANO-ROOM ,OUTCROPPING-ROOM>
		       <TELL
"The rocks look hot and are melted to all their neighbors." CR>)
		      (<OR <EQUAL? ,HERE
				   ,CLIFF-TOP ,CLIFF-MIDDLE ,CLIFF-BOTTOM>
			   <EQUAL? ,HERE ,MOUNTAIN-TOP ,CAVE-ENTRANCE>>
		       <COND (<OR ,ROCK-FLAG <TIME-FROZEN?>>
			      <TELL "You can see ">
			      <ROCKS-STOPPED>)
			     (<QUEUED? I-AVALANCHE>
			      <ROCKS-TUMBLING>)
			     (ELSE
			      <TELL ,ROCKS-PRECARIOUS ,PERIOD>)>)>)
	       (<VERB? CLIMB-FOO CLIMB-UP CLIMB-ON CLIMB-OVER>
		<DO-WALK ,P?UP>)
	       (<VERB? RUB MOVE PUSH LESOCH KICK MALYON>
		<COND (<EQUAL? ,HERE ,VOLCANO-BASE
			       ,VOLCANO-ROOM ,OUTCROPPING-ROOM>
		       <TELL-TOO-HOT>
		       <TELL ,PERIOD>
		       <RTRUE>)
		      (<OR <TIME-FROZEN?>
			   <NOT <EQUAL? ,HERE ,CLIFF-TOP ,MOUNTAIN-TOP>>>
		       <RFALSE>)
		      (<VERB? MALYON>
		       <TELL "You animate">)
		      (<VERB? LESOCH>
		       <TELL
"The wind whips up to a frenzy and touches">)
		      (ELSE
		       <TELL
"You gingerly touch">)>
		<TELL " a rock, which tilts a little. Another rock slides into
the gap, triggering a larger one to fall. Suddenly, the entire mountainside
begins to tumble down." CR>
		<DEQUEUE I-AVALANCHE?>
		<QUEUE I-AVALANCHE -1>
		<RTRUE>)
	       (<VERB? TAKE>
		<COND (<AND <EQUAL? ,HERE ,CLIFF-TOP ,MOUNTAIN-TOP>
			    <NOT <TIME-FROZEN?>>>
		       <COND (<NOT <QUEUED? I-AVALANCHE>>
			      <TELL
"Taken, but you drop it immediately when you see that your intemperate
action has triggered a rock slide." CR>
			      <SETG ROCK-SLIDE-COUNT 0>
			      <DEQUEUE I-AVALANCHE?>
			      <QUEUE I-AVALANCHE -1>
			      <RTRUE>)>)
		      (<EQUAL? ,HERE ,VOLCANO-BASE
			       ,VOLCANO-ROOM ,OUTCROPPING-ROOM>
		       <TELL-TOO-HOT>
		       <TELL " or solidly fixed to the
ground here." CR>)
		      (ELSE
		       <TELL
"None of the rocks look interesting enough to take." CR>)>)>>

<ROUTINE TELL-TOO-HOT ()
	 <TELL CTHE ,PRSO " is too hot to touch">>

<ROOM CLIFF-MIDDLE
      (IN ROOMS)
      (DESC "Cliff Middle")
      (UP TO CLIFF-TOP)
      (DOWN TO CLIFF-BOTTOM)
      (ACTION CLIFF-MIDDLE-F)
      (FLAGS RLANDBIT OUTSIDE ONBIT)
      (GLOBAL GLOBAL-ROCKS GLOBAL-CLIFF)
      (THINGS <PSEUDO (<> MOUNTAIN MOUNTAIN-PSEUDO)>)>

<ROUTINE CLIFF-MIDDLE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"A narrow ledge, barely wide enough to stand on, interrupts the cliff
here." CR>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<AND <VERB? WALK>
			    <NOT <EQUAL? ,P-WALK-DIR
					 ,P?UP ,P?DOWN>>>
		       <TELL
"The path leads up or down. There is a sheer cliff elsewhere." CR>)>)>>

<ROOM CLIFF-BOTTOM
      (IN ROOMS)
      (DESC "Cliff Bottom")
      (UP TO CLIFF-MIDDLE)
      (DOWN "You're at the bottom already.")
      (WEST TO CAVE-ENTRANCE)
      (EAST "There's no path that way.")
      (SOUTH "There's no path that way.")
      (ACTION CLIFF-BOTTOM-F)
      (FLAGS RLANDBIT OUTSIDE ONBIT)
      (GLOBAL GLOBAL-ROCKS GLOBAL-CLIFF)
      (THINGS <PSEUDO (<> MOUNTAIN MOUNTAIN-PSEUDO)>)>

<ROUTINE CLIFF-BOTTOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is the bottom of a sheer cliff which towers above you. Jumbled rockfalls
are all around you. A goat track (at best) leads up, and a well-worn
trail heads west." CR>)>>

<OBJECT GLOBAL-CAVE
	(IN LOCAL-GLOBALS)
	(DESC "cave")
	(SYNONYM CAVE CAVERN)
	(ADJECTIVE DARK)
	(FLAGS NDESCBIT)
	(ACTION GLOBAL-CAVE-F)>

<ROUTINE GLOBAL-CAVE-F ()
	 <COND (<AND <VERB? EXAMINE> <NOT <EQUAL? ,HERE ,CAVE-ENTRANCE>>>
		<PERFORM ,V?LOOK>
		<RTRUE>)
	       (<VERB? THROUGH>
		<COND (<EQUAL? ,HERE ,CAVE-ENTRANCE>
		       <GOTO ,OGRE-CAVE>)
		      (ELSE
		       <TELL ,YOU-ARE ,PERIOD>)>)
	       (ELSE
		<REDIRECT ,GLOBAL-CAVE ,GLOBAL-ROOM>)>>

<ROOM CAVE-ENTRANCE
      (IN ROOMS)
      (DESC "Cave Entrance")
      (EAST TO CLIFF-BOTTOM)
      (IN TO OGRE-CAVE)
      (NORTH TO OGRE-CAVE)
      (UP "There's no way up here.")
      (ACTION CAVE-ENTRANCE-F)
      (FLAGS RLANDBIT OUTSIDE ONBIT)
      (GLOBAL GLOBAL-CLIFF GLOBAL-CAVE GLOBAL-ROCKS)
      (THINGS
       <PSEUDO (<> MOUNTAIN MOUNTAIN-PSEUDO)
	       (<> LITTER RANDOM-PSEUDO)
	       (LITTER BONES PLURAL-PSEUDO)
	       (OLD HIDES PLURAL-PSEUDO)
	       (<> BRUSH PLANTS-PSEUDO)>)>

<ROUTINE CAVE-ENTRANCE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"A well-worn trail terminates here where a cave enters the cliff-side to
the north. Outside the cave is a litter of bones, old hides and brush.
The smell that issues from the cave is mephitic. To the east is the
bottom of a sheer cliff." CR>)
	       (<EQUAL? .RARG ,M-ENTER>
		<QUEUE I-OGRE -1>
		<RFALSE>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<AND <VERB? LISTEN> <NOT ,PRSO>>
		       <OGRE-NOISES>)
		      (<AND <VERB? SMELL> <NOT ,PRSO>>
		       <TELL
"It smells horrific. The sanitary habits of ogres are appalling." CR>)>)>>

<GLOBAL SNEEZY? <>>

<ROOM OGRE-CAVE
      (IN ROOMS)
      (DESC "Cave")
      (OUT TO CAVE-ENTRANCE)
      (SOUTH TO CAVE-ENTRANCE)
      (DOWN PER OGRE-BEDROOM-EXIT)
      (ACTION OGRE-CAVE-F)
      (FLAGS RLANDBIT)
      (GLOBAL GLOBAL-CAVE GLOBAL-ROCKS)
      (THINGS <PSEUDO (LOOSE DIRT RANDOM-PSEUDO)
		      (HARD DIRT RANDOM-PSEUDO)>)>

<ROUTINE OGRE-CAVE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a natural fissure in the rock which was enlarged with crude skill
into a spacious and comfortable room, at least if you're fond of caves.
The floor is dirt, hard packed in some parts, loose in others.
A low passage leads down. ">
		<OGRE-DESC>)
	       (<EQUAL? .RARG ,M-ENTER>
		<COND (<NOT <QUEUED? I-OGRE-KILLS-YOU>>
		       <QUEUE I-OGRE-KILLS-YOU 12>)>
		<COND (<NOT ,LIT>
		       <JIGS-UP
"In the dark you have blundered into something large, smelly, and mean.
It is annoyed by your intrusion and pounds you to a pulp.">)
		      (<AND <EQUAL? ,OHERE ,OGRE-BEDROOM>
			    <NOT ,SNEEZY?>
			    <NOT <EQUAL? ,ESPNIS? ,OGRE>>
			    <NOT <TIME-FROZEN?>>>
		       <I-OGRE-KILLS-YOU T>)>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<AND <VERB? LISTEN> <NOT ,PRSO>>
		       <PERFORM ,V?LISTEN ,OGRE>
		       <RTRUE>)
		      (<AND <VERB? SMELL> <NOT ,PRSO>>
		       <SMELL-OGRE-CAVE>)
		      (<OR <VERB? WAVE>
			   ;<AND <VERB? DROP>
				<EQUAL? ,PRSO ,CLUB>>>
		       <GIVE-TO-OGRE>)
		      (<AND <VERB? THROUGH> <EQUAL? ,PRSO ,CORRIDOR>>
		       <DO-WALK ,P?DOWN>)>)>>

<ROUTINE SMELL-OGRE-CAVE ()
	 <TELL
"It smells even worse inside than it did outside, as hard as that is to
credit." CR>>

<ROUTINE OGRE-BEDROOM-EXIT ()
	 <COND (<OR ,SNEEZY?
		    <TIME-FROZEN?>
		    <EQUAL? ,ESPNIS? ,OGRE>>
		<TELL
"You saunter nonchalantly past the " <COND (,SNEEZY?
					    "convulsively sneezing")
					   (<TIME-FROZEN?>
					    "immobile")
					   (ELSE "sleeping")>
" ogre." CR CR>
		,OGRE-BEDROOM)
	       (ELSE
		<TELL
"The ogre moves quickly to bar your way">
		;<COND (<IN? ,CLUB ,OGRE>
		       <TELL
", waving his club menacingly">)>
		<COND (<EQUAL? ,SHRINK-FLAG ,OGRE>
		       <TELL
". He may be small, but he's still dangerous">)>
		<TELL ,PERIOD>
		<RFALSE>)>>

<ROOM OGRE-BEDROOM
      (IN ROOMS)
      (DESC "Ogre Lair")
      (UP TO OGRE-CAVE)
      (OUT TO OGRE-CAVE)
      (ACTION OGRE-BEDROOM-F)
      (FLAGS RLANDBIT)
      (GLOBAL GLOBAL-CAVE)
      (THINGS
       <PSEUDO (FILTHY FUR RANDOM-PSEUDO)
	       (MOLDY FUR RANDOM-PSEUDO)
	       (FILTHY FURS PLURAL-PSEUDO)
	       (MOLDY FURS PLURAL-PSEUDO)
	       (CRUDE BED RANDOM-PSEUDO)>)>

<ROUTINE OGRE-BEDROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This small but cozy hole is the ogre's lair. Moldy, filthy furs piled
in one corner make a crude bed. There is a rocky crawl up to the main
part of the cave." CR>)
	       (<EQUAL? .RARG ,M-ENTER>
		<COND (<EQUAL? ,OHERE ,DULL-ROOM>
		       <I-OGRE-KILLS-YOU T>)>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<AND <VERB? LISTEN> <NOT ,PRSO>>
		       <OGRE-NOISES>)
		      (<AND <VERB? SMELL> <NOT ,PRSO>>
		       <SMELL-OGRE-CAVE>)
		      (<AND <VERB? THROUGH>
			    <EQUAL? ,PRSO ,CORRIDOR>>
		       <DO-WALK ,P?UP>)>)>>

<OBJECT MAGIC-BOX
	(IN OGRE-BEDROOM)
	(DESC "gold box")
	(SYNONYM BOX LATCH LID SYMBOL)
	(ADJECTIVE GOLD DECORATION)
	(FLAGS TAKEBIT CONTBIT MAGICBIT SEARCHBIT)
	(CAPACITY 10)
	(ACTION MAGIC-BOX-F)>

<ROUTINE MAGIC-BOX-EXIT ("AUX" L)
	 <SET L <LOC ,MAGIC-BOX>>
	 <COND (<AND .L
		     <IN? .L ,ROOMS>
		     <NOT <EQUAL? .L ,EMPORIUM>>
		     <NOT <GETP .L ,P?CUBE>>
		     <EQUAL? <GETP ,HERE ,P?CUBE> ,MAGIC-BOX-CUBE>>
		<COND (<EQUAL? .L ,CASTLE>
		       <MAGIC-DOOR-EXIT>)
		      (ELSE .L)>)
	       (ELSE
		<TELL
"Oddly, although there appears to be an exit there, you can't seem to
force your way through it." CR>
		<RFALSE>)>>

<GLOBAL MAGIC-BOX-CUBE <>>

<ROUTINE MAGIC-BOX-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The gold box is small, richly ornamented with allegorical figures of ">
		<MAGIC-BOX-CREATURE>
		<TELL " and cryptic symbols. It has
a small latch which ">
		<COND (<FSET? ,MAGIC-BOX ,OPENBIT>
		       <TELL "could hold">)
		      (ELSE
		       <TELL "holds">)>
		<TELL " closed the lid." CR>)
	       (<VERB? LOCK UNLOCK>
		<TELL "There's no lock, only a latch." CR>)
	       (<AND <VERB? PUT> <EQUAL? ,PRSI ,MAGIC-BOX>>
		<COND (<NOT <IN? ,MAGIC-BOX ,WINNER>>
		       <NOT-HOLDING ,PRSI>)
		      (<NOT <FSET? ,MAGIC-BOX ,OPENBIT>>
		       <TELL
,YOU-HAVE-TO " open the " 'PRSI " first." CR>)
		      (<FIRST? ,MAGIC-BOX>
		       <TELL
"There is already something in it." CR>)
		      (<NOT <GETPT ,PRSO ,P?NAME>>
		       <COND (<L? <GETP ,PRSO ,P?SIZE>
				  <GETP ,MAGIC-BOX ,P?CAPACITY>>
			      <TELL "Strangely, you can't fit it in." CR>)
			     (ELSE
			      <TELL ,DOESNT-FIT>)>)
		      (ELSE
		       <MOVE ,PRSO ,MAGIC-BOX>
		       <COND (<OR <EQUAL? ,PRSO ,MAGIC-BOX-CUBE>
				  <AND <EQUAL? ,MAGIC-BOX-CUBE ,TIME-CUBE>
				       <NOT <GETP ,PRSO ,P?CUBE>>>>
			      <TELL "Done." CR>)
			     (ELSE
			      <COND (<EQUAL? ,HERE ,SCALES-ROOM>
				     <USE-SPELL>)>
			      <SETG MAGIC-BOX-CUBE ,PRSO>
			      <TELL
"When you insert " THE ,PRSO " into the box, there is a brief burst of
light, and the decorations on the box change subtly. They now depict ">
			      <MAGIC-BOX-CREATURE>
			      <TELL ,PERIOD>)>)>)>>

<ROUTINE MAGIC-BOX-CREATURE ("AUX" STR)
	 <COND (<SET STR <GETP ,MAGIC-BOX-CUBE ,P?TEXT>>
		<TELL .STR>)
	       (ELSE <TELL "turtles">)>>

<OBJECT OGRE
	(IN OGRE-CAVE)
	(DESC "ogre")
	(SYNONYM OGRE)
	(ADJECTIVE MOUNTAIN)
	(FLAGS PERSON THE NDESCBIT BRIEFBIT CONTBIT OPENBIT)
	(ACTION OGRE-F)
	(DESCFCN OGRE-DESC)
	(CONTFCN OGRE-F)>

<ROUTINE OGRE-DESC ("OPTIONAL" RARG OBJ)
	 <TELL "A " <COND (<EQUAL? ,SHRINK-FLAG ,OGRE>
			   "small but nasty")
			  (ELSE "large")> " ogre ">
	 <COND (<TIME-FROZEN?>
		<TELL
"stands immobile in the passage, caught in mid-sneeze.">)
	       (<EQUAL? ,ESPNIS? ,OGRE>
		<TELL
"snores noisily here.">)
	       (,SNEEZY?
		<TELL
"rolls uncomfortably on the floor, sneezing loudly.">)
	       (ELSE
		;<COND (<IN? ,CLUB ,OGRE>
		       <TELL "with a club ">)>
		<TELL "bars the passage.">)>
	 <CRLF>>

<ROUTINE OGRE-F ("OPTIONAL" (RARG <>))
	 <COND (<EQUAL? ,WINNER ,OGRE>
		<COND (<OR <TIME-FROZEN?>
			   <EQUAL? ,ESPNIS? ,OGRE>>
		       <TELL
"There is no reply." CR>)
		      (ELSE
		       <TELL
CTHE ,OGRE " grunts nastily at you." CR>)>
		<END-QUOTE>)
	       ;(<EQUAL? .RARG ,M-CONTAINER>
		<COND (<AND <VERB? MALYON> <EQUAL? ,PRSO ,CLUB>>
		       <COND (<IMMOBILIZED?> <RTRUE>)
			     (ELSE
			      <TELL
"The club comes alive, writhing and kicking and trying to get away, but
the ogre grips it purposefully and glares at you until it quiets down." CR>)>)
		      (<AND <VERB? TAKE RUB>
			    <IN? ,PRSO ,OGRE>>
		       <TELL
"The ogre has " THE ,PRSO " gripped tight." CR>)>)
	       (ELSE
		<COND (<VERB? EXAMINE>
		       <TELL
"This is a fairly typical mountain ogre. His carbuncles are a brilliant
purple, and his hair is matted down with something slick and
unpleasant-smelling. His eyes are watering and his nose is running,
which doesn't make him any more attractive. His whole body is covered by
dirty brown fur. He looks like a particularly ill-favored
bear.">
		       ;<COND (<IN? ,CLUB ,OGRE>
			      <TELL
" He is carrying a large and well-used club.">)>
		       <COND (<TIME-FROZEN?>
			      <TELL
" He and all his surroundings are frozen in place.">)>
		       <COND (<EQUAL? ,SHRINK-FLAG ,OGRE>
			      <TELL
" He is currently six inches of concentrated ugliness.">)>
		       <CRLF>)
		      (<AND <VERB? GIVE SHOW WAVE-AT> <EQUAL? ,PRSI ,OGRE>>
		       <GIVE-TO-OGRE>)
		      (<VERB? LISTEN>
		       <TELL CTHE ,OGRE " sounds ">
		       <COND (<TIME-FROZEN?>
			      <TELL "very quiet." CR>)
			     (<EQUAL? ,ESPNIS? ,OGRE>
			      <TELL "like he is snoring." CR>)
			     (ELSE
			      <COND (<VISIBLE? ,WEED>
				     <COND (<FSET? ,WEED ,RMUNGBIT>
					    <TELL "extremely ">)
					   (ELSE
					    <TELL "somewhat ">)>)>
			      <TELL "congested and sneezy." CR>)>)
		      (<HOSTILE-VERB?>
		       <COND (<EQUAL? ,ESPNIS? ,OGRE>
			      <SETG ESPNIS? <>>
			      <DEQUEUE I-ESPNIS>
			      <TELL
"The ogre wakes at the first touch!" CR>)>
		       <COND (<TIME-FROZEN?>
			      <TELL
"There is no effect. It's like attacking a statue." CR>)
			     (,SNEEZY?
			      <TELL
CTHE ,OGRE "'s hide is thick, and your attack only tickles him." CR>)
			     (ELSE
			      <TELL
CTHE ,OGRE " contemptuously fends you off." CR>)>)
		      ;(<AND <VERB? ESPNIS>
			    <NOT <EQUAL? ,ESPNIS? ,OGRE>>>
		       <OGRE-LOSES-CLUB>
		       <RFALSE>)
		      (<VERB? SMELL>
		       <TELL
"You would put your nasal cavity at great risk." CR>)
		      (<VERB? YOMIN>
		       <COND (<EQUAL? ,ESPNIS? ,PRSO>
			      <TELL
CTHE ,PRSO " is asleep." CR>)
			     (ELSE
			      <TELL
"You get the impression of discomfort and annoyance. This is apparently
not just for the usual ogreish reasons (general nastiness, bad temper,
and lice) but because the ogre is suffering from hay fever." CR>)>)
		      (<VERB? SNAVIG>
		       <SETG CHANGED? ,OGRE>
		       <QUEUE I-SNAVIG 12>
		       <TELL
"You become just as ugly, bellicose, and sneezy as the ogre.">
		       <COND (<AND <NOT <EQUAL? ,ESPNIS? ,OGRE>>
				   <NOT <TIME-FROZEN?>>>
			      <TELL
" The ogre is even less inclined to let you by.">)>
		       <CRLF>)>)>>

<ROUTINE GIVE-TO-OGRE ()
	 <COND (<OR <TIME-FROZEN?>
		    <EQUAL? ,ESPNIS? ,OGRE>>
		<TELL
"He is in no position to respond." CR>)
	       (<EQUAL? ,PRSO ,WEED>
		<TELL
"The ogre shrinks back and lets go an explosive sneeze">
		;<COND (<IN? ,CLUB ,OGRE>
		       <TELL ", but his club is
still at the ready">)>
		<TELL ,PERIOD>)
	       ;(<EQUAL? ,PRSO ,CLUB>
		<MOVE ,CLUB ,OGRE>
		<FSET ,CLUB ,NDESCBIT>
		<TELL
		 "He grabs it." CR>)
	       (ELSE
		<UNINTERESTED ,OGRE>)>>

;<OBJECT CLUB
	(IN OGRE)
	(DESC "club")
	(SYNONYM CLUB)
	(SIZE 10)
	(FLAGS WEAPONBIT TAKEBIT TRYTAKEBIT NDESCBIT)>
