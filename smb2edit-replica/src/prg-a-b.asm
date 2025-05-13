;
; Bank A & Bank B
; ===============
;
; What's inside:
;
;   - Level title card background data and palettes
;   - Bonus chance background data and palettes
;   - Character select palettes
;   - Character data (physics, palettes, etc.)
;   - Character stats bootstrapping
;

;
; This title card is used for every world from 1 to 6.
; The only difference is the loaded CHR banks.
;
World1thru6TitleCard:
	.db $FB, $FB, $B0, $B2, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB
	.db $FB, $FB, $B1, $B3, $FB, $FB, $FB, $FB, $FB, $FB, $C0, $C1, $FB, $FB, $FB, $FB ; $10
	.db $FB, $FB, $B4, $B5, $FB, $FB, $FB, $FB, $B6, $B8, $BA, $B8, $BA, $BC, $FB, $FB ; $20
	.db $FB, $FB, $B4, $B5, $FB, $FB, $FB, $FB, $B7, $B9, $BB, $B9, $BB, $BD, $FB, $FB ; $30
	.db $FB, $FB, $B4, $B5, $FB, $FB, $FB, $FB, $B7, $B9, $BB, $B9, $BB, $BD, $FB, $FB ; $40
	.db $FB, $FB, $B4, $B5, $C0, $C1, $FB, $FB, $B7, $B9, $BB, $B9, $BB, $BD, $FB, $FB ; $50
	.db $CA, $CC, $CA, $CC, $CA, $CC, $CA, $CC, $CA, $CC, $CA, $CC, $CA, $CC, $CA, $CC ; $60
	.db $CB, $CD, $CB, $CD, $CB, $CD, $CB, $CD, $CB, $CD, $CB, $CD, $CB, $CD, $CB, $CD ; $70
	.db $CE, $CF, $CE, $CF, $CE, $CF, $CE, $CF, $CE, $CF, $CE, $CF, $CE, $CF, $CE, $CF ; $80
	.db $CF, $CE, $CF, $CE, $CF, $CE, $CF, $CE, $CF, $CE, $CF, $CE, $CF, $CE, $CF, $CE ; $90

;
; This one is the special one used for World 7
;
World7TitleCard:
	.db $FB, $FB, $B0, $B2, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB
	.db $FB, $FB, $B1, $B3, $FB, $FB, $FB, $FB, $FB, $FB, $C0, $C1, $FB, $FB, $FB, $FB ; $10
	.db $FB, $FB, $B1, $B3, $FB, $FB, $FB, $FB, $B6, $B8, $BA, $B8, $BA, $BC, $FB, $FB ; $20
	.db $FB, $FB, $B1, $B3, $FB, $FB, $FB, $FB, $B7, $B9, $BB, $B9, $BB, $BD, $FB, $FB ; $30
	.db $FB, $FB, $B1, $B3, $FB, $FB, $FB, $FB, $CA, $FC, $FC, $FC, $FC, $CC, $FB, $FB ; $40
	.db $FB, $FB, $B1, $B3, $C0, $C1, $FB, $FB, $CA, $FC, $FC, $FC, $FC, $CC, $FB, $FB ; $50
	.db $A8, $AC, $AA, $AC, $AA, $AC, $AA, $AC, $AA, $AC, $AA, $AC, $AA, $AC, $AA, $AE ; $60
	.db $A9, $AD, $AB, $AD, $AB, $AD, $AB, $AD, $AB, $AD, $AB, $AD, $AB, $AD, $AB, $AF ; $70
	.db $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB ; $80
	.db $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB ; $90

BonusChanceLayout:
	.db $20, $00, $60, $FD
	.db $20, $20, $60, $FD
	.db $20, $40, $60, $FD
	.db $20, $60, $60, $FD
	.db $23, $40, $60, $FD
	.db $23, $60, $60, $FD
	.db $23, $80, $60, $FD
	.db $23, $A0, $60, $FD
	.db $20, $80, $D6, $FD
	.db $20, $81, $D6, $FD
	.db $20, $82, $D6, $FD
	.db $20, $9D, $D6, $FD
	.db $20, $9E, $D6, $FD
	.db $20, $9F, $D6, $FD

	.db $20, $68, $10
	.db $48, $4A, $4C, $4E, $50, $51, $52, $53, $54, $55, $56, $57, $58, $5A, $5C, $5E

	.db $20, $83, $09, $FD, $FD, $22, $23, $24, $49, $4B, $4D, $4F
	.db $20, $94, $09, $59, $5B, $5D, $5F, $2E, $2F, $30, $FD, $FD
	.db $20, $A3, $04, $FD, $25, $26, $27
	.db $20, $B9, $04, $31, $32, $33, $FD
	.db $20, $C3, $04, $FD, $28, $29, $2A
	.db $20, $D9, $04, $34, $35, $36, $FD
	.db $20, $E3, $03, $2B, $2C, $2D
	.db $20, $FA, $03, $37, $38, $39
	.db $21, $03, $02, $3A, $3B
	.db $21, $1B, $02, $40, $41
	.db $21, $23, $D0, $3C
	.db $21, $3C, $D0, $42
	.db $22, $02, $02, $3E, $3F
	.db $22, $1C, $02, $61, $62
	.db $22, $22, $02, $43, $44
	.db $22, $3C, $02, $63, $64
	.db $22, $43, $01, $45
	.db $22, $5C, $01, $65
	.db $22, $C4, $02, $A6, $A8
	.db $22, $E4, $02, $A7, $A9
	.db $22, $FA, $04, $80, $82, $88, $8A
	.db $23, $04, $02, $90, $92
	.db $23, $14, $02, $9E, $A0
	.db $23, $1A, $04, $81, $83, $89, $8B
	.db $23, $23, $03, $46, $91, $93
	.db $23, $2A, $02, $A2, $A4

	.db $23, $2E, $10
	.db $67, $6C, $6E, $70, $72, $69, $9F, $A1, $75, $98, $9A, $FB, $84, $86, $8C, $8E

	.db $23, $43, $1B
	.db $47, $94, $96, $74, $74, $74, $74, $A3, $A5, $74, $66, $68, $6D, $6F, $71, $73
	.db $6A, $6B, $74, $74, $99, $9B, $74, $85, $87, $8D, $8F

	.db $23, $64, $05, $95, $97, $FD, $AA, $AB
	.db $23, $77, $05, $9C, $9D, $AA, $AB, $AB
	.db $23, $89, $02, $AA, $AB
	.db $20, $C9, $0E, $78, $AC, $B0, $B4, $B7, $BA, $FB, $BC, $BE, $C1, $C4, $C7, $CB, $7C

	.db $20, $E8, $10
	.db $1C, $79, $AD, $B1, $B5, $B8, $BB, $FB, $BD, $BF, $C2, $C5, $C8, $CC, $7D, $1E

	.db $21, $08, $10
	.db $1D, $7A, $AE, $B2, $B6, $B9, $FB, $FB, $FB, $C0, $C3, $C6, $C9, $CD, $7E, $1F

	.db $21, $29, $03, $7B, $AF, $B3
	.db $21, $34, $03, $CA, $CE, $7F
	.db $21, $6A, $0C, $14, $10, $10, $16, $14, $10, $10, $16, $14, $10, $10, $16
	.db $21, $8A, $0C, $11, $FC, $FC, $12, $11, $FC, $FC, $12, $11, $FC, $FC, $12
	.db $21, $AA, $0C, $11, $FC, $FC, $12, $11, $FC, $FC, $12, $11, $FC, $FC, $12
	.db $21, $CA, $0C, $15, $13, $13, $17, $15, $13, $13, $17, $15, $13, $13, $17
	.db $22, $0D, $02, $18, $1A
	.db $22, $2D, $02, $19, $1B
	.db $23, $D2, $04, $80, $A0, $A0, $20
	.db $23, $DA, $04, $88, $AA, $AA, $22
	.db $23, $E4, $01, $0A
	.db $23, $EA, $05, $A0, $A0, $A0, $A0, $20
	.db $00


;
; Copies the Bonus Chance PPU data
;
; This copies in two $100 byte chunks, the second of which includes extra data
; that is never used because of the terminating $00
;
CopyBonusChanceLayoutToRAM:
	LDY #$00
CopyBonusChanceLayoutToRAM_Loop1:
	LDA BonusChanceLayout, Y ; Blindly copy $100 bytes from $8140 to $7400
	STA PPUBuffer_BonusChanceLayout, Y
	DEY
	BNE CopyBonusChanceLayoutToRAM_Loop1

	LDY #$00
CopyBonusChanceLayoutToRAM_Loop2:
	; Blindly copy $100 more bytes from $8240 to $7500
	; That range includes this code! clap. clap.
	LDA BonusChanceLayout + $100, Y
	STA PPUBuffer_BonusChanceLayout + $100, Y
	DEY
	BNE CopyBonusChanceLayoutToRAM_Loop2

	RTS

; =============== S U B R O U T I N E =======================================

DrawTitleCardWorldImage:
	LDA CurrentWorld
	CMP #6
	BEQ loc_BANKA_8392 ; Special case for World 7's title card

	LDA #$25
	STA byte_RAM_0
	LDA #$C8
	STA byte_RAM_1
	LDY #$00

loc_BANKA_8338:
	LDX #$0F
	LDA PPUSTATUS
	LDA byte_RAM_0
	STA PPUADDR

loc_BANKA_8342:
	LDA byte_RAM_1
	STA PPUADDR

loc_BANKA_8347:
	LDA World1thru6TitleCard, Y
	STA PPUDATA
	INY
	DEX
	BPL loc_BANKA_8347

	CPY #$A0
	BCS loc_BANKA_8364

	LDA byte_RAM_1
	ADC #$20
	STA byte_RAM_1
	LDA byte_RAM_0
	ADC #0
	STA byte_RAM_0
	JMP loc_BANKA_8338

; ---------------------------------------------------------------------------

loc_BANKA_8364:
	LDA CurrentWorld
	CMP #1
	BEQ loc_BANKA_8371

	CMP #5
	BEQ loc_BANKA_8371

	BNE loc_BANKA_8389

loc_BANKA_8371:
	AND #$80
	BNE loc_BANKA_8389

	LDA #$26
	STA byte_RAM_0
	LDA #$88
	STA byte_RAM_1
	LDA CurrentWorld
	ORA #$80
	STA CurrentWorld
	LDY #$80
	BNE loc_BANKA_8338

loc_BANKA_8389:
	LDA CurrentWorld
	AND #$F
	STA CurrentWorld
	RTS

; ---------------------------------------------------------------------------

loc_BANKA_8392:
	LDA #$25
	STA byte_RAM_0
	LDA #$C8
	STA byte_RAM_1
	LDY #0

loc_BANKA_839C:
	LDX #$F
	LDA PPUSTATUS
	LDA byte_RAM_0
	STA PPUADDR
	LDA byte_RAM_1
	STA PPUADDR

loc_BANKA_83AB:
	LDA World7TitleCard, Y
	STA PPUDATA
	INY
	DEX
	BPL loc_BANKA_83AB

	CPY #$A0
	BCS locret_BANKA_83C8

	LDA byte_RAM_1
	ADC #$20
	STA byte_RAM_1
	LDA byte_RAM_0
	ADC #0
	STA byte_RAM_0
	JMP loc_BANKA_839C

