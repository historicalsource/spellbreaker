"C3 for
				MAGE
	(c) Copyright 1985 Infocom, Inc. All Rights Reserved."

"AIR"

<OBJECT AIR-CUBE
	(IN MOUTH)
	(DESC "cube")
	(SYNONYM CUBE CUBES)
	(ADJECTIVE CQ ;C3 SMALL FEATURELESS WHITE)
	(NAME 0)
	(TEXT "eagles")
	(FLAGS NDESCBIT TAKEBIT TRYTAKEBIT)
	(ACTION CUBE-F)
	(DESCFCN CUBE-DESC)
        (GENERIC GENERIC-CUBE-F)
	(CUBE AIR-ROOM)>

<ROOM AIR-ROOM
      (IN ROOMS)
      (DESC "Air Room")
      (CUBE AIR-CUBE)
      (NORTH TO GLACIER-ROOM)
      (WEST TO BAZAAR)
      (SOUTH PER MIDAIR-EXIT) ;"EITHER WARNING OR MIDAIR"
      (DOWN PER MAGIC-BOX-EXIT)
      (ACTION AIR-ROOM-F)
      (FLAGS RLANDBIT)
      (GLOBAL GLOBAL-HOLE)
      (THINGS <PSEUDO (FLUFFY CLOUD CLOUD-PSEUDO)
		      (FLUFFY CLOUDS CLOUD-PSEUDO)>)>

<ROUTINE MIDAIR-EXIT ()
	 <COND (<OR ,FALL-WARNING? <IN? ,PLAYER ,MAGIC-CARPET>>
		,MIDAIR)
	       (ELSE
		<SETG FALL-WARNING? T>
		<TELL
"You pull back at the edge, noticing just in time that the hole in the
floor opens into thin air which goes a long way down before anything
solid is reached." CR>
		<RFALSE>)>>

<GLOBAL FALL-WARNING?:FLAG <>>

<ROUTINE AIR-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are on a large fluffy white cloud. In fact, you are
surrounded by clouds. They blow past, wind seeming to boil them around
you from all sides. There is a bit of clear air to the north, momentary
gaps in the clouds to the south and west, and an alarming one below
you." CR>)
	       (<EQUAL? .RARG ,M-LEAVE>
		<RECOVER-CUBE>)>>

<ROOM GLACIER-ROOM
      (IN ROOMS)
      (DESC "Glacier")
      (ACTION GLACIER-ROOM-F)
      (FLAGS RLANDBIT OUTSIDE ONBIT)
      (THINGS
       <PSEUDO (TRACKLESS GLACIER GLACIER-PSEUDO)
	       (<> ICE GLACIER-PSEUDO)
	       (<> SNOW GLACIER-PSEUDO)
	       (<> CREVASSE GLACIER-PSEUDO)
	       (FLATHEAD MOUNTAIN MOUNTAIN-PSEUDO)>)>

<ROUTINE GLACIER-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are in the midst of a trackless glacier in the Flathead Mountains.
Snow blows around you, the wind complaining of its own discomfort. This
is a desolate and dangerous place, for there are crevasses everywhere
under the deceptive blanket of snow." CR>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<VERB? WALK>
		       <COND (<PROB 75>
			      <JIGS-UP
"You have just walked into a crevasse.">)
			     (ELSE
			      <GOTO ,GLACIER-ROOM>)>)>)
	       (<EQUAL? .RARG ,M-LEAVE>
		<SETG FREEZE-COUNT 0>)
	       (<EQUAL? .RARG ,M-END>
		<SETG FREEZE-COUNT <+ ,FREEZE-COUNT 1>>
		<COND (<EQUAL? ,FREEZE-COUNT 5>
		       <TELL CR
"Your body is becoming numb from the cold." CR>)
		      (<EQUAL? ,FREEZE-COUNT 10>
		       <CRLF>
		       <JIGS-UP
"The freezing weather has overcome you. You die of hypothermia.">)>)>>

<ROUTINE GLACIER-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The ice glints so brightly that you are almost blinded." CR>)
	       (<VERB? TINSOT>
		<TELL
"Coals to Newcastle, if you ask me." CR>)>>

<ROOM EMPORIUM
      (IN ROOMS)
      (DESC "Emporium")
      (ACTION EMPORIUM-F)
      (WEST TO BAZAAR IF EMPORIUM-DOOR IS OPEN)
      (OUT TO BAZAAR IF EMPORIUM-DOOR IS OPEN)
      (FLAGS ONBIT RLANDBIT)
      (GLOBAL EMPORIUM-DOOR)
      (THINGS
       <PSEUDO (<> SIGN SIGN-PSEUDO)
	       (<> SIGNS SIGN-PSEUDO)
	       (<> PILE CARPET-PSEUDO)
	       (<> CARPET CARPET-PSEUDO)
	       (WOVEN RUGS CARPET-PSEUDO)
	       (ORNATE RUGS CARPET-PSEUDO)>)>

<ROUTINE CARPET-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL
"They are beautiful examples of the weaver's art." CR>)
	       (<VERB? TAKE>
		<TELL
"You might be accused of thievery." CR>)
	       (<VERB? BUY>
		<TELL ,MORE-SPECIFIC ,PERIOD>)>>

<ROUTINE SIGN-PSEUDO ()
	 <COND (<VERB? READ EXAMINE>
		<TELL
"The sign might as well be Greek." CR>)>>

<ROUTINE EMPORIUM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is the middle of a huge emporium. Signs in a language unknown to you
grace the displays. Most of the objects displayed are ornately woven rugs.
There is an exit into the street to the west."
CR>)
	       (<EQUAL? .RARG ,M-ENTER>
		<QUEUE I-KICKED-OUT 50>
		<QUEUE I-MERCHANT -1>)
	       (<EQUAL? .RARG ,M-LEAVE>
		<COND (<OR <HELD? ,MAGIC-CARPET>
			   <HELD? ,RANDOM-CARPET>>
		       <FSET ,EMPORIUM-DOOR ,LOCKED>
		       <FCLEAR ,EMPORIUM-DOOR ,OPENBIT>)>
		<DEQUEUE I-MERCHANT>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<VERB? NO YES>
		       <TELL
"\"Words are trifles! Let me see your zorkmids!\" chides the merchant." CR>)
		      (<SPELL-VERB?>
		       <TELL
"The spell trickles away to nothing. The merchant smiles. \"Do you think
you are the first magician to try to use lawless, thieving magic on a
humble merchant?\"">
		       <KICKED-OUT>
		       <RTRUE>)>)>>

<OBJECT EMPORIUM-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "shop door")
	(SYNONYM DOOR)
	(ADJECTIVE SHOP)
	(ACTION EMPORIUM-DOOR-F)
	(FLAGS DOORBIT OPENBIT)>

<ROUTINE EMPORIUM-DOOR-F ()
	 <COND (<AND <VERB? OPEN KNOCK REZROV THROUGH>
		     <FSET? ,EMPORIUM-DOOR ,LOCKED>>
		<MERCHANT-AT-DOOR>)
	       (<VERB? THROUGH>
		<DO-WALK <COND (<EQUAL? ,HERE ,BAZAAR> ,P?EAST)
			       (ELSE ,P?WEST)>>)>>

<ROUTINE MERCHANT-AT-DOOR ()
	 <TELL
,DOOR-LOCKED ", apparently by powerful magic. When you attempt
entry, the merchant opens a small panel in the door and recognizes you.
\"We're closed for lunch!\" He slams the panel shut." CR>>

<ROUTINE EMPORIUM-EXIT ()
	 <COND (<FSET? ,EMPORIUM-DOOR ,LOCKED>
		<THIS-IS-IT ,EMPORIUM-DOOR>
		<MERCHANT-AT-DOOR>
		<RFALSE>)
	       (<FSET? ,EMPORIUM-DOOR ,OPENBIT>
	        ,EMPORIUM)
	       (ELSE
		<TELL-OPEN-CLOSED ,EMPORIUM-DOOR>
		<RFALSE>)>>


<OBJECT ZORKMID
	(IN MOUNTAIN-TOP)
	(DESC "gold coin")
	(SYNONYM ZORKMID ZM MONEY COIN)
	(ADJECTIVE GOLD INTNUM PRICE)
	(ACTION ZORKMID-F)
	(FLAGS TAKEBIT TRYTAKEBIT)>

<ROUTINE ZORKMID-F ()
	 <COND (<VERB? EXAMINE READ>
		<TELL
"This is a gold 500 zorkmid piece." CR>)>>

<OBJECT MERCHANT
	(IN EMPORIUM)
	(DESC "merchant")
	(SYNONYM MERCHANT SALESMAN MAN)
	(ADJECTIVE YOUNG EARNEST)
	(FLAGS THE PERSON OPENBIT CONTBIT TRANSBIT)
	(CONTFCN MERCHANT-F)
	(DESCFCN MERCHANT-DESC)
	(ACTION MERCHANT-F)>

<ROUTINE MERCHANT-DESC (RARG OBJ)
	 <TELL
