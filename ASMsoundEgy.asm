#a0 pitch
#a1 duration in ms
#a2 instrument
#a3 volume

li a7, 31 #system call 31 for MIDI output

##loads a MIDI out of 0 volume into MIDI buffer, duration 1 sec##
li a3, 0
li a2, 1
li a1, 1000
ecall
##this is done as in some devices MIDI output fires spontanouesly ignoring sequence, hence we load a silent output##

##calling sleep
li s1, 2000
jal ra, sleep
	

###song by Piano###
li t6 1
seq1:
	li s1, 800
	jal ra, sleep
	
	li a0, 84		#C4
	li a1, 600	#0.6sec C4 duration
	ecall

	li s1, 400	#0.4 ms gap
	jal ra, sleep	#sleep to have a gap between notes

	li a0, 77		#F4
	li a1, 2000	#2sec duration
	ecall 

	li s1, 1000
	jal ra, sleep

	ecall		#done twice
	
	addi t4, t4, 1
ble t4, t6, seq1
	
li s1, 600
jal ra, sleep
	
li a0, 77		#F4
li a1, 800	#0.8sec duration
ecall
	
jal ra, sleep
	
li a0, 76		#E4
li a1, 600	#0.6sec duration
ecall
	
jal ra, sleep
	
li a0, 77		#F4
li a1, 800	#0.8sec duration
ecall
	
jal ra, sleep
	
li a0, 79		#G4
li a1, 2000	#2sec duration
ecall

li s1, 800
jal ra, sleep
	
li a0, 93		#A5
li a1, 2000	#2sec duration
ecall

li s1, 600
jal ra, sleep
	
li a0, 77		#F4
li a1, 1500	#1.5sec duration
ecall
	
	
beq x0, x0, exit

sleep:
	##sleep sequence##
	mv t5, a0		#storing original pitch temporarily
	mv a0, s1 	#duration of sleep in a0
	li a7, 32		#sys call 32 to sleep
	ecall
	##restoring regs##
	mv a0, t5		#pitch back to original
	li a3, 55 	#volume back to normal
	li a7, 31		#syscall to MIDI output
	jalr x0, 0(ra)
	
exit:


