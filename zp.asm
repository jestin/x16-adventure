!ifdef ZERO_PAGE !eof
ZERO_PAGE = 1

!addr zp_vsync_trig				= $02

!addr zp_frame_counter			= $04
!addr zp_frame_counter_hi		= $05
!addr zp_frame_counter_R2		= $06
!addr zp_frame_counter_R2_hi	= $07
!addr zp_frame_counter_R4		= $08
!addr zp_frame_counter_R4_hi	= $09
!addr zp_frame_counter_L2		= $0A
!addr zp_frame_counter_L2_hi	= $0B
!addr zp_frame_counter_L4		= $0C
!addr zp_frame_counter_L4_hi	= $0D

!addr zp_current_screen			= $10
