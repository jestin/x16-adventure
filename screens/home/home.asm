HOME_ID = 0

!src "screens/home/home_tiles.inc"
!src "screens/home/home_map.inc"

;============================================================
; HOME_init
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
-	lda home_tiles,x
	sta veradat
	inx
	cpx #24
	bne -

	; write layer 2 tile data
	+vset $16000 | AUTO_INC_1
	ldx #0
-	lda home_tiles,x
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

	ldx #0
	ldy #0

	+LoadW zp_map_pointer, home_layer_1

-	lda (zp_map_pointer)
	sta veradat
	+IncW zp_map_pointer
	lda (zp_map_pointer)
	sta veradat
	+IncW zp_map_pointer
	inx
	txa
	cmp #$7f	; 128
	bne -
	ldx #0
	iny
	tya
	cmp #$40	; 64
	beq +
	jmp -

+	nop

	; write layer 2 map data
	+vset $12000 | AUTO_INC_1

	ldx #0
	ldy #0

	+LoadW zp_map_pointer, home_layer_2

-	lda (zp_map_pointer)
	sta veradat
	+IncW zp_map_pointer
	lda (zp_map_pointer)
	sta veradat
	+IncW zp_map_pointer
	inx
	txa
	cmp #$7f	; 128
	bne -
	ldx #0
	iny
	tya
	cmp #$40	; 64
	beq +
	jmp -

+	rts
