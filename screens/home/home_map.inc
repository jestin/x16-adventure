
home_layer_1:
!for home_columns, 0, 127 {
	!for home_rows, 0, 63 {
		!byte $01, $1a
	}
}

home_layer_2:
!for home_columns, 0, 127 {
	!for home_rows, 0, 31 {
		!byte $02, $06, $01, $00
	}
}