; ---------------------------------------------------------------------------

locret_BANKA_83C8:
	RTS

; End of function DrawTitleCardWorldImage

StatOffsets:
	.db (MarioStats - CharacterStats)
	.db (PrincessStats - CharacterStats)
	.db (ToadStats - CharacterStats)
	.db (LuigiStats - CharacterStats)

CharacterStats:
MarioStats:
	.db $00 ; Pick-up Speed, frame 1/6 - pulling
	.db $04 ; Pick-up Speed, frame 2/6 - pulling
	.db $02 ; Pick-up Speed, frame 3/6 - ducking
	.db $01 ; Pick-up Speed, frame 4/6 - ducking
	.db $04 ; Pick-up Speed, frame 5/6 - ducking
	.db $07 ; Pick-up Speed, frame 6/6 - ducking
	.db $B0 ; Jump Speed, still - no object
	.db $B0 ; Jump Speed, still - with object
	.db $98 ; Jump Speed, charged - no object
	.db $98 ; Jump Speed, charged - with object
	.db $A6 ; Jump Speed, running - no object
	.db $AA ; Jump Speed, running - with object
	.db $E0 ; Jump Speed - in quicksand
	.db $00 ; Floating Time
	.db $07 ; Gravity without Jump button pressed
	.db $04 ; Gravity with Jump button pressed
	.db $08 ; Gravity in quicksand
	.db $18 ; Running Speed, right - no object
	.db $18 ; Running Speed, right - with object
	.db $04 ; Running Speed, right - in quicksand
	.db $E8 ; Running Speed, left - no object
	.db $E8 ; Running Speed, left - with object
	.db $FC ; Running Speed, left - in quicksand

ToadStats:
	.db $00 ; Pick-up Speed, frame 1/6 - pulling
	.db $01 ; Pick-up Speed, frame 2/6 - pulling
	.db $01 ; Pick-up Speed, frame 3/6 - ducking
	.db $01 ; Pick-up Speed, frame 4/6 - ducking
	.db $01 ; Pick-up Speed, frame 5/6 - ducking
	.db $02 ; Pick-up Speed, frame 6/6 - ducking
	.db $B2 ; Jump Speed, still - no object
	.db $B2 ; Jump Speed, still - with object
	.db $98 ; Jump Speed, charged - no object
	.db $98 ; Jump Speed, charged - with object
	.db $AD ; Jump Speed, running - no object
	.db $AD ; Jump Speed, running - with object
	.db $E0 ; Jump Speed - in quicksand
	.db $00 ; Floating Time
	.db $07 ; Gravity without Jump button pressed
	.db $04 ; Gravity with Jump button pressed
	.db $08 ; Gravity in quicksand
	.db $18 ; Running Speed, right - no object
	.db $1D ; Running Speed, right - with object
	.db $04 ; Running Speed, right - in quicksand
	.db $E8 ; Running Speed, left - no object
	.db $E3 ; Running Speed, left - with object
	.db $FC ; Running Speed, left - in quicksand

LuigiStats:
	.db $00 ; Pick-up Speed, frame 1/6 - pulling
	.db $04 ; Pick-up Speed, frame 2/6 - pulling
	.db $02 ; Pick-up Speed, frame 3/6 - ducking
	.db $01 ; Pick-up Speed, frame 4/6 - ducking
	.db $04 ; Pick-up Speed, frame 5/6 - ducking
	.db $07 ; Pick-up Speed, frame 6/6 - ducking
	.db $D6 ; Jump Speed, still - no object
	.db $D6 ; Jump Speed, still - with object
	.db $C9 ; Jump Speed, charged - no object
	.db $C9 ; Jump Speed, charged - with object
	.db $D0 ; Jump Speed, running - no object
	.db $D4 ; Jump Speed, running - with object
	.db $E0 ; Jump Speed - in quicksand
	.db $00 ; Floating Time
	.db $02 ; Gravity without Jump button pressed
	.db $01 ; Gravity with Jump button pressed
	.db $08 ; Gravity in quicksand
	.db $18 ; Running Speed, right - no object
	.db $16 ; Running Speed, right - with object
	.db $04 ; Running Speed, right - in quicksand
	.db $E8 ; Running Speed, left - no object
	.db $EA ; Running Speed, left - with object
	.db $FC ; Running Speed, left - in quicksand

PrincessStats:
	.db $00 ; Pick-up Speed, frame 1/6 - pulling
	.db $06 ; Pick-up Speed, frame 2/6 - pulling
	.db $04 ; Pick-up Speed, frame 3/6 - ducking
	.db $02 ; Pick-up Speed, frame 4/6 - ducking
	.db $06 ; Pick-up Speed, frame 5/6 - ducking
	.db $0C ; Pick-up Speed, frame 6/6 - ducking
	.db $B3 ; Jump Speed, still - no object
	.db $B3 ; Jump Speed, still - with object
	.db $98 ; Jump Speed, charged - no object
	.db $98 ; Jump Speed, charged - with object
	.db $AC ; Jump Speed, running - no object
	.db $B3 ; Jump Speed, running - with object
	.db $E0 ; Jump Speed - in quicksand
	.db $3C ; Floating Time
	.db $07 ; Gravity without Jump button pressed
	.db $04 ; Gravity with Jump button pressed
	.db $08 ; Gravity in quicksand
	.db $18 ; Running Speed, right - no object
	.db $15 ; Running Speed, right - with object
	.db $04 ; Running Speed, right - in quicksand
	.db $E8 ; Running Speed, left - no object
	.db $EB ; Running Speed, left - with object
	.db $FC ; Running Speed, left - in quicksand

CharacterPalette:
IFDEF SMBEDIT
MarioPalette:
	.db $0D, $01, $16, $27
PrincessPalette:
	.db $0D, $06, $25, $36
ToadPalette:
	.db $0D, $01, $30, $27
LuigiPalette:
	.db $0D, $01, $2A, $36
ELSE
MarioPalette:
	.db $0F, $01, $16, $27
PrincessPalette:
	.db $0F, $06, $25, $36
ToadPalette:
	.db $0F, $01, $30, $27
LuigiPalette:
	.db $0F, $01, $2A, $36
ENDIF
;
; What is this for? It gets copied to RAM and then...that's all.
;
; In Doki Doki Panic, this data loads on the level/character select screen, but doesn't seem to be
; used for anything there either. Will we ever unravel this mystery?
;
MysteryData14439:
	.db $DF
	.db $EF
	.db $F7
	.db $FB

	.db $00
	.db $FF
	.db $FF
	.db $FF

	.db $AF
	.db $D7
	.db $EB
	.db $F5

	.db $FB
	.db $F7
	.db $EF
	.db $DF

	.db $00
	.db $FF
	.db $FF
	.db $FF

	.db $F5
	.db $EB
	.db $D7
	.db $AF


;
; This copies the selected character's stats
; into memory for use later, but also a bunch
; of other unrelated crap like the
; Bonus Chance slot reels (???) and
; god knows what else.
;
CopyCharacterStatsAndStuff:
IFDEF CONTROLLER_2_DEBUG
	JSR CopyCharacterStats
ENDIF

	LDX CurrentCharacter
	LDY StatOffsets, X
	LDX #$00
loc_BANKA_8458:
	LDA CharacterStats, Y
	STA CharacterStatsRAM, X
	INY
	INX
	CPX #$17
	BCC loc_BANKA_8458

	LDA CurrentCharacter
	ASL A
	ASL A
	TAY
	LDX #$00
loc_BANKA_846B:
	LDA CharacterPalette, Y
	STA RestorePlayerPalette0, X
	INY
	INX
	CPX #$04
	BCC loc_BANKA_846B

	LDY #$4C
loc_BANKA_8479:
	LDA PlayerSelectPalettes, Y
	STA PPUBuffer_TitleCardPalette, Y
	DEY
	CPY #$FF
	BNE loc_BANKA_8479

	LDY #$B6
loc_BANKA_8486:
	LDA BonusChanceReel1Order, Y
	STA SlotMachineReelOrder1RAM, Y
	DEY
	CPY #$FF
	BNE loc_BANKA_8486

	LDY #$63
loc_BANKA_8493:
	LDA TitleCardText, Y
	STA PPUBuffer_TitleCardText, Y
	DEY
	CPY #$FF
	BNE loc_BANKA_8493

	; This data is copied, but doesn't appear to be used. Its original purpose is not obvious.
	LDY #$17
loc_BANKA_84A0:
	LDA MysteryData14439, Y
	STA MysteryData14439_RAM, Y
	DEY
	BPL loc_BANKA_84A0

	; Copy object collision hitbox table
	;
	; The fact that it's in RAM is taken advantage of to programmatically change
	; the hitbox for Hawkmouth after picking up the crystal.
	LDY #$4F
loc_BANKA_84AB:
	LDA ObjectCollisionHitboxLeft, Y
	STA ObjectCollisionHitboxLeft_RAM, Y
	DEY
	BPL loc_BANKA_84AB

	; Copy flying carpet acceleration table
	LDY #$03
loc_BANKA_84B6:
	LDA FlyingCarpetAcceleration, Y
	STA FlyingCarpetAcceleration_RAM, Y
	DEY
	BPL loc_BANKA_84B6

	; Copy object collision type table
	;
	; The fact that it's in RAM is used to toggle the Boss Hawkmouth between an
	; object and an enemy.
	LDY #$49
loc_BANKA_84C1:
	LDA EnemyPlayerCollisionTable, Y
	STA EnemyPlayerCollisionTable_RAM, Y
	DEY
	BPL loc_BANKA_84C1

	; Copy end of level door PPU data to RAM
	;
	; The fact that it's in RAM is actually taken advantage of when defeating Clawgrip, since the
	; door needs to be drawn in a slightly different spot.
	LDY #$20
loc_BANKA_84CC:
	LDA EndOfLevelDoor, Y
	STA PPUBuffer_EndOfLevelDoor, Y
	DEY
	BPL loc_BANKA_84CC

	; Copy Wart's OAM address table
	LDY #$06
loc_BANKA_84D7:
	LDA WartOAMOffsets, Y
	STA WartOAMOffsets_RAM, Y
	DEY
	BPL loc_BANKA_84D7

	RTS


FlyingCarpetAcceleration:
	.db $00
	.db $01
	.db $FF
	.db $00

WartOAMOffsets:
	.db $00
	.db $E0
	.db $FF ; Cycled in code ($7267)
	.db $D0
	.db $00
	.db $E0
	.db $FF ; Cycled in code ($726B)

PlayerSelectPalettes:
	.db $3F, $00, $20
	.db $0F, $28, $16, $06
	.db $0F, $30, $12, $16
	.db $0F, $30, $16, $12
	.db $0F, $30, $12, $16
	.db $0F, $22, $12, $01
	.db $0F, $22, $12, $01
	.db $0F, $22, $12, $01
	.db $0F, $22, $12, $01
	.db $00

BonusChanceText_X_1:
	.db $22, $30, $03
	.db $EA, $FB, $D1
