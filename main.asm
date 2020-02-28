*=$1000
jmp start

!src "vera.asm"
!src "macros.asm"
!src "x16.asm"
!src "zp.asm"
!src "game.asm"
!src "tiles.inc"

!addr def_irq = $0000

start:
	+video_init

	jsr initialize_layers
	lda #$ff
	sta zp_next_screen
	sta zp_current_screen
	jsr init_irq
	+LoadW zp_frame_counter,0

;============================================================
; mainloop
;============================================================
mainloop:
   wai
   jsr check_vsync
   jmp mainloop  ; loop forever


;============================================================
; init_irq
; Initializes interrupt vector
;============================================================
init_irq:
	lda IRQVec
	sta def_irq
	lda IRQVec+1
	sta def_irq+1
	lda #<handle_irq
	sta IRQVec
	lda #>handle_irq
	sta IRQVec+1
	rts

;============================================================
; handle_irq
; Handles VERA IRQ
;============================================================
handle_irq:
	; check for VSYNC
	lda veraisr
	and #$01
	beq +
	sta zp_vsync_trig
	; clear vera irq flag
	sta veraisr

+	jmp (def_irq)

;============================================================
; check_vsync
;============================================================
check_vsync:
	lda zp_vsync_trig
	beq +

	; VSYNC has occurred, handle
	jsr game_tick

	stz zp_vsync_trig
+	rts

;============================================================
; initialize_layers
;============================================================
initialize_layers:

	; initialize layer 1
	+vset vreg_lay1 | AUTO_INC_1
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

	; initialize layer 2
	+vset vreg_lay2 | AUTO_INC_1
	lda #$01			; enable layer
	sta veradat
	lda #$06			; set MAPW/MAPH to 128x64
	sta veradat			; and TILEW/TILEH to 8x8
	lda #$00			; set layer 1 map base to $12000
	sta veradat
	lda #$48
	sta veradat			; set layer 1 tile base to $16000
	lda #$00
	sta veradat
	lda #$58
	sta veradat

	rts
