"MAGIC for
				MAGE
	(c) Copyright 1985 Infocom, Inc. All Rights Reserved."

"---Summary of magic spells---

    -Spell-	-English-

 s  AIMFIZ	transport yourself to someone's location
e   BLORB	STRONG-BOX-SPELL
  6 BLORPLE	explore mystic connections
  6 CASKLY	perfect
e   CLEESH	NEWT-SPELL
  6 ESPNIS	SLEEP-SPELL
e   EXEX	HASTE-SPELL
e   FILFRE	CREDITS-SPELL
es  FROTZ	LIGHT-SPELL
 s  FWEEP	turn caster into a bat
 s  GASPAR	resurrection
  6 GIRGOL	stop time
es  GNUSTO	WRITE-MAGIC-SPELL
 s  GOLMAC	travel temporally
e   GONDAR	QUENCH-SPELL
e   GUNCHO	BANISH-SPELL
es  IZYUK	FLY-SPELL
  6 JINDAK	detect magic
e   KREBF	REPAIR-SPELL
e   KULCAD	DISPEL-SPELL
  6 LESOCH	gust of wind
  6 LISKON	shrink
 s  MALYON	bring life to inanimate objects
 s  MEEF	cause plants to wilt
e   MELBOR	PROTECTION-SPELL
e   NITFOL	TALK-TO-ANIMALS-SPELL
e   OZMOO	CHEAT-DEATH-SPELL
 s  PULVER	cause liquids to dry up
es  REZROV	OPEN-SPELL
  6 SNAVIG	transform into another
 s  SWANZO	exorcise an inhabiting presence
  6 THROCK	cause plants to grow
  6 TINSOT	freeze
 s  VARDIK	shield a mind from an evil spirit
e   VAXUM	CHARM-SPELL
 s  VEZZA	view the future
 s  YOMIN	mind probe
 s  YONK	augment the power of certain spells
e   ZIFMIA	SUMMON-SPELL

    -Potion-	-English-

 s  BERZIO	obviate need for food and drink
 s  BLORT	see in the dark
 s  FLAXO	exquisite torture
 s  FOOBLE	increase coordination
 s  VILSTU	obviate need for breathing
"

<OBJECT SPELL-BOOK
	(IN PLAYER)
	(SYNONYM BOOK NOTES)
	(ADJECTIVE MY SPELL MARGIN)
	(DESC "spell book")
	(ACTION SPELL-BOOK-F)
	(FLAGS TOUCHBIT TAKEBIT READBIT CONTBIT OPENBIT MAGICBIT)>

<GLOBAL SEEN-BLORPLE? <>>