BonusChanceText_EXTRA_LIFE_1:
	.db $22, $C9, $0F
	.db $DE, $F1, $ED, $EB, $DA, $FB, $E5, $E2, $DF, $DE ; EXTRA LIFE
	.db $F9, $F9, $F9, $FB, $D1 ; ... 1
	.db $00

BonusChanceBackgroundPalettes:
	.db $0F, $27, $17, $07 ; $00
	.db $0F, $37, $16, $12 ; $04
	.db $0F, $30, $10, $00 ; $08
	.db $0F, $21, $12, $01 ; $0C

BonusChanceReel1Order:
	.db Slot_Snifit ; $00
	.db Slot_Turnip ; $01 ; Graphics exist for a mushroom (not used)
	.db Slot_Star   ; $02
	.db Slot_Turnip ; $03
	.db Slot_Snifit ; $04
	.db Slot_Star   ; $05
	.db Slot_Cherry ; $06
	.db Slot_Turnip ; $07
BonusChanceReel2Order:
	.db Slot_Star   ; $00
	.db Slot_Snifit ; $01
	.db Slot_Cherry ; $02
	.db Slot_Snifit ; $03
	.db Slot_Turnip ; $04
	.db Slot_Star   ; $05
	.db Slot_Snifit ; $06
	.db Slot_Turnip ; $07
BonusChanceReel3Order:
	.db Slot_Star   ; $00
	.db Slot_Snifit ; $01
	.db Slot_Star   ; $02
	.db Slot_Turnip ; $03
	.db Slot_Star   ; $04
	.db Slot_Cherry ; $05
	.db Slot_Turnip ; $06
	.db Slot_Snifit ; $07

BonusChanceUnusedCoinSprite:
	.db $F8, $19, $01, $60, $F8, $1B, $01, $68
BonusChanceUnusedImajinHead:
	.db $CB, $B0, $00, $A0, $CB, $B0, $40, $A8
BonusChanceUnusedLinaHead:
	.db $CB, $B2, $00, $A0, $CB, $B2, $40, $A8
BonusChanceUnusedMamaHead:
	.db $CB, $B6, $00, $A0, $CB, $B6, $40, $A8
BonusChanceUnusedPapaHead:
	.db $CB, $B4, $00, $A0, $CB, $B4, $40, $A8

;
; Based on the position and the number of tiles, this probably used to say...
;
; --- BONUS CHANCE ---
;
BonusChanceUnused_BONUS_CHANCE:
	.db $20, $C6, $14
	.db $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB
	.db $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB
	.db $00

BonusChanceText_NO_BONUS:
	.db $22, $86, $14
	.db $FB, $FB, $FB, $FB, $FB, $FB
	.db $E7, $E8, $FB, $DB, $E8, $E7, $EE, $EC ; NO BONUS
	.db $FB, $FB, $FB, $FB, $FB, $FB
	.db $00

BonusChanceText_PUSH_A_BUTTON:
	.db $22, $89, $0E
	.db $E9, $EE, $EC, $E1, $FB, $0E, $F,$FB, $DB, $EE, $ED, $ED, $E8, $E7 ; PUSH (A) BUTTON
	.db $00

BonusChanceText_PLAYER_1UP:
	.db $22, $8B, $0B
	.db $E9, $E5, $DA, $F2, $DE, $EB, $FB, $FB, $D1, $EE, $E9 ; PLAYER  1UP
	.db $00

Text_PAUSE:
	.db $25, $ED, $05
	.db $E9, $DA, $EE, $EC, $DE ; PAUSE
	.db $27, $DB, $02, $AA, $AA ; attribute data
	.db $00

; Erases NO BONUS / PUSH (A) BUTTON / PLAYER 1UP
BonusChanceText_Message_Erase:
	.db $22, $86, $54, $FB
	.db $00

; This would erase the "PUSH (A) BUTTON" text, but the placement is wrong.
; The placement matches the original Doki Doki Panic Bonus Chance screen.
BonusChanceText_PUSH_A_BUTTON_Erase:
	.db $22, $AA, $4D, $FB
	.db $00

; More leftovers. The placement matches the original Doki Doki Panic Bonus Chance screen's placement
; of the "PLAYER  1UP" message.
BonusChanceText_Message_Erase_Unused:
	.db $22, $EB, $4B, $FB
	.db $00

Text_PAUSE_Erase:
	.db $25, $ED, $05
	.db $FB, $FB, $FB, $FB, $FB
	.db $00

TitleCardText:
	; Level indicator dots
	.db $25, $0E, $07
	.db $FB, $FB, $FB, $FB, $FB, $FB, $FB
	; WORLD  1-1
	.db $24, $CA, $0B
	.db $FB, $F0, $E8, $EB, $E5, $DD, $FB, $FB, $D1, $F3, $D1
	; EXTRA LIFE...  0
	.db $23, $48, $10
	.db $DE, $F1, $ED, $EB, $DA, $FB, $E5, $E2, $DF, $DE
	.db $F9, $F9, $F9, $FB, $FB, $D0
	.db $00

Text_WARP:
	.db $21, $8E, $04, $F0, $DA, $EB, $E9

; Doki Doki Panic pseudo-leftover
; This actually has extra spaces on either end:
; "-WORLD-" ... It originally said "CHAPTER"
Text_WORLD_1:
	.db $22, $0C, $09
	.db $FB, $F0, $E8, $EB, $E5, $DD, $FB, $FB, $D1
	.db $00
Text_Unknown6:
	.db $21, $6A, $01, $FB
Text_Unknown7:
	.db $21, $AA, $01, $FB
	.db $00
Text_Unknown8:
	.db $21, $97, $C6, $FB
	.db $00
UnusedText_THANK_YOU:
	.db $21, $0C, $09
	.db $ED, $E1, $3A, $E7, $E4, $FB, $F2, $E8, $EE
UnusedText_Blank214D:
	.db $21, $4D, $06
IFDEF SMBEDIT
  .db $fb, $fb, $fb
.db $fb, $fb, $fb, $00
.db $80, $ed, $90, $18, $f1, $6d, $f6, $01, $00, $8c, $01, $8c
.db $02, $8c, $03, $8c, $4c, $10, $99, $16, $f2, $4d, $10, $6c, $11, $c4, $d1, $c9
.db $d1, $f2, $f5, $0f, $60, $f1, $cd, $f6, $00, $38, $2b, $5a, $10, $a5, $06, $ca
.db $d1, $f2, $f1, $8d, $f6, $02, $36, $10, $a9, $0f, $b0, $0f, $c1, $0f, $c7, $0f
.db $f2, $f1, $cd, $f6, $00, $34, $11, $9f, $16, $c2, $d1, $c7, $d1, $f2, $f0, $4d
.db $f6, $01, $38, $10, $ae, $07, $ca, $d1, $f2, $f0, $0d, $f6, $00, $f1, $ec, $f6
.db $03, $42, $11, $54, $10, $a1, $07, $ae, $94, $c6, $d1, $f2, $f0, $0c, $f6, $00
.db $26, $10, $63, $0f, $69, $0f, $76, $0f, $81, $0f, $87, $0f, $94, $21, $98, $26
.db $95, $0f, $9a, $0f, $f2, $34, $10, $5d, $0f, $7f, $0f, $87, $0f, $8b, $0f, $f2
.db $f5, $0f, $10, $0c, $89, $0d, $89, $0e, $89, $0f, $89, $44, $10, $57, $54, $59
.db $2d, $67, $34, $78, $33, $87, $34, $89, $0b, $96, $32, $9a, $31, $f2, $ff
; 6-1 bugged area
.db $89, $ea, $30, $19 ; header?
.db $f5, $0f, $09 ; area pointer
.db $f0, $4e ; change ground setting
.db $f1, $75 ; change ground setting
.db $f1, $bc ; change ground setting
.db $46, $13 ; door
.db $ff ; This ends the level stuff early, so nothing spawns?
.db $ff
.db $6d, $81, $6e, $81, $6f, $80, $9b, $81, $f2, $f5, $0f, $50, $60, $80, $61, $80
.db $a4, $00, $a9, $06, $af, $00, $b0, $07, $b2, $07, $b4, $06, $b5, $08, $b6, $08
.db $b7, $07, $ba, $07, $bb, $08, $bc, $06, $bd, $07, $be, $07, $bf, $08, $f2, $f5
.db $0f, $30, $f1, $71, $a7, $00, $b0, $07, $b1, $07, $b2, $08, $b3, $06, $b4, $07
.db $b5, $07, $b6, $08, $b7, $08, $f2, $f5, $0f, $20, $f1, $4f, $f1, $ca

.db $6b, $32
.db $7b, $32, $8b, $32, $8c, $09

.db $9b, $30, $9d, $30, $f2, $ff

.db $89, $ea, $20, $1a
.db $f5, $0f, $13, $f0, $51, $83, $13
.db $ff, $ff
.db $f2, $f0, $0c, $47, $83, $66, $81
.db $85, $32, $92, $00, $93, $00, $94, $00, $95, $32, $f2, $f5, $10, $00, $f0, $0f
.db $f0, $6a, $f2, $ff

; area 2?
.db $18, $e3, $21, $19, $f5, $0f, $12, $f0, $44, $f0, $65, $f0
.db $86, $f0, $a7, $f1, $86, $f1, $a8, $f1, $cf, $65, $31, $69, $31, $96, $33, $b4
.db $31, $ba, $31, $f2, $f0, $4a, $f0, $cd, $f1, $6b, $f1, $a0, $f2, $f2, $ff

.db $18, $e3, $01, $01
.db $f0, $44, $f0, $65, $f0, $86, $f0, $a7, $f1, $66, $f1, $83, $f1
.db $a0, $64, $32, $69, $32, $94, $30, $9b, $30, $a5, $35, $c8, $24, $f2, $ff, $18
.db $e3, $21, $19, $f5, $0f, $11, $f0, $44, $f0, $65, $f0, $86, $f0, $a7, $f1, $86
.db $f1, $a8, $f1, $cf, $65, $31
.db $69, $31, $96, $33, $b4, $31, $ba, $31, $f2, $f0
.db $4a, $f0, $cd, $f1, $6b, $f1, $a0, $86, $82, $87, $82, $88, $82, $89, $82, $a6
.db $27, $a7, $22, $a8, $22, $a9, $27, $f2, $f2, $ff, $18, $e3, $01, $01, $f5, $0f
.db $02, $f0, $44, $f0, $65, $f0, $86, $f0, $a7, $f1, $86, $f1, $a8, $f1, $cf, $f6
.db $04, $65, $31, $69, $31, $93, $31, $9b, $31, $a7, $31, $c6, $26, $f2, $ff, $18
.db $e3, $01, $01, $f5, $0f, $02, $f0, $44, $f0, $65, $f0, $86, $f0, $a7, $f1, $86
.db $f1, $a8, $f1, $cf, $f6, $04, $65, $31, $69, $31, $93, $31, $9b, $31, $a7, $31
.db $c6, $26, $f2, $ff, $18, $e3, $01, $01, $f5, $0f, $02, $f0, $44, $f0, $65, $f0
.db $86, $f0, $a7, $f1, $86, $f1, $a8, $f1, $cf, $f6, $04, $65, $31, $69, $31, $93
.db $31, $9b, $31, $a7, $31, $c6, $26, $f2, $ff, $18, $e3, $01, $01, $f5, $0f, $02
.db $f0, $44, $f0, $65, $f0, $86, $f0, $a7, $f1, $86, $f1, $a8, $f1, $cf, $f6, $04
.db $65, $31, $69, $31, $93, $31, $9b, $31, $a7, $31, $c6, $26, $f2, $ff, $91, $ea
.db $10, $19


; 6-2

.db $f0, $54, $f1, $8f, $f2, $f5, $10, $10, $f0, $ce, $f1, $ea, $4c, $14
.db $f2, $ff, $91, $ea, $90, $18, $f5, $10, $01, $f0, $81, $f1, $88, $f1, $e0, $00
.db $0e, $93, $0b, $ff, $ff, $a9, $21, $f2, $f0, $88, $f2, $c9, $82, $ca, $82, $cb
.db $82, $f2, $f2, $8f, $86, $f2, $70, $26, $71, $21, $74, $2b, $80, $86, $81, $86
.db $84, $86, $85, $86, $f2, $f2, $f2, $f2, $f5, $10, $20, $f0, $8b, $f1, $8a, $4c
.db $0b, $80, $21, $90, $85, $91, $85, $f2, $ff, $91, $ea, $20, $1a, $f5, $10, $19
.db $f0, $4e, $43, $13, $ff, $ff, $f2, $f0, $90, $6a, $00, $78, $32, $7e, $31, $a4
.db $31, $c8, $00, $c9, $44, $f2, $f5, $11, $00, $f0, $0e, $f1, $0f, $f1, $ca, $7a
.db $82, $7b, $82, $7c, $82, $7d, $82, $f2, $ff, $91, $ea, $20, $1a, $f5, $10, $19
.db $f0, $4e, $43, $13, $ff, $ff, $f2, $f0, $90, $6a, $00, $78, $32, $7e, $31, $a4
.db $31, $c8, $00, $c9, $44, $f2, $f5, $11, $00, $f0, $0e, $f1, $0f, $f1, $ca, $7a
.db $82, $7b, $82, $7c, $82, $7d, $82, $f2, $ff, $91, $ea, $20, $1a, $f5, $10, $19
.db $f0, $4e, $43, $13, $ff, $ff, $f2, $f0, $90, $6a, $00, $78, $32, $7e, $31, $a4
.db $31, $c8, $00, $c9, $44, $f2, $f5, $11, $00, $f0, $0e, $f1, $0f, $f1, $ca, $7a
.db $82, $7b, $82, $7c, $82, $7d, $82, $f2, $ff, $91, $ea, $20, $1a, $f5, $10, $19
.db $f0, $4e, $43, $13, $ff, $ff, $f2, $f0, $90, $6a, $00, $78, $32, $7e, $31, $a4
.db $31, $c8, $00, $c9, $44, $f2, $f5, $11, $00, $f0, $0e, $f1, $0f, $f1, $ca, $7a
.db $82, $7b, $82, $7c, $82, $7d, $82, $f2, $ff, $91, $ea, $20, $1a, $f5, $10, $19
.db $f0, $4e, $43, $13, $ff, $ff, $f2, $f0, $90, $6a, $00, $78, $32, $7e, $31, $a4
.db $31, $c8, $00, $c9, $44, $f2, $f5, $11, $00, $f0, $0e, $f1, $0f, $f1, $ca, $7a
.db $82, $7b, $82, $7c, $82, $7d, $82, $f2, $ff, $91, $ea, $20, $1a, $f5, $10, $19
.db $f0, $4e, $43, $13, $ff, $ff, $f2, $f0, $90, $6a, $00, $78, $32, $7e, $31, $a4
.db $31, $c8, $00, $c9, $44, $f2, $f5, $11, $00, $f0, $0e, $f1, $0f, $f1, $ca, $7a
.db $82, $7b, $82, $7c, $82, $7d, $82, $f2, $ff, $91, $ea, $20, $1a, $f5, $10, $19
.db $f0, $4e, $43, $13, $ff, $ff, $f2, $f0, $90, $6a, $00, $78, $32, $7e, $31, $a4
.db $31, $c8, $00, $c9, $44, $f2, $f5, $11, $00, $f0, $0e, $f1, $0f, $f1, $ca, $7a
.db $82, $7b, $82, $7c, $82, $7d, $82, $f2, $ff, $91, $ea, $20, $1a, $f5, $10, $19
.db $f0, $4e, $43, $13, $ff, $ff, $f2, $f0, $90, $6a, $00, $78, $32, $7e, $31, $a4
.db $31, $c8, $00, $c9, $44, $f2, $f5, $11, $00, $f0, $0e, $f1, $0f, $f1, $ca, $7a
.db $82, $7b, $82, $7c, $82, $7d, $82, $f2, $ff, $89, $ea, $00, $01, $f5, $11, $11
.db $f0, $50, $f1, $ca, $07, $a9, $f2, $ff, $80, $ec, $40, $00, $f5, $11, $44, $f1
.db $0c, $f6, $01, $00, $89, $01, $89, $0a, $89, $0b, $89, $0c, $89, $0d, $89, $0e
.db $89, $0f, $89, $75, $0a, $ff, $ff, $94, $42, $f2, $f5, $11, $00, $f0, $cc, $f6
.db $00, $00, $89, $01, $89, $02, $89, $03, $89, $28, $10, $3a, $11, $6e, $0f, $88
.db $a6, $8c, $0f, $8f, $0f, $9a, $26, $a8, $05, $d8, $05, $f2, $f0, $4c, $f6, $02
.db $28, $11, $3d, $11, $44, $10, $94, $d1, $98, $d1, $9d, $0f, $f2, $f1, $cc, $f6
.db $00, $2a, $10, $34, $10, $3d, $11, $80, $2b, $90, $0f, $94, $d1, $9b, $d1, $9f
.db $2a, $f2, $f5, $11, $20, $0b, $89, $0c, $89, $0d, $89, $0e, $89, $0f, $89, $0a
.db $97, $19, $1e, $f2, $ff, $91, $ea, $72, $19, $f5, $11, $14, $f0, $8f, $65, $15
.db $66, $13, $ff, $ff, $f2, $f1, $5b, $34, $a4, $43, $29, $45, $29, $6d, $a1, $94
.db $04, $9f, $04, $aa, $39, $ba, $39, $ca, $39, $f2, $f0, $91, $f1, $1b, $f1, $f1
.db $65, $a1, $6a, $a1, $9c, $04, $a8, $36, $b8, $36, $c8, $36, $c2, $29, $ce, $29
.db $f2, $f0, $5c, $f0, $95, $2d, $83, $56, $25, $57, $25, $62, $31, $72, $31, $82
.db $31, $90, $41, $92, $31, $94, $83, $a2, $31, $a7, $29, $b2, $31, $b5, $3a, $c2
.db $31, $c5, $3a, $f2, $f0, $1c, $f1, $15, $60, $37, $70, $37, $80, $37, $90, $37
.db $98, $83, $99, $83, $9f, $83, $a0, $37, $b0, $37, $ca, $54, $c0, $37, $f2, $f0
.db $88, $f0, $b5, $f1, $1c, $f1, $35, $f1, $a8, $f1, $d5, $04, $88, $0d, $88, $50
.db $25, $52, $25, $56, $26, $5a, $25, $5c, $25, $5e, $25, $88, $80, $99, $83, $9a
.db $83, $c2, $25, $cf, $25, $f2, $f0, $5c, $f0, $75, $f1, $bc, $f1, $d1, $4d, $a8
.db $57, $25, $6d, $05, $72, $81, $93, $83, $c1, $25, $c0, $2d, $c4, $52, $c8, $52
.db $f2, $f5, $11, $39, $f1, $0c, $f1, $2a, $88, $12, $f2, $ff, $00, $f3, $90, $08
.db $f5, $11, $40, $34, $e1, $78, $e1, $d7, $12, $f2, $12, $e1, $19, $e4, $64, $12
.db $78, $12, $79, $12, $7a, $12, $7b, $12, $7c, $12, $f2, $04, $e1, $3a, $e2, $52
.db $12, $6d, $12, $76, $e1, $c4, $12, $f2, $0c, $12, $2b, $12, $46, $12, $4a, $12
.db $84, $e7, $b4, $12, $b5, $12, $c6, $12, $e7, $12, $e8, $12, $ec, $e1, $f2, $14
.db $00, $1a, $00, $23, $e1, $2a, $e2, $75, $e4, $a6, $e2, $c1, $e1, $f2, $1a, $12
.db $1d, $12, $44, $12, $56, $e2, $a2, $12, $a4, $e1, $e0, $eb, $ec, $03, $ed, $e2
.db $f2, $41, $ea, $4c, $03, $4d, $e1, $72, $12, $73, $12, $74, $12, $75, $12, $78
.db $12, $79, $12, $7a, $12, $9c, $12, $a7, $12, $f2, $37, $e1, $41, $12, $4d, $12
.db $72, $e2, $79, $e2, $a6, $e1, $b8, $12, $f2, $f0, $34, $19, $e1, $65, $12, $a6
.db $12, $c9, $12, $f2, $f5, $11, $27, $f0, $18, $f0, $57, $07, $0c, $f2, $f4, $44
.db $0d, $88, $0d, $f2, $22, $0d, $2d, $0d, $f2, $4a, $0d, $4b, $0d, $4c, $0d, $86
.db $0d, $f2, $43, $0c, $f2, $0d, $0d, $34, $0d, $3a, $0d, $d2, $0d, $f2, $9c, $0c
.db $f2, $0c, $0d, $51, $0d, $5d, $0d, $f2, $15, $0c, $29, $0c, $2a, $0c, $2b, $0c
.db $b6, $0d, $f2, $8e, $86, $ad, $84, $cb, $82, $cc, $82, $f2, $29, $8c, $46, $8a
.db $48, $8a, $d7, $03, $e7, $03, $f2, $ff, $80, $e8, $40, $00, $f5, $11, $30, $24
.db $10, $48, $0c, $4e, $11, $d0, $e7, $d8, $03, $d9, $ef, $f2, $30, $10, $58, $11
.db $bc, $3f, $ca, $3e, $de, $3f, $f2, $f5, $11, $50, $20, $10, $42, $11, $47, $17
.db $99, $0b, $bc, $37, $c9, $3c, $de, $33, $e3, $39, $f2, $38, $11, $49, $e2, $52
.db $10, $f2, $f5, $11, $10, $2a, $0a, $40, $e1, $44, $e1, $49, $e2, $8d, $11, $93
.db $10, $b8, $11, $f2, $ff, $a0, $ea, $13, $22, $f5, $11, $42, $f0, $af, $86, $13
.db $ff, $ff, $f2, $f5, $11, $60, $f0, $11, $f0, $6c, $f1, $4b, $f1, $ca, $53, $32
.db $57, $36, $96, $00, $f2, $ff, $aa, $f8, $13, $2a, $f0, $50, $f0, $cd, $f1, $0c
.db $f1, $4f, $f1, $8e, $f2, $f0, $50, $f1, $37, $f1, $6f, $f1, $97, $f1, $ca, $8b
.db $81, $95, $32, $c2, $00, $c3, $00, $c4, $00, $c5, $00, $c6, $00, $c7, $00, $c8
.db $00, $f2, $ff, $aa, $f8, $13, $2a, $f0, $50, $f0, $cd, $f1, $0c, $f1, $4f, $f1
.db $8e, $f2, $f0, $50, $f1, $37, $f1, $6f, $f1, $97, $f1, $ca, $8b, $81, $95, $32
.db $c2, $00, $c3, $00, $c4, $00, $c5, $00, $c6, $00, $c7, $00, $c8, $00, $f2, $ff
.db $aa, $f8, $13, $2a, $f0, $50, $f0, $cd, $f1, $0c, $f1, $4f, $f1, $8e, $f2, $f0
.db $50, $f1, $37, $f1, $6f, $f1, $97, $f1, $ca, $8b, $81, $95, $32, $c2, $00, $c3
.db $00, $c4, $00, $c5, $00, $c6, $00, $c7, $00, $c8, $00, $f2, $ff, $aa, $f8, $13
.db $2a, $f0, $50, $f0, $cd, $f1, $0c, $f1, $4f, $f1, $8e, $f2, $f0, $50, $f1, $37
.db $f1, $6f, $f1, $97, $f1, $ca, $8b, $81, $95, $32, $c2, $00, $c3, $00, $c4, $00
.db $c5, $00, $c6, $00, $c7, $00, $c8, $00, $f2, $ff, $00, $f3, $00, $00, $f5, $12
.db $12, $03, $a3, $43, $e5, $60, $86, $61, $86, $78, $e3, $aa, $e3, $d0, $ef, $f2
.db $ff, $80, $e8, $63, $00, $f5, $12, $20, $27, $a9, $94, $23, $a3, $81, $a4, $81
.db $a5, $81, $aa, $e3, $c2, $e9, $f2, $34, $e3, $e6, $80, $ec, $80, $f2, $f5, $12
.db $00, $2e, $11, $8c, $a6, $ad, $e2, $d6, $e5, $dc, $05, $dd, $e4, $f2, $21, $10
.db $9e, $01, $c1, $3c, $cf, $33, $ee, $80, $f2, $24, $10, $37, $11, $a6, $52, $a7
.db $2b, $aa, $22, $b5, $c6, $ce, $3a, $e3, $80, $ed, $80, $f2, $2d, $10, $89, $26
.db $9d, $00, $ac, $e7, $e9, $80, $f2, $f5, $12, $50, $47, $21, $73, $04, $83, $00
.db $91, $ee, $f2, $f4, $42, $0f, $46, $0f, $f2, $2c, $0f, $46, $0f, $f2, $37, $0f
.db $f2, $90, $0f, $ae, $0f, $f2, $93, $0f, $ad, $0f, $f2, $99, $0f, $f2, $56, $c4
.db $6d, $0f, $78, $0a, $f2, $ff, $80, $e8, $30, $00, $3c, $11, $49, $10, $9f, $eb
.db $c4, $e7, $cc, $e9, $f2, $24, $10, $3b, $29, $8c, $e6, $b1, $29, $b2, $e8, $c9
.db $ea, $f2, $2c, $29, $63, $ed, $83, $04, $86, $ea, $90, $ee, $a8, $e7, $b2, $ef
.db $d3, $ec, $f2, $f5, $12, $33, $0c, $a7, $71, $29, $82, $eb, $a0, $29, $a2, $e5
.db $c8, $e5, $d0, $e3, $f2, $f4, $95, $0f, $f2, $7b, $0f, $f2, $4f, $0f, $52, $0f
.db $f2, $0b, $0f, $81, $0f, $f2, $ff, $00, $f3, $30, $00, $f5, $12, $40, $64, $a6
.db $6a, $a6, $82, $e1, $84, $05, $85, $e4, $8a, $05, $8b, $e1, $b7, $aa, $d1, $e5
.db $d7, $05, $d8, $e5, $f2, $46, $ab, $48, $ab, $54, $aa, $5a, $aa, $71, $e2, $7b
.db $e2, $f2, $00, $ef, $76, $00, $77, $00, $78, $00, $79, $00, $82, $a7, $85, $00
.db $8a, $00, $95, $00, $9a, $00, $a0, $e1, $a2, $05, $a3, $ec, $f2, $f5, $12, $23
.db $35, $00, $3a, $00, $3c, $00, $40, $ef, $70, $ef, $aa, $e3, $b3, $a3, $d0, $e2
.db $d3, $05, $d4, $eb, $f2, $f4, $35, $c4, $53, $0f, $5b, $0f, $67, $0a, $f2, $32
.db $0f, $3c, $0f, $f2, $f2, $f2, $ff, $a1, $ea, $10, $02, $f5, $12, $30, $f0, $8b
.db $f1, $6c, $48, $0a, $4c, $33, $f2, $f5, $13, $00, $f0, $8d, $f1, $4c, $f1, $ca
.db $74, $39, $8a, $43, $9a, $43, $90, $00, $f2, $ff, $a1, $ea, $00, $01, $f5, $12
.db $16, $f0, $3c, $f1, $ea, $4c, $00, $61, $2d, $62, $21, $63, $21, $64, $21, $65
.db $21, $66, $26, $67, $51, $71, $38, $aa, $32, $b7, $0a, $f2, $ff, $a1, $ea, $00
.db $01, $f5, $12, $16, $f0, $3c, $f1, $ea, $4c, $00, $61, $2d, $62, $21, $63, $21
.db $64, $21, $65, $21, $66, $26, $67, $51, $71, $38, $aa, $32, $b7, $0a, $f2, $ff
.db $a1, $ea, $00, $01, $f5, $12, $16, $f0, $3c, $f1, $ea, $4c, $00, $61, $2d, $62
.db $21, $63, $21, $64, $21, $65, $21, $66, $26, $67, $51, $71, $38, $aa, $32, $b7
.db $0a, $f2, $ff, $a1, $ea, $00, $01, $f5, $12, $16, $f0, $3c, $f1, $ea, $4c, $00
.db $61, $2d, $62, $21, $63, $21, $64, $21, $65, $21, $66, $26, $67, $51, $71, $38
.db $aa, $32, $b7, $0a, $f2, $ff, $a1, $ea, $00, $01, $f5, $12, $16, $f0, $3c, $f1
.db $ea, $4c, $00, $61, $2d, $62, $21, $63, $21, $64, $21, $65, $21, $66, $26, $67
.db $51, $71, $38, $aa, $32, $b7, $0a, $f2, $ff, $80, $ff, $20, $00, $80, $e5, $8d
.db $e5, $aa, $e5, $d6, $e5, $f2, $32, $10, $4a, $10, $5c, $10, $b3, $e6, $bb, $e6
.db $f2, $f5, $13, $10, $22, $10, $67, $b5, $b2, $65, $d7, $e8, $f2, $f4, $20, $c4
.db $6f, $0f, $f2, $95, $0f, $9e, $0f, $f2, $08, $19, $0e, $19, $3b, $1d, $3e, $1d
.db $57, $40, $78, $1c, $98, $0b, $f2, $ff, $a1, $ea, $65, $01, $f5, $13, $02, $f0
.db $50, $87, $13, $a2, $3d, $f2, $f0, $34, $f0, $70, $f1, $14, $f1, $50, $f1, $94
.db $f1, $b0, $f1, $ef, $35, $84, $3b, $84, $9f, $04, $a0, $3e, $f2, $f0, $17, $f0
.db $50, $81, $4e, $c2, $7d, $f2, $f1, $14, $f1, $50, $9d, $04, $a0, $4c, $ad, $82
.db $ae, $43, $c0, $7c, $ce, $75, $f2, $f5, $13, $60, $72, $3d, $97, $80, $a7, $a4
.db $ae, $4f, $b4, $81, $d7, $03, $f2, $70, $35, $ae, $46, $c4, $76, $cc, $78, $f2
.db $f5, $13, $22, $f1, $2a, $08, $a6, $86, $84, $87, $84, $88, $84, $c5, $80, $f2
.db $ff, $a1, $ea, $95, $01, $f5, $13, $93, $f0, $50, $f0, $ef, $f1, $50, $f1, $ea
.db $88, $0a, $93, $2b, $95, $0f, $9b, $0f, $a3, $0f, $ad, $0f, $c4, $2a, $cc, $26
.db $f2, $f5, $13, $86, $f0, $10, $f0, $91, $f1, $90, $08, $a9, $3c, $81, $3d, $80
.db $6a, $a3, $bc, $81, $cd, $80, $f2, $f5, $13, $16, $f0, $91, $f1, $0a, $32, $80
.db $33, $81, $65, $a3, $67, $a8, $a7, $03, $b3, $81, $c2, $80, $d7, $03, $f2, $f5
.db $13, $73, $f1, $11, $f1, $90, $08, $a9, $3c, $81, $3d, $80, $6a, $a3, $bc, $81
.db $cd, $80, $f2, $f5, $13, $66, $f0, $91, $f0, $fb, $f1, $4a, $32, $80, $33, $81
.db $65, $a3, $b3, $81, $b8, $0a, $c2, $80, $f2, $f5, $13, $41, $f1, $11, $f1, $cf
.db $08, $a7, $98, $4e, $f2, $f5, $13, $70, $f0, $f0, $f1, $ca, $37, $ab, $d7, $03
.db $f2, $f5, $13, $43, $f0, $af, $78, $0a, $95, $3d, $f2, $f5, $13, $44, $f0, $6a
.db $f0, $dc, $02, $a7, $86, $2d, $96, $0f, $a9, $0f, $af, $0f, $bc, $0f, $cb, $26
.db $cd, $2a, $f2, $f5, $13, $32, $f0, $6e, $f1, $ca, $4c, $0a, $92, $0f, $f2, $ff
.db $a1, $ea, $34, $01, $f5, $13, $63, $f0, $50, $5c, $40, $6c, $a4, $85, $0a, $a4
.db $33, $f2, $30, $4f, $40, $a7, $45, $a7, $4c, $a7, $c0, $4f, $f2, $f5, $13, $29
.db $30, $4f, $40, $4f, $50, $a5, $85, $35, $93, $0a, $b0, $4f, $c0, $4f, $f2, $f5
.db $13, $69, $f0, $11, $f1, $4a, $60, $a3, $88, $0a, $f2, $ff, $a1, $ea, $95, $02
.db $f5, $13, $80, $f0, $50, $3f, $a7, $66, $80, $76, $a3, $b3, $0a, $c9, $01, $f2
.db $f5, $13, $25, $50, $87, $51, $87, $52, $3d, $97, $80, $9b, $81, $9e, $81, $9f
.db $81, $a7, $a4, $d7, $03, $f2, $f5, $13, $47, $50, $3f, $a5, $0f, $ab, $0f, $b4
.db $0f, $b8, $09, $bc, $0f, $f2, $f5, $13, $27, $50, $3f, $a2, $80, $a5, $80, $b7
.db $0a, $f2, $f5, $13, $28, $f1, $ca, $3a, $a6, $3d, $ab, $50, $37, $58, $87, $59
.db $87, $dd, $03, $f2, $f2, $f2, $f5, $13, $42, $f0, $50, $b7, $0a, $f2, $a3, $00
.db $a8, $00, $b3, $0f, $b8, $0f, $f2, $f5, $13, $50, $f1, $4f, $f1, $8a, $a4, $0f
.db $b2, $0f, $b3, $0f, $b5, $0f, $b6, $0f, $f2, $ff, $aa, $ea, $22, $0b, $f0, $4f
.db $f0, $ac, $f1, $6e, $3d, $2c, $92, $48, $f2, $f1, $3a, $f1, $dc, $30, $2c, $33
.db $2c, $36, $2c, $4d, $2c, $8f, $32, $a9, $44, $f2, $f1, $7a, $f1, $d8, $40, $2c
.db $43, $2c, $46, $2c, $49, $2c, $74, $32, $92, $1a, $a0, $1a, $a4, $1a, $a8, $0f
.db $a9, $44, $b2, $41, $c0, $45, $f2, $ff, $21, $e0, $97, $01, $f5, $13, $14, $f0
.db $55, $f1, $dc, $08, $a5, $92, $4b, $d2, $4b, $f2, $f0, $75, $f1, $1c, $f1, $95
.db $13, $29, $32, $4b, $72, $4b, $ac, $29, $c2, $4b, $f2, $f0, $5c, $f0, $d5, $f1
.db $7c, $12, $4b, $4c, $29, $62, $4b, $a2, $4b, $d3, $29, $f2, $f5, $13, $30, $f0
.db $15, $f1, $a0, $02, $4b, $37, $29, $42, $4b, $ba, $0a, $f2, $f2, $f2, $f5, $13
.db $24, $f0, $97, $f1, $00, $48, $aa, $67, $0a, $88, $03, $f2, $f0, $76, $f1, $20
.db $f1, $56, $08, $ae, $5a, $29, $65, $29, $98, $03, $ca, $29, $d6, $29, $f2, $f0
.db $20, $f0, $56, $f1, $00, $f1, $36, $08, $a4, $18, $03, $4b, $29, $54, $29, $68
.db $a5, $88, $03, $c6, $29, $ca, $29, $d8, $ab, $f2, $f5, $13, $33, $f0, $00, $f1
.db $17, $f1, $a0, $08, $03, $b7, $0a, $f2, $ff, $21, $e0, $35, $01, $f5, $13, $26
.db $f0, $54, $08, $a4, $76, $33, $a4, $37, $d1, $33, $db, $43, $f2, $f0, $f5, $15
.db $36, $25, $46, $45, $46, $55, $36, $72, $42, $a3, $44, $d8, $33, $f2, $f0, $9c
.db $f0, $b4, $1b, $42, $36, $73, $3c, $31, $76, $35, $a3, $39, $d6, $33, $f2, $f5
.db $13, $23, $f1, $a0, $13, $49, $42, $49, $6c, $42, $84, $37, $97, $80, $a1, $32
.db $a7, $a4, $d7, $03, $f2, $ff, $21, $e0, $64, $01, $f5, $13, $40, $f0, $54, $28
.db $a8, $4c, $0a, $69, $45, $f2, $05, $35, $52, $32, $95, $33, $d8, $34, $f2, $f0
.db $95, $14, $37, $42, $33, $6c, $31, $a6, $32, $d8, $33, $f2, $f5, $13, $90, $f1
.db $5c, $15, $35, $62, $33, $75, $ad, $77, $33, $82, $0a, $a2, $32, $a5, $03, $aa
.db $31, $ba, $a9, $da, $03, $db, $32, $f2, $f0, $d4, $61, $86, $74, $30, $76, $33
.db $7b, $30, $a4, $36, $d1, $af, $d4, $36, $f2, $f0, $20, $f1, $14, $11, $03, $84
.db $a6, $86, $a6, $87, $82, $88, $a6, $8a, $a6, $8d, $ae, $f2, $f5, $13, $21, $f0
.db $00, $f0, $94, $f1, $a0, $0d, $03, $4e, $a8, $77, $40, $87, $a6, $d7, $03, $f2
.db $f4, $d6, $0f, $d9, $0f, $f2, $33, $0f, $76, $0f, $aa, $0f, $f2, $67, $0f, $8a
.db $0f, $f2, $46, $0f, $f2, $f2, $f2, $f2, $ff, $01, $fe, $30, $00, $f5, $13, $83
.db $28, $10, $6d, $81, $8b, $ad, $8d, $0a, $ab, $05, $ac, $41, $c2, $10, $f2, $16
.db $10, $5c, $aa, $7b, $80, $7c, $05, $81, $10, $a8, $11, $eb, $aa, $f2, $05, $10
.db $1b, $05, $1c, $80, $8c, $aa, $91, $10, $ab, $80, $ac, $05, $c4, $35, $d4, $35
.db $e4, $35, $f2, $f5, $13, $20, $f0, $80, $f1, $57, $f1, $a0, $04, $35, $14, $33
.db $18, $ab, $24, $33, $34, $33, $48, $05, $b7, $0a, $f2, $ff, $ff, $ff, $ff, $ff
.db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff

.pad $A000, $FF

; Enemy area data?
.db $01, $01, $05, $03, $76, $03, $6c, $01
.db $05, $14, $56, $14, $ad, $03, $03, $9d, $07, $0e, $83, $0e, $79, $03, $bc, $05, $0e, $90, $0e, $75

.db $03, $01, $ec, $07
.db $01, $1c, $02, $5c, $03, $e5, $07, $01, $6c, $02, $8c, $01, $cc, $05, $03, $79
.db $01, $d4, $09, $01, $04, $02, $34, $3b, $87, $3b, $c7, $07, $03, $a9, $03, $bc
.db $03, $c6, $05, $01, $9c, $03, $e5, $05, $01, $2c, $02, $4c, $07, $01, $1c, $03
.db $45, $02, $4c, $05, $01, $95, $14, $d1

.db $03, $03, $85, $01, $01

.db $03, $0e, $bc
.db $01, $01
.db $01, $01, $01, $01, $01, $01, $01, $03, $0e, $bc, $01, $01 ; what is this data?



.db $01, $01
.db $07, $1c, $a7, $44, $a8, $43, $e7, $01, $01


.db $01, $01, $07, $1c, $a7, $44, $a8
.db $43, $e7, $01, $01, $01, $01, $07, $1c, $a7, $44, $a8, $43, $e7, $01, $01, $01
.db $01, $07, $1c, $a7, $44, $a8, $43, $e7, $01, $01, $01, $01, $07, $1c, $a7, $44
.db $a8, $43, $e7, $01, $01, $03, $42, $6a, $03, $12, $22, $09, $0f, $00, $0f, $40
.db $0f, $90, $0f, $e0, $01, $05, $0e, $3c, $0e, $6c, $05, $06, $53, $0d, $83, $05
.db $01, $b6, $01, $f6, $01, $03, $01, $dc, $03, $07, $3c, $03, $06, $2c, $05, $0d
.db $79, $0d, $89, $01, $05, $1c, $a7, $44, $a8, $03, $43, $38, $05, $3d, $79, $17
.db $77, $03, $02, $28, $01, $01, $01, $01, $01, $01, $01, $01, $01, $03, $02, $28
.db $01, $01, $01, $03, $42, $38, $05, $07, $94, $07, $b4, $03, $01, $74, $05, $13
.db $34, $13, $a4, $07, $13, $02, $13, $62, $3b, $e6, $05, $3b, $26, $3b, $66, $09
.db $13, $4a, $3b, $5c, $13, $8a, $3b, $9c, $01, $01, $01, $03, $42, $38, $05, $07
.db $94, $07, $b4, $03, $01, $74, $05, $13, $34, $13, $a4, $07, $13, $02, $13, $62
.db $3b, $e6, $05, $3b, $26, $3b, $66, $09, $13, $4a, $3b, $5c, $13, $8a, $3b, $9c
.db $01, $01, $01, $03, $42, $38, $05, $07, $94, $07, $b4, $03, $01, $74, $05, $13
.db $34, $13, $a4, $07, $13, $02, $13, $62, $3b, $e6, $05, $3b, $26, $3b, $66, $09
.db $13, $4a, $3b, $5c, $13, $8a, $3b, $9c, $01, $01, $01, $03, $42, $38, $05, $07
.db $94, $07, $b4, $03, $01, $74, $05, $13, $34, $13, $a4, $07, $13, $02, $13, $62
.db $3b, $e6, $05, $3b, $26, $3b, $66, $09, $13, $4a, $3b, $5c, $13, $8a, $3b, $9c
.db $01, $01, $01, $03, $42, $38, $05, $07, $94, $07, $b4, $03, $01, $74, $05, $13
.db $34, $13, $a4, $07, $13, $02, $13, $62, $3b, $e6, $05, $3b, $26, $3b, $66, $09
.db $13, $4a, $3b, $5c, $13, $8a, $3b, $9c, $03, $42, $38, $05, $07, $94, $07, $b4
.db $03, $01, $74, $05, $13, $34, $13, $a4, $07, $13, $02, $13, $62, $3b, $e6, $05
.db $3b, $26, $3b, $66, $09, $13, $4a, $3b, $5c, $13, $8a, $3b, $9c, $05, $03, $2a
.db $03, $7a, $09, $0d, $29, $0d, $49, $02, $7a, $02, $9a, $01, $07, $17, $83, $3d
.db $88, $2e, $8a, $07, $2e, $4b, $30, $7c, $30, $c9, $01, $07, $30, $61, $31, $5a
.db $03, $ba, $03, $01, $db, $03, $06, $4a, $03, $03, $35, $01, $03, $31, $c9, $03
.db $2f, $c6, $09, $02, $56, $07, $d4, $07, $d7, $07, $da, $05, $30, $a7, $30, $f7
.db $05, $2e, $3a, $2e, $6a, $09, $0d, $09, $0d, $29, $44, $a8, $43, $d7, $03, $30
.db $f6, $04, $fe, $1d, $d7, $01, $01, $01, $01, $01, $01, $01, $01, $03, $30, $f6
.db $04, $fe, $1d, $d7, $03, $30, $f6, $04, $fe, $1d, $d7, $03, $30, $f6, $04, $fe
.db $1d, $d7, $03, $30, $f6, $04, $fe, $1d, $d7, $03, $30, $f6, $04, $fe, $1d, $d7
.db $03, $30, $f6, $04, $fe, $1d, $d7, $01, $03, $19, $fa, $03, $18, $a7, $05, $01
.db $69, $03, $99, $03, $18, $47, $03, $03, $f8, $01, $07, $23, $24, $01, $27, $01
.db $49, $03, $19, $4a, $01, $05, $01, $49, $01, $6d, $03, $01, $d3, $07, $01, $40
.db $06, $16, $01, $c8, $01, $01, $05, $1c, $a8, $44, $a9, $03, $43, $d3, $01, $05
.db $1c, $a8, $44, $a9, $03, $43, $d3, $03, $06, $6c, $01, $01, $01, $01, $01, $01
.db $01, $01, $01, $03, $06, $6c, $01, $05, $1c, $a8, $44, $a9, $03, $43, $d3, $01
.db $05, $1c, $a8, $44, $a9, $03, $43, $d3, $01, $05, $1c, $a8, $44, $a9, $03, $43
.db $d3, $01, $05, $1c, $a8, $44, $a9, $03, $43, $d3, $01, $05, $1c, $a8, $44, $a9
.db $03, $43, $d3, $03, $42, $5a, $01, $01, $03, $19, $8d, $05, $0f, $50, $18, $fa
.db $03, $01, $99, $05, $18, $0a, $18, $37, $07, $0f, $10, $18, $15, $3b, $97, $07
.db $18, $58, $18, $a8, $18, $e7, $09, $18, $28, $18, $57, $1a, $86, $18, $97, $03
.db $23, $b5, $03, $23, $05, $07, $03, $b8, $03, $f8, $03, $fb, $01, $01, $03, $01
.db $8a, $05, $01, $c2, $01, $67, $07, $0e, $a0, $01, $78, $01, $bd, $03, $06, $e2
.db $03, $01, $b9, $01, $01, $01, $01, $01, $01, $01, $01, $01, $03, $01, $b9, $01
.db $05, $1c, $b4, $44, $b4, $03, $43, $b3, $01, $05, $1c, $b4, $44, $b4, $03, $43
.db $b3, $01, $05, $1c, $b4, $44, $b4, $03, $43, $b3, $01, $05, $1c, $b4, $44, $b4
.db $03, $43, $b3, $01, $05, $1c, $b4, $44, $b4, $03, $43, $b3, $03, $42, $17, $03
.db $03, $c7, $03, $49, $20, $05, $0f, $20, $48, $a0, $01, $01, $03, $48, $80, $01
.db $03, $49, $00, $05, $19, $7a, $1a, $d6, $01, $01, $01, $03, $03, $4b, $05, $01
.db $d5, $01, $aa, $05, $03, $d2, $01, $d5, $03, $02, $88, $07, $01, $83, $01, $a9
.db $01, $1d, $07, $01, $b1, $01, $89, $01, $3d, $03, $01, $e3, $03, $01, $b9, $01
.db $01, $01, $01, $01, $01, $01, $01, $01, $03, $01, $b9, $01, $09, $01, $15, $01
.db $08, $01, $f8, $01, $cb, $01, $07, $23, $14, $03, $39, $03, $7b, $03, $18, $67
.db $07, $18, $0a, $44, $3b, $18, $6a, $03, $43, $97, $01, $06, $fe, $1f, $c5, $02
.db $d0, $07, $17, $83, $3d, $87, $2f, $a9, $07, $17, $83, $3d, $87, $2f, $a9, $07
.db $17, $83, $3d, $87, $2f, $a9, $01, $01, $03, $49, $08, $03, $48, $0e, $03, $48
.db $02, $05, $12, $92, $49, $09, $03, $03, $e5, $05, $03, $21, $03, $87, $01, $01
.db $01, $01, $01, $01, $01, $01, $03, $03, $2b, $03, $25, $12, $03, $23, $95, $03
.db $03, $65, $03, $24, $05, $01, $07, $43, $93, $1c, $b9, $44, $ba, $01, $01, $01
.db $01, $01, $01, $01, $01, $01, $07, $43, $93, $1c, $b9, $44, $ba, $01, $01, $05
.db $42, $42, $49, $40, $05, $08, $25, $48, $c0, $01, $03, $48, $00, $05, $25, $e6
.db $49, $80, $01, $05, $08, $35, $08, $55, $05, $06, $a4, $06, $cb, $01, $03, $06
.db $96, $05, $42, $42, $49, $40, $05, $08, $25, $48, $c0, $01, $03, $48, $00, $05
.db $25, $e6, $49, $80, $01, $05, $08, $35, $08, $55, $05, $06, $a4, $06, $cb, $01
.db $03, $06, $96, $05, $42, $42, $49, $40, $05, $08, $25, $48, $c0, $01, $03, $48
.db $00, $05, $25, $e6, $49, $80, $01, $05, $08, $35, $08, $55, $05, $06, $a4, $06
.db $cb, $01, $03, $06, $96, $05, $42, $42, $49, $40, $05, $08, $25, $48, $c0, $01
.db $03, $48, $00, $05, $25, $e6, $49, $80, $01, $05, $08, $35, $08, $55, $05, $06
.db $a4, $06, $cb, $01, $03, $06, $96, $05, $42, $42, $49, $40, $05, $08, $25, $48
.db $c0, $01, $03, $48, $00, $05, $25, $e6, $49, $80, $01, $05, $08, $35, $08, $55
.db $05, $06, $a4, $06, $cb, $01, $03, $06, $96, $05, $42, $42, $49, $40, $05, $08
.db $25, $48, $c0, $01, $03, $48, $00, $05, $25, $e6, $49, $80, $01, $05, $08, $35
.db $08, $55, $05, $06, $a4, $06, $cb, $01, $03, $06, $96, $07, $04, $3c, $04, $6c
.db $04, $ec, $03, $04, $1c, $01, $01, $03, $03, $29, $07, $02, $29, $02, $49, $02
.db $6c, $01, $01, $05, $1c, $b6, $44, $b6, $03, $43, $fa, $01, $01, $01, $04, $fe
.db $1c, $c7, $03, $42, $4a, $01, $01, $01, $01, $01, $01, $01, $01, $01, $03, $42
.db $4a, $01, $03, $42, $4a, $01, $03, $42, $4a, $01, $03, $42, $4a, $01, $03, $42
.db $4a, $01, $03, $42, $4a, $01, $03, $42, $4a, $01, $01, $01, $07, $0a, $14, $08
.db $58, $0a, $84, $01, $03, $31, $65, $05, $0e, $75, $0e, $95, $09, $30, $05, $31
.db $55, $0d, $ac, $0d, $cc, $01, $01, $09, $31, $72, $2e, $84, $2e, $b7, $30, $4c
.db $07, $2e, $81, $2f, $1a, $31, $df, $07, $2e, $35, $2e, $96, $2e, $18, $03, $31
.db $71, $03, $31, $cf, $07, $2f, $20, $31, $70, $2e, $7e, $07, $2f, $71, $30, $8d
.db $31, $7f, $05, $30, $34, $30, $c7, $01, $03, $06, $6c, $05, $23, $8d, $23, $cd
.db $05, $02, $57, $02, $ed, $01, $05, $05, $c2, $07, $3b, $05, $07, $c4, $03, $3d
.db $03, $0e, $d6, $01, $01, $01, $03, $06, $6c, $05, $23, $8d, $23, $cd, $05, $02
.db $57, $02, $ed, $01, $05, $05, $c2, $07, $3b, $05, $07, $c4, $03, $3d, $03, $0e
.db $d6, $03, $15, $6f, $03, $15, $6b, $03, $15, $67, $03, $15, $63, $0b, $31, $73
.db $2f, $84, $31, $79, $17, $87, $3d, $89, $01, $05, $0e, $c9, $0e, $e9, $03, $0d
.db $e9, $05, $0d, $09, $0d, $29, $05, $44, $6b, $43, $aa, $03, $2f, $22, $06, $2f
.db $62, $fe, $1d, $d6, $03, $2f, $22, $06, $2f, $62, $fe, $1d, $d6, $01, $05, $29
.db $96, $13, $b2, $03, $13, $22, $0b, $29, $09, $29, $29, $13, $35, $29, $d9, $29
.db $f6, $01, $09, $29, $46, $29, $98, $29, $a6, $29, $f8, $05, $13, $13, $29, $b8
.db $05, $29, $08, $29, $b5, $05, $29, $35, $13, $41, $01, $01, $01, $03, $26, $58
.db $01, $07, $29, $0a, $26, $58, $29, $9a, $05, $29, $3a, $29, $dc, $03, $26, $f6
.db $01, $05, $29, $3c, $26, $d7, $05, $44, $85, $43, $d4, $01, $04, $fe, $1c, $b8
.db $01, $04, $fe, $1c, $b8, $01, $04, $fe, $1c, $b8, $01, $01, $01, $01, $01, $01
.db $01, $01, $01, $04, $fe, $1c, $b8, $01, $04, $fe, $1c, $b8, $01, $04, $fe, $1c
.db $b8, $01, $04, $fe, $1c, $b8, $01, $04, $fe, $1c, $b8, $01, $04, $fe, $1c, $b8
.db $03, $42, $47, $01, $05, $10, $d3, $10, $f5, $03, $10, $d8, $09, $10, $16, $10
.db $37, $10, $44, $10, $78, $0b, $10, $67, $10, $98, $10, $c7, $10, $e4, $10, $f8
.db $07, $29, $c8, $29, $e8, $10, $f3, $05, $10, $a6, $10, $d8, $0b, $10, $37, $10
.db $53, $10, $95, $10, $d8, $10, $f4, $0b, $10, $3a, $10, $56, $10, $7b, $10, $84
.db $10, $f7, $07, $10, $23, $10, $66, $29, $b8, $01, $01, $03, $28, $6a, $05, $28
.db $7a, $28, $fa, $01, $03, $28, $da, $05, $28, $69, $07, $98, $09, $28, $2a, $03
.db $39, $28, $ba, $03, $c9, $05, $28, $69, $03, $88, $05, $28, $a9, $29, $d3, $01
.db $01, $03, $26, $c7, $01, $05, $04, $99, $04, $c9, $01, $05, $1c, $b8, $44, $b9
.db $03, $43, $ba, $01, $01, $01, $01, $01, $01, $01, $01, $05, $1c, $b8, $44, $b9
.db $03, $43, $ba, $01, $05, $1c, $b8, $44, $b9, $03, $43, $ba, $01, $05, $1c, $b8
.db $44, $b9, $03, $43, $ba, $01, $05, $1c, $b8, $44, $b9, $03, $43, $ba, $01, $05
.db $1c, $b8, $44, $b9, $03, $43, $ba, $01, $05, $1c, $b8, $44, $b9, $03, $43, $ba
.db $03, $42, $2a, $01, $03, $1c, $a9, $01, $01, $01, $01, $01, $01, $01, $03, $10
.db $18, $09, $29, $ea, $29, $ec, $29, $de, $29, $ee, $03, $29, $ee, $05, $29, $e0
.db $29, $e2, $03, $29, $8c, $09, $29, $92, $29, $b2, $29, $e9, $29, $eb, $05, $29
.db $71, $29, $e4, $01, $07, $01, $c8, $03, $d8, $02, $e8, $01, $01, $01, $07, $29
.db $72, $29, $82, $29, $7e, $01, $03, $29, $c1, $01, $01, $01, $01, $01, $01, $01
.db $01, $01, $01, $01, $01, $01, $01, $09, $17, $72, $3d, $74, $29, $57, $29, $97
.db $05, $29, $65, $29, $95, $05, $44, $2a, $43, $87, $04, $fe, $2a, $24, $01, $01
.db $01, $01, $01, $01, $03, $42, $31, $03, $08, $45, $03, $23, $56, $01, $03, $3b
.db $e4, $09, $3b, $34, $3b, $84, $13, $b2, $3b, $d4, $05, $13, $82, $13, $c2, $05
.db $13, $02, $3b, $a4, $07, $13, $42, $13, $82, $13, $c2, $03, $13, $b2, $05, $3b
.db $94, $3b, $e4, $01, $05, $1c, $c4, $44, $c5, $03, $43, $ca, $03, $42, $2a, $01
.db $03, $42, $2a, $01, $01, $01, $01, $01, $01, $01, $01, $01, $03, $42, $2a, $01
.db $03, $42, $2a, $01, $03, $42, $2a, $01, $03, $42, $2a, $01, $03, $42, $2a, $01
.db $03, $42, $2a, $01, $03, $42, $2a, $01, $01, $07, $14, $78, $14, $96, $14, $b8
.db $09, $08, $29, $14, $d6, $14, $e6, $14, $f6, $01, $09, $04, $8c, $04, $9c, $08
.db $ab, $04, $bc, $05, $14, $89, $14, $b9, $05, $14, $55, $14, $95, $07, $14, $17
.db $25, $38, $14, $57, $05, $0d, $26, $0d, $46, $05, $04, $6a, $08, $99, $03, $14
.db $8b, $09, $10, $f2, $14, $68, $14, $8e, $06, $de, $0b, $10, $02, $06, $c5, $06
.db $36, $10, $8e, $10, $de, $01, $01, $01, $01, $01, $01, $01, $05, $13, $55, $13
.db $85, $07, $13, $73, $1c, $b8, $44, $b9, $03, $43, $b4, $01, $01, $01, $01, $01
.db $01, $01, $01, $07, $13, $73, $1c, $b8, $44, $b9, $03, $43, $b4, $01, $07, $13
.db $73, $1c, $b8, $44, $b9, $03, $43, $b4, $03, $42, $3a, $01, $03, $42, $3a, $01
.db $03, $42, $3a, $01, $03, $42, $3a, $01, $03, $42, $3a, $01, $03, $49, $80, $01
.db $03, $47, $00, $01, $03, $47, $40, $03, $49, $c0, $03, $49, $c0, $07, $09, $2c
.db $09, $7c, $09, $ac, $01, $05, $09, $58, $09, $78, $01, $05, $23, $36, $09, $c6
.db $03, $09, $36, $05, $09, $25, $09, $45, $03, $16, $a5, $01, $05, $24, $52, $24
.db $3d, $01, $09, $09, $90, $09, $b0, $2f, $d5, $30, $4f, $05, $15, $82, $2f, $a8
.db $07, $30, $41, $15, $84, $31, $8a, $01, $01, $01, $05, $07, $67, $12, $d2, $01
.db $03, $12, $f2, $01, $07, $0f, $60, $03, $92, $03, $a6, $05, $03, $07, $03, $55
.db $05, $1c, $b7, $44, $b8, $03, $43, $b5, $01, $01, $05, $07, $67, $12, $d2, $01
.db $03, $12, $f2, $01, $07, $0f, $60, $03, $92, $03, $a6, $05, $03, $07, $03, $55
.db $05, $1c, $b7, $44, $b8, $03, $43, $b5, $01, $04, $fe, $21, $a7, $01, $04, $fe
.db $21, $a7, $01, $04, $fe, $21, $a7, $01, $04, $fe, $21, $a7, $01, $04, $fe, $21
.db $a7, $03, $42, $4a, $07, $19, $1d, $03, $ab, $19, $dd, $03, $18, $5a, $03, $1a
.db $49, $07, $19, $1d, $19, $5d, $03, $7b, $03, $18, $ea, $07, $18, $1a, $19, $ad
.db $19, $bd, $03, $1a, $e6, $05, $1a, $36, $24, $99

; area 1 $42
.db $01, $01, $07, $18, $4b, $18

.db $9a, $15, $fb, $05, $18, $2b, $18, $7b, $01, $01, $05, $1c, $c8, $44, $c8, $03
.db $43, $27, $03, $01, $5a, $09, $01, $41, $01, $b4, $17, $85, $3d, $69, $01, $05
.db $01, $2a, $01, $da, $01, $01, $01, $01, $01, $01, $01, $01, $01, $05, $01, $2a
.db $01, $da, $03, $01, $5a, $05, $01, $41, $01, $b4, $01, $03, $01, $b8, $03, $01
.db $b8, $03, $01, $b8, $03, $01, $b8
.db $03, $42, $2a, $01 ; Missing a $01 here?
.db $05, $0b, $0c, $0b, $26
.db $07, $0c, $ab, $0c, $c9, $0c, $e7, $03, $25, $ab, $07, $10, $55, $10, $85, $10
.db $a5, $05, $0c, $98, $0c, $c8, $03, $10, $a3, $07, $0c, $63, $0c, $65, $0c, $67
.db $07, $0c, $65, $0c, $93, $0c, $c4, $03, $0c, $eb, $05, $0c, $29, $0c, $a9, $01
.db $05, $1c, $ca, $44, $cb, $03, $43, $d4, $01, $05, $1c, $ca, $44, $cb, $03, $43
.db $d4, $01, $05, $1c, $ca, $44, $cb, $03, $43, $d4, $01, $01, $01, $01, $01, $01
.db $01, $01, $05, $1c, $ca, $44, $cb, $03, $43, $d4, $01, $05, $1c, $ca, $44, $cb
.db $03, $43, $d4, $01, $05, $1c, $ca, $44, $cb, $03, $43, $d4, $01, $05, $1c, $ca
.db $44, $cb, $03, $43, $d4, $01, $05, $1c, $ca, $44, $cb, $03, $43, $d4, $01, $05
.db $1c, $ca, $44, $cb, $03, $43, $d4, $03

.db $42, $2a, $01, $01
.db $03, $03, $98, $07
.db $03, $48, $1a, $66, $19, $aa, $01, $01, $05, $16, $49, $16, $f9, $05, $09, $a9
.db $16, $c9, $03, $0d, $f5, $07, $0d, $27, $0d, $38, $0d, $56, $01, $01, $01, $01
.db $09, $14, $95, $14, $a4, $14, $b3, $14, $c2, $07, $14, $a7, $14, $ba, $14, $c8
.db $03, $14, $34, $07, $14, $4a, $06, $75, $06, $7e, $03, $01, $28, $07, $14, $9c
.db $14, $ad, $14, $be, $03, $14, $5c, $03, $14, $93, $01, $01, $01, $01, $01, $01
.db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $07, $43, $97, $1c, $b3
.db $44, $b4, $01, $04, $fe, $1f, $b5, $01, $04, $fe, $1f, $b5, $01, $04, $fe, $1f
.db $b5, $01, $04, $fe, $1f, $b5, $03, $42, $2a, $01, $01, $01, $0d, $09, $8b, $0c
.db $94, $09, $94, $0d, $b8, $0c, $e4, $09, $e4, $07, $09, $2b, $0c, $e4, $09, $e4
.db $0d, $0e, $3b, $0c, $54, $09, $54, $09, $6b, $0c, $94, $09, $94, $07, $15, $37
.db $0c, $f3, $09, $f3, $01, $07, $02, $a8, $06, $b6, $06, $cb, $07, $15, $38, $03
.db $dc, $06, $f3, $05, $0d, $59, $06, $ab, $01, $07, $06, $21, $14, $66, $14, $8b
.db $07, $31, $87, $31, $d7, $2f, $d9, $05, $31, $e0, $31, $63, $01, $07, $43, $9a
.db $1c, $c5, $44, $c6, $01, $01, $01, $01, $01, $01, $01, $01, $01, $07, $43, $9a
.db $1c, $c5, $44, $c6, $05, $31, $b9, $31, $c3, $05, $31, $b9, $31, $c3, $05, $31
.db $b9, $31, $c3, $05, $31, $b9, $31, $c3, $05, $31, $b9, $31, $c3, $03, $06, $f5
.db $05, $06, $58, $06, $e8, $03, $0e, $74, $01, $07, $01, $99, $01, $d9, $15, $f9
.db $07, $0e, $77, $0e, $a7, $0e, $c7, $03, $16, $d9, $01, $05, $25, $1c, $25, $bc
.db $03, $25, $5b, $01, $05, $31, $99, $31, $ec, $05, $31, $24, $31, $69, $05, $2f
.db $96, $2f, $e3, $03, $2f, $3a, $03, $1c, $b7, $01, $07, $1c, $b7, $17, $a4, $3d
.db $b8, $01, $01, $07, $2f, $b8, $30, $f3, $2e, $fc, $09, $2f, $34, $2f, $74, $2f
.db $a4, $30, $ab, $07, $30, $1a, $2f, $79, $30, $f5, $01, $09, $2f, $23, $2f, $83
.db $2f, $e3, $31, $cc, $05, $2f, $bb, $2f, $fb, $03, $2f, $53, $09, $31, $29, $2e
.db $43, $2f, $a3, $31, $59, $01, $01, $01, $01, $01, $05, $44, $49, $2d, $b7, $09
.db $2f, $23, $2f, $83, $2f, $e3, $31, $cc, $05, $2f, $bb, $2f, $fb, $03, $2f, $53
.db $09, $31, $29, $2e, $43, $2f, $a3, $31, $59, $01, $01, $01, $01, $01, $05, $44
.db $49, $2d, $b7, $01, $01, $06, $4a, $1a, $fe, $2c, $a7, $03, $2f, $8a, $07, $2e
.db $73, $31, $85, $2f, $8c, $05, $31, $87, $2f, $8e, $05, $31, $50, $30, $a0, $01
.db $01, $01, $0d, $31, $61, $31, $a1, $2f, $a3, $31, $68, $2f, $5a, $2f, $aa, $05
.db $2f, $61, $2f, $a1, $01, $09, $03, $76, $07, $69, $07, $99, $30, $8f, $09, $2f
.db $a2, $31, $73, $31, $68, $2e, $ad, $07, $31, $80, $31, $97, $2e, $7f, $05, $07
.db $80, $01, $84, $05, $31, $9c, $30, $7e, $07, $2f, $35, $30, $77, $31, $a8, $05
.db $31, $67, $31, $ba, $01, $09, $30, $42, $31, $82, $30, $b2, $2f, $74, $09, $2f
.db $53, $2f, $93, $30, $54, $2f, $76, $01, $01, $01, $03, $23, $79, $05, $02, $20
.db $02, $d0, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
.db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff


ELSE
	.db $FB, $FB, $FB, $FB, $FB, $FB
	.db $00
ENDIF

IFDEF CONTROLLER_2_DEBUG
;
; Copies all character stats to RAM for hot-swapping the current character
;
CopyCharacterStats:
	LDX #(MysteryData14439 - StatOffsets - 1)
CopyCharacterStats_Loop:
	LDA StatOffsets, X
	STA StatOffsetsRAM, X
	DEX
	BPL CopyCharacterStats_Loop

	RTS
ENDIF


IFDEF DEBUG
	.include "src/extras/debug-a.asm"
ENDIF
