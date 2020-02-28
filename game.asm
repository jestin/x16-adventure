!src "screens/home.asm"
!src "screens/street.asm"

;============================================================
; game_tick
;============================================================
game_tick:

	lda zp_current_screen
	cmp #$ff					; if the current screen is unset
	bne +						; load the HOME screen
	lda #HOME_ID
	sta zp_next_screen
	jsr load_screen

+	jsr check_inputs
	jsr update_game_state
	jsr draw_screen
	jsr update_frame_counters

	rts


;============================================================
; load_screen
; Loads a new screen
;============================================================
load_screen:
	lda zp_next_screen
	pha
	cmp #HOME_ID
	beq @HOME
	cmp #STREET_ID
	beq @STREET

	jmp @end

@HOME:
	jsr HOME_init
	jmp @end
@STREET:
	jsr STREET_init
	jmp @end
@end:
	pla
	sta zp_current_screen
	rts

;============================================================
; update_frame_counters
; Keep frame counters up to date
;============================================================
update_frame_counters:
	+IncW zp_frame_counter

	; slower counters
	+MoveW zp_frame_counter, zp_frame_counter_R2
	+LsrW zp_frame_counter_R2
	+MoveW zp_frame_counter_R2, zp_frame_counter_R4
	+LsrW zp_frame_counter_R4

	; faster counters
	+MoveW zp_frame_counter, zp_frame_counter_L2
	+AslW zp_frame_counter_L2
	+MoveW zp_frame_counter_L2, zp_frame_counter_L4
	+AslW zp_frame_counter_L4
	rts

;============================================================
; check_inputs
; Get inputs from user
;============================================================
check_inputs:
	rts

;============================================================
; update_game_state
; Updates the state of the game
;============================================================
update_game_state:
	; hscroll layer 1
	+vset (vreg_lay1 + 6) | AUTO_INC_1
	lda zp_frame_counter_L4
	sta veradat
	lda zp_frame_counter_L4+1
	sta veradat

	; vscroll layer 1
	+vset (vreg_lay1 + 8) | AUTO_INC_1
	lda zp_frame_counter_L2
	sta veradat
	lda zp_frame_counter_L2+1
	sta veradat

	; hscroll layer 2
	+vset (vreg_lay2 + 6) | AUTO_INC_1
	lda zp_frame_counter
	sta veradat
	lda zp_frame_counter+1
	sta veradat
	rts

;============================================================
; draw_screen
; Draws the screen
;============================================================
draw_screen:
	rts