<ROUTINE SPELL-BOOK-F ("AUX" (F <FIRST? ,SPELL-BOOK>))
	 <COND (<VERB? EXAMINE>
		<TELL
"This is your well-used old " 'SPELL-BOOK ", first given to you by Belboz
years ago after your original book was lost. ">
		<COND (<FSET? ,PRSO ,RMUNGBIT>
		       <TELL
"He would be appalled by its current ruined condition. It's
water-soaked, and the ink has run. It's useless.">)
		      (ELSE
		       <TELL "There are some spells
written in the book, those few still working of the many you once knew.
The rest have faded away.">
		       <COND (<AND ,CLEESHED? <NOT ,SEEN-BLORPLE?>>
			      <SEE-BLORPLE>
			      <TELL
" As you look at it closely, though, you realize that the book has
changed subtly from its previous appearance. There is a new
entry: " 'BLORPLE-SPELL " ("
<GETP ,BLORPLE-SPELL ,P?TEXT> ").">)>)>
		<CRLF>)
	       (<VERB? OPEN CLOSE>
		<TELL
"The " 'SPELL-BOOK " is always open to the right place, but it is also
always closed. This eliminates tedious leafing and hunting for spells.
Many lives have been saved by this magical innovation." CR>)
	       (<VERB? READ LOOK-INSIDE>
		<COND (<FSET? ,PRSO ,RMUNGBIT>
		       <TELL
CTHE ,SPELL-BOOK " is totally unreadable. The ink has run, and the pages
are soaked. What a mess!" CR>
		       <RTRUE>)
		      (<NOT ,LIT>
		       <TELL
"The magic writing of the spells casts enough light
that you can read them." CR>)>
		<TELL "My Spell Book|
|
">
		<REPEAT ()
			<COND (<NOT .F> <RETURN>)>
			<TELL CTHE .F " (" <GETP .F ,P?TEXT> ")." CR>
			<SET F <NEXT? .F>>>
		<COND (<AND ,CLEESHED? <NOT ,SEEN-BLORPLE?>>
		       <SEE-BLORPLE>
		       <TELL
"|
Oddly enough, you have never before seen or heard of the blorple spell
which now graces (or defaces?) your book." CR>)>
		<RTRUE>)
	       (<VERB? WRITE>
		<TELL
"When you are done, the " 'SPELL-BOOK " remains unmarred." CR>)>>

<OBJECT BLORPLE-SPELL 
	(IN CASTLE) ;"so MOBY-FIND can find it"
	(SYNONYM SPELLS SPELL)
	(ADJECTIVE AABBCC BLORPLE)
	(DESC "blorple spell")
	(TEXT "explore an object's mystic connections")
	(COUNT 0)
	(ACTION SPELL-F)
	(SIZE 1)
	(FLAGS NDESCBIT SPELLBIT)>

<OBJECT LESOCH-SPELL 
	(IN SPELL-BOOK)
	(SYNONYM SPELLS SPELL)
	(ADJECTIVE AABBCC LESOCH)
	(DESC "lesoch spell")
	(TEXT "gust of wind")
	(COUNT 0)
	(ACTION SPELL-F)
	(SIZE 1)
	(FLAGS NDESCBIT SPELLBIT)>

<OBJECT SNAVIG-SPELL 
	(IN CASTLE) ;"so MOBY-FIND can find it"
	(SYNONYM SPELLS SPELL)
	(ADJECTIVE AABBCC SNAVIG)
	(DESC "snavig spell")
	(TEXT "shape change")
	(COUNT 0)
	(ACTION SPELL-F)
	(SIZE 1)
	(FLAGS NDESCBIT SPELLBIT)>

<OBJECT GIRGOL-SCROLL 
	(IN CASTLE) ;"so MOBY-FIND can find it"
	(SYNONYM SCROLL)
	(ADJECTIVE FLIMSY)
	(DESC "flimsy scroll")
	(ACTION SCROLL-F)
	(FLAGS TAKEBIT TRYTAKEBIT READBIT
	       SCROLLBIT CONTBIT TRANSBIT)>

<OBJECT GIRGOL-SPELL 
	(IN GIRGOL-SCROLL)
	(SYNONYM SPELLS SPELL)
	(ADJECTIVE AABBCC GIRGOL)
	(DESC "girgol spell")
	(TEXT "stop time")
	(COUNT 0)
	(ACTION SPELL-F)
	(SIZE 1)
	(FLAGS NDESCBIT SPELLBIT)>

<OBJECT JINDAK-SPELL 
	(IN SPELL-BOOK)
	(SYNONYM SPELLS SPELL)
	(ADJECTIVE AABBCC JINDAK)
	(DESC "jindak spell")
	(TEXT "detect magic")
	(COUNT 0)
	(ACTION SPELL-F)
	(SIZE 1)
	(FLAGS NDESCBIT SPELLBIT)>

<OBJECT ESPNIS-SCROLL 
	(IN OGRE-BEDROOM)
	(SYNONYM SCROLL)
	(ADJECTIVE DUSTY)
	(DESC "dusty scroll")
	(ACTION SCROLL-F)
	(FLAGS TAKEBIT TRYTAKEBIT READBIT
	       SCROLLBIT CONTBIT TRANSBIT)>

<OBJECT ESPNIS-SPELL
	(IN ESPNIS-SCROLL)
	(SYNONYM SPELLS SPELL)
	(ADJECTIVE AABBCC ESPNIS)
	(DESC "espnis spell")
	(TEXT "sleep")
	(COUNT 0)
	(ACTION SPELL-F)
	(SIZE 1)
	(FLAGS NDESCBIT SPELLBIT)>

<OBJECT TINSOT-SCROLL 
	(IN GLACIER-ROOM)
	(SYNONYM SCROLL)
	(ADJECTIVE WHITE)
	(DESC "white scroll")
	(ACTION SCROLL-F)
	(FLAGS TAKEBIT TRYTAKEBIT READBIT
	       SCROLLBIT CONTBIT TRANSBIT)>

<OBJECT TINSOT-SPELL 
	(IN TINSOT-SCROLL)
	(SYNONYM SPELLS SPELL)
	(ADJECTIVE AABBCC TINSOT)
	(DESC "tinsot spell")
	(TEXT "freeze")
	(COUNT 0)
	(ACTION SPELL-F)
	(SIZE 1)
	(FLAGS NDESCBIT SPELLBIT)>

<OBJECT THROCK-SCROLL 
	(IN CLIFF-MIDDLE)
	(SYNONYM SCROLL)
	(ADJECTIVE DIRTY)
	(DESC "dirty scroll")
	(ACTION SCROLL-F)
	(FLAGS TAKEBIT TRYTAKEBIT READBIT
	       SCROLLBIT CONTBIT TRANSBIT)>

<OBJECT THROCK-SPELL 
	(IN THROCK-SCROLL)
	(SYNONYM SPELLS SPELL)
	(ADJECTIVE AABBCC THROCK)
	(DESC "throck spell")
	(TEXT "cause plants to grow")
	(COUNT 0)
	(ACTION SPELL-F)
	(SIZE 1)
	(FLAGS NDESCBIT SPELLBIT)>

<OBJECT CASKLY-SCROLL 
	(IN ROC-NEST)
	(SYNONYM SCROLL)
	(ADJECTIVE STAINED)
	(DESC "stained scroll")
	(ACTION SCROLL-F)
	(FLAGS TAKEBIT TRYTAKEBIT READBIT
	       SCROLLBIT CONTBIT TRANSBIT)>

<OBJECT CASKLY-SPELL 
	(IN CASKLY-SCROLL)
	(SYNONYM SPELLS SPELL)
	(ADJECTIVE AABBCC CASKLY)
	(DESC "caskly spell")
	(TEXT "cause perfection")
	(COUNT 0)
	(ACTION SPELL-F)
	(SIZE 1)
	(FLAGS NDESCBIT SPELLBIT)>

<OBJECT LISKON-SCROLL 
	(IN BOTTLE)
	(SYNONYM SCROLL)
	(ADJECTIVE DAMP)
	(DESC "damp scroll")
	(ACTION SCROLL-F)
	(FLAGS NDESCBIT
	       TAKEBIT TRYTAKEBIT READBIT
	       SCROLLBIT CONTBIT TRANSBIT)>

<OBJECT LISKON-SPELL
	(IN LISKON-SCROLL)
	(SYNONYM SPELLS SPELL)
	(ADJECTIVE AABBCC LISKON)
	(DESC "liskon spell")
	(TEXT "shrink a living thing")
	(COUNT 0)
	(ACTION SPELL-F)
	(SIZE 1)
	(FLAGS NDESCBIT SPELLBIT)>

"OLD SPELLS"

<OBJECT MALYON-SPELL 
	(IN SPELL-BOOK)
	(SYNONYM SPELLS SPELL)
	(ADJECTIVE AABBCC MALYON)
	(DESC "malyon spell")
	(TEXT "animate")
	(COUNT 0)
	(ACTION SPELL-F)
	(SIZE 1)
	(FLAGS NDESCBIT SPELLBIT)>

<OBJECT GNUSTO-SPELL 
	(IN SPELL-BOOK)
	(SYNONYM SPELLS SPELL)
	(ADJECTIVE AABBCC GNUSTO)
	(DESC "gnusto spell")
	(TEXT "write a magic spell into a spell book")
	(COUNT 0)
	(ACTION SPELL-F)
	(SIZE 1)
	(FLAGS NDESCBIT SPELLBIT)>

<OBJECT FROTZ-SPELL
	(IN SPELL-BOOK)
	(SYNONYM SPELLS SPELL)
	(ADJECTIVE AABBCC FROTZ)
	(DESC "frotz spell")
	(TEXT "cause something to give off light")
	(COUNT 0)
	(ACTION SPELL-F)
	(SIZE 1)
	(FLAGS NDESCBIT SPELLBIT)>

<OBJECT REZROV-SPELL
	(IN SPELL-BOOK)
	(SYNONYM SPELLS SPELL)
	(ADJECTIVE AABBCC REZROV)
	(DESC "rezrov spell")
	(TEXT "open even locked or enchanted objects")
	(COUNT 0)
	(ACTION SPELL-F)
	(SIZE 1)
	(FLAGS NDESCBIT SPELLBIT)>	

<OBJECT YOMIN-SPELL
	(IN SPELL-BOOK)
	(SYNONYM SPELLS SPELL)
	(ADJECTIVE AABBCC YOMIN)
	(DESC "yomin spell")
	(TEXT "mind probe")
	(COUNT 0)
	(SIZE 1)
	(FLAGS NDESCBIT SPELLBIT)
	(ACTION SPELL-F)>

<ROUTINE SCROLL-F ("AUX" SPELL)
	 <COND (<VERB? TAKE>
		<SET SPELL <FIRST? ,PRSO>>
		<FSET .SPELL ,TOUCHBIT>
		<FCLEAR ,PRSO ,TRYTAKEBIT>
		<RFALSE>)
	       ;(<AND <NOT <FIRST? ,PRSO>>
		     <NOT <FIRST? ,PRSI>>>
		<TELL "Bug #72" CR>)
	       (<VERB? GNUSTO COPY WRITE>
		<COND (<AND <FSET? ,PRSO ,SCROLLBIT>
			    <NOT <IN? ,PRSO ,WINNER>>>
		       <MUST-HOLD-SCROLL>)
		      (<SET SPELL <FIRST? ,PRSO>>
		       <PERFORM ,PRSA .SPELL ,PRSI>
		       <RTRUE>)>)
	       (<VERB? EXAMINE READ>
		<READ-SCROLL>)>>

<ROUTINE SCROLL-WET ()
	 <TELL
"The scroll is wet, and the spell cannot be read." CR>>

<ROUTINE READ-SCROLL ("OPTIONAL" (SPELL <>))
	 <COND (<FSET? ,PRSO ,RMUNGBIT>
		<SCROLL-WET>
		<RTRUE>)>
	 <COND (<NOT .SPELL> <SET SPELL <FIRST? ,PRSO>>)>
	 <TELL "The scroll">
	 <SPELL-READS .SPELL>>

<ROUTINE MUST-HOLD-SCROLL ()
	 <TELL
"You must be holding the spell scroll you wish to copy!" CR>>

<ROUTINE SPELL-F ("AUX" MEM? (FORGET <>))
	 <COND (<AND <VERB? READ LEARN>
		     <NOT <IN? ,PRSO ,SPELL-BOOK>>
		     <FSET? <LOC ,PRSO> ,TOUCHBIT>
		     <NOT <IN? <LOC ,PRSO> ,WINNER>>>
		<TELL
,YOU-CANT "do that without having the spell in your book." CR>
		<RFATAL>)
	       (<AND <VERB? READ LEARN>
		     <FSET? ,SPELL-BOOK ,RMUNGBIT>>
		<PERFORM ,V?READ ,SPELL-BOOK>
		<THIS-IS-IT ,PRSO>
		<RFATAL>)
	       (<AND <LOC ,PRSO>
		     <FSET? <LOC ,PRSO> ,RMUNGBIT>>
		<SCROLL-WET>)
	       (<VERB? READ>
		<TELL "The spell">
		<SPELL-READS ,PRSO>)
	       (<VERB? LEARN>
		<COND (<NOT <IN? ,PRSO ,SPELL-BOOK>>
		       <COND (<HELD? ,PRSO>
			      <TELL
"You haven't written that spell into your book yet. Until you do, you
can't memorize the spell." CR>)
			     (T
			      <V-LEARN>)>
		       <RFATAL>)
		      (<IN? ,PRSO ,DEAD-BOOK>
		       <TELL
"You can learn spells only from your own " 'SPELL-BOOK>
		       <TELL ,PERIOD>
		       <RFATAL>)		      
		      (<EQUAL? ,PRSO
			       ,GNUSTO-SPELL ,FROTZ-SPELL ,REZROV-SPELL>
		       <TELL "You already know that spell by heart." CR>)
		      (<NOT <IN? ,SPELL-BOOK ,WINNER>>
		       <TELL
,YOU-DONT-HAVE "your " 'SPELL-BOOK ". You can't memorize a spell
without a " 'SPELL-BOOK ,PERIOD>
		       <RFATAL>)
		      (T
		       <SET MEM? <GETP ,PRSO ,P?COUNT>>
		       <COND (<NOT <HELD? ,MAGIC-CUBE>>
			      <COND (<OR <EQUAL? ,SPELL-MAX 1>
					 <G? ,AWAKE 6>
					 <AND <G? ,AWAKE 0>
					      <PROB <* 5 ,AWAKE>>>>
				     <TELL
,YOU-CANT "concentrate well enough to learn the spell." CR>
				     <RTRUE>)
				    (<EQUAL? .MEM? ,SPELL-MAX>
				     <TELL
"You try, but you just can't memorize those complex syllables again.
They slip out of your memory as soon as you cram them in." CR>
				     <RTRUE>)
				    (<NOT <G? ,SPELL-ROOM 0>>
				     <FORGET-SPELL ,PRSO>
				     <SETG SPELL-ROOM 1>
				     <SET FORGET T>)>)>
		       <SETG SPELL-ROOM <- ,SPELL-ROOM 1>>
		       <SET MEM? <+ .MEM? 1>>
		       <PUTP ,PRSO ,P?COUNT .MEM?>
		       <COND (<HELD? ,MAGIC-CUBE>
			      <TELL "You easily">)
			     (ELSE
			      <TELL "Using your best study habits, you">)>
		       <TELL " learn the " 'PRSO>
		       <COND (<G? .MEM? 1>
			      <TELL " yet another time">)>
		       <TELL ,PERIOD>
		       <COND (.FORGET
			      <TELL
"You have so much buzzing around in your head, though, that it's
likely that something may have been forgotten in the shuffle." CR>)>
		       <RTRUE>)>)
	       (<AND <NOT <VISIBLE? ,PRSO>>
		     <NOT <VERB? CAST>>>
		<TELL ,YOU-CANT-SEE "that spell here!" CR>)
	       (<VERB? TAKE DROP THROW>
		<TELL-YUKS>)>>

<ROUTINE SPELL-READS (SPELL)
	 <TELL
" reads \"" D .SPELL ": " <GETP .SPELL ,P?TEXT> ".\"">
	 <COND (<OR <EQUAL? .SPELL ,GIRGOL-SPELL>
		    <AND <EQUAL? .SPELL ,SPELL-COPY>
			 <EQUAL? <GETP .SPELL ,P?WALLS> ,GIRGOL-SPELL>>>
		<TELL
" The spell is long and complicated.">)>
	 <CRLF>>

<ROUTINE FORGET-SPELL (SPL "AUX" F CNT TBL (NUM 0) (SP <>))
	 <SET F <FIRST? ,SPELL-BOOK>>
	 <SET TBL ,FORGET-TBL>
	 <REPEAT ()
		 <COND (<NOT .F> <RETURN>)
		       (<G? <SET CNT <GETP .F ,P?COUNT>> 0>
			<REPEAT ()
				<SET SP .F>
				<PUT .TBL 1 .F>
				<SET NUM <+ .NUM 1>>
				<SET TBL <REST .TBL 2>>
				<COND (<L? <SET CNT <- .CNT 1>> 1>
				       <RETURN>)>>)>
		 <SET F <NEXT? .F>>>
	 <COND (<AND <G? .NUM 0>
		     <EQUAL? <GETP .SP ,P?COUNT> .NUM>>
		<PUTP .SP ,P?COUNT <- .NUM 1>>
		<RTRUE>)>
	 <PUT ,FORGET-TBL 0 .NUM>
	 <COND (<ZERO? .NUM> <RTRUE>)>
	 <SET SPL <RANDOM-ELEMENT ,FORGET-TBL>>
	 <PUTP .SPL ,P?COUNT <- <GETP .SPL ,P?COUNT> 1>>>

<GLOBAL FORGET-TBL <LTABLE 0 0 0 0 0 0 0 0 0 0>>

<ROUTINE FORGET-ALL ("AUX" F)
	 <SETG SPELL-ROOM ,SPELL-MAX>
	 <SET F <FIRST? ,SPELL-BOOK>>
	 <REPEAT ()
		 <COND (<NOT .F> <RETURN>)
		       (ELSE
			<PUTP .F ,P?COUNT 0>
			<SET F <NEXT? .F>>)>>>

<ROUTINE WEAR-OFF-SPELLS ("OPTIONAL" (SLEEP? T))
	 <COND (,CHANGED?
		<COND (.SLEEP? <I-SNAVIG>)
		      (ELSE
		       <SETG CHANGED? <>>
		       <DEQUEUE I-SNAVIG>)>)> ;"not changed"
	 <COND (,SHRINK-FLAG
		<COND (.SLEEP? <I-LISKON>)
		      (ELSE
		       <COND (<AND <HELD? ,SHRINK-FLAG>
				   <EQUAL? ,SHRINK-FLAG ,WEED>>
			      <MOVE ,WEED ,HERE>)>
		       <SETG SHRINK-FLAG <>>
		       <SETG SMALL-FLAG <>>
		       <DEQUEUE I-LISKON>)>)> ;"not shrunk"
	 <COND (,TIME-STOPPED?
		<COND (.SLEEP? <I-GIRGOL>)
		      (ELSE
		       <SETG TIME-STOPPED? <>>
		       <SETG ROCK-FLAG <>>
		       <DEQUEUE I-GIRGOL>)>)> ;"not time-stopped"
	 <COND (,ESPNIS?
		<COND (.SLEEP? <I-ESPNIS>)
		      (ELSE
		       <SETG ESPNIS? <>>
		       <DEQUEUE I-ESPNIS>)>)> ;"not sleeped">

<GLOBAL REAL-SPELL-MAX 4>
<GLOBAL SPELL-MAX 4>  ;"max spells memorizable"
<GLOBAL SPELL-ROOM 4> ;"number can memorize now"

"subtitle magic-related verbs"

<ROUTINE SPELL-VERB? ()
	 <VERB? GNUSTO FROTZ REZROV TINSOT YOMIN
		MALYON LESOCH BLORPLE SNAVIG GIRGOL
		JINDAK ESPNIS CASKLY LISKON THROCK>> 

<ROUTINE PRE-CAST ("AUX" SPELL SCROLL)
	 <COND (,SPELL-CAST <RFALSE>)>
	 <SET SPELL
	      <COND (<VERB? GNUSTO> ,GNUSTO-SPELL)
		    (<VERB? FROTZ> ,FROTZ-SPELL)
		    (<VERB? REZROV> ,REZROV-SPELL)
		    (<VERB? YOMIN> ,YOMIN-SPELL)
		    (<VERB? LESOCH> ,LESOCH-SPELL)
		    (<VERB? BLORPLE> ,BLORPLE-SPELL)
		    (<VERB? SNAVIG> ,SNAVIG-SPELL)
		    (<VERB? GIRGOL> ,GIRGOL-SPELL)
		    (<VERB? JINDAK> ,JINDAK-SPELL)
		    (<VERB? ESPNIS> ,ESPNIS-SPELL)
		    (<VERB? MALYON> ,MALYON-SPELL)
		    (<VERB? CASKLY> ,CASKLY-SPELL)
		    (<VERB? LISKON> ,LISKON-SPELL)
		    (<VERB? THROCK> ,THROCK-SPELL)
		    (<VERB? TINSOT> ,TINSOT-SPELL)
		    (<VERB? $XEROX> ,SPELL-COPY)>>
	 <COND (<AND <IN? .SPELL ,BLANK-SCROLL>
		     <IN? <LOC ,SPELL-COPY> ,WINNER>
		     <NOT <IN? ,BLANK-SCROLL ,WINNER>>>
		<SET SPELL ,SPELL-COPY>)>
	 <COND (<EQUAL? ,CHANGED? ,GROUPER ,SNAKE ,GRUE>
		<TELL
"Your mouth cannot form the words of spells while you are changed into a "
'CHANGED? ,PERIOD>
		<RTRUE>)
	       (<EQUAL? ,HERE ,OCEAN-FLOOR>
		<TELL
"You can't cast a spell while underwater!" CR>
		<RTRUE>)>
	 <SET SCROLL <LOC .SPELL>>
	 <COND (<OR <EQUAL? .SPELL ,PRSO>
		    <AND <EQUAL? .SCROLL ,PRSO>
			 <NOT <EQUAL? .SCROLL ,SPELL-BOOK>>>>
		<TELL
"As you must remember from Thaumaturgy 101, you cannot cast a spell upon
itself, or upon the scroll it is written on." CR>
		<RTRUE>)
	       (<AND .SCROLL
		     <NOT <EQUAL? .SCROLL ,SPELL-BOOK>>
		     <OR <FSET? .SCROLL ,SCROLLBIT>
			 <EQUAL? .SCROLL ,DEAD-BOOK>>>
		<COND (<FSET? .SCROLL ,RMUNGBIT>
		       <TELL CTHE .SCROLL " is unreadable." CR>
		       <RTRUE>)
		      (<IN? .SCROLL ,WINNER>
		       <REMOVE .SCROLL>
		       <TELL
"As you cast the spell, " THE .SCROLL " vanishes!" CR>
		       <PUTP .SPELL ,P?COUNT 1>)
		      (T
		       <TELL
CTHE .SPELL " is not memorized, and you aren't holding a scroll
on which it is written." CR>
		       <RTRUE>)>)>
	 <COND (<EQUAL? .SPELL ,SPELL-COPY>
		<SETG PRSA <GETP ,SPELL-COPY ,P?EXITS>>)>
	 <COND (<AND <VERB? BLORPLE> <NOT <IN? ,PRSO ,WINNER>>>
		<NOT-HOLDING ,PRSO>
		<RTRUE>)>
	 <COND (<OR <NOT <ZERO? <GETP .SPELL ,P?COUNT>>>
		    <EQUAL? .SPELL ,GNUSTO-SPELL ,REZROV-SPELL ,FROTZ-SPELL>>
		<SETG SPELL-CAST .SPELL>
		<COND (<EQUAL? ,HERE ,SCALES-ROOM>
		       <COND (<AND <VERB? REZROV MALYON>
				   <EQUAL? ,PRSO ,IRON-DOOR ,VAULT-DOOR>>
			      <SETG SPELLS-USED 2>)>
		       <USE-SPELL>)>
		<COND (<EQUAL? ,HERE ,PLAIN-ROOM>
		       <PLAIN-SPELL-FAIL>)
		      (<NOT <SPELL-PROB? .SPELL>>
		       <TELL
"The casting feels wrong, and sure enough, " <PICK-ONE ,FIZZLES> CR>
		       <RTRUE>)
		      (ELSE
		       <RFALSE>)>)
	       (ELSE
		<TELL
,YOU-DONT-HAVE THE .SPELL " memorized!" CR>
		<THIS-IS-IT .SPELL>
		<RTRUE>)>>

<GLOBAL USED-JINDAK? <>>

<ROUTINE USE-SPELL ()
	 <COND (<VERB? JINDAK> <SETG USED-JINDAK? T>)>
	 <SETG SPELLS-USED <+ ,SPELLS-USED 1>>
	 <COND (<AND <G? ,SPELLS-USED 2>
		     <ZERO? ,GUARDS-FLAG>
		     <NOT <QUEUED? I-ALARM>>>
		<QUEUE I-ALARM -1>
		<QUEUE I-GUARDS 2>)>
	 <RFALSE>>

<GLOBAL SPELL-CAST <>>

<GLOBAL FIZZLES
	<LTABLE 0
"nothing happens."
"a huge ball of green light appears, then dissipates."
"your fingers grow numb."
"you are momentarily blinded."
"there is a distant rumble of thunder."
"your whole body feels as if your funny bone has been struck.">>

<ROUTINE SPELL-PROB? (SPELL? "AUX" (P 50) N1 N2)
	 <COND (<AND <GOT? ,MAGIC-CUBE>
		     <NOT <EQUAL? .SPELL? ,GIRGOL-SPELL>>>
		<RTRUE>)
	       (<AND <EQUAL? .SPELL? ,FROTZ-SPELL>
		     <OR <EQUAL? ,HERE ,DARK-CAVE ,GRUE-CAVE ,LIGHT-POOL>
			 <EQUAL? ,HERE ,PILLAR-ROOM>>>
		<RFALSE>)
	       (<AND <EQUAL? .SPELL? ,BLORPLE-SPELL>
		     <EQUAL? ,HERE ,CASTLE>
		     <G? ,SHADOW-COUNT 8>>
		<RFALSE>)>
	 <COND (<EQUAL? .SPELL? ,GNUSTO-SPELL>
		<SET P 75>
		<SET N1 ,CHANGE-CUBE> <SET N2 ,EARTH-CUBE>)
	       (<EQUAL? .SPELL? ,FROTZ-SPELL>
		<SET P 75>
		<SET N1 ,CHANGE-CUBE> <SET N2 ,LIGHT-CUBE>)
	       (<EQUAL? .SPELL? ,REZROV-SPELL>
		<SET N1 ,CHANGE-CUBE> <SET N2 ,EARTH-CUBE>)
	       (<EQUAL? .SPELL? ,YOMIN-SPELL>
		<SET N1 ,MIND-CUBE> <SET N2 ,LIGHT-CUBE>)
	       (<EQUAL? .SPELL? ,LESOCH-SPELL>
		<SET N1 ,AIR-CUBE> <SET N2 ,FIRE-CUBE>)
	       (<EQUAL? .SPELL? ,BLORPLE-SPELL>
		<RTRUE>)
	       (<EQUAL? .SPELL? ,SNAVIG-SPELL>
		<SET N1 ,CHANGE-CUBE> <SET N2 ,DARK-CUBE>)
	       (<EQUAL? .SPELL? ,GIRGOL-SPELL>
		<COND (<IN? ,GIRGOL-SPELL ,GIRGOL-SCROLL>
		       <COND (<AND <EQUAL? .SPELL? ,GIRGOL-SPELL>
				   <EQUAL? ,HERE ,COUNCIL-CHAMBER>>
			      <RFALSE>)
			     (ELSE <RTRUE>)>)
		      (<EQUAL? ,HERE ,CASTLE ,PAST-RUINS-ROOM ,PAST-CELL-EAST>
		       <RTRUE>)
		      (<EQUAL? ,HERE ,MAGIC-ROOM ,TIME-ROOM>
		       <RTRUE>)
		      (ELSE
		       <RFALSE>)>)
	       (<EQUAL? .SPELL? ,JINDAK-SPELL>
		<SET N1 ,LIGHT-CUBE> <SET N2 ,CONNECTIVITY-CUBE>)
	       (<EQUAL? .SPELL? ,ESPNIS-SPELL>
		<SET N1 ,MIND-CUBE> <SET N2 ,DEATH-CUBE>)
	       (<EQUAL? .SPELL? ,MALYON-SPELL>
		<SET N1 ,FIRE-CUBE> <SET N2 ,LIFE-CUBE>)
	       (<EQUAL? .SPELL? ,CASKLY-SPELL>
		<SET N1 ,CHANGE-CUBE> <SET N2 ,CONNECTIVITY-CUBE>)
	       (<EQUAL? .SPELL? ,LISKON-SPELL>
		<SET N1 ,CHANGE-CUBE> <SET N2 ,EARTH-CUBE>)
	       (<EQUAL? .SPELL? ,THROCK-SPELL>
		<SET N1 ,LIFE-CUBE> <SET N2 ,WATER-CUBE>)
	       (<EQUAL? .SPELL? ,TINSOT-SPELL>
		<SET N1 ,WATER-CUBE> <SET N2 ,FIRE-CUBE>)>
	 <SET P <+ .P <* <COUNT-CUBES> 5>>>
	 <COND (<GOT? .N1> <SET P <+ .P 20>>)>
	 <COND (<GOT? .N2> <SET P <+ .P 20>>)>
	 %<DEBUG-CODE
	    <COND (,ZDEBUG
		   <TELL "[Prob=" N .P "]" CR>)>>
	 <COND (<OR <NOT <L? .P 100>> <PROB .P>>
		<RTRUE>)
	       (ELSE
		<RFALSE>)>>

<ROUTINE V-CAST ("AUX" VRB)
	 <COND (<NOT <FSET? ,PRSO ,SPELLBIT>>
		<TELL
"You can't cast "> <A-PRSO>)
	       (T
		<SET VRB <SPELL-TO-VERB>>
		<COND (<AND <NOT ,PRSI>
			    <NOT <EQUAL? .VRB
					 ,V?JINDAK ,V?GIRGOL ,V?LESOCH>>
			    <NOT <EQUAL? .VRB ,V?$XEROX>>>
		       <TELL
"You must cast that on something." CR>)
		      (T
		       <PERFORM .VRB ,PRSI>)>
		<RTRUE>)>>

<ROUTINE V-$XEROX ("AUX" VRB)
	 <COND (<SET VRB <GETP ,SPELL-COPY ,P?EXITS>>
		<PERFORM .VRB ,PRSO>)>
	 <RTRUE>>

<ROUTINE SPELL-TO-VERB ()
	 <COND (<EQUAL? ,PRSO ,GNUSTO-SPELL> ,V?GNUSTO)
	       (<EQUAL? ,PRSO ,FROTZ-SPELL> ,V?FROTZ)
	       (<EQUAL? ,PRSO ,REZROV-SPELL> ,V?REZROV)
	       (<EQUAL? ,PRSO ,YOMIN-SPELL> ,V?YOMIN)
	       (<EQUAL? ,PRSO ,LESOCH-SPELL> ,V?LESOCH)
	       (<EQUAL? ,PRSO ,BLORPLE-SPELL> ,V?BLORPLE)
	       (<EQUAL? ,PRSO ,SNAVIG-SPELL> ,V?SNAVIG)
	       (<EQUAL? ,PRSO ,GIRGOL-SPELL> ,V?GIRGOL)
	       (<EQUAL? ,PRSO ,JINDAK-SPELL> ,V?JINDAK)
	       (<EQUAL? ,PRSO ,ESPNIS-SPELL> ,V?ESPNIS)
	       (<EQUAL? ,PRSO ,MALYON-SPELL> ,V?MALYON)
	       (<EQUAL? ,PRSO ,CASKLY-SPELL> ,V?CASKLY)
	       (<EQUAL? ,PRSO ,LISKON-SPELL> ,V?LISKON)
	       (<EQUAL? ,PRSO ,THROCK-SPELL> ,V?THROCK)
	       (<EQUAL? ,PRSO ,TINSOT-SPELL> ,V?TINSOT)
	       (<EQUAL? ,PRSO ,SPELL-COPY> ,V?$XEROX ;<GETP ,PRSO ,P?EXITS>)>>

<GLOBAL ALL-SPELLS
	<PLTABLE
	  GNUSTO-SPELL
	  FROTZ-SPELL
	  REZROV-SPELL
	  YOMIN-SPELL
	  LESOCH-SPELL
	  BLORPLE-SPELL
	  SNAVIG-SPELL
	  GIRGOL-SPELL
	  JINDAK-SPELL
	  MALYON-SPELL
	  ESPNIS-SPELL
	  CASKLY-SPELL
	  LISKON-SPELL
	  THROCK-SPELL
	  TINSOT-SPELL>>

;"These spells no longer exist"
	  ;IZYUK-SPELL
	  ;AIMFIZ-SPELL
	  ;SWANZO-SPELL
	  ;GOLMAC-SPELL
	  ;VARDIK-SPELL
	  ;PULVER-SPELL
	  ;MEEF-SPELL
	  ;VEZZA-SPELL
	  ;GASPAR-SPELL
	  ;YONK-SPELL

<ROUTINE V-SPELLS ("AUX" (CNT <GET ,ALL-SPELLS 0>) S (ANY <>) (OS <>) TMP)
	 <TELL
"The gnusto, rezrov, and frotz spells are yours forever. Other than that,
you have ">
	 <REPEAT ()
		 <COND (<EQUAL? .CNT 0>
			<COND (.OS
			       <SPELL-PRINT .OS .ANY T>
			       <SET ANY T>)>
			<COND (<NOT .ANY>
			       <TELL "no spells memorized.">)
			      (T
			       <TELL " committed to memory.">)>
			<CRLF>
			<RTRUE>)>
		 <COND (<SET TMP <SPELL-TIMES <GET ,ALL-SPELLS .CNT>>>
			<COND (.OS
			       <SPELL-PRINT .OS .ANY>
			       <SET ANY T>)>
			<SET OS .TMP>)>
		 <SET CNT <- .CNT 1>>>>

<ROUTINE SPELL-PRINT (S ANY "OPTIONAL" (PAND? <>) "AUX" X)
	 <COND (.ANY
		<COND (.PAND?
		       <TELL " and ">)
		      (T
		       <TELL ", ">)>)>
	 <TELL THE .S " ">
	 <SET X <- <GETP .S ,P?COUNT> 1>>
	 <COND (<G? .X 4>
		<SET X 4>)> ;"prevents ,COUNTERS table overflow"
	 <TELL <GET ,COUNTERS .X>>
	 .S>

<ROUTINE SPELL-TIMES (S)
	 <COND (<AND <G? <GETP .S ,P?COUNT> 0>
		     <IN? .S ,SPELL-BOOK>>
		.S)>>

<GLOBAL COUNTERS	;"should be as many entries as ,SPELL-MAX"
	<PTABLE "once"
	       "twice"
	       "thrice"
	       "four times"
	       "many times">>

<ROUTINE V-LEARN ()
	 <TELL ,YOU-DONT-HAVE "that spell, if indeed that is a spell." CR>>

<ROUTINE SEE-BLORPLE ()
	 <COND (<NOT ,SEEN-BLORPLE?>
		<SETG SEEN-BLORPLE? T>
		<SETG SCORE <+ ,SCORE 15>>)>>

<ROUTINE V-BLORPLE ("AUX" RM)
	 <SEE-BLORPLE>
	 <COND (<OR <GETP ,HERE ,P?CUBE> <EQUAL? ,HERE ,DULL-ROOM>>
		<TELL ,NOTHING-HAPPENS>)
	       (ELSE
		<COND (<AND <EQUAL? ,PRSO ,TIME-CUBE>
			    <NOT ,USED-JINDAK?>>
		       <SETG BLORPLE-OBJECT <>>
		       <SET RM <>>)
		      (ELSE
		       <SETG BLORPLE-OBJECT ,PRSO>
		       <SET RM <GETP ,PRSO ,P?CUBE>>)>
		<COND (<NOT .RM>
		       <SETG DULL-ROOM-RETURN ,HERE>
		       <SET RM ,DULL-ROOM>)>
		<TELL
"Abruptly, your surroundings shift.">
		<COND (<FSET? <LOC ,PLAYER> ,VEHBIT>
		       <TELL
" The spell leaves " THE <LOC ,PLAYER> " behind.">)>
		<MOVE ,PLAYER ,HERE>
		<REMOVE ,PRSO>
		<CRLF>
		<CRLF>
		<GOTO .RM>)>>

<GLOBAL BLORPLE-OBJECT <>>

<ROUTINE RECOVER-CUBE ()
	 <COND (<AND ,BLORPLE-OBJECT
		     <NOT <EQUAL? ,HERE ,OHERE>>>
		<TELL
"As you leave, " THE ,BLORPLE-OBJECT " reappears in your hand." CR CR>
		<MOVE ,BLORPLE-OBJECT ,WINNER>
		<FCLEAR ,BLORPLE-OBJECT ,NDESCBIT>
		<SETG BLORPLE-OBJECT <>>
		<RTRUE>)>>

<ROUTINE V-LESOCH ()
	 <COND (<AND <EQUAL? ,HERE ,BELWIT-SQUARE>
		     <OR <EQUAL? ,PRSO ,CLOUD>
			 <AND <NOT ,PRSO>
			      <NOT <FSET? ,CLOUD ,INVISIBLE>>>>>
		<FSET ,CLOUD ,INVISIBLE>
		<DEQUEUE I-CLOUD-GONE>
		<TELL
"A small gust of wind begins to roil the cloud. The cloud is unimpressed.
The wind builds, slowly but inexorably, to hurricane force. The cloud starts
to unravel at the edges, and then gives up and dissipates">
		<COND (<IN? ,EARTH-CUBE ,HERE>
		       <THIS-IS-IT ,EARTH-CUBE>
		       <FCLEAR ,EARTH-CUBE ,INVISIBLE>
		       <TELL
". Left behind on the ground is a small " ,WHITE-CUBE ".">)>
		<CLEVER-CONTENTS ,HERE " Also revealed" ,EARTH-CUBE>
		<CRLF>
		<RTRUE>)
	       (ELSE
		<TELL
"Slowly, teasingly, a small puff of wind begins to blow. It quickly builds
to gale force, then hurricane force, and just as you feel you are about to
be swept away, it subsides." CR>)>>

<GLOBAL CHANGED? <>>

<ROUTINE V-SNAVIG ()
	 <COND (<NOT ,PRSO>
		<TELL
"You have to transform into something, and it has to be something nearby." CR>)
	       (<EQUAL? ,CHANGED? ,PRSO>
		<TELL ,NOTHING-HAPPENS>)
	       (<AND <EQUAL? ,PRSO ,PSEUDO-OBJECT>
		     <EQUAL? ,P-PNAM ,W?MOSS ,W?CORAL>>
		<TELL "You're too large." CR>)
	       (ELSE
		<YOU-CANT-X-PRSO "change into">)>>

<GLOBAL TIME-STOPPED? <>>

<ROUTINE TOO-PRECISE (STR)
	 <COND (<NOT <EQUAL? ,PRSO <> ,GLOBAL-ROOM>>
		<TELL
"This spell " .STR " in a large area, so directing it at ">
		<COND (<HELD? ,PRSO>
		       <TELL "an object
you are holding won't work very well">)
		      (ELSE
		       <TELL "a specific
object is unnecessarily precise">)>
		<TELL ,PERIOD CR>)>>

<ROUTINE V-GIRGOL ()
	 <COND (,TIME-STOPPED?
		<TELL ,NOTHING-HAPPENS>)
	       (<EQUAL? ,HERE ,EMPORIUM>
		<PERFORM ,V?ESPNIS ,MERCHANT>
		<RTRUE>)
	       (ELSE
		<TOO-PRECISE "stops time">
		<SETG TIME-STOPPED? ,HERE>
		<QUEUE I-GIRGOL 12>
		<COND (<AND <EQUAL? ,HERE ,CLIFF-TOP>
			    <QUEUED? I-AVALANCHE>
			    <G? ,ROCK-SLIDE-COUNT 0>>
		       <STOP-AVALANCHE>)
		      (<EQUAL? ,HERE ,OGRE-CAVE>
		       <TELL
"The ogre, who was gesticulating wildly, freezes in place. He looks like
a particularly bad statue of himself. Even his lice aren't moving." CR>)
		      (<EQUAL? ,HERE ,SOUTH-SNAKE-ROOM ,NORTH-SNAKE-ROOM>
		       <TELL
"The snake freezes in place, as though a particularly good statue of itself
had been put in its place. However, it still completely blocks the passage." CR>)
		      (<EQUAL? ,HERE ,PAST-RUINS-ROOM>
		       <DEQUEUE I-WATER-RISING>
		       <TELL "The water stops rising." CR>)
		      (<AND <EQUAL? ,HERE ,CASTLE>
			    <IN? ,SHADOW ,CASTLE>>
		       <COND (<L? ,SHADOW-COUNT 8>
			      <SETG TIME-STOPPED? <>>
			      <DEQUEUE I-GIRGOL>
			      <TELL
"The shadow turns and silences you with a word of power, cancelling
the spell." CR>)
			     (<EQUAL? ,SHADOW-COUNT 8>
			      <QUEUE I-GIRGOL 3>
			      <TELL
"All around you freezes in place! The shadow is caught in
a particularly evil posture. You can tell the spell won't hold for
long!" CR>)
			     (<EQUAL? ,SHADOW-COUNT 9>
			      <QUEUE I-GIRGOL 3>
			      <TELL
"The shadow freezes in mid-leap! You can tell the spell won't hold for
long in this magically charged atmosphere!" CR>)>)
		      (ELSE
		       <TELL
,AT-FIRST "subtle changes in your
surroundings. Nothing is moving. You can see dust motes hanging
in midair, and a tiny gnat, its wings motionless, unknowingly defying
gravity." CR>)>)>>

<GLOBAL AT-FIRST "At first, nothing happens. Then you notice ">

<ROUTINE V-JINDAK ("AUX" F (1ST? T) P1 P2)
	 <TOO-PRECISE "detects magic">
	 <COND (<EQUAL? ,HERE ,SCALES-ROOM>
		<SET P1 <MEASURE ,PILE-1>>
		<SET P2 <MEASURE ,PILE-2>>
		<COND (<AND <G? .P1 0> <G? .P2 0>>
		       <TELL
"Both piles of cubes glow with a faint blue glow. ">
		       <COND (<EQUAL? .P1 .P2>
			      <TELL "Both piles seem to glow
with identical brightness.">)
			     (ELSE
			      <TELL
"However, the ">
			      <COND (<G? .P1 .P2> <TELL 'PILE-1>)
				    (ELSE <TELL 'PILE-2>)>
			      <TELL " is glowing more brightly.">)>)
		      (<G? .P1 0>
		       <TELL CTHE ,PILE-1 ,IS-GLOWING>)
		      (<G? .P2 0>
		       <TELL CTHE ,PILE-2 ,IS-GLOWING>)
		      (<AND <FIRST? ,PILE-1> <FIRST? ,PILE-2>>
		       <TELL "Neither pile is glowing at all.">)>
		<CRLF>
		<COND (<NOT <DETECT-MAGIC ,HERE>>
		       <TELL "Nothing else is glowing." CR>)>)
	       (<NOT <DETECT-MAGIC ,HERE>>
		<TELL
"Nothing in the vicinity glows. Apparently there is no magic
nearby." CR>)>>

<ROUTINE DETECT-MAGIC (OBJ "OPTIONAL" (1ST? T) "AUX" F)
	 <SET F <FIRST? .OBJ>>
	 <REPEAT ()
		 <COND (<NOT .F> <RETURN <NOT .1ST?>>)
		       (<NOT <EQUAL? .F ,PLAYER ,PILE-1 ,PILE-2>>
			<COND (<AND <VISIBLE? .F>
				    <MAGIC? .F>>
			       <SET 1ST? <>>
			       <TELL
				CTHE .F ,IS-GLOWING CR>)
			      (<AND <SEE-INSIDE? .F>
				    <FIRST? .F>>
			       <COND (<DETECT-MAGIC .F .1ST?>
				      <SET 1ST? <>>)>)>)>
		 <SET F <NEXT? .F>>>>

<ROUTINE MAGIC? (OBJ)
	 <COND (<FSET? .OBJ ,MAGICBIT> <RTRUE>)
	       (<FSET? .OBJ ,SCROLLBIT> <RTRUE>)
	       (<GETPT .OBJ ,P?NAME> <RTRUE>)>>

<GLOBAL ESPNIS? <>>

<ROUTINE V-ESPNIS ()
	 <COND (<EQUAL? ,PRSO ,ME ,WINNER>
		<V-SLEEP T>)
	       (<TIME-FROZEN?>
		<TELL ,NOTHING-HAPPENS>)
	       (<FSET? ,PRSO ,PERSON>
		<QUEUE I-ESPNIS 20>
		<COND (<EQUAL? ,ESPNIS? ,PRSO>
		       <TELL
CTHE ,PRSO " continues to sleep." CR>)
		      (ELSE
		       <COND (,ESPNIS? <I-ESPNIS>)>
		       <SETG ESPNIS? ,PRSO>
		       <TELL
CTHE ,PRSO " falls asleep, yawning lazily." CR>)>)
	       (ELSE
		<TELL
"I suppose you expect to hear " THE ,PRSO " snoring?" CR>)>>

<ROUTINE V-CASKLY ()
	 <TELL CTHE ,PRSO>
	 <COND (<AND <FSET? ,PRSO ,RMUNGBIT>
		     <FSET? ,PRSO ,TAKEBIT>>
		<FCLEAR ,PRSO ,RMUNGBIT>
		<TELL
" is returned to its original perfection." CR>)
	       (ELSE
		<TELL
" looks pretty perfect as is." CR>)>>

<ROUTINE V-THROCK ()
	 <TELL 
"I guess you have a black thumb. " ,NOTHING-HAPPENS>>

<ROUTINE V-TINSOT ()
	 <SETG ICED-OBJECT ,PRSO>
	 <COND (<AND <EQUAL? ,HERE ,OUBLIETTE>
		     <OR <EQUAL? ,PRSO ,INFLOW ,OUTFLOW ,OUBLIETTE-CHANNEL>
			 <EQUAL? ,PRSO ,WATER>>>
		<COND (<AND <G? ,WATER-FLAG 0>
			    <NOT <EQUAL? ,PRSO ,WATER>>>
		       <TELL ,YOU-CANT-SEE "that anymore" ,PERIOD>)
		      (<EQUAL? ,PRSO ,INFLOW>
		       <PARTIAL-BLOCKAGE ,INFLOW>)
		      (<EQUAL? ,WATER-FLAG 0>
		       <QUEUE I-TINSOT 30>
		       <SETG ICED-OBJECT ,OUTFLOW>
		       <SETG FREEZE-FLAG <+ ,FREEZE-FLAG 1>>
		       <COND (<EQUAL? ,FREEZE-FLAG 1>
			      <PARTIAL-BLOCKAGE ,OUTFLOW>)
			     (<EQUAL? ,FREEZE-FLAG 2>
			      <QUEUE I-OUBLIETTE-FILLS -1>
			      <TELL
"In a dazzling purple flash, more water freezes, forming a large icy cap over
the outflow pipe in the channel. Water continues to pour in the inflow, and
it spills over the edge of the channel and begins to fill the room." CR>)>)
		      (<NOT <IN? ,ICEBERG ,HERE>>
		       <MOVE ,ICEBERG ,HERE>
		       <SETG ICED-OBJECT ,ICEBERG>
		       <TELL
"The purple flash freezes a small ice floe in the frigid water. It has a nice
flat top." CR>)
		      (ELSE
		       <TELL ,NOTHING-HAPPENS>)>)
	       ;(<AND <EQUAL? ,HERE ,RUINS-ROOM>
		     <EQUAL? ,PRSO ,WATER ,RUINS-OUTFLOW ,RUINS-CHANNEL>>
		)
	       (<EQUAL? ,PRSO ,AIR>
		<V-SQUEEZE>)
	       (<AND <EQUAL? ,PRSO ,BOTTLE ,WATER ,LOCAL-WATER>
		     <IN? ,LOCAL-WATER ,BOTTLE>>
		<REMOVE ,LOCAL-WATER>
		<REMOVE ,BOTTLE>
		<TELL
"The water and bottle freeze and shatter into a million pieces!" CR>)
	       (ELSE
		<TELL
CTHE ,PRSO " is covered with a thin film of ice.">
		<COND (<FSET? ,PRSO ,PERSON>
		       <TELL
" " CTHE ,PRSO " shakes and shivers, and the ice cracks and peels away.">)>
		<CRLF>)>>

<ROUTINE PARTIAL-BLOCKAGE (OBJ)
	 <TELL
"There is a purple flash, and in a burst of snow and freezing spray, the
water in the channel freezes. But the water flow is so hard that " THE .OBJ
" is only partially blocked." CR>>

<ROUTINE PRE-LISKON ()
	 <COND (<OR <EQUAL? ,SHRINK-FLAG ,PRSO>
		    <AND <EQUAL? ,SHRINK-FLAG ,PLAYER>
			 <EQUAL? ,PRSO ,ME>>>
		<TELL ,NOTHING-HAPPENS>
		<RTRUE>)
	       (,SHRINK-FLAG
		<COND (<I-LISKON T>
		       <CRLF>)>
		<RFALSE>)>>

<ROUTINE V-LISKON ()
	 <COND (<FSET? ,PRSO ,PERSON>
		<COND (<PRE-LISKON> <RTRUE>)
		      (ELSE
		       <QUEUE I-LISKON 15>
		       <COND (<AND ,PRSO <NOT <EQUAL? ,PRSO ,ME>>>
			      <SETG SHRINK-FLAG ,PRSO>
			      <TELL
CTHE ,PRSO " shrinks to about a tenth of its former size.">
			      <COND (<EQUAL? ,PRSO ,OGRE>
				     <TELL " He still looks mean.">)>
			      <CRLF>)
			     (ELSE
			      <SETG SHRINK-FLAG ,PLAYER>
			      <SETG SMALL-FLAG T>
			      <TELL
"You feel very funny, sort of squashed and pushed and squeezed. Your
surroundings are wavering, then growing, then wavering again. The feeling
vanishes, but your surroundings are ten times their former size... or is
it that you are one-tenth your former size?" CR>)>)>)
	       (ELSE
		<TELL
"Nothing happens, which is unsurprising, as this spell works only on
living things." CR>)>>

<GLOBAL SHRINK-FLAG <>> ;"object shrunk"
<GLOBAL SMALL-FLAG <>> ;"T if player shrunk"

<ROUTINE V-GNUSTO ("AUX" SCROLL)
	 <COND (<NOT <IN? ,SPELL-BOOK ,WINNER>>
		<TELL
"The spell quests around in your hands, looking for your " 'SPELL-BOOK ", and
not finding it, fades reluctantly." CR>)
	       (<NOT <FSET? ,PRSO ,SPELLBIT>>
		<TELL
,YOU-CANT "inscribe " A ,PRSO " in your " 'SPELL-BOOK "!" CR>)
	       (<IN? ,PRSO ,SPELL-BOOK>
		<TELL
,YOU-HAVE "that spell inscribed in your " 'SPELL-BOOK "!" CR>)
	       (<AND <LOC ,PRSO>
		     <NOT <IN? <LOC ,PRSO> ,WINNER>>>
		<MUST-HOLD-SCROLL>)
	       (<FSET? ,PRSO ,RMUNGBIT>
		<TELL "The spell is unreadable." CR>)
	       (T
		<SET SCROLL <LOC ,PRSO>>
		<COND (<FSET? .SCROLL ,RMUNGBIT>
		       <SCROLL-WET>)
		      (<AND <FSET? .SCROLL ,SCROLLBIT>
			    <HELD? .SCROLL>> 
		       <TELL "Your " 'SPELL-BOOK " begins to glow softly. ">
		       <COND (<EQUAL? ,PRSO ,GIRGOL-SPELL>
			      <TELL "In a spectacular effort of magic,
the powers of the gnusto spell attempt to copy the " 'PRSO " into your
book, but the spell is too long, too complicated, and too powerful. The
glow fades, but fortunately " THE .SCROLL " remains intact." CR>
			      <RTRUE>)
			     (T
			      <REMOVE .SCROLL>
			      <MOVE ,PRSO ,SPELL-BOOK>
			      <PUTP ,PRSO ,P?COUNT 0>
			      <TELL "Slowly, ornately, the words of the "
'PRSO " are inscribed, glowing even more brightly than
the book itself. The book's brightness fades, but the spell remains!">
			      <COND (<EQUAL? .SCROLL ,DEAD-BOOK>
				     <TELL
" The old book in which it was written crumbles to dust">)
				    (ELSE
				     <TELL
" However, the scroll on which it was written vanishes">)>
			      <TELL " as the last word is copied." CR>)>
		       T)
		      (T
		       <TELL
"You must have the object from which you are copying in your hands before
the gnusto spell will work on it." CR>)>)>>

<ROUTINE V-FROTZ ("AUX" OLIT) ;"light"
	 <SET OLIT ,LIT>
	 <COND (<FSET? ,PRSO ,ONBIT>
		<TELL
"Have you forgotten that you already frotzed " THE ,PRSO "?" CR>)
	       (<OR <FSET? ,PRSO ,TAKEBIT>
		    <FSET? ,PRSO ,PERSON>>
		<FSET ,PRSO ,ONBIT>
		<FSET ,PRSO ,TOUCHBIT>
		<TELL "There is an almost blinding flash of light as ">
		<COND (<EQUAL? ,PRSO ,ME>
		       <FSET ,WINNER ,ONBIT>
		       <TELL "you begin">)
		      (ELSE
		       <TELL THE ,PRSO " begins">)>
		<TELL
" to glow! It slowly fades to a less painful level, but ">
		<COND (<EQUAL? ,PRSO ,ME>
		       <TELL "you are">)
		      (ELSE <TELL THE ,PRSO " is">)>
		<TELL
" now a serviceable light source.">
		<CRLF>
		<SETG LIT <LIT? ,HERE>>
		<COND (<AND <NOT .OLIT> ,LIT>
		       <CRLF>
		       <V-LOOK>)>
		<RTRUE>)
	       (T
		<V-NO-OP>)>>

<ROUTINE V-MALYON ()
	 <COND (<FSET? ,PRSO ,PERSON>
		<TELL
"Wow! " ,IT-LOOKS-LIKE THE ,PRSO " is now alive! What a magician you are!" CR>)
	       (<FSET? ,PRSO ,TAKEBIT>
		<TELL
"As you complete the spell, " THE ,PRSO " comes alive! It blinks, dances a
little jig, and a moment later returns to normal." CR>)
	       (T
		<V-NO-OP>)>>

<ROUTINE V-REZROV () ;"open"
	 <COND (<FSET? ,PRSO ,PERSON>
		<TELL
"It might be a boon to surgeons if it worked, but it doesn't." CR>)
	       (<AND <FSET? ,PRSO ,VEHBIT>
		     <NOT <EQUAL? ,PRSO ,ZIPPER>>>
		<TELL
"It doesn't need opening." CR>)
	       (<OR <FSET? ,PRSO ,CONTBIT>
		    <FSET? ,PRSO ,DOORBIT>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <ALREADY-OPEN>)
		      (<NOT <FSET? ,PRSO ,SCROLLBIT>>
		       <TELL "Silently, ">
		       <TELL THE ,PRSO " swings open">
		       <COND (<FIRST? ,PRSO>
			      <TELL ", revealing ">
			      <PRINT-CONTENTS ,PRSO>)>
		       <COND (<NOT <EQUAL? ,PRSO ,IRON-DOOR>>
			      <TELL
". Like swatting a fly with a sledge hammer, if you ask me">)>
		       <TELL ,PERIOD>
		       <FSET ,PRSO ,OPENBIT>)
		      (T
		       <V-NO-OP>)>)
	       (T
		<V-NO-OP>)>>

<ROUTINE V-NO-OP () ;"exorcise"
	 <TELL
"Although you complete the spell, nothing has happened." CR>>

<ROUTINE V-YOMIN ()
	 <TELL "I'm afraid ">
	 <TELL THE ,PRSO " doesn't have much of a mind for you to read." CR>>

<OBJECT SPELL-COPY 
	(SYNONYM SPELLS SPELL)
	(ADJECTIVE DUPLICATE ;"PLACE HOLDER" ORIGINAL)
	(DESC "original")
	(TEXT 0)
	(COUNT 0)
	(ACTION SPELL-F)
	(SIZE 1)
	(EXITS 0) ;"will hold verb of spell this is a copy of"
	(WALLS 0) ;"will hold spell this is a copy of"
	(FLAGS NDESCBIT SPELLBIT AN)>

<OBJECT BLANK-SCROLL 
	(IN PAST-CABINET)
	(SYNONYM SCROLL)
	(ADJECTIVE NEW VELLUM BLANK)
	(DESC "vellum scroll")
	(ACTION BLANK-SCROLL-F)
	(FLAGS TAKEBIT TRYTAKEBIT READBIT
	       SCROLLBIT CONTBIT TRANSBIT)>

<ROUTINE BLANK-SCROLL-F ("AUX" OT DT)
	 <COND (<VERB? COPY>
		<COND (<NOT <IN? ,BURIN ,WINNER>>
		       <NO-BURIN>)
		      (<NOT <EQUAL? ,PRSI ,BLANK-SCROLL>>
		       <RFALSE>)
		      (<FSET? ,PRSI ,RMUNGBIT>
		       <TELL CTHE ,PRSI " is too wet." CR>)
		      (<FIRST? ,PRSI>
		       <ALREADY-USED>)
		      (<NOT <FSET? ,PRSO ,SPELLBIT>>
		       <RFALSE>)
		      (<EQUAL? <LOC ,PRSO> ,SPELL-BOOK ,DEAD-BOOK>
		       <TELL
"Spell books are copy-protected to prevent spell thieves from making
spell scrolls from another mage's spell book." CR>)
		      (<AND <EQUAL? ,PRSO ,GIRGOL-SPELL>
			    <NOT <HELD? ,MAGIC-CUBE>>>
		       <TELL
"You try hard to copy the obscure runes and ideographs of the spell, but
your mind just can't comprehend them, and your fingers just can't
follow the curves and strokes." CR>)
		      (ELSE
		       <SET DT <GETPT ,PRSO ,P?ADJECTIVE>>
		       <SET OT <GETPT ,SPELL-COPY ,P?ADJECTIVE>>
		       <PUTB .DT 0 <GETB .OT 0>>
		       <PUTB .OT 0 <GETB .DT 1>>
		       <PUTP ,SPELL-COPY
			     ,P?TEXT
			     <GETP ,PRSO ,P?TEXT>>
		       <MOVE ,SPELL-COPY <LOC ,PRSO>>
		       <FSET ,PRSO ,RWATERBIT>
		       <MOVE ,PRSO ,PRSI>
		       <PUTP ,SPELL-COPY ,P?WALLS ,PRSO>
		       <PUTP ,SPELL-COPY ,P?EXITS <SPELL-TO-VERB>>
		       <TELL
			"Copied." CR>)>)
	       (<NOT <FIRST? ,PRSO>>
		<COND (<VERB? EXAMINE>
		       <TELL
,IT-LOOKS-LIKE "a blank piece of vellum scroll paper." CR>)
		      (<VERB? READ>
		       <TELL "This scroll is blank." CR>)
		      (<AND <VERB? WRITE>
			    <EQUAL? ,PRSO ,QWORD>>
		       <TELL
"You should write spells, not random words, on spell paper." CR>)
		      (<AND <VERB? WRITE>
			    <NOT <FSET? ,PRSO ,SPELLBIT>>>
		       <TELL
"That's not a spell! You'll waste good spell paper!" CR>)>)
	       (ELSE <SCROLL-F>)>>
