*=$1000
jmp start

!src "vera.asm"
!src "macros.asm"
!src "x16.asm"
!src "zp.asm"
!src "game.asm"
!src "screen.asm"
!src "vram.inc"

!addr def_irq = $0000

start:
	+video_init

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