"A young and earnest-looking merchant stands near a pile
of carpets">
	 <COND (<FIRST? ,MERCHANT>
		<TELL ". He is carrying in his arms a ">
		<COND (<IN? ,MAGIC-CARPET ,MERCHANT>
		       <TELL
'MAGIC-CARPET " with a design of cubes on it">
		       <COND (<IN? ,RANDOM-CARPET ,MERCHANT>
			      <TELL " and a ">)>)>
		<COND (<IN? ,RANDOM-CARPET ,MERCHANT>
		       <TELL
'RANDOM-CARPET " that's shabby and badly made">)>)>
	 <TELL ,PERIOD>>

<GLOBAL MERCHANT-FLAG:FLAG <>>

<ROUTINE MERCHANT-F ("OPTIONAL" (RARG <>) "AUX" PREV)
	 <SETG MERCHANT-FLAG T>
	 <COND (<EQUAL? ,WINNER ,MERCHANT>
		<COND (<AND <VERB? TELL-ABOUT>
			    <EQUAL? ,PRSO ,ME>>
		       <RFALSE>)
		      (<VERB? HELLO>
		       <TELL
"\"Greetings to you! May I be of assistance?\"" CR>)
		      (<OR <VERB? TELL-ME-ABOUT>
			   <AND <VERB? GIVE SELL>
				<EQUAL? ,PRSI ,ME>>>
		       <ASK-ABOUT-CARPET ,PRSO>)
		      (<ZERO? ,YOUR-OFFER>
		       <TELL
"\"Would you care to purchase a fine carpet?\"" CR>)
		      (ELSE
		       <TELL
"\"Come, come. I haven't all day.\"" CR>)>)
	       (<EQUAL? .RARG ,M-CONTAINER>
		<COND (<VERB? EXAMINE> <RFALSE>)
		      (<VERB? BUY>
		       <COND (<EQUAL? ,PRSI ,OPAL ,ZORKMID>
			      <SETG ASKED-FOR ,PRSO>
			      <PERFORM ,V?GIVE ,PRSI ,MERCHANT>
			      <RTRUE>)
			     (<AND <ZERO? ,YOUR-OFFER>
				   <ZERO? ,MERCHANT-COUNT>>
			      <SETG ASKED-FOR ,PRSO>
			      <MAKE-NEW-OFFER>)
			     (ELSE
			      <ASK-ABOUT-CARPET ,PRSO>)>)
		      (<VERB? TAKE POINT RUB ADMIRE POINT>
		       <ASK-ABOUT-CARPET ,PRSO>)
		      (<NOT <VERB? FIND>>
		       <TELL
"\"Your obvious eagerness to do business is matched only by your boorish
manners.\"" CR>)>)
	       (<NOT .RARG>
		<COND (<AND <VERB? EXAMINE>
			    <EQUAL? ,PRSO ,MERCHANT>>
		       <TELL
"The merchant is extremely anxious to please. He looks as if it might be
his first day on the job. He's a young fellow wearing purple trousers
which bulge alarmingly at the knees, an orange-striped shirt and a
small hat. He has a detestable moustache." CR>)
		      (<VERB? BARGAIN>
		       <TELL
"\"This is precisely my intention!\"" CR>)
		      (<AND <VERB? GIVE SHOW> <EQUAL? ,PRSI ,MERCHANT>>
		       <COND (<EQUAL? ,PRSO ,MAGIC-CARPET>
			      <PERFORM ,V?TAKE ,RANDOM-CARPET>
			      <RTRUE>)
			     (<EQUAL? ,PRSO ,RANDOM-CARPET>
			      <PERFORM ,V?TAKE ,MAGIC-CARPET>
			      <RTRUE>)
			     (<NOT <G? ,MERCHANT-WANTS ,YOUR-OFFER>>
			      <TELL
"\"But we've already made a deal! I can't accept anything additional!\"" CR>)
			     (<OR <EQUAL? ,PRSO ,OPAL>
				  <EQUAL? ,PRSO ,ZORKMID ,INTNUM>>
			      <NEW-OFFER>)
			     (<NOT <ZERO? <GETP ,PRSO ,P?CUBE>>>
			      <TELL
"\"A mere gewgaw, hardly worth a single zorkmid!\"" CR>)
			     (<OR <FSET? ,PRSO ,MAGICBIT>
				  <FSET? ,PRSO ,SCROLLBIT>>
			      <TELL
"\"That sort of thing is worthless to me. I am a simple man with no
interest in magic!\"" CR>)
			     (ELSE
			      <TELL
"\"You insult me. You insult my wife, you insult my children, you insult
even my lowliest, mangiest dog.\"" CR>)>)>)>>

"ask for a carpet"

<ROUTINE ASK-ABOUT-CARPET (OBJ)
	 <COND (<ZERO? ,YOUR-OFFER>
		<COND (<OR <VERB? ASK-ABOUT ASK-FOR TELL-ME-ABOUT>
			   <VERB? ADMIRE POINT>
			   <NOT <EQUAL? .OBJ ,MAGIC-CARPET ,RANDOM-CARPET>>>
		       <TELL
"\"I see you have excellent taste. Let me tell you about these fine carpets">
		       <COND (<NOT <EQUAL? .OBJ ,MAGIC-CARPET ,RANDOM-CARPET>>
			      <TELL " instead">)
			     (ELSE <SETG ASKED-FOR .OBJ>)>
		       <TELL
". They are my pride and joy, next of course to my nieces and nephews, but
I digress... These carpets are the best you will find anywhere.\"" CR>)
		      (ELSE
		       <SETG ASKED-FOR .OBJ>
		       <TELL
"\"This is a valuable carpet. What will you offer for it? I'm not in
business for my health.\"" CR>)>)
	       (<L? ,YOUR-OFFER ,MERCHANT-WANTS>
		<TELL
"\"A serious offer, now! Enough of this game-playing!\"" CR>)
	       (<AND <EQUAL? .OBJ ,MAGIC-CARPET>
		     <IN? .OBJ ,MERCHANT>>
		<COND (<EQUAL? ,ASKED-FOR ,MAGIC-CARPET>
		       <COND (<IN? ,RANDOM-CARPET ,PLAYER>
			      <TELL
"\"How silly of me! You wanted this one with the cubes, didn't you?\" He
gives it to you">)
			     (ELSE
			      <TELL
"He grudgingly gives you the " 'MAGIC-CARPET>)>
		       <COND (<IN? ,PLAYER ,RANDOM-CARPET>
			      <MOVE ,PLAYER ,HERE>)>
		       <MOVE ,RANDOM-CARPET ,MERCHANT>
		       <MOVE ,MAGIC-CARPET ,PLAYER>
		       <SCORE-OBJECT ,MAGIC-CARPET>
		       <COND (<NOT <IN? ,RANDOM-CARPET ,MERCHANT>>
			      <TELL ", retrieving the " 'RANDOM-CARPET>)>
		       <TELL ,PERIOD>)
		      (<EQUAL? ,ASKED-FOR ,RANDOM-CARPET>
		       <TELL
"\"No going back on our deal! I'll report you to the merchants'
association!\"" CR>)>)
	       (<AND <EQUAL? .OBJ ,RANDOM-CARPET>
		     <IN? .OBJ ,MERCHANT>>
		<SETG ASKED-FOR ,RANDOM-CARPET>
		<TELL
"He hurriedly gives you the " 'RANDOM-CARPET>
		<COND (<NOT <IN? ,MAGIC-CARPET ,MERCHANT>>
		       <TELL ", retrieving the " 'MAGIC-CARPET>)>
		<COND (<IN? ,PLAYER ,MAGIC-CARPET>
		       <MOVE ,PLAYER ,HERE>)>
		<MOVE ,MAGIC-CARPET ,MERCHANT>
		<MOVE ,RANDOM-CARPET ,PLAYER>
		<TELL ,PERIOD>)
	       (ELSE
		<TELL "\"Yes? What about " THE .OBJ "?\"" CR>)>>

"process new offer to merchant"

<ROUTINE NEW-OFFER ("AUX" NEW OBJ)
	 <COND (<EQUAL? ,PRSO ,ZORKMID ,INTNUM>
		<SET OBJ ,ZORKMID>
		<COND (<ZERO? ,P-NUMBER>
		       <COND (<ZERO? ,YOUR-OFFER>
			      <TELL
"\"Five hundred zorkmids? Possibly a true coin...\" He
tries to hide his interest. ">)>
		       <SET NEW 500>)
		      (ELSE
		       <SET NEW ,P-NUMBER>)>)
	       (ELSE
		<SET OBJ ,PRSO>
		<SET NEW ,MERCHANT-WANTS>)>
	 <COND (<NOT ,ASKED-FOR>
		<SETG ASKED-FOR ,RANDOM-CARPET>
		<TELL
"The merchant's eyes light up. \"No doubt you wish to purchase this lovely "
'RANDOM-CARPET ". A wise choice!\"" CR>)
	       (<NOT <G? ,MERCHANT-WANTS .NEW>>
		<SETG YOUR-OFFER .NEW>
		<TELL
"\"Done, then!\" The merchant takes " THE .OBJ ". ">
		<COND (<NOT <EQUAL? .OBJ ,ZORKMID>>
		       <TELL "He examines it skeptically. \"I don't
really think this is worth the price, no, it won't do at all...\" He
hefts it in his hand. \"Well, I believe in accommodating our out-of-town
visitors. Otherwise, we don't get any repeat customers, right? I can always
put this trinket on the mantelpiece and regale my family with the story.\"
He smiles unctuously. ">)
		      (<G? ,YOUR-OFFER 500>
		       <TELL
"\"What do you take me for? This is only a 500 zorkmid piece! Trying to
cheat me is trying to cheat my children! This I cannot accept! Out with
you!\"">
		       <KICKED-OUT>
		       <RTRUE>)>
		<MOVE .OBJ ,MERCHANT>
		<MOVE ,RANDOM-CARPET ,PLAYER>
		<TELL
"\"I don't know what my family will eat tonight, but they say I'm
softhearted. I only want to get back to my lunch, so you've got a deal. You
should have told me you were an expert.\" He gives you a carpet. \"Now
go before my family sees what a fool I've been...\"" CR>)
	       (<AND <NOT <L? .NEW 100>>
		     <NOT <L? .NEW <+ 50 ,YOUR-OFFER>>>>
		<MAKE-NEW-OFFER .NEW>)
	       (ELSE
		<COND (<ZERO? ,YOUR-OFFER>
		       <SETG YOUR-OFFER .NEW>)>
		<TELL
"\"Now, really, you must bargain in good faith. My patience is not infinite,
as my lunch even now is congealing.\"" CR>)>>

<ROUTINE MAKE-NEW-OFFER ("OPTIONAL" (NEW 0))
	 <SETG YOUR-OFFER .NEW>
	 <SETG MERCHANT-COUNT <+ ,MERCHANT-COUNT 1>>
	 <COND (<NOT <G? ,MERCHANT-COUNT <GET ,MERCHANT-SAYS 0>>>
		<SETG MERCHANT-WANTS <- ,MERCHANT-WANTS 100>>
		<COND (<NOT <G? ,MERCHANT-WANTS ,YOUR-OFFER>>
		       <SETG MERCHANT-WANTS ,YOUR-OFFER>
		       <NEW-OFFER>)
		      (ELSE
		       <TELL <GET ,MERCHANT-SAYS
				  ,MERCHANT-COUNT>
			     CR>)>)
	       (ELSE
		<TELL
"\"That does it! Out you go! Down the road to the rag-pickers, you
thief!\"">
		<KICKED-OUT>
		<RTRUE>)>>

<GLOBAL ASKED-FOR:FLAG <>>

<ROUTINE KICKED-OUT ("AUX" (L <LOC ,PLAYER>))
	 <COND (<FSET? .L ,VEHBIT>
		<MOVE ,PLAYER ,HERE>
		<MOVE .L ,PLAYER>)> 
	 <TELL " He throws you into the street and bars the door." CR CR>
	 <FCLEAR ,EMPORIUM-DOOR ,OPENBIT>
	 <FSET ,EMPORIUM-DOOR ,LOCKED>
	 <GOTO ,BAZAAR>>

<ROUTINE I-KICKED-OUT ()
	 <COND (<EQUAL? ,HERE ,EMPORIUM>
		<TELL CR
"The merchant says, \"Time is money, and you've wasted too much of mine!\"">
		<KICKED-OUT>)>>

<GLOBAL YOUR-OFFER:NUMBER 0>
<GLOBAL MERCHANT-WANTS:NUMBER 900>
<GLOBAL MERCHANT-COUNT:NUMBER 0>
<GLOBAL MERCHANT-SAYS:TABLE
	<PLTABLE
"\"These carpets are the epitome of the weaver's art, woven
by skilled native craftsmen with pride in their work. The Flatheads themselves
have carpets like these. Their worth is nearly incalculable, but because
today is my aged mother's birthday, we are offering them at an absurdly low
price. A mere eight hundred zorkmids each!\""

"\"You obviously didn't hear me. I didn't say we were giving them away.
But my father is also hard of hearing and
thus I have a warm spot in my heart for those similarly afflicted, so I will
accept a pittance, as charity: seven hundred zorkmids.\""

"\"My word! Let me see your teeth... No, not shark's teeth after all. Perhaps
your rapaciousness has led you astray. Down the block you may find old rags
and such to make a fine floor covering for your hovel. Here you must pay what
the product is worth. Six hundred, or I send you down the street.\""

"\"This grows tedious. Because I am a busy man and my lunch is growing cold,
I will sell you a rug below my own cost. These rugs are imported at great
expense over burning deserts, steep mountains and bandit-infested plains.
My own cousin, who was watching out for the family interests in the caravan,
was lost bringing this very shipment here. The caravan master, in his
absence, no doubt robbed us blind, as you propose to do. Done at five hundred,
then!\" He reaches toward you expectantly.">>

<ROOM BAZAAR
      (IN ROOMS)
      (DESC "Bazaar")
      (EAST PER EMPORIUM-EXIT)
      (IN PER EMPORIUM-EXIT)
      (FLAGS RLANDBIT OUTSIDE ONBIT)
      (ACTION BAZAAR-F)
      (GLOBAL EMPORIUM-DOOR)
      (THINGS
       <PSEUDO ;(RAGGED URCHIN URCHIN-PSEUDO)
	       (<> SIGN SIGN-PSEUDO)
	       (<> SHOP SHOP-PSEUDO)
	       (<> EMPORIUM SHOP-PSEUDO)>)>

<ROUTINE SHOP-PSEUDO ()
	 <COND (<VERB? THROUGH>
		<DO-WALK ,P?EAST>)>>

;<ROUTINE URCHIN-PSEUDO ()
	 <COND (<OR <VERB? EXAMINE FOLLOW GIVE FIND>
		    <HOSTILE-VERB?>>
		<TELL "What urchin? You don't see an urchin." CR>)>>

<ROUTINE BAZAAR-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a crowded, noisy bazaar. Directly in front of you to the east
is a shop. Above its door is a sign in an unknown tongue. " ,YOU-CANT "read
it, but it is illustrated with a picture of a very ornate rug. ">
		<COND (<FSET? ,EMPORIUM-DOOR ,LOCKED>
		       <THIS-IS-IT ,EMPORIUM-DOOR>
		       <TELL ,DOOR-LOCKED ,PERIOD>)
		      (<NOT <FSET? ,EMPORIUM-DOOR ,OPENBIT>>
		       <TELL-OPEN-CLOSED ,EMPORIUM-DOOR>)
		      (ELSE
		       <TELL "The door beckons invitingly." CR>)>)
	       ;(<EQUAL? .RARG ,M-ENTER>
		<QUEUE I-URCHIN 2>)>>

<OBJECT RANDOM-CARPET
	(DESC "scruffy red carpet")
	(SYNONYM CARPET RUG)
	(ADJECTIVE SHABBY SCRUFFY RED UGLY)
	(FLAGS TAKEBIT VEHBIT CONTBIT OPENBIT SURFACEBIT SEARCHBIT)
	(CAPACITY 200)
	(GENERIC GENERIC-CARPET-F)
	(ACTION RANDOM-CARPET-F)>

<ROUTINE TAKE-ON-CARPET (CARP)
	 <COND (<EQUAL? ,PRSO ,MAGIC-CARPET>
		<GET-OFF-FIRST>)
	       (<NOT-IN-VEHICLE?>
		<CANT-REACH-THAT>)>>

<ROUTINE NOT-SITTING ()
	 <COND (,SITTING?
		<MOVE ,PLAYER ,HERE>
		<SETG SITTING? <>>
		<TELL
" You are no longer sitting on the carpet.">)>>

<ROUTINE NOW-SITTING ()
	 <COND (<AND ,SITTING? <IN? ,PLAYER ,PRSO>>
		<TELL ,YOU-ARE ,PERIOD>
		<RFALSE>)
	       (ELSE
		<SETG SITTING? T>
		<TELL "You ">
		<COND (<IN? ,PLAYER ,PRSO>
		       <TELL "sit down">)
		      (ELSE
		       <MOVE ,PLAYER ,PRSO>
		       <TELL "are now sitting">)>
		<TELL " on " THE ,PRSO ". ">)>>

<ROUTINE RANDOM-CARPET-F ("OPTIONAL" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-BEG>
		<COND (<OR <VERB? FLY>
			   <AND <VERB? WALK>
				<OR <EQUAL? ,P-WALK-DIR ,P?UP>
				    <G? ,UD-COUNT 0>>>>
		       <TELL ,NOTHING-HAPPENS>)
		      (<VERB? WALK>
		       <GET-OFF-FIRST>)
		      (<VERB? TAKE MOVE>
		       <TAKE-ON-CARPET ,RANDOM-CARPET>)
		      (<AND <VERB? DISEMBARK>
			    <EQUAL? ,PRSO ,RANDOM-CARPET>>
		       <STEP-OFF-CARPET>
		       <CRLF>)>)
	       (<NOT .RARG>
		<COND (<VERB? EXAMINE>
		       <TELL
"This is a cheaply made and ugly carpet. It is a garish red and looks ready
to fall apart.">
		       <CLEVER-CONTENTS ,RANDOM-CARPET
					" On the carpet">
		       <CRLF>)
		      (<VERB? CASKLY>
		       <TELL
"It's perfectly awful already." CR>)
		      (<AND <VERB? OFFER>
			    <EQUAL? ,PRSI ,RANDOM-CARPET>
			    <IN? ,MERCHANT ,HERE>>
		       <SETG ASKED-FOR ,PRSI>
		       <PERFORM ,V?GIVE ,PRSO ,MERCHANT>
		       <RTRUE>)
		      (<VERB? TAKE>
		       <TAKE-CARPET>)
		      (<VERB? BOARD CLIMB-ON STAND-ON>
		       <BOARD-CARPET>)
		      (<AND <VERB? SIT>
			    <NOT <IN? ,WINNER ,RANDOM-CARPET>>>
		       <COND (<CANT-GET-ON?>
			      <RTRUE>)
			     (ELSE
			      <COND (<NOW-SITTING>
				     <TELL
"Some of the nap comes off on you." CR>)>
			      <RTRUE>)>)
		      (<AND <VERB? CUT>
			    <EQUAL? ,PRSI ,SHEARS ,KNIFE>>
		       <CARPET-CRUMBLES>)>)>>

<GLOBAL SITTING?:FLAG <>>

<ROUTINE IMPOSSIBLE-MANEUVER ()
	 <TELL
"An impossible maneuver under the circumstances." CR>>

<ROUTINE CANT-GET-ON? ()
	 <COND (<FSET? ,HERE ,RAIRBIT>
		<TELL
"A good thought, but a little too late to save you, I'm afraid." CR>)
	       (<FSET? ,HERE ,RWATERBIT>
		<IMPOSSIBLE-MANEUVER>)
	       (<HELD? ,PRSO>
		<TELL
,YOU-HAVE-TO " put it down first." CR>)>>

<ROUTINE BOARD-CARPET ()
	 <COND (<IN? ,PLAYER ,PRSO>
		<TELL ,YOU-ARE ,PERIOD>)
	       (<CANT-GET-ON?> <RTRUE>)
	       (ELSE
		<MOVE ,PLAYER ,PRSO>
		<SETG SITTING? <>>
		<TELL
,YOU-ARE-NOW "standing on the carpet. Nothing expected is happening." CR>)>>

<ROUTINE STEP-OFF-CARPET ()
	 <SETG SITTING? <>>
	 <MOVE ,PLAYER <LOC ,PRSO>>
	 <TELL "You step off the carpet.">>

<OBJECT MAGIC-CARPET
	(DESC "beautiful blue carpet")
	(SYNONYM CARPET RUG)
	(ADJECTIVE MAGIC BEAUTIFUL BLUE STRANGE DESIGN)
	(FLAGS TAKEBIT VEHBIT MAGICBIT CONTBIT OPENBIT SURFACEBIT SEARCHBIT)
	(CAPACITY 200)
	(GENERIC GENERIC-CARPET-F)
	(ACTION MAGIC-CARPET-F)>

<ROUTINE MAGIC-CARPET-F ("OPTIONAL" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-BEG>
		<COND (<VERB? TAKE MOVE>
		       <TAKE-ON-CARPET ,MAGIC-CARPET>)
		      (<AND <VERB? DROP> <G? ,UD-COUNT 0>>
		       <DROP-IN-AIR>)
		      (<OR <VERB? FLY>
			   <AND <VERB? WALK>
				<OR <EQUAL? ,P-WALK-DIR ,P?UP>
				    <G? ,UD-COUNT 0>>>>
		       <COND (<AND <VERB? FLY>
				   <NOT ,PRSO>>
			      <SETG P-WALK-DIR ,P?UP>)>
		       <COND (<OR <NOT <IN? ,CARPET-LABEL ,MAGIC-CARPET>>
				  <FSET? ,CARPET-LABEL ,RMUNGBIT>>
			      <TELL ,NOTHING-HAPPENS>)
			     (<NOT ,SITTING?>
			      <TELL ,RIPPLES ,PERIOD>)
			     (<EQUAL? ,HERE ,MIDAIR>
			      <COND (<EQUAL? ,P-WALK-DIR ,P?NORTH>
				     <SETG NS-COUNT <+ ,NS-COUNT 1>>)
				    (<EQUAL? ,P-WALK-DIR ,P?SOUTH>
				     <SETG NS-COUNT <- ,NS-COUNT 1>>)
				    (<EQUAL? ,P-WALK-DIR ,P?EAST>
				     <SETG EW-COUNT <+ ,EW-COUNT 1>>)
				    (<EQUAL? ,P-WALK-DIR ,P?WEST>
				     <SETG EW-COUNT <- ,EW-COUNT 1>>)
				    (<EQUAL? ,P-WALK-DIR ,P?UP>
				     <SETG UD-COUNT <+ ,UD-COUNT 1>>)
				    (<EQUAL? ,P-WALK-DIR ,P?DOWN>
				     <SETG UD-COUNT <- ,UD-COUNT 1>>)
				    (<EQUAL? ,P-WALK-DIR ,P?NE>
				     <SETG NS-COUNT <+ ,NS-COUNT 1>>
				     <SETG EW-COUNT <+ ,EW-COUNT 1>>)
				    (<EQUAL? ,P-WALK-DIR ,P?NW>
				     <SETG NS-COUNT <+ ,NS-COUNT 1>>
				     <SETG EW-COUNT <- ,EW-COUNT 1>>)
				    (<EQUAL? ,P-WALK-DIR ,P?SE>
				     <SETG NS-COUNT <- ,NS-COUNT 1>>
				     <SETG EW-COUNT <+ ,EW-COUNT 1>>)
				    (<EQUAL? ,P-WALK-DIR ,P?SW>
				     <SETG NS-COUNT <- ,NS-COUNT 1>>
				     <SETG EW-COUNT <- ,EW-COUNT 1>>)
				    (ELSE
				     <TELL
"The carpet doesn't move." CR>
				     <RTRUE>)>
			      <COND (<EQUAL? ,UD-COUNT 0>
				     <COND (<AND <EQUAL? ,NS-COUNT 0>
						 <EQUAL? ,EW-COUNT 0>>
					    <GOTO ,ROC-NEST>)
					   (<AND <EQUAL? ,NS-COUNT 0>
						 <EQUAL? ,EW-COUNT 4>
						 ,SEEN-TOWER?>
					    <GOTO ,GUARD-TOWER>)
					   (ELSE
					    <GOTO ,LOST-ON-LAND>)>
				     <RTRUE>)
				    (ELSE
				     <DESCRIBE-CARPET-LOC>)>)
			     (<EQUAL? ,HERE ,LOST-IN-CLOUDS>
			      <SETG SMASH-PROB <+ ,SMASH-PROB 5>>
			      <COND (<PROB ,SMASH-PROB>
				     <FCLEAR ,MIDAIR ,TOUCHBIT>
				     <GOTO ,MIDAIR>)
				    (ELSE
				     <TELL
"You are still lost in thick, fluffy clouds. It is impossible to tell
directions in here." CR>)>)
			     (<EQUAL? ,P-WALK-DIR ,P?UP>
			      <COND (<EQUAL? ,HERE ,GUARD-TOWER ,ROC-NEST>
				     <TELL
"The carpet takes to the air, rising swiftly.">
				     <COND (<AND <IN? ,ROC ,HERE>
						 <EQUAL? ,HERE ,GUARD-TOWER>>
					    <REMOVE ,ROC>
					    <TELL
" The huge bird stops, almost stalls, and flees goggle-eyed with
surprise.">)>
				     <CRLF>
				     <CRLF>
				     <FCLEAR ,MIDAIR ,TOUCHBIT>
				     <GOTO ,MIDAIR>)
				    (<EQUAL? ,HERE ,VOLCANO-ROOM ,VOLCANO-BASE
					     ,OUTCROPPING-ROOM>
				     <TELL
"You begin to rise, but you notice that the ">
				     <COND (<EQUAL? ,MAGIC-CARPET ,ICED-OBJECT>
					    <SETG ICED-OBJECT <>>
					    <TELL
"carpet is steaming as the ice melts. You prudently return to earth." CR>
					    <RTRUE>)
					   (ELSE
					    <REMOVE ,CARPET-LABEL>
					    <JIGS-UP
"fringe of the carpet is starting
to singe and turn brown from the heat. Just as you are about to turn back,
the label catches fire and burns to a crisp. You plummet into the lava and
are seen no more.">)>)
				    (<FSET? ,HERE ,OUTSIDE>
				     <FCLEAR ,LOST-IN-CLOUDS ,TOUCHBIT>
				     <GOTO ,LOST-IN-CLOUDS>)
				    (ELSE
				     <TELL
"It ripples a little." CR>)>)
			     (ELSE
			      <TELL ,RIPPLES ,PERIOD>)>)
		      (<VERB? WALK>
		       <GET-OFF-FIRST>)
		      (<AND <VERB? DISEMBARK>
			    <EQUAL? ,PRSO ,MAGIC-CARPET>>
		       <STEP-OFF-CARPET>
		       <COND (<FSET? ,HERE ,RAIRBIT>
			      <START-FALLING>
			      <TELL
" As you are in midair, you begin to fall. The
carpet loses its impetus the moment you cease to touch it and accordians
like a rug that's been slipped on. It too begins to fall.">)>
		       <CRLF>)
		      (<AND <VERB? LEAP> <G? ,UD-COUNT 0>>
		       <TELL
"This is not the most prudent method of disembarking." CR>)>)
	       (<NOT .RARG>
		<COND (<VERB? EXAMINE>
		       <TELL
"This is a carpet of unusual design. It is blue, beautifully woven and has
a pattern that looks different each time you look at it.
Sometimes, for example, it's an array of cubes pointing upward, and other
times it's the same array pointing downward. There is a jaunty fringe
around the outer edge.">
		       <CLEVER-CONTENTS ,MAGIC-CARPET
					" On the carpet"
					,CARPET-LABEL>
		       <CRLF>)
		      (<AND <VERB? OFFER>
			    <EQUAL? ,PRSI ,MAGIC-CARPET>
			    <IN? ,MERCHANT ,HERE>>
		       <SETG ASKED-FOR ,PRSI>
		       <PERFORM ,V?GIVE ,PRSO ,MERCHANT>
		       <RTRUE>)
		      (<VERB? TAKE>
		       <TAKE-CARPET>)
		      (<AND <VERB? CUT>
			    <EQUAL? ,PRSI ,SHEARS ,KNIFE>>
		       <START-FALLING>
		       <CARPET-CRUMBLES>)
		      (<VERB? LOOK-INSIDE>
		       <COND (<CLEVER-CONTENTS ,PRSO
					"On the carpet"
					,CARPET-LABEL>
			      <CRLF>)
			     (ELSE <ITS-EMPTY>)>)
		      (<VERB? LOOK-UNDER TURN-OVER MOVE>
		       <TELL "You turn the carpet over and discover ">
		       <COND (<AND <IN? ,PLAYER ,MAGIC-CARPET>
				   <EQUAL? ,HERE ,MIDAIR ,LOST-IN-CLOUDS>>
			      <JIGS-UP
"that you have sent the carpet into a fatal stall!">
			      <RFATAL>) 
			     (<AND <IN? ,CARPET-LABEL ,MAGIC-CARPET>
				   <NOT <FSET? ,CARPET-LABEL ,RMUNGBIT>>>
			      <FCLEAR ,CARPET-LABEL ,INVISIBLE>
			      <TELL "a label">)
			     (ELSE
			      <TELL "nothing">)>
		       <TELL ,PERIOD>)
		      (<VERB? BOARD CLIMB-ON STAND-ON>
		       <BOARD-CARPET>)
		      (<VERB? SIT>
		       <COND (<CANT-GET-ON?> <RTRUE>)
			     (<NOW-SITTING>
			      <COND (<AND <IN? ,CARPET-LABEL
					       ,MAGIC-CARPET>
					  <NOT <FSET? ,CARPET-LABEL
						      ,RMUNGBIT>>>
				     <TELL
"At first nothing happens. Then the
fringe of the carpet starts to ruffle expectantly." CR>)
				    (ELSE
				     <TELL
"Nothing interesting happens, although the carpet is comfortable." CR>)>)>
		       <RTRUE>)>)
	       (<EQUAL? .RARG ,M-ENTER>
		<SETG SMASH-PROB 0>)>>

<ROUTINE TAKE-CARPET ("AUX" (IGNORE? <>))
	 <COND (<EQUAL? <ITAKE> T>
		<TELL "Taken">
		<SET IGNORE?
		     <COND (<NOT <FSET? ,CARPET-LABEL ,RMUNGBIT>>
			    ,CARPET-LABEL)>>
		<COND (<ROB ,PRSO ,HERE .IGNORE?>
		       <TELL ", but something fell off">)>
		<TELL ,PERIOD>)>
	 <RTRUE>>

<GLOBAL RIPPLES:STRING "The carpet ripples excitedly">

<ROUTINE GET-OFF-FIRST ()
	 <TELL
,YOU-HAVE-TO " get off the carpet first." CR>>

<ROUTINE CARPET-CRUMBLES ()
	 <COND (<IN? ,PLAYER ,PRSO>
		<MOVE ,PLAYER ,HERE>)>
	 <REMOVE ,PRSO>
	 <TELL
"As the first thread is cut, the " 'PRSO " crumbles to dust." CR>>

<ROUTINE DESCRIBE-CARPET-LOC ()
	 <TELL "You are ">
	 <COND (<IN? ,PLAYER ,MAGIC-CARPET> <TELL "flying ">)>
	 <COND (<G? ,UD-COUNT 3>
		<TELL "dizzyingly high ">)
	       (<G? ,UD-COUNT 2>
		<TELL "very high ">)
	       (<G? ,UD-COUNT 1>
		<TELL "high ">)>
	 <TELL "above ">
	 <COND (<AND <EQUAL? ,NS-COUNT 0>
		     <EQUAL? ,EW-COUNT 0>>
		<TELL "a giant bird's nest">)
	       (<AND <EQUAL? ,NS-COUNT 0>
		     <EQUAL? ,EW-COUNT 4>
		     ,SEEN-TOWER?>
		<TELL "an abandoned guard tower">)
	       (<EQUAL? ,EW-COUNT 0>
		<TELL "jagged mountains">)
	       (ELSE
		<TELL "a trackless wilderness to the ">
		<COND (<G? ,EW-COUNT 0>
		       <TELL "east">)
		      (ELSE
		       <TELL "west">)>
		<TELL " of a range of jagged mountains">)>
	 <TELL ,PERIOD>>

<OBJECT CARPET-LABEL
	(IN MAGIC-CARPET)
	(DESC "label")
	(SYNONYM LABEL)
	(FLAGS INVISIBLE TAKEBIT READBIT)
	(ACTION CARPET-LABEL-F)>

<ROUTINE CARPET-LABEL-F ()
	 <COND (<VERB? READ EXAMINE>
		<TELL
"The label reads:|
|
\"Frobozz Magic Magic Carpet Co.|
|
This carpet is made of all-unnatural fibers.
Occupancy by more than one person is prohibited. Keep to posted speeds.
Do not remove this label under penalty of law.|
|
Abdul el-Flathead|
|
(Printed by the Frobozz Magic Label Co.)\"" CR>)
	       (<AND <VERB? CASKLY>
		     <NOT <IN? ,CARPET-LABEL ,MAGIC-CARPET>>>
		<TELL ,NOTHING-HAPPENS>)
	       (<OR <VERB? TAKE MUNG>
		    <AND <VERB? CUT>
			 ,PRSI
			 <FSET? ,PRSI ,WEAPONBIT>>> 
		<FSET ,PRSO ,RMUNGBIT>
		<COND (<AND <IN? ,PLAYER ,MAGIC-CARPET>
			    <FSET? ,HERE ,RAIRBIT>>
		       <START-FALLING>
		       <MOVE ,PLAYER ,HERE>
		       <TELL
"As soon as the label is removed, the carpet hits an air pocket and rolls
up. There is no room for you on a rolled-up carpet. You begin to fall."
CR>)>)>>

<ROUTINE START-FALLING ()
	 <SETG FALLING? T>
	 <SETG SMASH-PROB 0>
	 <QUEUE I-FALLING -1>>

<ROOM MIDAIR
      (IN ROOMS)
      (DESC "Midair")
      (ACTION MIDAIR-F)
      (FLAGS RAIRBIT OUTSIDE ONBIT)
      (THINGS
       <PSEUDO (FLATHEAD MOUNTAIN MOUNTAIN-PSEUDO)
	       (TRACKLESS WILDERNESS RANDOM-PSEUDO)
	       (<> CLOUDS CLOUD-PSEUDO)
	       (GUARD TOWER RANDOM-PSEUDO)
	       (ROC NEST NEST-PSEUDO)>)>

<ROUTINE MIDAIR-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL "You are in midair.">
		<COND (<IN? ,PLAYER ,ROC>
		       <TELL
" Fortunately a very large bird is carrying you, otherwise you would fall.">)
		      (<IN? ,PLAYER ,MAGIC-CARPET>
		       <TELL
" Fortunately you are sitting on a magic carpet and thus are fairly safe.">)
		      (,FALLING?
		       <TELL " You are falling.">)>
		<COND (<EQUAL? ,HERE ,MIDAIR>
		       <TELL " ">
		       <DESCRIBE-CARPET-LOC>)
		      (ELSE <CRLF>)>
		<RTRUE>)
	       (<EQUAL? .RARG ,M-ENTER>
		<COND (<NOT <IN? ,PLAYER ,MAGIC-CARPET>>
		       <SETG ROC-PROB
			     <COND (<FSET? ,HERE ,TOUCHBIT> 0)
				   (ELSE 25)>>
		       <QUEUE I-ROC -1>)>
		<SETG EW-COUNT
		      <COND (<EQUAL? ,OHERE ,LOST-IN-CLOUDS>
			     <- <RANDOM 5> 1>)
			    (<EQUAL? ,OHERE ,GUARD-TOWER
				     ,AIR-ROOM ,EARTH-ROOM>
			     4)
			    (ELSE
			     0)>>
		<SETG NS-COUNT
		      <COND (<EQUAL? ,OHERE ,LOST-IN-CLOUDS>
			     <- <RANDOM 5> 3>)
			    (ELSE
			     0)>>
		<SETG UD-COUNT
		      <COND (<EQUAL? ,OHERE ,LOST-IN-CLOUDS>
			     <RANDOM 4>)
			    (<EQUAL? ,OHERE ,AIR-ROOM ,EARTH-ROOM>
			     4)
			    (ELSE
			     1)>>
		<RFALSE>)
	       (<EQUAL? .RARG ,M-LEAVE>
		<COND (<IN? ,MAGIC-CARPET ,HERE>
		       <MOVE ,MAGIC-CARPET ,LOST-ON-LAND>)>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<AND <VERB? WALK> ,FALLING?>
		       <COND (<EQUAL? ,P-WALK-DIR ,P?DOWN>
			      <TELL "You have little choice." CR>)
			     (ELSE
			      <TELL "Down seems more likely." CR>)>)
		      (<AND <VERB? LESOCH> <NOT ,PRSO>>
		       <LESOCH-CLOUDS>)
		      (<VERB? DROP>
		       <DROP-IN-AIR>)>)
	       (<EQUAL? .RARG ,M-END>
		<COND (<AND <NOT <EQUAL? <LOC ,PLAYER> ,ROC ,MAGIC-CARPET>>
			    <NOT ,FALLING?>>
		       <SETG ROC-PROB 0>
		       <START-FALLING>
		       <TELL "You have begun to fall." CR>)>)>>

<ROUTINE DROP-IN-AIR ()
	 <COND (<EQUAL? ,PRSO <LOC ,WINNER>>
		<RFALSE>)
	       (<IDROP>
		<COND (<EQUAL? ,PRSO ,MAGIC-BOX>
		       <MOVE ,PRSO ,LOST-ON-LAND>)
		      (ELSE
		       <REMOVE ,PRSO>)>
		<TELL
CTHE ,PRSO " falls, dwindling below you, never to be seen again." CR>)
	       (ELSE <RTRUE>)>>

<GLOBAL NS-COUNT:NUMBER 0>
<GLOBAL EW-COUNT:NUMBER 0>
<GLOBAL UD-COUNT:NUMBER 0>

<ROOM LOST-IN-CLOUDS
      (IN ROOMS)
      (DESC "In Thick Clouds")
      (ACTION MIDAIR-F)
      (FLAGS ONBIT RAIRBIT)
      (THINGS <PSEUDO (<> CLOUDS CLOUD-PSEUDO)
		      (<> CLOUD CLOUD-PSEUDO)>)>

<ROOM LOST-ON-LAND
      (IN ROOMS)
      (DESC "Wilderness")
      (ACTION WILDERNESS-F)
      (FLAGS ONBIT RLANDBIT)>

<ROUTINE WILDERNESS-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<TELL
"Wilderness|
You are lost in a trackless wilderness. Wild creatures and wild men
rule here. As soon as ">
		<COND (<IN? ,PLAYER ,MAGIC-CARPET>
		       <TELL "your carpet touches ground">)
		      (ELSE
		       <TELL "you arrive">)>
		<TELL ", you are set upon by
one or the other (they are difficult to tell apart) and devoured.">
			<JIGS-UP>)>>

"FIRE"

<OBJECT FIRE-CUBE
	(IN PILLAR-ROOM)
	(DESC "cube")
	(SYNONYM CUBE CUBES)
	(ADJECTIVE DQ ;C4 SMALL FEATURELESS WHITE)
	(NAME 0)
	(TEXT "salamanders")
	(FLAGS TAKEBIT)
	(ACTION CUBE-F)
	(DESCFCN CUBE-DESC)
        (GENERIC GENERIC-CUBE-F)
	(CUBE FIRE-ROOM)>

<ROOM FIRE-ROOM
      (IN ROOMS)
      (DESC "Fire Room")
      (CUBE FIRE-CUBE)
      (SOUTH TO CLIFF-TOP)
      (NORTH TO VOLCANO-ROOM)
      (EAST PER MAGIC-BOX-EXIT)
      (ACTION FIRE-ROOM-F)
      (FLAGS RLANDBIT ONBIT)>

<ROUTINE FIRE-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"In this room, the walls are brick and glow a deep red. The floor itself
radiates heat, and in fact the entire room is hot, oppressive and smokey.
Searing heat radiates from openings in the north, east and south walls." CR>)
	       (<EQUAL? .RARG ,M-LEAVE>
		<RECOVER-CUBE>)>>

<ROOM VOLCANO-ROOM
      (IN ROOMS)
      (DESC "Volcano")
      (ACTION VOLCANO-ROOM-F)
      (FLAGS RLANDBIT OUTSIDE ONBIT)
      (GLOBAL OUTCROPPING GLOBAL-ROCKS)
      (THINGS
       <PSEUDO (<> VOLCANO VOLCANO-PSEUDO)
	       (MOLTEN LAVA LAVA-PSEUDO)>)>

<ROUTINE VOLCANO-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are at the edge of a lava vent in an active volcano. The
lava glows red and yellow, and there is a stench of sulphur in the air.
A lake of lava bubbles and steams before you, molten rock roiling from
unseen disturbances. To the west, in the middle of the tumult, is a
small outcropping of something with a higher melting point than rock. It
is undisturbed by the heat." CR>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<AND <VERB? SMELL> <NOT ,PRSO>>
		       <TELL ,SMELL-LAVA>)>)>>

<ROUTINE VOLCANO-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<PERFORM ,V?LOOK>
		<RTRUE>)
	       (<VERB? SMELL>
		<TELL ,SMELL-LAVA>)
	       (<VERB? TINSOT>
		<LAVA-COOLS>)>>

<ROUTINE LAVA-COOLS ()
	 <TELL
"A small patch of lava cools, but it is swept away." CR>>

<GLOBAL SMELL-LAVA:STRING "It smells like boiling brimstone.|">

<ROUTINE LAVA-PSEUDO ()
	 <COND (<VERB? EXAMINE TAKE SWIM THROUGH>
		<TAKE-LAVA>)
	       (<VERB? SMELL>
		<TELL ,SMELL-LAVA>)
	       (<AND <VERB? THROW PUT>
		     <HELD? ,PRSO>
		     <EQUAL? ,PRSI ,PSEUDO-OBJECT>>
		<INTO-LAVA>)
	       (<VERB? TAKE RUB>
		<TAKE-LAVA>)
	       (<VERB? TINSOT>
		<LAVA-COOLS>)>>

<ROUTINE INTO-LAVA ()
	 <REMOVE ,PRSO>
	 <TELL
"It disappears into the lava." CR>>

<ROOM VOLCANO-BASE
      (IN ROOMS)
      (DESC "Volcano Base")
      (ACTION VOLCANO-BASE-F)
      (FLAGS ONBIT RLANDBIT)
      (GLOBAL GLOBAL-ROCKS)
      (THINGS
       <PSEUDO (<> VOLCANO VOLCANO-PSEUDO)
	       (MOLTEN LAVA LAVA-PSEUDO)>)>

<ROUTINE VOLCANO-BASE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are partway up the base of an active volcano. All around you is a
stream of glowing, molten lava, bubbling and spitting. Clumps of red-hot
lava fly through the air, narrowly missing you. Your
vantage point is a small point of rock that hasn't been remelted by
the flow." CR>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<VERB? WALK>
		       <TELL
"The heat of the lava would cook you for sure!" CR>)
		      (<AND <VERB? SMELL> <NOT ,PRSO>>
		       <TELL ,SMELL-LAVA>)>)
	       (<EQUAL? .RARG ,M-ENTER>
		<COND (<NOT ,ROCK-ARRIVED?>
		       <SETG ROCK-ARRIVED? T>
		       <QUEUE I-ROCK-ARRIVES 2>)>)>>

<GLOBAL ROCK-ARRIVED?:FLAG <>>

<OBJECT LAVA-ROCK
	(DESC "lava fragment")
	(SYNONYM FRAGMENT)
	(ADJECTIVE LAVA)
	(FLAGS TAKEBIT TRYTAKEBIT RMUNGBIT)
	(ACTION LAVA-ROCK-F)>

<ROUTINE LAVA-ROCK-F ()
	 <COND (<OR <VERB? TINSOT>
		    <AND <VERB? POUR>
			 <EQUAL? ,PRSO ,LOCAL-WATER>>>
		<COND (<VERB? POUR>
		       <REMOVE ,LOCAL-WATER>)>
		<FSET ,LAVA-ROCK ,TOUCHBIT>
		<FCLEAR ,LAVA-ROCK ,RMUNGBIT>
		<THIS-IS-IT ,LAVA-ROCK>
		<TELL
"The fragment is cool enough to touch." CR>)
	       (<AND <VERB? EXAMINE>
		     <FSET? ,PRSO ,RMUNGBIT>>
		<TELL
"It's cooling slowly but is still too hot to touch safely." CR>)
	       (<VERB? SMELL>
		<TELL ,SMELL-LAVA>)
	       (<AND <VERB? TAKE RUB>
		     <FSET? ,PRSO ,RMUNGBIT>>
		<TAKE-LAVA>)>>

<ROUTINE TAKE-LAVA ()
	 <COND (,PRSI
		<COND (<OR <EQUAL? ,PRSI ,WEED ,SPELL-BOOK>
			   <EQUAL? ,PRSI ,DEAD-BOOK ,BREAD ,FISH>
			   <EQUAL? ,PRSI ,MAGIC-CARPET ,RANDOM-CARPET>
			   <FSET? ,PRSI ,SCROLLBIT>>
		       <REMOVE ,PRSI>
		       <TELL
CTHE ,PRSI " catches fire and burns to a crisp." CR>)
		      (ELSE
		       <TELL
CTHE ,PRSI " hisses and sizzles when you touch the lava with it." CR>)>)
	       (ELSE
		<TELL
"It's too hot to touch. You burn yourself slightly just getting near it."
		 CR>)>>

<ROOM OUTCROPPING-ROOM
      (IN ROOMS)
      (DESC "Outcropping")
      (ACTION OUTCROPPING-ROOM-F)
      (FLAGS RLANDBIT OUTSIDE ONBIT)
      (GLOBAL OUTCROPPING GLOBAL-ROCKS)
      (THINGS
       <PSEUDO (SOLID GROUND SOLID-GROUND-PSEUDO)
	       (<> VOLCANO VOLCANO-PSEUDO)
	       (MOLTEN LAVA LAVA-PSEUDO)
	       (<> MOUNTAIN VOLCANO-PSEUDO)>)>

<GLOBAL GOT-MAGIC-CUBE?:FLAG <>>

<ROUTINE OUTCROPPING-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are on a very small outcropping of some material that is
impervious to heat. All around you lava bubbles and steams, flowing down
the side of the mountain in a relentless stream. There is solid ground out
of reach to the east." CR>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<AND <VERB? TAKE>
			    <EQUAL? ,PRSO ,MAGIC-CUBE>
			    <NOT ,GOT-MAGIC-CUBE?>>
		       <SETG GOT-MAGIC-CUBE? T>
		       <SCORE-OBJECT>
		       <MOVE ,MAGIC-CUBE ,WINNER>
		       <TELL
"As you take the cube, you are nearly blinded by a blast of power. It
rolls out from the cube, up your arm and all over your body. Every hair
stands on end, every muscle is tense. You feel more powerful, as though
a weight had been lifted from your body and a veil drawn from before you.
The very stuff of magic crackles from your fingertips." CR>)
		      (<AND <VERB? SMELL> <NOT ,PRSO>>
		       <TELL ,SMELL-LAVA>)>)>>

<ROUTINE SOLID-GROUND-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL
"There is solid ground about twenty feet to the east, past a stream of
molten lava.">
		<CLEVER-CONTENTS ,VOLCANO-ROOM " On the ground">
		<CRLF>)
	       (<AND <VERB? THROW>
		     <HELD? ,PRSO>
		     <EQUAL? ,PRSI ,PSEUDO-OBJECT>>
		<MOVE ,PRSO ,VOLCANO-ROOM>
		<TELL
CTHE ,PRSO " sails smoothly through the broiling air and lands on the
ground to your east." CR>)
	       (<VERB? CLIMB-ON BOARD>
		<TELL ,TOO-FAR>)>>

<OBJECT OUTCROPPING
	(IN LOCAL-GLOBALS)
	(DESC "outcropping")
	(SYNONYM OUTCROPPING)
	(ADJECTIVE HARD SOLID)
	(FLAGS NDESCBIT AN SURFACEBIT OPENBIT CONTBIT)
	(ACTION OUTCROPPING-F)>

<ROUTINE OUTCROPPING-F ()
	 <COND (<EQUAL? ,HERE ,VOLCANO-ROOM>
		<COND (<VERB? EXAMINE LOOK-INSIDE>
		       <TELL
"The outcropping is made of some hard, heat-resistant substance. It sticks
up about three feet out of the lava about twenty feet from you. It has a
flat top about four feet across which is roughly square.">
		       <COND (<IN? ,MAGIC-CUBE ,OUTCROPPING-ROOM>
			      <TELL
" Sitting in the very center of the outcropping is something small, white,
and cubical.">)>
		       <CLEVER-CONTENTS ,OUTCROPPING-ROOM
					" On the top of the outcropping"
					,MAGIC-CUBE>
		       <CRLF>)
		      (<AND <VERB? PUT PUT-ON>
			    <EQUAL? ,PRSI ,OUTCROPPING>>
		       <TELL ,TOO-FAR>)
		      (<THROW-ONTO ,OUTCROPPING ,OUTCROPPING-ROOM>
		       <RTRUE>)
		      (<AND <VERB? THROW-OFF>
			    <HELD? ,PRSO>
			    <EQUAL? ,PRSI ,OUTCROPPING>>
		       <INTO-LAVA>)
		      (<VERB? THROUGH WALK-TO CLIMB-ON BOARD>
		       <TELL ,TOO-FAR>)>)
	       (ELSE
		<COND (<VERB? EXAMINE LOOK-INSIDE>
		       <TELL
"Now that you are on it, you can see that the outcropping is made
of some kind of volcanic glass that somehow was expelled from the volcano
and lodged here in the middle of the lava stream. It is an iceberg only
partly above the flow, stuck solidly in the channel through which the
lava flows." CR>)>)>>

<ROUTINE THROW-ONTO (OBJ RM)
	 <COND (<AND <VERB? THROW>
		     <HELD? ,PRSO>
		     <EQUAL? ,PRSI .OBJ>>
		<COND (<EQUAL? ,PRSO ,WATER ,LOCAL-WATER>
		       <INTO-LAVA>)
		      (ELSE
		       <MOVE ,PRSO .RM>
		       <TELL
CTHE ,PRSO " sails smoothly through the air, bounces on " THE ,PRSI
" and ends up perched on the very edge of the far side." CR>)>)>>

"DARK"

<OBJECT DARK-CUBE
	(IN OTHER-ROCK)
	(DESC "cube")
	(SYNONYM CUBE CUBES)
	(ADJECTIVE EQ ;C5 SMALL FEATURELESS WHITE)
	(NAME 0)
	(TEXT "grues")
	(FLAGS NDESCBIT TRYTAKEBIT TAKEBIT)
	(ACTION CUBE-F)
	(DESCFCN CUBE-DESC)
        (GENERIC GENERIC-CUBE-F)
	(CUBE DARK-ROOM)>

<ROOM DARK-ROOM
      (IN ROOMS)
      (DESC "Dark Room")
      (DOWN TO DARK-CAVE)
      (UP PER MAGIC-BOX-EXIT)
      (CUBE DARK-CUBE)
      (ACTION DARK-ROOM-F)
      (FLAGS RLANDBIT)>

<ROUTINE DARK-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This room is totally black, so black that you see nothing when you look
around it. All light is absorbed by the substance of
the place. You can tell it is physical, because you can feel your feet
touching the floor, but your eyes tell you nothing." CR>)
	       (<EQUAL? .RARG ,M-LEAVE>
		<RECOVER-CUBE>)>>

<ROOM DARK-CAVE
      (IN ROOMS)
      (DESC "Dark Cave")
      (DOWN TO GRUE-CAVE)
      (ACTION DARK-CAVE-F)
      (FLAGS RLANDBIT)
      (GLOBAL GLOBAL-CAVE)>

<ROUTINE DARK-CAVE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<COND (<EQUAL? ,CHANGED? ,GRUE>
		       <TELL
"This is a jumbled, rough cave with many small passages leading in and
out, and one large one leading down." CR>)
		      (ELSE
		       <TELL
"This is a large cave with a rough floor. You can tell little about the
surroundings, because your " 'FROTZ-SPELL " doesn't seem to be
working normally here and produces only a wan and sickly glow. The
light coming from ">
		       <TELL-LIGHT-SOURCE>
		       <TELL " has been reduced
to a thin, barely glowing stream of tiny blobs that drips, spurts
and sputters uselessly to the ground. There it collects into a small pile
which is slowly disappearing, perhaps by evaporation." CR>)>)
	       (<EQUAL? .RARG ,M-ENTER>
		<PUT <GETPT ,LIGHT ,P?SYNONYM> 2 ,W?PILE>)
	       (<EQUAL? .RARG ,M-LEAVE>
		<PUT <GETPT ,LIGHT ,P?SYNONYM> 2 ,W?LIGHTS>)>>

<ROUTINE TELL-LIGHT-SOURCE ()
	 <COND (<EQUAL? ,LIT ,WINNER>
		<TELL "you">)
	       (<EQUAL? ,LIT ,HERE>
		<TELL "here">)
	       (ELSE
		<TELL THE ,LIT>)>>

<ROOM GRUE-CAVE
      (IN ROOMS)
      (DESC "Grue Cave")
      (UP TO DARK-CAVE)
      (IN TO LIGHT-POOL)
      (DOWN TO LIGHT-POOL)
      (ACTION GRUE-CAVE-F)
      (FLAGS RLANDBIT)
      (GLOBAL GRUE GLOBAL-CAVE PILLAR)
      (THINGS <PSEUDO (LIGHT POOL POOL-PSEUDO)>)>

<ROUTINE POOL-PSEUDO ()
	 <COND (<VERB? THROUGH BOARD> <DO-WALK ,P?DOWN>)
	       (<VERB? EXAMINE> <PERFORM ,V?LOOK> <RTRUE>)
	       (<AND <VERB? THROW DROP>
		     <EQUAL? ,PRSI ,PSEUDO-OBJECT>>
		<COND (<IDROP>
		       <MOVE ,PRSO ,LIGHT-POOL>
		       <COND (<VERB? THROW> <TELL "Thrown">)
			     (ELSE <TELL "Dropped">)>
		       <TELL ,PERIOD>)
		      (ELSE <RTRUE>)>)>>

<ROUTINE GRUE-CAVE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<COND (<EQUAL? ,CHANGED? ,GRUE>
		       <TELL
"A natural amphitheater carved out of the underground rock opens from
several small passages. The cave is crowded with grues of all shapes and
sizes. At the lowest point of the cave a small pool of light has gathered,
glowing very dimly (from a human point of view).
The grues avoid it, and in fact it hurts your eyes to look at it for very
long. In the middle of the pool is a short, squat pillar">
		       <COND (<FIRST? ,PILLAR-ROOM>
			      <THIS-IS-IT ,FIRE-CUBE>
			      <TELL " with something
on top of it. This is the object of all the attention. The grues
seem to regard the pillar or its contents with awe">)>
		       <TELL ,PERIOD>)
		      (ELSE
		       <TELL
"This is a large underground chamber filled with nightmarish, barely
visible shapes. There is very dim light issuing from somewhere near the
center of the room." CR>)>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<AND <NOT <EQUAL? ,CHANGED? ,GRUE>>
			    <VERB? WALK TELL HELLO BOARD>>
		       <DEQUEUE I-GRUES-NOTICE>
		       <I-GRUES-NOTICE T>
		       <RTRUE>)>)
	       (<EQUAL? .RARG ,M-ENTER>
		<PUT <GETPT ,LIGHT ,P?SYNONYM> 2 ,W?PILE>
		<COND (<NOT <EQUAL? ,CHANGED? ,GRUE>>
		       <COND (<NOT <EQUAL? ,OHERE ,DARK-CAVE>>
			      <QUEUE I-GRUES-NOTICE 1>
			      <RFALSE>)>
		       <QUEUE I-GRUES-NOTICE 2>
		       <COND (<NOT ,LIT>
			      <TELL
"You stumble blindly down a short passage which opens into what feels like
a larger area." CR CR>)
			     (<NOT <EQUAL? ,LIT ,GRUE>>
			      <TELL
"You make your way carefully in the almost non-existent light down to an
area filled with dim shapes. They move about purposefully, making horrible
gurgling noises. The floor is rough and jumbled near the walls, so you
haven't been noticed yet." CR CR>)>)>)
	       (<EQUAL? .RARG ,M-LEAVE>
		<PUT <GETPT ,LIGHT ,P?SYNONYM> 2 ,W?LIGHTS>)>>

<ROOM LIGHT-POOL
      (IN ROOMS)
      (DESC "Light Pool")
      (OUT TO GRUE-CAVE)
      (UP TO GRUE-CAVE)
      (ACTION LIGHT-POOL-F)
      (FLAGS RLANDBIT)
      (GLOBAL PILLAR GRUE GLOBAL-CAVE)
      (THINGS <PSEUDO (LIGHT POOL POOL-PSEUDO)>)>

<ROUTINE LIGHT-POOL-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a small pool or pond of light, very dim by human standards, but
painful for a grue to even look at. In the center of the pool is a pillar
which sticks up out of the light." CR>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<AND <VERB? DISEMBARK>
			    <EQUAL? ,PRSO <> ,ROOMS ,PSEUDO-OBJECT>>
		       <DO-WALK ,P?OUT>)>)
	       (<EQUAL? .RARG ,M-ENTER>
		<PUT <GETPT ,LIGHT ,P?SYNONYM> 2 ,W?PILE>
		<QUEUE I-FRIED-GRUE 2>
		<TELL
"You enter the pool, which is composed of the accumulated dribbles of light
that have made their way to this uttermost bottom of a dark dimension. The
light tickles">
		<COND (<EQUAL? ,CHANGED? ,GRUE>
		       <TELL " at first, but then it begins to burn and your eyes are
hurting severely">)>
		<TELL ,PERIOD CR>)
	       (<EQUAL? .RARG ,M-LEAVE>
		<PUT <GETPT ,LIGHT ,P?SYNONYM> 2 ,W?LIGHTS>)>>

<ROOM PILLAR-ROOM
      (IN ROOMS)
      (DESC "On Pillar")
      (DOWN TO LIGHT-POOL)
      (ACTION PILLAR-ROOM-F)
      (FLAGS RLANDBIT)
      (GLOBAL PILLAR GRUE GLOBAL-CAVE)
      (THINGS <PSEUDO (LIGHT POOL POOL-PSEUDO)>)>

<ROUTINE PILLAR-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are on top of a short marble pillar surrounded by a pool of ">
		<COND (<EQUAL? ,CHANGED? ,GRUE>
		       <TELL
"light. Squinting through the intolerable glare, you can see
that the other grues are staring at you with a mixture of amazement and
fear." CR>)
		      (ELSE
		       <TELL
"almost imperceptible light. You can barely see dim shapes capering in
the dark." CR>)>)
	       (<EQUAL? .RARG ,M-ENTER>
		<PUT <GETPT ,LIGHT ,P?SYNONYM> 2 ,W?PILE>)
	       (<EQUAL? .RARG ,M-LEAVE>
		<PUT <GETPT ,LIGHT ,P?SYNONYM> 2 ,W?LIGHTS>)>>

<OBJECT PILLAR
	(IN LOCAL-GLOBALS)
	(DESC "pillar")
	(SYNONYM PILLAR GLYPHS)
	(ADJECTIVE MARBLE ERODED STUMP)
	(FLAGS NDESCBIT SURFACEBIT READBIT)
	(ACTION PILLAR-F)
	(TEXT "The only readable ones say \"D.L. 1985.\"")>

<ROUTINE PILLAR-F ("AUX" (IGNORE? <>))
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<TELL
"This is the stump of a marble pillar covered with eroded glyphs. It
barely projects out of the pool of light. The grues seem awed by it.">
		<COND (<AND <IN? ,FIRE-CUBE ,PILLAR-ROOM>
			    <NOT <EQUAL? ,HERE ,PILLAR-ROOM>>>
		       <SET IGNORE? ,FIRE-CUBE>
		       <COND (<EQUAL? ,HERE ,LIGHT-POOL>
			      <TELL
" You can't see the top of the pillar from here.">)
			     (ELSE
			      <TELL
" There is something small and white on the pillar.">
			      <CLEVER-CONTENTS ,PILLAR-ROOM
					       " On top of the pillar"
					       .IGNORE?>)>)>
		<CRLF>)
	       (<THROW-ONTO ,PILLAR ,PILLAR-ROOM>
		<RTRUE>)
	       (<VERB? CLIMB-ON CLIMB-UP CLIMB-FOO BOARD>
		<COND (<EQUAL? ,HERE ,GRUE-CAVE>
		       <TELL
"It's in the pool, out of reach from here." CR>)
		      (<EQUAL? ,HERE ,LIGHT-POOL>
		       <GOTO ,PILLAR-ROOM>)
		      (<EQUAL? ,HERE ,PILLAR-ROOM>
		       <TELL
"It doesn't go any higher, and you're on it already." CR>)>)
	       (<VERB? DISEMBARK CLIMB-DOWN>
		<COND (<EQUAL? ,HERE ,LIGHT-POOL ,GRUE-CAVE>
		       <TELL
,YOU-ARENT "on it yet." CR>)
		      (<EQUAL? ,HERE ,PILLAR-ROOM>
		       <GOTO ,LIGHT-POOL>)>)>>

"MIND"

<OBJECT MIND-CUBE
	(IN MAZE-1)
	(DESC "cube")
	(SYNONYM CUBE CUBES)
	(ADJECTIVE FQ ;C6 SMALL FEATURELESS WHITE)
	(NAME 0)
	(TEXT "owls")
	(FLAGS TAKEBIT)
	(ACTION CUBE-F)
	(DESCFCN CUBE-DESC)
        (GENERIC GENERIC-CUBE-F)
	(CUBE MIND-ROOM)>

<ROOM MIND-ROOM
      (IN ROOMS)
      (DESC "No Place")
      (EAST PER SCALES-ROOM-EXIT)
      (SOUTH PER PLAIN-ROOM-EXIT)
      (WEST PER MIND-BOX-EXIT)
      (CUBE MIND-CUBE)
      (ACTION MIND-ROOM-F)
      (FLAGS RLANDBIT)>

<ROUTINE SCALES-ROOM-EXIT ()
	 <TELL
"You slowly drift \"eastward,\" and the nothing attenuates. Something
begins to break through the nothing." CR CR>
	 ,INNER-VAULT>

<ROUTINE PLAIN-ROOM-EXIT ()
	 <TELL
"Your mind starts to wander \"southward,\" and slowly something impinges
itself on your mind." CR CR>
	 ,PLAIN-ROOM>

<ROUTINE MIND-BOX-EXIT ()
	 <COND (<AND <IN? <LOC ,MAGIC-BOX> ,ROOMS>
		     <EQUAL? <GETP ,HERE ,P?CUBE> ,MAGIC-BOX-CUBE>>
		<TELL
"Your mind drifts \"westward,\" and slowly something surrounds your mind."
CR CR>
		<LOC ,MAGIC-BOX>)
	       (ELSE
		<TELL
"Oddly, although your mind is drawn in that direction, no act of will
helps in going that way." CR>
		<RFALSE>)>>

<ROUTINE MIND-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
,THERE-IS-NOTHING "here. You are here, but there is no here where you are.
You see nothing. Your senses are vainly trying to find something, anything
to work on. You can know your body is there, but you can't truly sense it
to confirm the suspicion. Your mind is alternately drawn in three
\"directions\"
(or at least what seem like directions): east, west and south. There is something
slightly different about the nothing in those directions." CR>)
	       (<EQUAL? .RARG ,M-LEAVE>
		<RECOVER-CUBE>)>>

<ROOM INNER-VAULT
      (IN ROOMS)
      (DESC "Inner Vault")
      (OUT TO SCALES-ROOM IF VAULT-DOOR IS OPEN)
      (NORTH TO SCALES-ROOM IF VAULT-DOOR IS OPEN)
      (FLAGS RLANDBIT)
      (ACTION INNER-VAULT-F)
      (GLOBAL VAULT-DOOR)
      (THINGS <PSEUDO (<> COINS FAKE-PSEUDO)
		      (RARE PAINTINGS FAKE-PSEUDO)
		      (STACKS PAINTINGS FAKE-PSEUDO)
		      (ORNAMENTED GLASSWARE FAKE-PSEUDO)>)>

<ROUTINE FAKE-PSEUDO ()
	 <REDIRECT ,PSEUDO-OBJECT ,TREASURE>>

<ROUTINE INNER-VAULT-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a bare concrete chamber that looks like the inside of a vault.">
		<COND (<IN? ,TREASURE ,HERE>
		       <TELL
" The room is filled with unimaginable treasure. Gold and jewels are
strewn everywhere. Coffers burst with coins, and stacks of rare
paintings lean against the walls. Beautifully ornamented vases and
glassware are carelessly stacked in corners.">)>
		<TELL " There is a door on the
north side of the room whose lock mechanism is visible. ">
		<DESCRIBE-VAULT-DOOR>)
	       (<EQUAL? .RARG ,M-LEAVE>
		<COND (<VERB? BLORPLE> <MAKE-JUNK>)>)>>

<OBJECT VAULT-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "vault door")
	(SYNONYM DOOR MECHANISM)
	(ADJECTIVE STEEL VAULT)
	(FLAGS DOORBIT)
	(ACTION VAULT-DOOR-F)>

<ROUTINE VAULT-DOOR-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"This is a steel door. It is thick and heavy, like the door
to a bank vault. ">
		<COND (<EQUAL? ,HERE ,INNER-VAULT>
		       <TELL
"It is covered with complicated mechanisms which
look like they are part of a timing or locking device. ">)>
		<DESCRIBE-VAULT-DOOR>)
	       (<AND <VERB? OPEN UNLOCK>
		     <NOT <FSET? ,PRSO ,OPENBIT>>>
		<TELL "You can see no way to open "> <THE-PRSO>)
	       (<VERB? THROUGH>
		<DO-WALK <COND (<EQUAL? ,HERE ,SCALES-ROOM> ,P?SOUTH)
			       (ELSE ,P?NORTH)>>)
	       (<VERB? REZROV>
		<COND (<FSET? ,VAULT-DOOR ,OPENBIT>
		       <TELL-OPEN-CLOSED ,VAULT-DOOR>)
		      (<HELD? ,MAGIC-CUBE>
		       <FCLEAR ,VAULT-DOOR ,LOCKED>
		       <FSET ,VAULT-DOOR ,OPENBIT>
		       <COND (<EQUAL? ,HERE ,INNER-VAULT>
			      <TELL
"The mechanisms whirr madly">)
			     (ELSE
			      <TELL
"You hear strange noises">)>
		       <TELL " for a few moments, and then the door swings
ponderously open." CR>)
		      (ELSE
		       <REZROV-TOUGH-DOOR>)>)>>

<ROUTINE REZROV-TOUGH-DOOR ()
	 <COND (<EQUAL? ,HERE ,INNER-VAULT>
		<TELL
"The mechanisms try vainly to turn,">)
	       (ELSE
		<TELL
"The door strains and creaks,">)>
	 <TELL " but your spell is just not powerful enough." CR>>

<ROUTINE DESCRIBE-VAULT-DOOR ()
	 <TELL "The door is ">
	 <COND (<FSET? ,VAULT-DOOR ,OPENBIT>
		<TELL
"open, and beyond you can see ">
		<COND (<EQUAL? ,HERE ,SCALES-ROOM>
		       <TELL "a treasure chamber">)
		      (ELSE
		       <TELL "the outer vault">)>)
	       (ELSE
		<TELL
"closed and locked">)>
	 <TELL ,PERIOD>>

<ROOM SCALES-ROOM
      (IN ROOMS)
      (DESC "Outer Vault")
      (OUT PER IRON-DOOR-EXIT)
      (NORTH PER IRON-DOOR-EXIT)
      (SOUTH TO INNER-VAULT IF VAULT-DOOR IS OPEN)
      (FLAGS RLANDBIT)
      (ACTION SCALES-ROOM-F)
      (GLOBAL IRON-DOOR VAULT-DOOR)
      (THINGS <PSEUDO (BURLY GUARDS CASTLE-GUARDS-PSEUDO)>)>

<ROUTINE CASTLE-GUARDS-PSEUDO ()
	 <COND (<OR <AND <EQUAL? ,HERE ,SCALES-ROOM ,INNER-VAULT>
			 <ZERO? ,GUARDS-FLAG>>
		    <AND <EQUAL? ,HERE ,PAST-CELL-EAST>
			 <NOT <FSET? ,CELL-DOOR ,OPENBIT>>>>
		<TELL "What guards?" CR>)
	       (<VERB? EXAMINE>
		<TELL
"The guards are no doubt burly, thuggish and nasty." CR>)
	       (<SPELL-VERB?>
		<TELL
"\"A wise guy, eh?\" The guards burst in and dispatch you before you
can finish the spell." CR CR>
		<TIME-SICK-CELL-EAST>)>>

<ROUTINE IRON-DOOR-EXIT ()
	 <COND (<FSET? ,IRON-DOOR ,OPENBIT>
		<TELL
"You poke your head out the door. ">
		<COND (<EQUAL? ,GUARDS-FLAG 1>
		       <TELL
"You see, directly in front of you, five burly guards who look like they
want to discuss something with you." CR>)
		      (ELSE
		       <TELL
"You see a long, gloomy corridor down which
five burly guards are coming." CR>)>)
	       (ELSE
		<THIS-IS-IT ,IRON-DOOR>
		<TELL-OPEN-CLOSED ,IRON-DOOR>)>
	 <RFALSE>>

<OBJECT IRON-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "iron door")
	(SYNONYM DOOR)
	(ADJECTIVE IRON NORTH)
	(FLAGS DOORBIT LOCKED)
	(ACTION IRON-DOOR-F)>

<ROUTINE IRON-DOOR-F ()
	 <COND (<AND <VERB? UNLOCK OPEN>
		     <NOT <FSET? ,IRON-DOOR ,OPENBIT>>>
		<TELL
"The lock is beyond your ability to unlock or pick." CR>)
	       (<VERB? THROUGH>
		<DO-WALK ,P?NORTH>)>>

<GLOBAL SPELLS-USED:FLAG 0>

<ROUTINE SCALES-ROOM-F (RARG "AUX" P1 P2)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are in a large, bare concrete room.">
		<COND (<AND <FIRST? ,PILE-1> <FIRST? ,PILE-2>>
		       <TELL
" There are two piles on the floor. The first contains ">
		       <PILE-LOOP ,PILE-1>
		       <TELL ". The second contains ">
		       <PILE-LOOP ,PILE-2>
		       <TELL ".">)
		      (<FIRST? ,PILE-1>
		       <TELL-PILE ,PILE-1 ,PILE-2>)
		      (<FIRST? ,PILE-2>
		       <TELL-PILE ,PILE-2 ,PILE-1>)>
		<TELL
" An exit is to the north. It is ">
		<COND (<FSET? ,IRON-DOOR ,OPENBIT>
		       <TELL "an open">)
		      (ELSE
		       <TELL "a closed">)>
		<TELL " iron door. To the south is the inner vault. Its
steel door is ">
		<COND (<FSET? ,VAULT-DOOR ,OPENBIT>
		       <TELL "open">)
		      (ELSE
		       <TELL "closed">)>
		<COND (<IN? ,ALARM-FAIRY ,HERE>
		       <TELL
". An agitated alarm fairy flits about near the ceiling">)>
		<TELL ,PERIOD>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<VERB? SAVE>
		       <TELL "That spell doesn't work here." CR>)>)
	       (<EQUAL? .RARG ,M-ENTER>
		<COND (<EQUAL? ,OHERE ,INNER-VAULT>
		       <COND (<HELD? ,TREASURE>
			      <USE-SPELL>)>
		       <FCLEAR ,VAULT-DOOR ,OPENBIT>
		       <TELL
"As you enter the outer vault, the vault door swings inexorably shut." CR CR>)>
		<COND (,TREASURY-GUARDED?
		       <JIGS-UP
"A group of burly guards has been stationed permanently in the treasury
now. They are surprised but happy to see you, dedicated professionals
that they are.">)
		      (ELSE
		       <JUGGLE-CUBES>
		       <SETG USED-JINDAK? <>>
		       <COND (<PROB 50>
			      <SETG REAL-VALUE 3>
			      <SETG FAKE-VALUE 2>)
			     (ELSE
			      <SETG REAL-VALUE 2>
			      <SETG FAKE-VALUE 3>)>)>)
	       (<EQUAL? .RARG ,M-LEAVE>
		<CUBES-TO-PILES>
		<COND (,TIME-CUBE-SCORE?
		       <SETG TREASURY-GUARDED? T>)>
		<COND (<VERB? BLORPLE>
		       <MAKE-JUNK>)>)>>

<GLOBAL FAKE-CUBE-LIST:TABLE
	<LTABLE 0
		CUBE-1 CUBE-2 CUBE-3 CUBE-4 CUBE-5 CUBE-6
		CUBE-7 CUBE-8 CUBE-9 CUBE-10 CUBE-11 TIME-CUBE>>

<ROUTINE INITIALIZE-CUBES ("AUX" (CNT 1) L BUF)
	 <SET L ,FAKE-CUBE-LIST>
	 <SET BUF ,P-QBUF>
	 <REPEAT ()
		 <COND (<IGRTR? CNT 13> <RETURN>)>
		 <PUTP <GET .L .CNT> ,P?NAME .BUF>
		 <SET BUF <REST .BUF 10>>>
	 <PUT .BUF 0 0>
	 <SETG P-QNEXT .BUF>>

<ROUTINE CUBES-TO-PILES ("AUX" L)
	 <SET L ,FAKE-CUBE-LIST>
	 <DO (CNT 2 13)
	     <MOVE <GET .L .CNT> ,PILE-1>>
	 <COND (<EQUAL? ,TIME-CUBE ,BLORPLE-OBJECT>
		<REMOVE ,TIME-CUBE>
		<COND (<NOT ,TIME-CUBE-SCORE?>
		       <SETG TIME-CUBE-SCORE? T>
		       <FCLEAR ,TIME-CUBE ,TOUCHBIT>
		       <SCORE-OBJECT ,TIME-CUBE>)>)>
	 <COND (<AND ,BLORPLE-OBJECT
		     <LOC ,BLORPLE-OBJECT>>
		<SETG BLORPLE-OBJECT <>>)>>

<GLOBAL TIME-CUBE-SCORE?:FLAG <>>

<ROUTINE JUGGLE-CUBES ("AUX" BUF (P1 0) (P2 0) Q)
	 <ROB ,PILE-1 ,SCALES-ROOM>
	 <ROB ,PILE-2 ,SCALES-ROOM>
	 <DO (CNT 2 13)
	     <SET Q <PICK-ONE ,FAKE-CUBE-LIST>>
	     <FSET .Q ,NDESCBIT>
	     <COND (<OR <EQUAL? .P2 6>
			<AND <L? .P1 6> <PROB 50>>>
		    <SET P1 <+ .P1 1>>
		    <MOVE .Q ,PILE-1>)
		   (ELSE
		    <MOVE .Q ,PILE-2>
		    <SET P2 <+ .P2 1>>)>>
	 <SET BUF ,P-QBUF>
	 <MAP-CONTENTS (Q ,PILE-1)
		       <PUTP .Q ,P?NAME .BUF>
		       <PUT .BUF 0 <CUBE-ADJ .Q>>
		       <SET BUF <REST .BUF 10>>>
	 <MAP-CONTENTS (Q ,PILE-2)
		       <PUTP .Q ,P?NAME .BUF>
		       <PUT .BUF 0 <CUBE-ADJ .Q>>
		       <SET BUF <REST .BUF 10>>>
	 <RTRUE>>

<ROUTINE TELL-PILE (PILE OTHER)
	 <TELL
" There is a pile of things on the floor, containing ">
	 <PILE-LOOP .PILE>
	 <TELL
". There is an empty spot where " THE .OTHER " was.">>

<OBJECT TREASURE
	(IN INNER-VAULT)
	(SYNONYM TREASURE GOLD JEWELS VASES)
	(ADJECTIVE RICH ORNAMENTED)
	(DESC "treasure")
	(FLAGS TAKEBIT TRYTAKEBIT NDESCBIT)
	(ACTION TREASURE-F)>

<ROUTINE TREASURE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"On closer examination, the treasure is even richer than you thought." CR>)
	       (<VERB? DROP>
		<COND (<EQUAL? ,HERE ,INNER-VAULT>
		       <FSET ,TREASURE ,NDESCBIT>)>
		<RFALSE>)>>

<ROUTINE MAKE-JUNK ()
	 <FCLEAR ,VAULT-DOOR ,OPENBIT>
	 <COND (<HELD? ,TREASURE>
		<MOVE ,JUNK <LOC ,TREASURE>>
		<FSET ,TREASURE ,NDESCBIT>
		<MOVE ,TREASURE ,INNER-VAULT>)>>

<OBJECT JUNK
	(SYNONYM JUNK PASTE GILT LEAD)
	(ADJECTIVE PILE)
	(DESC "pile of junk")
	(FLAGS TAKEBIT TRYTAKEBIT)
	(ACTION JUNK-F)>

<ROUTINE JUNK-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The treasure consists of paste jewels, badly crafted gilt vessels and
lead coins." CR>)
	       (<AND <VERB? DROP>
		     <EQUAL? ,HERE ,INNER-VAULT>>
		<COND (<IDROP>
		       <REMOVE ,JUNK>
		       <MOVE ,TREASURE ,HERE>
		       <TELL "The junk looks valuable again." CR>)
		      (ELSE <RTRUE>)>)>>

<GLOBAL IS-GLOWING:STRING " is glowing with a faint blue glow.">

<ROUTINE MEASURE (OBJ "AUX" F (CNT 0))
	 <MAP-CONTENTS (F .OBJ)
		       (<RETURN .CNT>)
		       <COND (<GETP .F ,P?CUBE> ;"REAL CUBE"
			      <SET CNT <+ .CNT ,REAL-VALUE>>)
			     (<GETPT .F ,P?NAME> ;"FAKE CUBE"
			      <SET CNT <+ .CNT ,FAKE-VALUE>>)
			     (<OR <FSET? .F ,MAGICBIT>
				  <FSET? .F ,SCROLLBIT>>
			      <SET CNT <+ .CNT 1>>)>>>

<GLOBAL REAL-VALUE:NUMBER 3>
<GLOBAL FAKE-VALUE:NUMBER 2>

<OBJECT ALARM-FAIRY
	(DESC "alarm fairy")
	(SYNONYM FAIRY)
	(ADJECTIVE ALARM)
	(FLAGS THE PERSON NDESCBIT AN)
	(ACTION ALARM-FAIRY-F)>

<ROUTINE ALARM-FAIRY-F ()
	 <COND (<EQUAL? ,WINNER ,ALARM-FAIRY>
		<TELL
"\"Go away, thief! Just wait 'til the guards come! You'll be sorry!\"" CR>)
	       (<VERB? EXAMINE KISS>
		<TELL
"The alarm fairy is small, winged and very obnoxious. It flies near the
ceiling, out of reach, and jeers at you." CR>)
	       (<VERB? ESPNIS>
		<TELL
"It thumbs its nose at you. \"I never sleep!\" it jeers." CR>)
	       (<VERB? YOMIN>
		<TELL
"You sense a mixture of spitefulness and pleasurable anticipation." CR>)
	       (<VERB? SNAVIG>
		<TELL
"It's too small." CR>)
	       (<HOSTILE-VERB?>
		<TELL
"\"Missed me! Missed me! Now you have to kiss me!\" It plants a smooch
on your cheek." CR>)>>

<GLOBAL GUARDS-FLAG:NUMBER 0>
<GLOBAL TREASURY-GUARDED?:FLAG <>>

<OBJECT PILE-1
	(IN SCALES-ROOM)
	(DESC "first pile")
	(SYNONYM PILE PILES)
	(ADJECTIVE FIRST)
	(FLAGS NDESCBIT OPENBIT TRANSBIT CONTBIT SEARCHBIT)
	(CAPACITY 200)
	(GENERIC GENERIC-RANDOM-F)
	(ACTION PILE-F)>

<OBJECT PILE-2
	(IN SCALES-ROOM)
	(DESC "second pile")
	(SYNONYM PILE PILES)
	(ADJECTIVE SECOND)
	(FLAGS NDESCBIT OPENBIT TRANSBIT CONTBIT SEARCHBIT)
	(CAPACITY 200)
	(GENERIC GENERIC-RANDOM-F)
	(ACTION PILE-F)>

<GLOBAL WHITE-CUBE:STRING "featureless white cube">

<ROUTINE PILE-LOOP (OBJ "AUX" F N (1ST? T) (CNT 0) CUBE?)
	 <MAP-CONTENTS (F N .OBJ)
		       (END <COND (<G? .CNT 0>
				   <COND (<NOT .1ST?>
					  <TELL " and ">)>
				   <TELL N .CNT " " ,WHITE-CUBE>
				   <COND (<G? .CNT 1> <TELL "s">)>)>)
		       <SET CUBE? <GETPT .F ,P?NAME>>
		       <COND (<OR <NOT .CUBE?> ;"not a cube?"
				  <NOT <ZERO? <GETP .F ,P?NAME>>>>
			      <COND (<NOT .1ST?>
				     <COND (<AND <NOT .N> <ZERO? .CNT>>
					    <TELL " and ">)
					   (ELSE <TELL ", ">)>)
				    (T <SET 1ST? <>>)>
			      <COND (<NOT <GETPT .F ,P?NAME>>
				     <TELL A .F>)
				    (ELSE
				     <TELL THE .F>)>)
			     (ELSE <SET CNT <+ .CNT 1>>)>>
	 >

<ROUTINE PILE-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<FIRST? ,PRSO>
		       <TELL
"The pile contains ">
		       <PILE-LOOP ,PRSO>)
		      (ELSE
		       <TELL "Its spot is empty">)>
		<TELL ,PERIOD>)
	       (<AND <VERB? COUNT>
		     <NOT <ZERO? <GETPT ,PRSO ,P?NAME>>>
		     <EQUAL? ,PRSI ,PILE-1 ,PILE-2>>
		<TELL CTHE ,PRSI " holds ">
		<TELL-CUBE-COUNT ,PRSI>)
	       (<VERB? CUT>
		<TELL
,MORE-SPECIFIC " about individual items to take, drop,
etc." CR>)
	       (<VERB? PUT>
		<COND (<EQUAL? ,PRSI ,PILE-1 ,PILE-2>
		       <COND (<AND <NOT <HELD? ,PRSO>>
				   <EQUAL? <ITAKE> ,M-FATAL <>>>
			      <RTRUE>)
			     (<EQUAL? ,PRSO
				      ,MAGIC-CARPET ,RANDOM-CARPET ,ZIPPER>
			      <MOVE ,PRSO ,HERE>
			      <TELL
"You put it on the floor near " THE ,PRSI ,PERIOD>)
			     (ELSE
			      <MOVE ,PRSO ,PRSI>
			      <FSET ,PRSO ,TOUCHBIT>
			      <FSET ,PRSO ,NDESCBIT>
			      <TELL "Done." CR>)>)>)
	       (<VERB? PUT-ON>
		<PERFORM ,V?PUT ,PRSO ,PRSI>
		<RTRUE>)>>

<OBJECT CUBE-1
	(IN PILE-1)
	(DESC "cube")
	(SYNONYM CUBE CUBES)
	(ADJECTIVE AZ ;F1 SMALL WHITE)
	(NAME 0)
	(FLAGS TAKEBIT NDESCBIT THE)
	(DESCFCN CUBE-DESC)
        (GENERIC GENERIC-CUBE-F)
	(ACTION CUBE-F)>

<OBJECT CUBE-2
	(IN PILE-1)
	(DESC "cube")
	(SYNONYM CUBE CUBES)
	(ADJECTIVE BZ ;F2 SMALL WHITE)
	(NAME 0)
	(FLAGS TAKEBIT NDESCBIT THE)
	(DESCFCN CUBE-DESC)
        (GENERIC GENERIC-CUBE-F)
	(ACTION CUBE-F)>

<OBJECT CUBE-3
	(IN PILE-1)
	(DESC "cube")
	(SYNONYM CUBE CUBES)
	(ADJECTIVE CZ ;F3 SMALL WHITE)
	(NAME 0)
	(FLAGS TAKEBIT NDESCBIT THE)
	(DESCFCN CUBE-DESC)
        (GENERIC GENERIC-CUBE-F)
	(ACTION CUBE-F)>

<OBJECT CUBE-4
	(IN PILE-1)
	(DESC "cube")
	(SYNONYM CUBE CUBES)
	(ADJECTIVE DZ ;F4 SMALL WHITE)
	(NAME 0)
	(FLAGS TAKEBIT NDESCBIT THE)
	(DESCFCN CUBE-DESC)
        (GENERIC GENERIC-CUBE-F)
	(ACTION CUBE-F)>

<OBJECT CUBE-5
	(IN PILE-1)
	(DESC "cube")
	(SYNONYM CUBE CUBES)
	(ADJECTIVE EZ ;F5 SMALL WHITE)
	(NAME 0)
	(FLAGS TAKEBIT NDESCBIT THE)
	(DESCFCN CUBE-DESC)
        (GENERIC GENERIC-CUBE-F)
	(ACTION CUBE-F)>

<OBJECT CUBE-6
	(IN PILE-1)
	(DESC "cube")
	(SYNONYM CUBE CUBES)
	(ADJECTIVE FZ ;F6 SMALL WHITE)
	(NAME 0)
	(FLAGS TAKEBIT NDESCBIT THE)
	(DESCFCN CUBE-DESC)
        (GENERIC GENERIC-CUBE-F)
	(ACTION CUBE-F)>

<OBJECT CUBE-7
	(IN PILE-2)
	(DESC "cube")
	(SYNONYM CUBE CUBES)
	(ADJECTIVE GZ ;F7 SMALL WHITE)
	(NAME 0)
	(FLAGS TAKEBIT NDESCBIT THE)
	(DESCFCN CUBE-DESC)
        (GENERIC GENERIC-CUBE-F)
	(ACTION CUBE-F)>

<OBJECT CUBE-8
	(IN PILE-2)
	(DESC "cube")
	(SYNONYM CUBE CUBES)
	(ADJECTIVE HZ ;F8 SMALL WHITE)
	(NAME 0)
	(FLAGS TAKEBIT NDESCBIT THE)
	(DESCFCN CUBE-DESC)
        (GENERIC GENERIC-CUBE-F)
	(ACTION CUBE-F)>

<OBJECT CUBE-9
	(IN PILE-2)
	(DESC "cube")
	(SYNONYM CUBE CUBES)
	(ADJECTIVE IZ ;F9 SMALL WHITE)
	(NAME 0)
	(FLAGS TAKEBIT NDESCBIT THE)
	(DESCFCN CUBE-DESC)
        (GENERIC GENERIC-CUBE-F)
	(ACTION CUBE-F)>

<OBJECT CUBE-10
	(IN PILE-2)
	(DESC "cube")
	(SYNONYM CUBE CUBES)
	(ADJECTIVE JZ ;F10 SMALL WHITE)
	(NAME 0)
	(FLAGS TAKEBIT NDESCBIT THE)
	(DESCFCN CUBE-DESC)
        (GENERIC GENERIC-CUBE-F)
	(ACTION CUBE-F)>

<OBJECT CUBE-11
	(IN PILE-2)
	(DESC "cube")
	(SYNONYM CUBE CUBES)
	(ADJECTIVE KZ ;F11 SMALL WHITE)
	(NAME 0)
	(FLAGS TAKEBIT NDESCBIT THE)
	(DESCFCN CUBE-DESC)
        (GENERIC GENERIC-CUBE-F)
	(ACTION CUBE-F)>

<ROUTINE CUBE-DESC (RARG OBJ)
	 <TELL
"A white cube">
	 <COND (<NOT <ZERO? <GETP .OBJ ,P?NAME>>>
		<TELL " labelled ">
		<CUBE-NAME .OBJ>)>
	 <TELL " is here." CR>>

<ROUTINE CUBE-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<NOT <ZERO? <GETP ,PRSO ,P?NAME>>>
		       <TELL
"This is a white cube with the word "> <CUBE-NAME ,PRSO> <TELL " written
on it." CR>)
		      (ELSE
		       <TELL
"This is a " ,WHITE-CUBE ,PERIOD>)>)
	       (<AND <VERB? COMPARE>
		     <NOT <EQUAL? ,PRSO ,PRSI>>
		     <GETPT ,PRSO ,P?NAME>
		     <GETPT ,PRSI ,P?NAME>>
		<TELL
"Structurally, they are identical.">
		<COND (<GETP ,PRSO ,P?NAME>
		       <TELL " One has ">
		       <CUBE-NAME ,PRSO>
		       <TELL " written on it.">)>
		<COND (<GETP ,PRSI ,P?NAME>
		       <TELL " One has ">
		       <CUBE-NAME ,PRSI>
		       <TELL " written on it.">)>
		<CRLF>)
	       (<VERB? WRITE>
		<COND (<EQUAL? ,PRSO ,QWORD>
		       <COND (<AND ,PRSI <NOT <HELD? ,PRSI>>>
			      <TELL
"You must have " THE ,PRSI " to write on it." CR>)
			     (<KNOWN-NAME? ,P-QWORD>
			      <TELL
"Strangely, your efforts leave " THE ,PRSI " unchanged." CR>)
			     (<NOT <ZERO? <GETP ,PRSI ,P?NAME>>>
			      <TELL "You replace the word ">
			      <CUBE-NAME ,PRSI>
			      <TELL " with the word ">
			      <WRITE-ON-CUBE ,PRSI>
			      <CUBE-NAME ,PRSI>
			      <TELL ,PERIOD>)
			     (<WRITE-ON-CUBE ,PRSI>
			      <TELL "The word ">
			      <CUBE-NAME ,PRSI>
			      <TELL " is now written on the cube." CR>)
			     (ELSE
			      <YOU-CANT-X-THAT "write on">)>)
		      (<AND ,PRSI <GETPT ,PRSI ,P?NAME>>
		       <COND (<FSET? ,PRSO ,READBIT>
			      <TELL
"Strangely, you cannot duplicate the pattern." CR>)
			     (ELSE
			      <YOU-CANT-X-PRSI "write that on">)>)>)
	       (<VERB? TAKE>
		<COND (<EQUAL? ,PRSI ,PILE-1 ,PILE-2>
		       <FCLEAR ,PRSO ,NDESCBIT>)>
		<RFALSE>)
	       (<VERB? COUNT>
		<TELL "You have ">
		<TELL-CUBE-COUNT ,WINNER>)>>

<ROUTINE TELL-CUBE-COUNT (OBJ "AUX" CNT)
	 <SET CNT <CUBE-COUNT .OBJ>>
	 <COND (<ZERO? .CNT>
		<TELL "no">)
	       (ELSE <TELL N .CNT>)>
	 <TELL " cube">
	 <COND (<NOT <EQUAL? .CNT 1>>
		<TELL "s">)>
	 <TELL "." CR>>

<ROUTINE CUBE-COUNT (OBJ "AUX" (CNT 0))
	 <MAP-CONTENTS (CONT .OBJ)
		       (END <RETURN .CNT>)
		       <COND (<NOT <ZERO? <GETPT .CONT ,P?NAME>>>
			      <SET CNT <+ .CNT 1>>)
			     (<FIRST? .CONT>
			      <SET CNT <+ .CNT <CUBE-COUNT .CONT>>>)>>>
