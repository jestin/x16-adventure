STREET_ID = 1

!src "screens/street/street_tiles.inc"

;============================================================
; STREET_init
;============================================================
STREET_init:
	jsr STREET_write_tiles
	jsr STREET_write_maps
	rts

;============================================================
; STREET_write_tiles
;============================================================
STREET_write_tiles:
	; write layer 1 tile data
	+vset $08000 | AUTO_INC_1
	ldx #0
-	lda street_tiles,x
	sta veradat
	inx
	cpx #24
	bne -

	; write layer 2 tile data
	+vset $16000 | AUTO_INC_1
	ldx #0
-	lda street_tiles,x
	sta veradat
	inx
	cpx #24
	bne -

	rts

;============================================================
; STREET_write_maps
;============================================================
STREET_write_maps:

	; write layer 1 map data
	+vset $04000 | AUTO_INC_1
	lda #0
	sta veradat
	lda #$32
	sta veradat
	lda #1
	sta veradat
	lda #$32
	sta veradat
	lda #2
	sta veradat
	lda #$32
	sta veradat


	; write layer 2 map data
	+vset $12000 | AUTO_INC_1
	lda #0
	sta veradat
	lda #$36
	sta veradat
	lda #1
	sta veradat
	lda #$36
	sta veradat
	lda #2
	sta veradat
	lda #$36
	sta veradat

	rts
