"INTERRUPTS for
				MAGE
	(c) Copyright 1985 Infocom, Inc. All Rights Reserved."

;"GENERICS"

<ROUTINE GENERIC-CUBE-F (TBL LEN
			 "AUX" F (CNT 1) (CONT <>) CUBE?)
	 <COND (<VERB? ASK-ABOUT TELL-ME-ABOUT COUNT>
		<GET .TBL .CNT>)
	       (ELSE
		<COND (<AND <VERB? TAKE>
			    <EQUAL? <GET ,P-ITBL ,P-PREP2> ,PR?FROM>
			    <EQUAL? <GET ,P-PRSI ,P-MATCHLEN> 1>>
		       <SET CONT <GET ,P-PRSI 1>>)>
		<REPEAT ()
			<COND (<G? .CNT .LEN>
			       <RFALSE>)>
			<SET F <GET .TBL .CNT>>
			<SET CUBE? <GETPT .F ,P?NAME>>
			<COND (<AND .CUBE?
				    <OR <VISIBLE? .F>
					<VERB? ASK-ABOUT TELL-ABOUT>>>
			       <COND (<ZERO? <GETP .F ,P?NAME>>
				      <COND (<OR <NOT .CONT>
						 <IN? .F .CONT>>
					     <RETURN .F>)>)>)>
			<SET CNT <+ .CNT 1>>>)>>

<ROUTINE GENERIC-FISH-F (TBL LEN)
	 <COND (<VERB? DROP EAT SHOW GIVE> ,FISH)>>

<ROUTINE GENERIC-ROCK-F (TBL LEN)
	 <COND (<IN? ,PLAYER ,ROCK>
		,ROCK)
	       (<IN? ,PLAYER ,OTHER-ROCK>
		,OTHER-ROCK)
	       (<AND <EQUAL? ,YOU-LOC ,ROCK-LOC>
		     <EQUAL? ,YOU-LOC ,OTHER-ROCK-LOC>>
		<RFALSE>)
	       (<EQUAL? ,YOU-LOC ,ROCK-LOC>
		,ROCK)
	       (<EQUAL? ,YOU-LOC ,OTHER-ROCK-LOC>
		,OTHER-ROCK)
	       (ELSE
		<RFALSE>)>>

<ROUTINE GENERIC-CARPET-F (TBL LEN)
	 <COND (<VERB? EXAMINE> <RFALSE>)
	       (ELSE ,RANDOM-CARPET)>>

<ROUTINE GENERIC-HOLE-F (TBL LEN)
	 <COND (<OR <IN? ,OCTAGONAL-HOLE ,HERE>
		    <EQUAL? ,HERE ,MAZE-2>>
		,OCTAGONAL-HOLE)
	       (ELSE ,GLOBAL-HOLE)>>

<ROUTINE GENERIC-RANDOM-F (TBL LEN)
	 <RFALSE>>

;"from GUILD.ZIL"

