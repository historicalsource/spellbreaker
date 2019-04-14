"GUILD for
				MAGE
	(c) Copyright 1985 Infocom, Inc. All Rights Reserved."

<OBJECT KNIFE
	(IN PLAYER)
	(DESC "knife")
	(SYNONYM KNIFE DAGGER)
	(FLAGS TAKEBIT WEAPONBIT)
	(ACTION KNIFE-F)>

<ROUTINE KNIFE-F ()
	 <COND (<AND <VERB? CUT>
		     <EQUAL? ,PRSO ,BREAD ,FISH>>
		<TELL
"You slice off a little piece and eat it. It tastes pretty good, but
you really weren't feeling very hungry." CR>)>>

<ROOM GUILD-HALL
      (IN ROOMS)
      (DESC "Guild Hall")
      (NORTH TO COUNCIL-CHAMBER)
      (SOUTH TO BELWIT-SQUARE)
      (OUT TO BELWIT-SQUARE)
      (ACTION GUILD-HALL-F)
      (FLAGS ONBIT RLANDBIT)>

<ROUTINE GUILD-HALL-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is the entrance to the Guild Hall in Borphee. To the north is
the Council Chamber, and to the south is an exit leading outside.">
		<COND (<OR <NOT <FSET? ,BREAD ,TOUCHBIT>>
			   <NOT <FSET? ,FISH ,TOUCHBIT>>>
		       <TELL
" Little is left of the sumptuous buffet lunch. Only ">
		       <COND (<NOT <FSET? ,BREAD ,TOUCHBIT>>
			      <TELL "a loaf of bread">
			      <COND (<NOT <FSET? ,FISH ,TOUCHBIT>>
				     <TELL " and ">)>)>
		       <COND (<NOT <FSET? ,FISH ,TOUCHBIT>>
			      <TELL "some smoked fish">)>
		       <TELL " remains.">)>
		<CRLF>)>>

<OBJECT BREAD
	(IN GUILD-HALL)
	(DESC "chunk of rye bread")
	(SYNONYM BREAD FOOD LOAF CHUNK)
	(ADJECTIVE FRESH RYE LOAF CHUNK)
	(FLAGS NDESCBIT BRIEFBIT TAKEBIT)>

<OBJECT FISH
	(IN GUILD-HALL)
	(DESC "smoked fish")
	(SYNONYM FISH SARDINE HERRING FOOD)
	(ADJECTIVE SMOKED)
	(FLAGS NDESCBIT BRIEFBIT TAKEBIT)
	(GENERIC GENERIC-FISH-F)>

<ROOM COUNCIL-CHAMBER
      (IN ROOMS)
      (DESC "Council Chamber")
      (ACTION COUNCIL-CHAMBER-F)
      (SOUTH TO GUILD-HALL)
      (OUT TO GUILD-HALL)
      (FLAGS ONBIT RLANDBIT)
      (THINGS
       <PSEUDO (LEOPARD FROG FROG-PSEUDO)
	       (<> FROGS AMPHIBIAN-PSEUDO)
	       (TREE TOAD TOAD-PSEUDO)
	       (<> TOADS AMPHIBIAN-PSEUDO)
	       (<> SALAMANDER SALAMANDER-PSEUDO)
	       (<> NEWT NEWT-PSEUDO)
	       (<> NEWTS AMPHIBIAN-PSEUDO)
	       (<> HELLBENDER HELLBENDER-PSEUDO)
	       (<> EFT AMPHIBIAN-PSEUDO)
	       (<> EFTS AMPHIBIAN-PSEUDO)>)>

<ROUTINE FROG-PSEUDO ()
	 <COND (,CLEESHED? <REDIRECT ,PSEUDO-OBJECT ,GZORNENPLATZ>)
	       (ELSE <AMPHIBIAN-PSEUDO>)>>

<ROUTINE TOAD-PSEUDO ()
	 <COND (,CLEESHED? <REDIRECT ,PSEUDO-OBJECT ,SNEFFLE>)
	       (ELSE <AMPHIBIAN-PSEUDO>)>>

<ROUTINE SALAMANDER-PSEUDO ()
	 <COND (,CLEESHED? <REDIRECT ,PSEUDO-OBJECT ,HOOBLY>)
	       (ELSE <AMPHIBIAN-PSEUDO>)>>

