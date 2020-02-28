;============================================================
; HOME_write_tiles
;============================================================
HOME_init:
	jsr HOME_write_tiles
	jsr HOME_write_maps
	rts

;============================================================
; HOME_write_tiles
;============================================================
HOME_write_tiles:
	; write layer 1 tile data
	+vset $08000 | AUTO_INC_1
	ldx #0
-	lda tiles,x
	sta veradat
	inx
	cpx #24
	bne -

	; write layer 2 tile data
	+vset $16000 | AUTO_INC_1
	ldx #0
-	lda tiles,x
	sta veradat
	inx
	cpx #24
	bne -

	rts

;============================================================
; HOME_write_maps
;============================================================
HOME_write_maps:

	; write layer 1 map data
	+vset $04000 | AUTO_INC_1
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


	; write layer 2 map data
	+vset $12000 | AUTO_INC_1
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

	rts