<ROUTINE I-ORATION ()
	 <SETG OCOUNT <+ ,OCOUNT 1>>
	 <CRLF>
	 <COND (<==? ,OCOUNT 1>
		<SETG ORATOR ,SNEFFLE>
		<TELL
'SNEFFLE " of the Guild of Bakers is addressing the gathering. \"Do you know what this is doing
to our business? Do you know how difficult it is to make those yummy butter
pastries by hand? When a simple 'gloth' spell would fold the dough 83 times
it was possible to make a profit, but now 'gloth' hardly works, and when it
does, it usually folds the dough too often and the butter melts, or it
doesn't come out the right size, or...\" He stops, apparently overwhelmed by
the prospect of a world where the pastries have to be hand-made. \"Can't you do
anything about this? You're supposed to know all about magic!\"">)
		(<==? ,OCOUNT 2>
		 <SETG ORATOR ,HOOBLY>
		 <TELL
'HOOBLY " of the Guild of Brewers stands, gesturing at the floury baker. \"You don't know what
trouble is! Lately, what comes out of the vats, like as not, is cherry
flavored or worse. The last vat, I swear it, tasted as if grues had been
bathing in it. It takes magic to turn weird vegetables and water into
good Borphee beer. Well, without magic, there isn't going to be any
beer!\" This statement has a profound effect on portions of the
crowd. You can hear rumblings from the back concerning Enchanters. The
word \"traitors\" rises out of nowhere. Your fellow Enchanters are
looking at one another nervously.">)
		(<==? ,OCOUNT 3>
		 <SETG ORATOR ,GZORNENPLATZ>
		 <TELL
"A tall, gruff fellow begins to speak. This is " 'GZORNENPLATZ " of the
Guild of Huntsmen. \"I'm a simple man, and I don't know much about
magic. But I do know that the wild beasts are kept out of the towns and
villages not just by the huntsmen, but by spells as well. Just
yesterday, one of my men was attacked and badly wounded by a troop of
rat-ants. They'd slipped the bounds set down by a 'fripple' spell
somehow. Are we going to let the sorcerers loose rat-ants on us, and
worse?\" He sits, glaring significantly at the now-angry clump of mages
around you.">)
		(<==? ,OCOUNT 4>
		 <SETG ORATOR ,ARDIS>
		 <SETG CLEESHED? T>
		 <MOVE ,BLORPLE-SPELL ,SPELL-BOOK>
		 <TELL
"As the huntsman's accusations are being absorbed and discussed, "
'ARDIS " of the Guild of Poets takes the floor. He begins to talk about
magic rhyming and spelling aids, and their lack.|
|
In the midst of his
splendid peroration, just as he was sketching out an insulting
mythological allusion in iambic hexameter, the poet turns even greener
than usual. His chin elongates and his skin begins to look sort of
slimy. In the blink of an eye there stands at the podium, not the
orator, but rather a large orange newt. \"Breek! Co-ax! Co-ax!\" it
protests.|
|
As you look around the room in shock, you discover that
Ardis is not alone. Each and every guildmaster in the room has been
turned into a frog, salamander, or other amphibian! All but one, that
is: yourself!|
|
No! There is one other survivor. At the rear of the
room, a " 'SHADOW " in a dark cloak slips quietly out the door.">
		 <THIS-IS-IT ,SHADOW>
		 <FCLEAR ,SHADOW ,NDESCBIT>
		 <MOVE ,SHADOW ,GUILD-HALL>
		 <QUEUE I-SHADOW-GOES 1>
		 <DEQUEUE I-ORATION>)>
	 <CRLF>>

<GLOBAL OCOUNT 0>

<GLOBAL SAMARRA? <>>

<ROUTINE I-SAMARRA ()
	 <COND (<EQUAL? ,HERE ,BELWIT-SQUARE ,GUILD-HALL>
		<TELL CR
"Out of the corner of your eye, you see the dark-cloaked figure. At
first oblivious to you, it straightens up, startled and surprised,
then vanishes." CR>)
	       (ELSE
		<SETG SAMARRA? <>>)>>

<ROUTINE I-SHADOW-GOES ()
	 <COND (<IN? ,SHADOW ,GUILD-HALL>
		<QUEUE I-SHADOW-GOES 1>
		<MOVE ,SHADOW ,BELWIT-SQUARE>
		<COND (<EQUAL? ,HERE ,GUILD-HALL>
		       <CRLF>
		       <TELL
CTHE ,SHADOW ", its cloak billowing, charges south into
Belwit Square." CR>)>)
	       (ELSE
		<MOVE ,EARTH-CUBE ,BELWIT-SQUARE>
		<MOVE ,SHADOW ,GLOBAL-OBJECTS>
		<FCLEAR ,SHADOW ,TAKEBIT>
		<FCLEAR ,SHADOW ,TRYTAKEBIT>
		<FCLEAR ,CLOUD ,INVISIBLE>
		<QUEUE I-CLOUD-GONE 20>
		<COND (<EQUAL? ,HERE ,GUILD-HALL>
		       <CRLF>
		       <TELL
"Out in the square, there is a crashing noise like
an explosion, and then a wisp of orange smoke drifts in through the door." CR>)
		      (<EQUAL? ,HERE ,BELWIT-SQUARE>
		       <CRLF>
		       <TELL
"The sinister figure, its face hidden in the shadows of a dark cowl, turns to
face you. It nonchalantly jumps into the air, where it is engulfed
in a huge explosion. A thick and acrid
cloud of orange smoke fills the square. There is no sign of the figure."
CR>)>)>>

<ROUTINE I-CLOUD-GONE ()
	 <FSET ,CLOUD ,INVISIBLE>
	 <COND (<IN? ,EARTH-CUBE ,BELWIT-SQUARE>
		<FCLEAR ,EARTH-CUBE ,INVISIBLE>
		<THIS-IS-IT ,EARTH-CUBE>)>
	 <COND (<EQUAL? ,HERE ,BELWIT-SQUARE>
		<CRLF>
		<TELL
"The orange smoke dissipates almost as suddenly as it arrived">
		<COND (<IN? ,EARTH-CUBE ,BELWIT-SQUARE>
		       <TELL
". Left behind on the cobblestones is a small " ,WHITE-CUBE>)>
		<CLEVER-CONTENTS ,HERE ". Also revealed" ,EARTH-CUBE>
		<TELL ,PERIOD>)>>

<ROUTINE I-SHADOW-ARRIVES ()
	 <COND (<EQUAL? ,HERE ,CASTLE>
		<COND (<EQUAL? ,TIME-STOPPED? ,HERE>
		       <QUEUE I-SHADOW-ARRIVES 1>
		       <RFALSE>)>
		<QUEUE I-SHADOW -1>
		<MOVE ,SHADOW ,CASTLE>
		<FCLEAR ,SHADOW ,TAKEBIT>
		<FCLEAR ,SHADOW ,TRYTAKEBIT>
		<CRLF>
		<TELL
"Around the throne a dark mist begins to coalesce. It thickens
into the outline of a human figure sitting
nonchalantly on the throne. You can see the ghost of a cloak and
hood as well." CR>)>>

<GLOBAL SHADOW-COUNT 0>

<ROUTINE I-SHADOW ("AUX" (WON? <>) X)
	 <COND (<NOT <EQUAL? ,HERE ,CASTLE>>
		<DEQUEUE I-SHADOW>
		<RFALSE>)>
	 <COND (,SAMARRA?
		<SETG SAMARRA? <>>
		<TELL CR
"\"So glad to see you. I was surprised to find you in Borphee when I knew
we had an appointment here.\"" CR>
		<RTRUE>)>
	 <COND (<EQUAL? ,TIME-STOPPED? ,HERE>
		<RFALSE>)>
	 <SETG SHADOW-COUNT <+ ,SHADOW-COUNT 1>>
	 <CRLF>
	 <COND (<EQUAL? ,SHADOW-COUNT 1>
		<TELL
"The figure speaks. \"It's been such a pleasure to follow your progress. ">
		<COND (<G? ,DEATHS 0>
		       <TELL
"I'm so glad I could be of assistance when you had trouble. It made me
feel useful. ">)>
		<TELL "Thank you for collecting the cubes.\"" CR>)
	       (<EQUAL? ,SHADOW-COUNT 2>
		<MOVE ,HYPERCUBE ,HERE>
		<TELL
"The figure waves its arms in the air. Before you, rolling and tumbling
in a bath of light, are four cubes.
\"When I gathered these and " THE ,EARTH-CUBE ", after searching old tomes and
questioning the wise about their whereabouts, I conceived my plan.
I could not gather the remainder of the cubes, but to achieve my
desire, they had to be brought together. Who better than you to act in
my stead?\"" CR>)
	       (<EQUAL? ,SHADOW-COUNT 3>
		<TELL
"\"It was a simple matter to perturb the cubes I had to make your
simple magics flicker or fail. I knew this would set you on a quest.
For I know you well!\"
The four cubes disappear. The figure sits straight on its throne and
removes its hood. You are looking at a shadowy, dark and transparent
version of yourself!" CR CR 
"\"Magic is a powerful force, the most powerful in the universe, but
its exercise has its price. Each time a great mage performs a spell, some
part of the power in that spell is lost in shadow. A great
mage ultimately creates a shadow-self that is dimly aware.\" The figure
grins. \"You have become the most powerful wizard of all, for I, your
shadow, have become very nearly as powerful as you!\"" CR>)
	       (<EQUAL? ,SHADOW-COUNT 4>
		<TELL
"\"But why, you ask, am I collecting the elemental cubes? It's easy to
answer. I am not powerful enough. My existence is still but a shadow of
your own. My desires are unfulfilled. I wish power over all creation!
I wish to remold the universe in my own image, and rule it. In such a
universe, my merest whim would smash a star or slay a butterfly. You
have brought me the tools of the remaking!\"" CR CR>
		<COND (<NOT ,FROZEN?>
		       <FREEZES-YOU T>
		       <CRLF>)>
		<SHADOW-ACQUIRES ,EARTH-CUBE>
		<TELL " sets it in the air between
you, where it hangs motionless." CR>)
	       (<EQUAL? ,SHADOW-COUNT 5>
		<SHADOW-ACQUIRES ,AIR-CUBE>
		<TELL
" places it next to " THE ,EARTH-CUBE ". They disappear into a glowing
line which appears between them. ">
		<SHADOW-ACQUIRES <>>
		<TELL
" places " THE ,FIRE-CUBE " and " THE ,WATER-CUBE " in the air,
creating a square of glowing light." CR>)
	       (<EQUAL? ,SHADOW-COUNT 6>
		<TELL
"Four more cubes are placed above the square: " THE ,LIFE-CUBE ", "
THE ,DEATH-CUBE ", " THE ,LIGHT-CUBE " and " THE ,DARK-CUBE ". A
cube of light shimmers before you. The shadow is growing
more excited, hopping around the structure to place the cubes." CR>)
	       (<EQUAL? ,SHADOW-COUNT 7>
		<TELL
"All the remaining cubes save one, " THE ,MAGIC-CUBE ", build another
square, then the shadow adds its own four cubes to make a second cube
of light, which hangs next to the first." CR>)
	       (<EQUAL? ,SHADOW-COUNT 8>
		<TELL
"The shadow grabs the first cube of light, and twisting, chanting, squeezing,
the cube is compressed and thrust inside the second cube. The points of
the inner and outer cube connect, and it begins to tumble, seeming to
twist and distort as one face, then another, presents itself to you. The
figure capers madly in front of its construction, laughing and
giggling. It ignores you." CR>)
	       (<EQUAL? ,SHADOW-COUNT 9>
		<COND (<ROB ,HYPERCUBE ,HERE ,MAGIC-CUBE>
		       <TELL
CTHE ,SHADOW " removes some detritus from " THE ,HYPERCUBE ". ">)>
		<COND (<IN? ,MAGIC-CUBE ,HYPERCUBE>
		       <TELL
CTHE ,SHADOW " grins evilly at " THE ,MAGIC-CUBE " floating in">)
		      (ELSE
		       <SHADOW-ACQUIRES ,MAGIC-CUBE>
		       <MOVE ,MAGIC-CUBE ,HYPERCUBE>
		       <TELL
" raising it high, thrusts it into">)>
		<TELL " the
center of the tesseract! Cascades of light pour forth, blindingly
bright, but you can still see " THE ,MAGIC-CUBE " at the center. The
shadow is growing more solid, no longer transparent and dark! Chortling
gleefully, it prepares to jump into the hypercube!" CR>)
	       (<EQUAL? ,SHADOW-COUNT 10>
		<TELL
"The shadow, now as solid as a real person, performs a back flip into
the tesseract">
		<COND (<IN? ,MAGIC-CUBE ,HYPERCUBE>
		       <SET WON? <>>
		       <TELL ", laughing triumphantly.">)
		      (<SET X <FIRST? ,HYPERCUBE>>
		       <COND (<NOT <MAGIC? .X>> <SET WON? 3>)
			     (ELSE <SET WON? 2>)>)
		      (ELSE
		       <SET WON? 1>)>
		<COND (<EQUAL? .WON? 2>
		       <TELL
". \"Fool! Everything will be as it was!\"">)
		      (.WON?
		       <TELL
". \"No!\" It screams. \"Stop! Fool, you've destroyed me! You've destroyed ">
		       <COND (<EQUAL? .WON? 1>
			      <TELL "everything">)
			     (<EQUAL? .WON? 3>
			      <TELL "magic itself">)>
		       <TELL "! All my lovely plans!\"">)>
		<TELL " Now glowing as brightly as the
construction it made, the figure approaches the center. ">
		<COND (<EQUAL? .WON? 3>
		       <TELL
"It grows smaller and smaller, and just before it disappears, the hypercube
vanishes with a pop, and " THE ,MAGIC-CUBE " melts in your hand like an
ice cube." CR CR
"You find yourself back in Belwit Square, all the guildmasters and even
Belboz crowding around you. \"A new age begins today,\" says Belboz after
hearing your story. \"The age of magic is ended, as it must, for as magic
can confer absolute power, so it can also produce absolute evil. We may
defeat this evil when it appears, but if wizardry builds it anew, we can
never ultimately win. The new world will be strange, but in time it will
serve us better.\"" CR>
		       <SETG SCORE 600>
		       <FINISH>)
		      (ELSE
		       <END-OF-WORLD .WON?>
		       <CRLF>
		       <SETG SCORE -99>
		       <FINISH>)>)>>

<ROUTINE END-OF-WORLD (WON?)
	 <COND (<EQUAL? .WON? 2>
		<TELL
"It returns in fury, retrieves the " 'MAGIC-CUBE ", and resumes
its quest. ">
		<END-OF-WORLD <>>
		<RTRUE>)>
	 <TELL
"It dwindles in size and grows in brightness at the same time, until">
	 <COND (<EQUAL? .WON? 1>
		<TELL " it reaches the empty center.
Then you, it and all the world blink out like a spent match.">)
	       (ELSE
		<TELL " you
are almost blinded by a light so bright it fills the world. A
voice like honey and ashes speaks in your mind. \"I am the All, I am
the Will, I am the Power. The universe is Mine! Begone, insect!\" You
and all you hold dear are abolished in an instant, and the reign of the
shadow begins.">)>>

<GLOBAL FROZEN? <>>

<ROUTINE FREEZES-YOU ("OPTIONAL" (PREC? <>))
	 <COND (<OR <NOT .PREC?> <NOT ,FROZEN?>>
		<SETG FROZEN? 5>
		<COND (<HELD? ,MAGIC-CUBE>
		       <QUEUE I-UNFREEZE 2>)>
		<COND (.PREC?
		       <TELL
"\"Now for a small precaution.\"">)
		      (ELSE
		       <TELL
"The shadow notices you. \"You force me to take precautions.\"">)>
		<TELL
" The shadow gestures, and you are frozen in
place, unable to move even your littlest finger." CR>)>>

"steal all but magic cube"
<ROUTINE STEAL-CUBES ("AUX" (CNT 0) (N 0) CUBE)
	 <REPEAT ()
		 <SET CUBE <GET ,CUBE-LIST <* .CNT 2>>>
		 <MOVE .CUBE ,HERE>
		 <FSET .CUBE ,NDESCBIT>
		 <COND (<IGRTR? CNT 11> <RETURN .N>)>>>

<ROUTINE SHADOW-ACQUIRES (OBJ)
	 <TELL CTHE ,SHADOW>
	 <COND (<NOT .OBJ> <STEAL-CUBES> ;"all but magic")
	       (ELSE
		<COND (<HELD? .OBJ ,WINNER>
		       <TELL
" deftly takes " THE .OBJ " from ">
		       <COND (<IN? .OBJ ,WINNER>
			      <TELL "you">)
			     (ELSE
			      <TELL THE <LOC .OBJ>>)>)
		      (ELSE
		       <TELL " takes " THE .OBJ>)>
		<TELL " and">
		<FSET .OBJ ,NDESCBIT>
		<MOVE .OBJ ,HERE>)>>

<ROUTINE I-UNFREEZE ()
	 <SETG FROZEN? <- ,FROZEN? 1>>
	 <QUEUE I-UNFREEZE 1>
	 <CRLF>
	 <COND (<EQUAL? ,FROZEN? 4>
		<TELL
"Your little finger is full of pins and needles. You could move it if you
wanted." CR>)
	       (<EQUAL? ,FROZEN? 3>
		<TELL
"Your feet and hands feel as if they've been asleep, but you can move
them." CR>)
	       (<EQUAL? ,FROZEN? 2>
		<TELL
"Your arms and legs are free, but you still cannot speak or move your
head." CR>)
	       (<EQUAL? ,FROZEN? 1>
		<TELL
"You feel almost thawed, but your mouth feels full of cotton." CR>)
	       (<ZERO? ,FROZEN?>
		<DEQUEUE I-UNFREEZE>
		<SETG FROZEN? <>>
		<TELL
"The freeze has worn entirely off! Your contact with " THE ,MAGIC-CUBE
" must have weakened it." CR>)>>

;"from HUNGER"

<GLOBAL LOAD-MAX 150>
<GLOBAL LOAD-ALLOWED 150>

<GLOBAL AWAKE -1>

<ROUTINE I-TIRED ("AUX" (FORG <>))
	 <QUEUE I-TIRED 8>
	 <COND (<HELD? ,MAGIC-CUBE> <RTRUE>)>
	 <COND (<G? ,LOAD-ALLOWED 10>
		<SETG LOAD-ALLOWED <- ,LOAD-ALLOWED 10>>)>
	 <COND (<G? ,FUMBLE-NUMBER 1>
		<SETG FUMBLE-NUMBER <- ,FUMBLE-NUMBER 1>>)>
	 <COND (<G? ,SPELL-MAX 1>
		<SETG SPELL-MAX <- ,SPELL-MAX 1>>
		<COND (<G? ,SPELL-ROOM 0>
		       <SETG SPELL-ROOM <- ,SPELL-ROOM 1>>)>
		<COND (<EQUAL? ,SPELL-ROOM 0>
		       <SET FORG T>)>)>
	 <SETG AWAKE <+ ,AWAKE 1>>
	 <COND (<G? ,AWAKE 8>
		<TELL
"You are so exhausted you can't stay awake any longer." CR>
		<CRLF>
		<V-SLEEP T>
		<RFATAL>)
	       (T
		<TELL "You are " <GET ,TIRED-TELL ,AWAKE>>
		<COND (.FORG
		       <TELL
", and the spells you've memorized are becoming confused">)>
		<TELL ,PERIOD>)>>

;"from MAGIC"

<ROUTINE I-SNAVIG ("AUX" OCHANGE)
	 <COND (<NOT ,CHANGED?> <RFALSE>)>
	 <SET OCHANGE ,CHANGED?>
	 <SETG CHANGED? <>>
	 <TELL CR
"You have become yourself again.">
	 <COND (<EQUAL? .OCHANGE ,GRUE>
		<SETG LIT <LIT? ,HERE>>
		<COND (<EQUAL? ,HERE ,GRUE-CAVE>
		       <TELL
" You are immediately noticed by the startled grues. The one drawback of this
essentially light-free environment is that it is also adventurer-free. The
grues are overjoyed to find this deficiency remedied. You are probably less
so.">
		       <JIGS-UP>
		       <RFATAL>)>)
	       (<EQUAL? .OCHANGE ,ROC>
		<COND (<FSET? ,HERE ,RAIRBIT>
		       <START-FALLING>
		       <TELL
" You begin to fall.">)>)
	       (<EQUAL? .OCHANGE ,GROUPER>
		<COND (<EQUAL? ,HERE ,OCEAN-FLOOR>
		       <QUEUE I-DROWN 3>
		       <TELL
" Fortunately your gills have stored some oxygen, but you are in danger
of drowning.">)>
		<COND (,ATE-AS-GROUPER?
		       <TELL
" You have a horrible stomachache. It must have been something you ate.">)>)>
	 <CRLF>>

<ROUTINE I-DROWN ()
	 <COND (<AND <EQUAL? ,HERE ,OCEAN-FLOOR>
		     <NOT <EQUAL? ,CHANGED? ,GROUPER>>>
		<CRLF>
		<JIGS-UP
"Your air has run out. You are still far underwater. You have drowned.">)>>

<ROUTINE I-GIRGOL ("AUX" TF?)
	 <COND (<NOT ,TIME-STOPPED?> <RFALSE>)
	       (<SET TF? <TIME-FROZEN?>>
		<TELL CR "Time resumes its forward flight." CR>)>
	 <SETG TIME-STOPPED? <>>
	 <COND (,ROCK-FLAG
		<SETG ROCK-FLAG <>>
		<COND (<EQUAL? ,HERE ,HUT-ROOM ,MOUNTAIN-TOP ,CAVE-ENTRANCE>
		       <TELL CR
"You hear a gigantic rush of sound as an avalanche tumbles down the
mountain." CR>)
		      (<EQUAL? ,HERE ,BOULDER-1 ,BOULDER-2 ,BOULDER-3>
		       <CRLF>
		       <JIGS-UP
"Tons of rock and dirt continue towards their rendezvous with the valley
floor. Unfortunately, you are ground to nothingness when they arrive for
their appointment.">)
		      (<EQUAL? .TF?
			       ,CLIFF-TOP ,CLIFF-MIDDLE ,CLIFF-BOTTOM>
		       <QUEUE I-AVALANCHE -1>
		       <TELL CR
"Tons of rock and dirt continue their downward plunge." CR>)>)>
	 <COND (<AND <EQUAL? .TF? ,OGRE-BEDROOM ,OGRE-CAVE>
		     <EQUAL? ,HERE ,OGRE-BEDROOM ,OGRE-CAVE>>
		<I-OGRE-KILLS-YOU T>)>
	 <COND (<AND <EQUAL? .TF? ,PAST-RUINS-ROOM>
		     <EQUAL? ,HERE ,PAST-RUINS-ROOM>>
		<QUEUE I-WATER-RISING 3>
		<TELL CR
"The water begins to rise again." CR>)>
	 <COND (<AND <EQUAL? .TF? ,CASTLE>
		     <EQUAL? ,HERE ,CASTLE>>
		<COND (<EQUAL? ,SHADOW-COUNT 8>
		       <TELL CR
"\"Fool!\" chortles the shadow." CR>)>
		<RTRUE>)>>

<GLOBAL OGRE-MURDEROUS? <>>

<ROUTINE I-OGRE-KILLS-YOU ("OPTIONAL" (GIRGOL? <>))
	 <COND (<OR <TIME-FROZEN?>
		    ,SNEEZY?
		    <EQUAL? ,ESPNIS? ,OGRE>>
		<QUEUE I-OGRE-KILLS-YOU 2>
		<RFALSE>)>
	 <COND (<EQUAL? ,HERE ,OGRE-CAVE ,OGRE-BEDROOM>
		<COND (<IN? ,PLAYER ,ZIPPER>
		       <SETG OGRE-MURDEROUS? T>
		       <RTRUE>)>
		<COND (<NOT .GIRGOL?> <CRLF>)>
		<TELL
"The ogre, impatient with your presence and your impudent intrusion, ">
		<COND (<EQUAL? ,HERE ,OGRE-BEDROOM>
		       <TELL "charges in and ">)>
		<TELL "tramples you to a pulp.">
		<JIGS-UP>)>>

<ROUTINE I-ESPNIS ()
	 <COND (<TIME-FROZEN?>
		<QUEUE I-ESPNIS 2>)
	       (<NOT ,ESPNIS?> <RFALSE>)>
	 <COND (<IN? ,ESPNIS? ,HERE>
		<TELL CR
CTHE ,ESPNIS? " awakes, looking sheepish.">
		<COND (<AND <EQUAL? ,ESPNIS? ,OGRE>
			    <NOT ,SNEEZY?>>
		       <OGRE-MAD>)
		      (ELSE <CRLF>)>)>
	 <SETG ESPNIS? <>>>

<ROUTINE I-LISKON ("OPTIONAL" (NOCR? <>) "AUX" SF)
	 <COND (<NOT ,SHRINK-FLAG> <RFALSE>)>
	 <SET SF ,SHRINK-FLAG>
	 <SETG SHRINK-FLAG <>>
	 <COND (<NOT <EQUAL? .SF ,PLAYER>>
		<COND (<AND <FSET? ,WEED ,RMUNGBIT>
			    <EQUAL? .SF ,WEED>>
		       <PUTP ,WEED ,P?SIZE 200>)>
		<COND (<VISIBLE? .SF>
		       <COND (<NOT .NOCR?> <CRLF>)>
		       <COND (<EQUAL? .SF ,SNAKE>
			      <TELL
"The serpent slowly and jerkily returns to its former size, swallowing its
tail again in the process." CR>)
			     (ELSE
			      <TELL
"With a rather unsettling lack of uniformity, " THE .SF " returns
to its former size.">
			      <COND (<AND <EQUAL? .SF ,WEED>
					  <FSET? ,WEED ,RMUNGBIT>>
				     <COND (<IN? .SF ,WINNER>
					    <MOVE .SF ,HERE>
					    <TELL
" It's too heavy to carry.">)
					   (<EQUAL? <LOC .SF> ,BOTTLE>
					    <MOVE .SF <META-LOC ,BOTTLE>>
					    <REMOVE ,BOTTLE>
					    <TELL
" It bursts the bottle!">)
					   (<EQUAL? <LOC .SF>
						    ,MAGIC-CARPET
						    ,RANDOM-CARPET>
					    <MOVE .SF <META-LOC .SF>>)>)>
			      <CRLF>)>)>)
	       (ELSE
		<SETG SMALL-FLAG <>>
		<COND (<NOT .NOCR?> <CRLF>)>
		<TELL
"You feel stretched, wrung out, and pulled in all directions. You
are growing." CR>
		<COND (<EQUAL? <LOC ,PLAYER> ,CABINET ,PAST-CABINET>
		       <TOO-LARGE ,CABINET>)
		      (<IN? ,PLAYER ,ZIPPER>
		       <RFALSE>)
		      (<EQUAL? ,HERE ,IN-PIPE ,IN-PIPE-2 ,IN-SEWER>
		       <TOO-LARGE ,WATER-PIPE>
		       <RFATAL>)
		      (<EQUAL? ,HERE ,IN-CHANNEL>
		       <CRLF>
		       <GOTO ,OUBLIETTE>)
		      (<EQUAL? ,HERE ,RUINED-PIPE>
		       <CRLF>
		       <GOTO ,RUINS-ROOM>)>)>>

<ROUTINE TOO-LARGE (OBJ)
	 <TELL
"Unfortunately, you are rather too large for " THE .OBJ " you are in, and are
crushed by its sides as you try to resume your full size." CR>
	 <JIGS-UP>>

;"from C1"

<ROUTINE I-SNAKE ()
	 <COND (<EQUAL? ,HERE ,NORTH-SNAKE-ROOM ,SOUTH-SNAKE-ROOM>
		<TELL CR
"The scaly wall begins to move, undulating back and forth in the
confined space. A musty odor permeates the air, and you hear
scales scraping on stone. Finally, an enormous head slides into view
from the east and stops with one monstrous eye staring coldly at you.
You notice something unusual about the huge serpent: the tail, which
trails out of the western hole, disappears into the gaping maw of the
creature. You realize that the monster must be huge enough to make a
complete loop!" CR>)>>

<ROUTINE I-UNMALYON-IDOL ()
	 <DEQUEUE I-IDOL>
	 <DEQUEUE I-FULL-YAWN>
	 <DEQUEUE I-IDOL-ASLEEP>
	 <FCLEAR ,IDOL ,PERSON>
	 <COND (<EQUAL? ,HERE ,TEMPLE-ROOM>
		<CRLF>
		<TELL
"The idol turns back into basalt.">
		<COND (,IDOL-ASLEEP?
		       <TELL
" It is curled up comfortably asleep.">)
		      (,IDOL-YAWNING?
		       <TELL
" It has been caught in a cheek-stretching yawn.">)>
		<CRLF>)>>

<ROUTINE I-IDOL ()
	 <QUEUE I-IDOL -1>
	 <COND (<EQUAL? ,HERE ,TEMPLE-ROOM>
		<TELL CR
"The idol is ">
		<COND (,IDOL-SLEEPED?
		       <TELL
"looking sleepy and tired.">)
		      (ELSE
		       <TELL-IDOL-ACTION>
		       <TELL
" around the room, searching for something. No doubt
it's you! It looks a little stiff, but for former basalt, it's pretty
supple.">)>
		<CRLF>)>>

<ROUTINE TELL-IDOL-ACTION ()
	 <COND (<IN? ,OPAL ,IDOL> <TELL "looking">)
	       (ELSE <TELL "groping">)>>

<ROUTINE I-FULL-YAWN ()
	 <DEQUEUE I-IDOL>
	 <SETG IDOL-ASLEEP? <>>
	 <FSET ,MOUTH ,OPENBIT>
	 <SETG IDOL-YAWNING? T>
	 <COND (<EQUAL? ,HERE ,TEMPLE-ROOM>
		<TELL CR
"The idol is yawning sleepily, its mouth gaping open." CR>)>>

<ROUTINE I-IDOL-ASLEEP ()
	 <SETG IDOL-YAWNING? <>>
	 <FCLEAR ,MOUTH ,OPENBIT>
	 <SETG IDOL-ASLEEP? T>
	 <COND (<EQUAL? ,HERE ,TEMPLE-ROOM>
		<TELL CR
"The idol curls up comfortably and falls asleep on the floor." CR>)>>

<ROUTINE I-OPAL-SMASHES ()
	 <COND (<AND <IN? ,OPAL ,IDOL> ,OPAL-LOOSE?>
		<REMOVE ,OPAL>
		<SETG OPAL-LOOSE? <>>
		<MOVE ,OPAL-SHARD ,HERE>
		<COND (<EQUAL? ,HERE ,TEMPLE-ROOM>
		       <TELL
"The opal totters one last time and falls. You ">
		       <COND (<IN? ,PLAYER ,IDOL>
			      <TELL "grab for it frantically">)
			     (ELSE
			      <TELL "try to catch it">)>
		       <TELL ", but it
escapes your grip and smashes into a million pieces on the idol's
foot." CR>)>)>>

<GLOBAL SLIDE-PROB 10>

<ROUTINE I-AVALANCHE? ()
	 <COND (<NOT <EQUAL? ,HERE ,CLIFF-TOP>> <RFALSE>)
	       (<EQUAL? ,TIME-STOPPED? ,HERE> <RFALSE>)
	       (<PROB ,SLIDE-PROB>
		<SETG ROCK-SLIDE-COUNT 0>
		<DEQUEUE I-AVALANCHE?>
		<QUEUE I-AVALANCHE -1>
		<TELL CR
"Something you've done has disturbed the rocks above! Dirt and small stones
are trickling down. " ,IT-LOOKS-LIKE "the whole dike is about to give way!" CR>)
	       (ELSE
		<SETG SLIDE-PROB <+ ,SLIDE-PROB 10>>)>>

<GLOBAL ROCK-SLIDE-COUNT 0>

<ROUTINE HEAR-AVALANCHE ()
	 <TELL
"You hear the tremendous sliding, deep-voiced roar of thousands of tons of
rock tumbling down the mountain">>

<ROUTINE I-AVALANCHE ()
	 <COND (,TIME-STOPPED? <RFALSE>)
	       (<G? ,ROCK-SLIDE-COUNT 3>
		<SETG ROCK-SLIDE-COUNT 0>
		<DEQUEUE I-AVALANCHE>
		<RFALSE>)>
	 <SETG ROCK-SLIDE-COUNT <+ ,ROCK-SLIDE-COUNT 1>>
	 <COND (<EQUAL? ,HERE ,CAVE-ENTRANCE ,MOUNTAIN-TOP>
		<CRLF>
		<HEAR-AVALANCHE>
		<COND (<EQUAL? ,HERE ,CAVE-ENTRANCE>
		       <TELL " to your east">)>
		<TELL ,PERIOD>)
	       (<EQUAL? ,HERE ,CLIFF-TOP ,CLIFF-MIDDLE ,CLIFF-BOTTOM>
		<CRLF>
		<COND (<EQUAL? ,ROCK-SLIDE-COUNT 1>
		       <TELL
"Huge rocks and boulders are tumbling down, making an almost continuous
curtain above you. If you don't do something soon, you will die!" CR>)
		      (<OR <AND <EQUAL? ,HERE ,CLIFF-TOP>
				<G? ,ROCK-SLIDE-COUNT 1>>
			   <AND <EQUAL? ,HERE ,CLIFF-MIDDLE>
				<G? ,ROCK-SLIDE-COUNT 2>>
			   <AND <EQUAL? ,HERE ,CLIFF-BOTTOM>
				<G? ,ROCK-SLIDE-COUNT 3>>>
		       <DEQUEUE I-AVALANCHE>
		       <SETG ROCK-SLIDE-COUNT 0>
		       <COND (<IN? ,PLAYER ,ZIPPER>
			      <TELL
"Although you can't see or feel it, y">)
			     (ELSE <TELL "Y">)>
		       <JIGS-UP
"ou are swept away down the cliff face by thousands of tons of rock.
A huge cloud of dust blowing away down the valley is your only memorial.">)
		      (<EQUAL? ,HERE ,CLIFF-TOP ,CLIFF-MIDDLE ,CLIFF-BOTTOM>
		       <ROCKS-TUMBLING>)>)>>

<ROUTINE ROCKS-TUMBLING ()
	 <TELL
"Thousands of tons of rock are tumbling down the mountainside!" CR>>

<ROUTINE I-OGRE ()
	 <COND (<EQUAL? ,TIME-STOPPED? ,OGRE-CAVE> <RFALSE>)
	       (<EQUAL? ,HERE ,CAVE-ENTRANCE ,OGRE-BEDROOM>
		<COND (<EQUAL? ,ESPNIS? ,OGRE>
		       <CRLF>
		       <OGRE-NOISES>)
		      (,SNEEZY?
		       <TELL CR
"You hear explosive sneezing from the cave." CR>)
		      (<PROB 50>
		       <CRLF>
		       <OGRE-NOISES>)>)
	       (<EQUAL? ,HERE ,OGRE-CAVE>
		<COND (<EQUAL? ,ESPNIS? ,OGRE>
		       <TELL CR
"The ogre snores loudly." CR>)
		      (,SNEEZY?
		       <TELL CR
"The ogre doubles over in a spectacular paroxysm of sneezing." CR>)
		      (<PROB 50>
		       <TELL CR
"The ogre sneezes." CR>)>)
	       (ELSE
		<DEQUEUE I-OGRE>
		<RFALSE>)>>

<ROUTINE OGRE-NOISES ()
	 <COND (<NOT <TIME-FROZEN?>>
		<TELL
"You hear a noise from within the cave that sounds like ">
		<COND (<EQUAL? ,ESPNIS? ,OGRE> <TELL "snoring">)
		      (T <TELL "a sneeze">)>
		<TELL ,PERIOD>)>>	

;"from C2"

<ROUTINE I-FLOTSAM ()
	 <SINK-STUFF ,OCEAN-ROOM>
	 <SINK-STUFF ,LOST-IN-OCEAN>>

<ROUTINE SINK-STUFF (RM "AUX" (F <FIRST? .RM>) N)
	 <REPEAT ()
		 <COND (<NOT .F> <RETURN>)>
		 <SET N <NEXT? .F>>
		 <COND (<EQUAL? .F ,PLAYER ,GROUPER> T)
		       (<AND <EQUAL? .F ,WATER-CUBE>
			     <QUEUED? I-CUBE-SINKS>>
			T)
		       (<OR <EQUAL? .F ,ZIPPER>
			    <NOT <FSET? .F ,CONTBIT>>
			    <AND <FSET? .F ,OPENBIT>
				 <PROB 75>>>
				<MOVE .F ,OCEAN-FLOOR>
			<FCLEAR .F ,NDESCBIT>
			<COND (<EQUAL? ,HERE .RM>
			       <TELL
CTHE .F " sinks beneath the waves." CR>)>)
		       (ELSE
			<QUEUE I-FLOTSAM 2>)>
		 <SET F .N>>>

<ROUTINE I-GROUPER ("AUX" (SNACK <>))
	 <COND (<IN? ,FISH ,OCEAN-ROOM>
		<SET SNACK ,FISH>)
	       (<IN? ,BREAD ,OCEAN-ROOM>
		<SET SNACK ,BREAD>)
	       (<IN? ,WATER-CUBE ,OCEAN-ROOM>
		<SET SNACK ,WATER-CUBE>)
	       (<IN? ,BOTTLE ,OCEAN-ROOM>
		<SET SNACK ,BOTTLE>)>
	 <COND (.SNACK
		<MOVE .SNACK ,GROUPER>
		<QUEUE I-GROUPER-IN-NEST 2>
		<COND (<EQUAL? ,HERE ,OCEAN-ROOM>
		       <TELL CR
"The grouper, nosing around for something tasty, swallows " THE .SNACK
" and starts to swim downward, temporarily sated." CR>)>)>>

<ROUTINE I-CUBE-SINKS ()
	 <COND (<IN? ,WATER-CUBE ,OCEAN-ROOM>
		<MOVE ,WATER-CUBE ,OCEAN-FLOOR>
		<FCLEAR ,WATER-CUBE ,NDESCBIT>
		<COND (<EQUAL? ,HERE ,OCEAN-ROOM>
		       <TELL CR
CTHE ,WATER-CUBE " sinks out of sight." CR>)>)>>

<ROUTINE I-GROUPER-IN-NEST ()
	 <MOVE ,GROUPER ,OCEAN-FLOOR>
	 <COND (<EQUAL? ,HERE ,OCEAN-ROOM>
		<TELL
"The grouper swims down out of sight." CR>)
	       (<EQUAL? ,HERE ,OCEAN-FLOOR>
		<TELL
"The grouper approaches, its goggle eyes staring curiously." CR>)>>

<ROUTINE I-TINSOT ()
	 <SETG ICED-OBJECT <>>
	 <COND (<NOT <QUEUED? I-OUBLIETTE-EMPTIES>>
		<SETG FREEZE-FLAG 0>)>
	 <RFALSE>>

<ROUTINE I-OUBLIETTE-FILLS ("AUX" (H <>))
	 <COND (<EQUAL? ,HERE ,OUBLIETTE> <SET H T>)>
	 <COND (<L? ,WATER-FLAG 3>
		<ROB ,OUBLIETTE <> ,ICEBERG>
		<SETG WATER-FLAG <+ ,WATER-FLAG 1>>
		<COND (.H
		       <TELL CR
"The water level rises. The oubliette is "
<GET ,WATER-HEIGHTS ,WATER-FLAG> " full.">
		       <COND (<NOT <IN? ,PLAYER ,ICEBERG>>
			      <SOAK-PLAYER>)>
		       <NOT-SITTING>
		       <CRLF>)>)
	       (ELSE
		<SETG WATER-FLAG 4>
		<DEQUEUE I-OUBLIETTE-FILLS>
		<QUEUE I-OUBLIETTE-EMPTIES 5>
		<COND (.H
		       <TELL CR
"The oubliette is full. There is about four feet of space between the
water and the roof. The water must have reached its level, because it has
ceased to rise. You are ">
		       <COND (<IN? ,PLAYER ,ICEBERG>
			      <TELL
"floating serenely on a small ice floe.">)
			     (ELSE
			      <TELL
"splashing a tantalizing distance from the roof and trap door.">)>
		       <CRLF>)>)>>


<ROUTINE I-OUBLIETTE-EMPTIES ("AUX" (H <>))
	 <COND (<EQUAL? ,HERE ,OUBLIETTE> <SET H T>)>
	 <COND (<AND <EQUAL? ,WATER-FLAG 4>
		     <G? ,FREEZE-FLAG 0>>
		<SETG FREEZE-FLAG 0>
		<QUEUE I-OUBLIETTE-EMPTIES -1>
		<COND (.H
		       <TELL CR
"The water level has begun to fall." CR>)>)
	       (ELSE
		<SETG WATER-FLAG <- ,WATER-FLAG 1>>
		<COND (<G? ,WATER-FLAG 0>
		       <COND (.H
			      <TELL CR
"The water level falls. The oubliette is "
<GET ,WATER-HEIGHTS ,WATER-FLAG> " full." CR>)>)
		      (ELSE
		       <DEQUEUE I-OUBLIETTE-EMPTIES>
		       <COND (<IN? ,PLAYER ,ICEBERG>
			      <MOVE ,WINNER ,HERE>)>
		       <ROB ,ICEBERG ,HERE>
		       <REMOVE ,ICEBERG>
		       <SETG ICED-OBJECT <>>
		       <COND (.H
			      <TELL CR
"The oubliette is empty again. All the ice has melted, and the pipes
are open again." CR>)>)>)>>

<ROUTINE I-DOWNSTREAM ("AUX" (RM <>))
	 <COND (<EQUAL? ,HERE ,IN-CHANNEL>
		<SET RM ,IN-PIPE>)
	       (<EQUAL? ,HERE ,IN-PIPE>
		<SET RM ,IN-PIPE-2>)
	       (<EQUAL? ,HERE ,IN-PIPE-2>
		<SET RM ,RUINED-PIPE>)
	       (<EQUAL? ,HERE ,RUINED-PIPE>
		<SET RM ,IN-SEWER>)>
	 <COND (.RM
		<TELL CR
"The rushing water is forcing you downstream." CR CR>
		<GOTO .RM>)>>

<GLOBAL ROC-COUNT 0>

<GLOBAL ROC-DESCS
	<PTABLE
"tiny black dot silhouetted against the clouds."
"large object silhouetted against the clouds."
"large bird approaching."
"large bird circling the tower and eyeing you suspiciously.">>

<ROUTINE I-ROC ()
	 <COND (<EQUAL? ,HERE ,GUARD-TOWER>
		<SETG ROC-COUNT <+ ,ROC-COUNT 1>>
		<COND (<IN? ,PLAYER ,ZIPPER>
		       <RFALSE>)
		      (<G? ,ROC-COUNT 4>
		       <DEQUEUE I-ROC>
		       <ROC-GRABS-PLAYER>
		       <CRLF>
		       <GOTO ,MIDAIR>)
		      (<G? ,ROC-COUNT 0>
		       <THIS-IS-IT ,ROC>
		       <TELL CR "There is a ">
		       <DESCRIBE-ROC>)>)>>

<GLOBAL ROC-FLY-COUNT 0>

<ROUTINE I-ROC-FLY ()
	 <SETG ROC-FLY-COUNT <+ ,ROC-FLY-COUNT 1>>
	 <SETG EW-COUNT <- ,EW-COUNT 1>>
	 <CRLF>
	 <COND (<EQUAL? ,ROC-FLY-COUNT 1>
		<SETG UD-COUNT 4>
		<TELL
"The roc gains height and heads west towards the distant Flathead
Mountains." CR>)
	       (<EQUAL? ,ROC-FLY-COUNT 2>
		<TELL
"The roc continues to fly west towards the mountains." CR>)
	       (<EQUAL? ,ROC-FLY-COUNT 3>
		<TELL
"You are rapidly approaching a rocky eyrie containing an enormous
nest." CR>)
	       (<EQUAL? ,ROC-FLY-COUNT 4>
		<SETG UD-COUNT 0>
		<DEQUEUE I-ROC-FLY>
		<MOVE ,PLAYER ,HERE>
		<MOVE ,ROC ,ROC-NEST>
		<TELL
"The roc circles over its nest, settles to the ground, and releases you."
CR CR>
		<GOTO ,ROC-NEST>)>>

<ROUTINE I-ROC-HATCHES ("OPTIONAL" (ARG <>))
	 <COND (<EQUAL? ,TIME-STOPPED? ,HERE>
		<QUEUE I-ROC-HATCHES 5>
		<RFALSE>)
	       (<IN? ,BABY-ROC ,HERE>
		<RFALSE>)>
	 <MOVE ,BABY-ROC ,ROC-NEST>
	 <FSET ,EGG ,RMUNGBIT>
	 <COND (<EQUAL? ,HERE ,ROC-NEST>
		<QUEUE I-YUM-YUM -1>
		<COND (<IN? ,PLAYER ,ZIPPER> <RFALSE>)
		      (<NOT .ARG> <CRLF>)
		      (ELSE
		       <TELL
"You batter the egg, intending to destroy it. ">)>
		<TELL
"Suddenly the egg begins to crack. You can see feathers,
then a large, almost reptilian eye. The egg shatters, and a small
(wagon-sized) roc chick rolls out. It eyes you hungrily">
		<COND (<IN? ,CONNECTIVITY-CUBE ,ROC-NEST>
		       <REMOVE ,CONNECTIVITY-CUBE>
		       <TELL ", notices the cube at its feet, and gobbles
it greedily. It still looks hungry">)>
		<TELL ,PERIOD>)>>

<ROUTINE I-YUM-YUM ()
	 <COND (<EQUAL? ,HERE ,ROC-NEST>
		<COND (<AND <NOT <IN? ,PLAYER ,ZIPPER>>
			    <NOT <EQUAL? ,ESPNIS? ,BABY-ROC>>>
		       <COND (<IN? ,CONNECTIVITY-CUBE ,PLAYER>
			      <MOVE ,CONNECTIVITY-CUBE ,HERE>)>
		       <DEQUEUE I-YUM-YUM>
		       <JIGS-UP
"The baby roc, still ravenously hungry, devours you with relish.">)>)
	       (ELSE
		<DEQUEUE I-YUM-YUM>
		<RFALSE>)>>

;"from C3"

<ROUTINE I-MERCHANT ()
	 <COND (<NOT <FSET? ,MERCHANT ,TOUCHBIT>>
		<FSET ,MERCHANT ,TOUCHBIT>
		<MOVE ,MAGIC-CARPET ,MERCHANT>
		<MOVE ,RANDOM-CARPET ,MERCHANT>
		<TELL CR
"The merchant approaches you. \"May I help you? We have a fine selection
of carpets of all sizes and uses.\" He indicates the pile of rugs and
picks up two of them. \"These are particularly nice,\" he says. One is "
A ,MAGIC-CARPET " with a strange design of cubes, and the other is "
A ,RANDOM-CARPET " that's rather shabby and badly made."
CR>)
	       (,MERCHANT-FLAG
		<SETG MERCHANT-FLAG <>>
		<RFALSE>)
	       (<OR <IN? ,MAGIC-CARPET ,PLAYER>
		    <IN? ,RANDOM-CARPET ,PLAYER>>
		<TELL
"The merchant is patiently waiting for you to leave." CR>)
	       (ELSE
		<TELL CR
"The merchant tries to look bored. He doesn't pull it off." CR>)>>

;<ROUTINE I-URCHIN ()
	 <COND (<NOT <FIRST? ,BAZAAR>>
		<DEQUEUE I-URCHIN>
		<RFALSE>)
	       (ELSE
		<QUEUE I-URCHIN -1>)>
	 <COND (<ROB ,HERE <> ,PLAYER>
		<COND (<EQUAL? ,HERE ,BAZAAR>
		       <TELL CR
"A ragged street urchin, excited by this opportunity,
runs up, scoops up something and disappears into the crowd." CR>)>)>>

<GLOBAL SMASH-PROB 0>
<GLOBAL ROC-PROB 0>
<GLOBAL FALLING? <>>

<ROUTINE I-FALLING ()
	 <COND (<EQUAL? ,TIME-STOPPED? ,HERE>
		<RFALSE>)
	       (<NOT <EQUAL? ,HERE ,MIDAIR ,LOST-IN-CLOUDS>>
		<SETG FALLING? <>>
		<SETG SMASH-PROB 0>
		<DEQUEUE I-FALLING>
		<RFALSE>)>
	 <COND (<G? ,UD-COUNT 1>
		<SETG UD-COUNT <- ,UD-COUNT 1>>
		<SETG ROC-PROB <+ ,ROC-PROB 25>>
		<COND (<AND <NOT <FSET? <LOC ,PLAYER> ,VEHBIT>>
			    <EQUAL? ,OHERE ,EARTH-ROOM ,AIR-ROOM>
			    <PROB ,ROC-PROB>>
		       <SETG FALLING? <>>
		       <ROC-GRABS-PLAYER T>
		       <RTRUE>)>)
	       (ELSE
		<SETG SMASH-PROB <+ ,SMASH-PROB 20>>
		<COND (<PROB ,SMASH-PROB>
		       <SETG FALLING? <>>
		       <TELL CR
"You tumble helplessly into the earth, and the results are, of course,
fatal.">
		       <JIGS-UP>
		       <RFATAL>)>)>
	 <TELL CR
"You are falling towards the ground, wind whipping around you." CR>>

<ROUTINE I-ROCK-ARRIVES ()
	 <MOVE ,LAVA-ROCK ,VOLCANO-BASE>
	 <COND (<EQUAL? ,HERE ,VOLCANO-BASE>
		<TELL CR
"One fragment of molten lava explodes out of the flow and drops right
at your feet! It sizzles and hisses." CR>)>>

<ROUTINE I-GRUES-NOTICE ("OPTIONAL" (CR? <>))
	 <COND (<EQUAL? ,HERE ,GRUE-CAVE>
		<COND (<NOT ,LIT>
		       <COND (<NOT .CR?> <CRLF>)>
		       <JIGS-UP
"Scrabbling and scratching claws are approaching in the dark. The last
sound you hear is the gurgling of the pack of grues that devours you
with unmentionable enjoyment.">)
		      (<OR <NOT <EQUAL? ,CHANGED? ,GRUE>>
			   <NOT <EQUAL? ,LIT ,GRUE>>>
		       <GRUES-NOTICE-LIGHT>)>)
	       (<EQUAL? ,HERE ,PILLAR-ROOM ,LIGHT-POOL>
		<COND (<NOT ,LIT>
		       <COND (<NOT .CR?> <CRLF>)>
		       <TELL
"Scrabbling and scratching claws are nearby.">)
		      (<OR <NOT <EQUAL? ,CHANGED? ,GRUE>>
			   <NOT <EQUAL? ,LIT ,GRUE>>>
		       <TELL
"The grues have noticed you, and are terrifically agitated." CR>)>)>>

<ROUTINE GRUES-NOTICE-LIGHT ()
	 <TELL
"The shapes are coming closer. They have noticed ">
	 <TELL-LIGHT-SOURCE>
	 <TELL ,PERIOD>
	 <TELL
"They approach you warily, avoiding the tiny drips
of light. They grab you, overwhelm you, and ">
	 <COND (<EQUAL? ,CHANGED? ,GRUE>
		<TELL "as in
addition to their other nasty habits, grues are cannibalistic, they ">)>
	 <TELL "devour you, grunting, gurgling,
and snapping at each other as they fight over the best parts.">
	 <JIGS-UP>>

<ROUTINE I-FRIED-GRUE ()
	 <COND (<AND <EQUAL? ,HERE ,LIGHT-POOL>
		     <EQUAL? ,CHANGED? ,GRUE>>
		<JIGS-UP
"The burning sensation gets worse and worse. You struggle
against it, but the light is just too much. You lose consciousness, sink
to the bottom of the pool, and expire.">)
	       (ELSE
		<QUEUE I-FRIED-GRUE -1>
		<RFALSE>)>>

<ROUTINE I-ALARM ()
	 <COND (<NOT <IN? ,ALARM-FAIRY ,SCALES-ROOM>>
		<MOVE ,ALARM-FAIRY ,SCALES-ROOM>
		<COND (<EQUAL? ,HERE ,SCALES-ROOM>
		       <TELL CR
"Suddenly an alarm fairy appears in the Treasury. It carries a big gong which
it begins to pound incessantly, and it yells at the top of its lungs." CR>)>)>
	 <COND (<EQUAL? ,HERE ,SCALES-ROOM>
		<TELL CR
"\"There's a thief here! Hey, guards! Thief! Nasty thieving thief's here!
Come capture the thief!\" The din is tremendous." CR>)>>

<ROUTINE I-GUARDS ()
	 <SETG GUARDS-FLAG <+ ,GUARDS-FLAG 1>>
	 <COND (<EQUAL? ,GUARDS-FLAG 1>
		<QUEUE I-GUARDS 1>
		<COND (<EQUAL? ,HERE ,SCALES-ROOM>
		       <COND (<FSET? ,IRON-DOOR ,OPENBIT>
			      <TELL CR
"Five burly guards, unshaven and thuggish, stand
outside the door. It is clear their intention is to come in.">)
			     (ELSE
			      <TELL CR
"You can hear a key being inserted in the lock from outside. The alarm
fairy thumbs its nose at you derisively.">)>
		       <CRLF>)>)
	       (ELSE
		<SETG TREASURY-GUARDED? T>
		<COND (<EQUAL? ,HERE ,SCALES-ROOM ,INNER-VAULT>
		       <TELL CR "All at once ">
		       <COND (<NOT <FSET? ,IRON-DOOR ,OPENBIT>>
			      <TELL "the door bursts in and ">)>
		       <FCLEAR ,IRON-DOOR ,OPENBIT>
		       <TELL
"five burly guards crowd into the
Treasury. They look at you with extreme disapproval, tinged with a
certain sadistic anticipation of what is to come. The alarm fairy
twitters about near the ceiling, jeering at you. \"Told you so, nyaah,
nyaah!\" it chants. In the interest of taste, we will gloss over what
happens next, but at the end of it you are dead.">
		       <JIGS-UP>)>)>>

;"from C4"


<ROUTINE I-OTHER-ROCK ("AUX" DIR RROW RCOL OROW OCOL (DROW 0) (DCOL 0))
	 <COND (<EQUAL? ,ROCK-LOC ,OTHER-ROCK-LOC>
		<SETG ROCK-MOVED? <>>
		<DEQUEUE I-OTHER-ROCK>
		<TELL
CTHE ,OTHER-ROCK ", mesmerized by the looming presence of " THE ,ROCK
", does not move." CR>)
	       (,ROCK-MOVED?
		<SETG ROCK-MOVED? <>>
		<SET RROW </ ,ROCK-LOC 4>>
		<SET RCOL <BAND ,ROCK-LOC 3>>
		<SET OROW </ ,OTHER-ROCK-LOC 4>>
		<SET OCOL <BAND ,OTHER-ROCK-LOC 3>>
		<SET DROW
		     <COND (<G? .RROW .OROW> <- .RROW .OROW>)
			   (ELSE <- .OROW .RROW>)>>
		<SET DCOL
		     <COND (<G? .RCOL .OCOL> <- .RCOL .OCOL>)
			   (ELSE <- .OCOL .RCOL>)>>
		<CRLF>
		<COND (<EQUAL? ,OTHER-ROCK-LOC 1>
		       <COND (<AND <NOT <EQUAL? ,ROCK-LOC 4 5 8>>
				   <ZERO? <BAND <+ .DROW .DCOL> 1>>>
			      <SET DIR ,P?SW>)
			     (<NOT <EQUAL? ,ROCK-LOC 5>>
			      <SET DIR ,P?SOUTH>)
			     (<NOT <EQUAL? ,ROCK-LOC 2>>
			      <SET DIR ,P?EAST>)>)
		      (<EQUAL? ,OTHER-ROCK-LOC 4>
		       <COND (<AND <NOT <EQUAL? ,ROCK-LOC 1 2 5>>
				   <ZERO? <BAND <+ .DROW .DCOL> 1>>>
			      <SET DIR ,P?NE>)
			     (<NOT <EQUAL? ,ROCK-LOC 5>>
			      <SET DIR ,P?EAST>)
			     (<NOT <EQUAL? ,ROCK-LOC 8>>
			      <SET DIR ,P?SOUTH>)>)
		      (<AND <EQUAL? ,OTHER-ROCK-LOC 5>
			    <EQUAL? ,ROCK-LOC 1 4>>
		       <SET DIR
			    <COND (<EQUAL? ,ROCK-LOC 4> ,P?EAST)
				  (ELSE ,P?SOUTH)>>)
		      (<EQUAL? .RROW .OROW>
		       <COND (<OR <EQUAL? .OROW 0>
				  <AND <EQUAL? .OROW 1>
				       <EQUAL? .OCOL 0>>>
			      <SET DIR ,P?SOUTH>)
			     (<OR <EQUAL? .OROW 3>
				  <PROB 50>>
			      <SET DIR ,P?NORTH>)
			     (ELSE
			      <SET DIR ,P?SOUTH>)>)
		      (<EQUAL? .RCOL .OCOL>
		       <COND (<OR <EQUAL? .OCOL 0>
				  <AND <EQUAL? .OCOL 1>
				       <EQUAL? .OROW 0>>>
			      <SET DIR ,P?EAST>)
			     (<OR <EQUAL? .OCOL 3>
				  <PROB 50>>
			      <SET DIR ,P?WEST>)
			     (ELSE
			      <SET DIR ,P?EAST>)>)
		      (<AND <EQUAL? .OCOL 0> <EQUAL? .OROW 3>>
		       <COND (<PROB 50> <SET DIR ,P?EAST>)
			     (ELSE <SET DIR ,P?NORTH>)>)
		      (<AND <EQUAL? .OCOL 3> <EQUAL? .OROW 3>>
		       <COND (<PROB 50> <SET DIR ,P?WEST>)
			     (ELSE <SET DIR ,P?NORTH>)>)
		      (<AND <EQUAL? .OCOL 3> <EQUAL? .OROW 0>>
		       <COND (<PROB 50> <SET DIR ,P?WEST>)
			     (ELSE <SET DIR ,P?SOUTH>)>)
		      (<AND <G? .RROW .OROW>
			    <G? .OROW 0>
			    <OR <G? .OROW 1> <G? .OCOL 0>>>
		       <SET DIR ,P?NORTH>)
		      (<AND <G? .RCOL .OCOL>
			    <G? .OCOL 0>
			    <OR <G? .OCOL 1> <G? .OROW 0>>>
		       <SET DIR ,P?WEST>)
		      (<AND <L? .RROW .OROW> <L? .OROW 3>>
		       <SET DIR ,P?SOUTH>)
		      (<AND <L? .RCOL .OCOL> <L? .OCOL 3>>
		       <SET DIR ,P?EAST>)>
		%<DEBUG-CODE
		   <COND (<ZERO? .DIR>
			  <TELL
"[BUG: Brown-eyed rock zero direction?]" CR
"[Blue: " N ,ROCK-LOC ", Brown: " N ,OTHER-ROCK-LOC "]" CR>)>>
		<COND (<EQUAL? .DIR ,P?EAST>
		       <SET OCOL <+ .OCOL 1>>)
		      (<EQUAL? .DIR ,P?WEST>
		       <SET OCOL <- .OCOL 1>>)
		      (<EQUAL? .DIR ,P?SOUTH>
		       <SET OROW <+ .OROW 1>>)
		      (<EQUAL? .DIR ,P?NORTH>
		       <SET OROW <- .OROW 1>>)
		      (<EQUAL? .DIR ,P?NE>
		       <SET OROW <- .OROW 1>>
		       <SET OCOL <+ .OCOL 1>>)
		      (ELSE
		       <SET OROW <+ .OROW 1>>
		       <SET OCOL <- .OCOL 1>>)>
		<SETG OTHER-ROCK-LOC <+ <* 4 .OROW> .OCOL>>
		<COND (<IN? ,PLAYER ,OTHER-ROCK>
		       <SETG YOU-LOC ,OTHER-ROCK-LOC>)>
		%<DEBUG-CODE <COND (,ZDEBUG
<TELL "[Brown: " N ,OTHER-ROCK-LOC "]" CR>)>>
		<TELL
CTHE ,OTHER-ROCK " slides gracefully ">
		<COND (<SET DIR <DIR-BASE .DIR ,DIR-DIR ,DIR-NAME>>
		       <TELL .DIR>)>
		<TELL ,PERIOD>
		%<DEBUG-CODE
		   <COND (<OR <L? .OROW 0>
			      <L? .OCOL 0>
			      <G? .OROW 3>
			      <G? .OCOL 3>
			      <AND <EQUAL? .OROW 0>
				   <EQUAL? .OCOL 0>>>
			  <TELL
"[BUG: Brown eyed rock off plain?]" CR
"[Blue: " N ,ROCK-LOC ", Brown: " N ,OTHER-ROCK-LOC "]" CR>)>>
		<RTRUE>)>>

<ROUTINE I-STOP-SNEEZING ()
	 <SETG SNEEZY? <>>
	 <COND (<AND <EQUAL? ,HERE ,OGRE-CAVE>
		     <NOT <EQUAL? ,TIME-STOPPED? ,HERE>>
		     <NOT <EQUAL? ,ESPNIS? ,OGRE>>>
		<TELL CR
"The pollen has settled out, and the ogre's sneezes abate.">
		<OGRE-MAD>)
	       (<EQUAL? ,HERE ,CAVE-ENTRANCE ,OGRE-BEDROOM>
		<TELL CR
"The sneezing noises have slowed in volume and frequency." CR>)>>

<ROUTINE OGRE-MAD ()
	 <TELL " He recovers his self-possession." CR>
	 <I-OGRE-KILLS-YOU>>

<ROUTINE I-WATER-RISING ()
	 <COND (<EQUAL? ,HERE ,PAST-RUINS-ROOM>
		<COND (<EQUAL? ,PAST-WATER-FLAG 4>
		       <HYPOTHERMIA>
		       <RFATAL>)>
		<QUEUE I-WATER-RISING 4>
		<COND (<L? ,PAST-WATER-FLAG 4>
		       <SETG PAST-WATER-FLAG <+ ,PAST-WATER-FLAG 1>>)>
		<COND (<IN? ,PLAYER ,ZIPPER> <RFALSE>)>
		<TELL CR <GET ,WATER-TABLE ,PAST-WATER-FLAG>>
		<COND (<EQUAL? ,PAST-WATER-FLAG 2>
		       <COND (<SOAK-STUFF ,HERE <>>
			      <TELL
" Items on the floor are wet and ruined, of course.">)>
		       <NOT-SITTING>)
		      (<EQUAL? ,PAST-WATER-FLAG 4>
		       <SOAK-PLAYER>)>
		<CRLF>)>>

<GLOBAL PAST-WATER-FLAG 0>

<ROUTINE I-PRISON-GUARDS ()
	 <COND (<TIME-FROZEN?>
		<QUEUE I-PRISON-GUARDS 2>
		<RFALSE>)
	       (<EQUAL? ,HERE ,PAST-CELL-EAST>
		<TELL
"Many nasty guards arrive">
		<COND (<IN? ,PLAYER ,CABINET>
		       <TELL ", find you hiding in the cabinet,">)>
		<TELL " and immediately (for their own protection, of
course) run you through with their swords." CR CR>
		<TIME-SICK-CELL-EAST>)>>