<ROUTINE NEWT-PSEUDO ()
	 <COND (,CLEESHED? <REDIRECT ,PSEUDO-OBJECT ,ARDIS>)
	       (ELSE <AMPHIBIAN-PSEUDO>)>>

<ROUTINE HELLBENDER-PSEUDO ()
	 <COND (,CLEESHED? <REDIRECT ,PSEUDO-OBJECT ,ORKAN>)
	       (ELSE <AMPHIBIAN-PSEUDO>)>>

<ROUTINE AMPHIBIAN-PSEUDO ()
	 <COND (,CLEESHED?
		<TELL
"They are hopping around so wildly it's hard to do anything with them." CR>)
	       (ELSE
		<TELL
"I think you had too much punch at lunch. There's no such thing here." CR>)>>

<GLOBAL ORATOR <>>
<GLOBAL CLEESHED? <>>

<OBJECT SORCERER
	(IN COUNCIL-CHAMBER)
	(DESC "sorcerer")
	(SYNONYM SORCERER ENCHANTER MAGE MAGES)
	(ADJECTIVE GROUP PARTY)
	(ACTION SORCERER-F)
	(FLAGS NDESCBIT PERSON THE)>

<ROUTINE SORCERER-F ()
	 <COND (<VERB? TELL>
		<TELL
,MORE-SPECIFIC ". There are about ten of them around, including
yourself." CR>)
	       (<VERB? EXAMINE>
		<COND (,CLEESHED?
		       <TELL
"The former mages are scuttling hither and yon across the floor." CR>)
		      (ELSE
		       <TELL
"The mages, grouped loosely near you, are listening to the speakers." CR>)>)
	       (<VERB? COUNT>
		<COND (,CLEESHED?
		       <TELL
"It's hard to tell. I assume there are still about ten." CR>)
		      (ELSE
		       <TELL
"There are about ten, including you and " 'ORKAN ", the
most eminent of the group, now that Belboz has retired." CR>)>)>>

<OBJECT SPEAKER
	(IN COUNCIL-CHAMBER)
	(DESC "speaker")
	(SYNONYM SPEAKER ORATOR GUILDMASTER)
	(ACTION SPEAKER-F)
	(FLAGS NDESCBIT)>

<ROUTINE SPEAKER-F ()
	 <REDIRECT ,SPEAKER ,ORATOR>>

<ROUTINE COUNCIL-CHAMBER-F ("OPTIONAL" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are in the Council Chamber of the ancient Guild Hall at Borphee. To
the south is the entry of the Guild Hall. ">
		<COND (,CLEESHED?
		       <TELL
"Scurrying wetly hither and yon around you are many brightly colored newts,
efts, and salamanders. Toads and frogs hop excitedly about.">)
		      (ELSE
		       <TELL
"There is a meeting of the Guildmasters going on. You are standing among
a group of about ten sorcerers, each the master of an Enchanters Guild chapter
somewhere in the land.">
		       <COND (<G? ,OCOUNT 0>
			      <TELL
" " 'ORATOR " is addressing the meeting.">)>)>
		<CRLF>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<NOT ,CLEESHED?>
		       <COND (<VERB? WALK>
			      <TELL
"Annoyed guildmasters make way grudgingly. You hear muttering about
\"arrogant enchanters\" as you try to leave the chamber. Finally, "
'ORKAN ", one of your colleagues, says, \"Stay. Be quiet. Don't
embarrass us.\"" CR>)
			     (<AND <VERB? SAY> <NOT ,PRSO>>
			      <TELL
'ORKAN " quiets you. \"Interruptions will only annoy them.\"" CR>)
			     (<AND <VERB? LISTEN>
				   <NOT ,PRSO>>
			      <TELL
'ORATOR " is speaking." CR>)
			     (<SPELL-VERB?>
			      <TELL
'ORKAN " stares at you in wonderment. \"Are you trying to get them
even more mad at us?\" He makes a gesture of cancellation before you can
finish the spell." CR>)
			     (<AND <HOSTILE-VERB?>
				   <FSET? ,PRSO ,PERSON>>
			      <COND (<EQUAL? ,PRSO ,ORKAN>
				     <TELL
'ORKAN " easily subdues you without causing undue disruption." CR>)
				    (ELSE
				     <TELL
'ORKAN " grabs you and prevents your antisocial deed." CR>)>)
			     (<VERB? YAWN SLEEP>
			      <TELL
"Realizing how insulting you are being to the speaker, you try to stifle
the yawn." CR>)>)>)>>

<OBJECT ORKAN
	(IN COUNCIL-CHAMBER)
	(DESC "Orkan of Thriff")
	(SYNONYM ORKAN)
	(ADJECTIVE THRIFF)
	(ACTION ORKAN-F)
	(FLAGS PERSON NOABIT NOTHEBIT NDESCBIT)>

<ROUTINE ORKAN-F ()
	 <COND (<EQUAL? ,WINNER ,ORKAN>
		<COND (<AND <VERB? TELL-ABOUT>
			    <EQUAL? ,PRSO ,ME>>
		       <RFALSE>)
		      (,CLEESHED?
		       <TELL "Orkan doesn't reply." CR>)
		      (ELSE
		       <TELL
"\"Please! You should at least pretend to pay attention to these fools,\"
whispers Orkan." CR>)>
		<END-QUOTE>)
	       (<VERB? EXAMINE>
		<COND (,CLEESHED?
		       <TELL "Orkan is now a hellbender." CR>)
		      (ELSE
		       <TELL
'ORKAN " is a large bear-like gentleman dressed in the traditional garb
of a mage." CR>)>)
	       (<VERB? LISTEN>
		<COND (<NOT ,CLEESHED?>
		       <TELL
"Orkan is listening to the speaker and suggests you do the same." CR>)>)
	       (<VERB? YOMIN>
		<COND (,CLEESHED?
		       <TELL
"You get a vague impression of hunger and annoyance at being dry." CR>)>)>>

<OBJECT SNEFFLE
	(IN COUNCIL-CHAMBER)
	(DESC "Sneffle")
	(SYNONYM SNEFFLE BAKER)
	(ACTION SNEFFLE-F)
	(FLAGS PERSON NOABIT NOTHEBIT NDESCBIT)>

<ROUTINE SNEFFLE-F ()
	 <COND (<EQUAL? ,WINNER ,SNEFFLE>
		<COND (<AND <VERB? TELL-ABOUT>
			    <EQUAL? ,PRSO ,ME>>
		       <RFALSE>)
		      (,CLEESHED?
		       <TELL "\"Breep!\"" CR>)
		      (ELSE
		       <TELL
"\"Interrupting, eh? This is precisely what I was talking about!\" snorts "
'SNEFFLE>
		       <TELL ,PERIOD>)>
		<END-QUOTE>)
	       (<VERB? EXAMINE>
		<COND (,CLEESHED?
		       <TELL "Sneffle is now a tree toad." CR>)
		      (ELSE
		       <TELL
"Sneffle is a small doughy gentleman whose person is splotched here and
there with flour." CR>)>)
	       (<VERB? LISTEN>
		<COND (<NOT ,CLEESHED?>
		       <LISTEN-TO-GUILDMASTER>)>)
	       (<VERB? YOMIN>
		<COND (,CLEESHED?
		       <TELL
"Sneffle is searching intently for flies." CR>)>)>>

<ROUTINE LISTEN-TO-GUILDMASTER ()
	 <TELL 'PRSO " is ">
	 <COND (<EQUAL? ,PRSO ,ORATOR>
		<TELL "making a speech.">)
	       (ELSE
		<TELL "listening to the speaker.">)>
	 <CRLF>>

<OBJECT HOOBLY
	(IN COUNCIL-CHAMBER)
	(DESC "Hoobly")
	(SYNONYM HOOBLY BREWER)
	(ADJECTIVE CORPULENT FAT)
	(ACTION HOOBLY-F)
	(FLAGS PERSON NOABIT NOTHEBIT NDESCBIT)>

<ROUTINE HOOBLY-F ()
	 <COND (<EQUAL? ,WINNER ,HOOBLY>
		<COND (<AND <VERB? TELL-ABOUT>
			    <EQUAL? ,PRSO ,ME>>
		       <RFALSE>)
		      (,CLEESHED?
		       <TELL "\"Ssss!\"" CR>)
		      (<EQUAL? ,ORATOR ,HOOBLY>
		       <TELL
'HOOBLY " pointedly ignores you." CR>)
		      (ELSE
		       <TELL
"\"Your manners leave something to be desired! " 'ORATOR " is
speaking!\" remarks " 'HOOBLY>
		       <TELL ,PERIOD>)>
		<END-QUOTE>)
	       (<VERB? EXAMINE>
		<COND (,CLEESHED?
		       <TELL "Hoobly has become a salamander." CR>)
		      (ELSE
		       <TELL
"Hoobly is a large, florid, and solid-looking fellow who gives the appearance
of being one of his own better customers." CR>)>)
	       (<VERB? YOMIN>
		<COND (,CLEESHED?
		       <TELL
"You get a strong feeling of torpidity." CR>)>)>>

<OBJECT GZORNENPLATZ
	(IN COUNCIL-CHAMBER)
	(DESC "Gzornenplatz")
	(SYNONYM GZORNENPLATZ HUNTSMAN)
	(ACTION GZORNENPLATZ-F)
	(FLAGS PERSON NOABIT NOTHEBIT NDESCBIT)>

<ROUTINE GZORNENPLATZ-F ()
	 <COND (<EQUAL? ,WINNER ,GZORNENPLATZ>
		<COND (<AND <VERB? TELL-ABOUT>
			    <EQUAL? ,PRSO ,ME>>
		       <RFALSE>)
		      (,CLEESHED?
		       <TELL "\"Braaaak! Gleep?\"" CR>)
		      (ELSE
		       <TELL
'GZORNENPLATZ " glares at you.">
		       <COND (<NOT <EQUAL? ,ORATOR ,GZORNENPLATZ>>
			      <TELL " \"No doubt you don't wish the speakers
to be heard. This is what I expect from such as you!\"">)>
		       <CRLF>)>
		<END-QUOTE>)
	       (<VERB? EXAMINE>
		<COND (,CLEESHED?
		       <TELL 'GZORNENPLATZ " has become a leopard frog." CR>)
		      (ELSE
		       <TELL
'GZORNENPLATZ " is a tall, whipcord thin man with sandy blond hair. He
is dressed in the traditional lincoln green of huntsmen." CR>)>)
	       (<VERB? YOMIN>
		<COND (,CLEESHED?
		       <TELL
"You feel a strong impression of intent, careful stalking of a beetle."
CR>)>)>>

<OBJECT ARDIS
	(IN COUNCIL-CHAMBER)
	(DESC "Ardis")
	(SYNONYM ARDIS POET)
	(ACTION ARDIS-F)
	(FLAGS PERSON NOABIT NOTHEBIT NDESCBIT)>

<ROUTINE ARDIS-F ()
	 <COND (<EQUAL? ,WINNER ,ARDIS>
		<COND (<AND <VERB? TELL-ABOUT>
			    <EQUAL? ,PRSO ,ME>>
		       <RFALSE>)
		      (,CLEESHED?
		       <UNINTERESTED ,ARDIS>)
		      (ELSE
		       <TELL
"\"You must wait your turn!\" screams " 'ARDIS>
		       <TELL ,PERIOD>)>
		<END-QUOTE>)
	       (<VERB? EXAMINE>
		<COND (,CLEESHED?
		       <TELL "Ardis has become a newt." CR>)
		      (ELSE
		       <TELL
"Ardis is the muscular sort of poet (as opposed to the neurasthenic).
He sports a full black beard, wild hair, and talks in a loud voice." CR>)>)
	       (<VERB? YOMIN>
		<COND (,CLEESHED?
		       <TELL
"You get a feeling of surprise and terror." CR>)>)>>

<ROOM BELWIT-SQUARE
      (IN ROOMS)
      (DESC "Belwit Square")
      (NORTH TO GUILD-HALL)
      (EAST "You wander around for a while and end up back in the square.")
      (WEST "You wander around for a while and end up back in the square.")
      (SOUTH "A remarkably surly guard blocks your way.")
      (ACTION BELWIT-SQUARE-F)
      (FLAGS ONBIT RLANDBIT)
      (THINGS
       <PSEUDO (SURLY GUARD GUARD-PSEUDO)
	       (STORIED MANSE MANSE-PSEUDO)
	       (GUILD HALL GUILD-HALL-PSEUDO)
	       (<> BUILDING RANDOM-PSEUDO)>)>

<ROUTINE GUILD-HALL-PSEUDO ()
	 <COND (<VERB? THROUGH>
		<DO-WALK ,P?NORTH>)
	       (ELSE <RANDOM-PSEUDO>)>>

<ROUTINE MANSE-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL "It is a large, imposing building of great age." CR>)
	       (<VERB? THROUGH>
		<TELL "The manse is closed to the public." CR>)>>

<ROUTINE GUARD-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL "He looks very zealous." CR>)
	       (<VERB? TELL ASK-ABOUT>
		<TELL
"The guard ignores you, intent on his duty." CR>
		<COND (<VERB? TELL> <END-QUOTE>)
		      (ELSE <RTRUE>)>)
	       (<VERB? SHOW GIVE OFFER>
		<TELL "Trying to bribe the guard, eh?" CR>)
	       (<HOSTILE-VERB?>
		<TELL "That would be incredibly dangerous." CR>)
	       (<SPELL-VERB?>
		<TELL
"Nothing happens, as the mayoral guards are quite well-protected
from spells." CR>)>>

<ROUTINE BELWIT-SQUARE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is " 'HERE ". ">
		<COND (<NOT <FSET? ,CLOUD ,INVISIBLE>>
		       <TELL
"Its many historic and picturesque buildings are obscured by
a cloud of orange smoke.">)
		      (ELSE
		       <TELL
"To the north is the ancient Guild Hall.
A wide cobblestone street runs east and west. To the south is the storied
Manse, home of the Mayors of Borphee for generations.">)>
		<CRLF>)
	       (<AND <EQUAL? .RARG ,M-BEG>
		     <NOT <FSET? ,CLOUD ,INVISIBLE>>>
		<COND (<VERB? WALK>
		       <TELL
,YOU-CANT-SEE "well enough to find your way out" ,PERIOD>)
		      (<EQUAL? ,PRSO ,CLOUD> <RFALSE>)
		      (<AND <VERB? FIND LOOK TAKE EXAMINE TELL ASK-ABOUT>
			    <NOT <HELD? ,PRSO>>>
		       <TELL
,YOU-CANT-SEE "anything, what with the smokey orange cloud that blankets
the square." CR>)
		      (<VERB? DROP>
		       <COND (<IDROP>
			      <TELL
"Dropped, but you lose it in the smoke." CR>)
			     (ELSE <RTRUE>)>)
		      (<AND <VERB? SMELL> <NOT ,PRSO>>
		       <SMELL-CLOUD>)>)
	       (<EQUAL? .RARG ,M-ENTER>
		<COND (<AND <FSET? ,DEATH-CUBE ,TOUCHBIT>
			    <NOT ,SAMARRA?>>
		       <SETG SAMARRA? T>
		       <QUEUE I-SAMARRA 1>)>)>>

<OBJECT SHADOW
	(IN COUNCIL-CHAMBER)
	(DESC "shadowy figure")
	(SYNONYM FIGURE SHADOW TWIN BEING)
	(ADJECTIVE SHADOW CLOAKED)
	(DESCFCN SHADOW-DESC)
	(ACTION SHADOW-F)
	(FLAGS PERSON NDESCBIT TAKEBIT TRYTAKEBIT THE MAGICBIT)>

<ROUTINE SHADOW-DESC (RARG OBJ)
	 <COND (,CLEESHED?
		<TELL
"A " 'SHADOW " in a dark cloak ">
		<COND (<EQUAL? ,HERE ,GUILD-HALL ,COUNCIL-CHAMBER>
		       <TELL "is running out the door">)
		      (<EQUAL? ,HERE ,BELWIT-SQUARE>
		       <TELL "flees across the square">)
		      (ELSE
		       <TELL "is here">)>
		<TELL ,PERIOD>)>>

<ROUTINE SHADOW-F ()
	 <COND (<OR <NOT <EQUAL? ,HERE ,CASTLE>>
		    <NOT <IN? ,SHADOW ,CASTLE>>>
		<COND (<EQUAL? ,WINNER ,SHADOW>
		       <END-QUOTE>
		       <TELL "What shadow?" CR>)
		      (<AND <NOT ,CLEESHED?>
			    <VERB? FIND>
			    <PROB 33>>
		       <TELL
"There is a figure wearing a dark cloak on the other side of the room,
but almost the moment you catch sight of it, it disappears." CR>)
		      (<VERB? EXAMINE>
		       <TELL
"I don't see any " 'SHADOW " anywhere." CR>)
		      (<VERB? ASK-ABOUT TELL-ABOUT TELL-ME-ABOUT>
		       <RFALSE>)
		      (<AND <VERB? FOLLOW>
			    <NOT <IN? ,SHADOW ,HERE>>>
		       <COND (<EQUAL? ,HERE ,COUNCIL-CHAMBER ,GUILD-HALL>
			      <DO-WALK ,P?SOUTH>)
			     (ELSE
			      <TELL
"Where it went, I doubt you can follow." CR>)>)
		      (ELSE
		       <TELL
"There is no sign of such a person." CR>)>)
	       (<EQUAL? ,HERE ,CASTLE>
		<COND (<EQUAL? ,WINNER ,SHADOW>
		       <COND (<TIME-FROZEN?>
			      <IMMOBILE>
			      <END-QUOTE>)
			     (ELSE
			      <TELL
"\"All will be revealed in due time.\"" CR>)>)
		      (<AND <VERB? GIVE>
			    <GETP ,PRSO ,P?CUBE>>
		       <MOVE ,PRSO ,HERE>
		       <FSET ,PRSO ,NDESCBIT>
		       <TELL
CTHE ,SHADOW " snatches it greedily." CR>)
		      (<HOSTILE-VERB?>
		       <COND (<EQUAL? ,TIME-STOPPED? ,HERE>
			      <TELL
"The frozen shadow is impervious to harm." CR>)
			     (ELSE <FREEZES-YOU>)>)
		      (<VERB? ESPNIS>
		       <TELL
"The shadow begins to nod off but with great effort resists and
awakens. ">
		       <FREEZES-YOU>)
		      (<VERB? YOMIN>
		       <TELL
"You feel your own innermost desires, petty jealousies, and unworthy
thoughts magnified a thousand times." CR>)
		      (<VERB? EXAMINE>
		       <TELL
CTHE ,SHADOW " is hard to see, almost as though some spell is acting
to obscure it. It's clad in a dark cloak with a hood, and it blends into
the background in a disturbing way." CR>)
		      (<AND <VERB? TELL> ,FROZEN?>
		       <TELL "You cannot speak." CR>
		       <END-QUOTE>)
		      (<AND <NOT ,FROZEN?>
			    <G? ,SHADOW-COUNT 4>
			    <L? ,SHADOW-COUNT 8>>
		       <COND (<VERB? TELL>
			      <FREEZES-YOU>)
			     (<OR <NO-CLOCK-VERB?>
				  <VERB? EXAMINE LOOK WAIT LOOK-INSIDE>>
			      <RFALSE>)
			     (ELSE
			      <FREEZES-YOU>)>)>)>>

<OBJECT CLOUD
	(IN BELWIT-SQUARE)
	(DESC "cloud of orange smoke")
	(SYNONYM CLOUD SMOKE)
	(ADJECTIVE ORANGE)
	(FLAGS NDESCBIT INVISIBLE)
	(ACTION CLOUD-F)>

<ROUTINE CLOUD-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"This is a fairly standard " 'PRSO ", a side effect of a certain class
of teleportation spells. These spells are favored by those of a less
than honest nature, as the " 'PRSO " serves to conceal their usually
hasty departures." CR>)
	       (<VERB? THROUGH>
		<TELL ,YOU-ARE " in the middle of it." CR>)
	       (<VERB? SMELL>
		<SMELL-CLOUD>)>>

<ROUTINE SMELL-CLOUD ()
	 <TELL
"It smells vaguely of orange peels, but the predominant motif is less
pleasant and more acrid." CR>>

<ROOM CASTLE
      (IN ROOMS)
      (DESC "Castle")
      (ACTION CASTLE-F)
      (FLAGS RLANDBIT ONBIT)
      (THINGS
       <PSEUDO (<> THRONE RANDOM-PSEUDO)
	       (<> WINDOW RANDOM-PSEUDO)
	       (<> SKYLIGHT RANDOM-PSEUDO)
	       (<> MIST RANDOM-PSEUDO)>)>

<ROUTINE CASTLE-F (RARG "AUX" F)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is the audience chamber. It is high and spacious, and every
proportion and decoration is intended to highlight the throne that
looms before you. The throne itself is bathed in light, but only
featureless gray may be seen through the windows and skylights." CR>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<OR <VERB? EXAMINE WAIT LOOK>
			   <NO-CLOCK-VERB?>>
		       <RFALSE>)
		      (,FROZEN?
		       <COND (<EQUAL? ,FROZEN? 1>
			      <COND (<NOT <EQUAL? ,TIME-STOPPED? ,HERE>>
				     <TELL "You clumsily attempt to ">
				     <COND (<SPELL-VERB?>
					    <TELL "cast the spell.">)
					   (ELSE
					    <TELL "do it.">)>
				     <COND (<OR <L? ,SHADOW-COUNT 8>
						<SPELL-VERB?>
						<HOSTILE-VERB?>
						<EQUAL? ,PRSO ,SHADOW>>
					    <TELL " ">
					    <FREEZES-YOU>)>
				     <RTRUE>)>)
			     (ELSE
			      <TELL "You are frozen." CR>)>)
		      (<VERB? LEARN>
		       <TELL
"Something about this place prevents you. It's unsettling." CR>)
		      (<VERB? TAKE>
		       <COND (<EQUAL? ,TIME-STOPPED? ,HERE>
			      <COND (<NOT <ZERO? ,P-MULT>>
				     <TELL
"As you try to decide what to take first, the spell wears off! ">
				     <FREEZES-YOU>
				     <RFATAL>)
				    (<AND <EQUAL? ,PRSO ,MAGIC-CUBE>
					  <EQUAL? ,SHADOW-COUNT 9>>
				     <MOVE ,MAGIC-CUBE ,WINNER>
				     <FCLEAR ,MAGIC-CUBE ,NDESCBIT>
				     <TELL
"You tug and pull at the cube, trying desperately to remove it from its
place in the center of the tesseract. With your last reserve of strength
you free it!" CR>)
				    (<AND <GETP ,PRSO ,P?CUBE>
					  <FSET? ,PRSO ,NDESCBIT>>
				     <TELL
"You can no longer see " THE ,PRSO " in the blaze of light." CR>)
				    (<EQUAL? <ITAKE> T>
				     <TELL ,TAKEN>)
				    (ELSE <RTRUE>)>)
			     (<IN? ,SHADOW ,HERE>
			      <FREEZES-YOU>)>)
		      (<AND <VERB? PUT>
			    <EQUAL? ,PRSI ,HYPERCUBE>>
		       <COND (<EQUAL? ,TIME-STOPPED? ,HERE>
			      <COND (<SET F <FIRST? ,HYPERCUBE>>
				     <TELL
CTHE .F " is already there." CR>)
				    (ELSE
				     <MOVE ,PRSO ,HYPERCUBE>
				     <FSET ,PRSO ,NDESCBIT>
				     <TELL
"You push " THE ,PRSO " into the hypercube, where it hangs unsupported." CR>)>)
			     (<IN? ,SHADOW ,HERE>
			      <FREEZES-YOU>)>)
		      (<AND <VERB? BOARD>
			    <IN? ,SHADOW ,HERE>
			    <NOT <EQUAL? ,TIME-STOPPED? ,HERE>>>
		       <FREEZES-YOU>)
		      (<VERB? JINDAK>
		       <TELL "Everything glows." CR>)>)
	       (<EQUAL? .RARG ,M-ENTER>
		<COND (<NOT <IN? ,SHADOW ,HERE>>
		       <QUEUE I-SHADOW-ARRIVES 2>)
		      (ELSE <QUEUE I-SHADOW -1>)>
		<TELL
"Mocking laughter echoes around you." CR CR>)>>

<OBJECT HYPERCUBE
	(DESC "construction")
	(SYNONYM CONSTRUCT HYPERCUBE TESSERACT SQUARE)
	(ADJECTIVE GLOWING TUMBLING)
	(FLAGS NDESCBIT CONTBIT OPENBIT)
	(ACTION HYPERCUBE-F)>

<ROUTINE HYPERCUBE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It floats in front of you, glowing and tumbling." CR>)
	       (<VERB? LEAP>
		<TELL
"Though tempted, you cannot bring yourself to do it." CR>)>>
