!src "vera.asm"
!src "macros.asm"
!src "x16.asm"

*=$1000
	+video_init

	jsr initialize_layers

	; initialize layer 2
	+vset vreg_lay2 | AUTO_INC_1
	lda #$01			; enable layer
	sta veradat
	lda #$06			; set MAPW/MAPH to 128x64
	sta veradat			; and TILEW/TILEH to 8x8
	lda #$00			; set layer 1 map base to $04000
	sta veradat
	lda #$10
	sta veradat			; set layer 1 tile base to $08000
	lda #$00
	sta veradat
	lda #$20
	sta veradat

	; write layer 2 tile data
	+vset $08000 | AUTO_INC_1
	ldx #0
-	lda tiles,x
	sta veradat
	inx
	cpx #24
	bne -

	; write layer 2 map data
	+vset $04006 | AUTO_INC_1
	lda #0
	sta veradat
	lda #$34
	sta veradat
	lda #1
	sta veradat
	lda #$34
	sta veradat
	lda #2
	sta veradat
	lda #$34
	sta veradat

	; hscroll layer 0
	lda #$06
	sta veralo
	lda #$20
	sta veramid
	lda #$0f
	sta verahi
	lda #5
	sta veradat

	; vscroll layer 0
	lda #$08
	sta veralo
	lda #$20
	sta veramid
	lda #$0f
	sta verahi
	lda #5
	sta veradat

	rts

;============================================================
; initialize_layers
;============================================================
initialize_layers:
	; copy layer 1 registers to layer 0
	+vset vreg_lay1 | AUTO_INC_1
	+vset2 vreg_lay2 | AUTO_INC_1

	lda veradat2
	sta veradat
	lda veradat2
	sta veradat
	lda veradat2
	sta veradat
	lda veradat2
	sta veradat
	lda veradat2
	sta veradat
	lda veradat2
	sta veradat
	lda veradat2
	sta veradat
	lda veradat2
	sta veradat
	lda veradat2
	sta veradat
	lda veradat2
	sta veradat

	lda #0
	sta veractl

	rts

tiles:
	!byte %00111100
	!byte %01111110
	!byte %01100110
	!byte %11000011
	!byte %11111111
	!byte %11111111
	!byte %11000011
	!byte %11000011

	!byte %00000000
	!byte %01111110
	!byte %01111110
	!byte %01111110
	!byte %01111110
	!byte %01111110
	!byte %01111110
	!byte %00000000

	!byte %00011000
	!byte %00011000
	!byte %00011000
	!byte %11111111
	!byte %11111111
	!byte %00011000
	!byte %00011000
	!byte %00011000
