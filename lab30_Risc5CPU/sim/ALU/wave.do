onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ALU_tb/ALUCode
add wave -noupdate /ALU_tb/A
add wave -noupdate /ALU_tb/B
add wave -noupdate /ALU_tb/ALUResult
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1229467 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {1260 ns}
