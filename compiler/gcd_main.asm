loop:
slt     $t0, $zero, $s0
slt     $t1, $zero, $s1 
and     $t2, $t0, $t1 # forwarding
bne		$t2, $zero, target # forwarding
add		$s2, $s0, $zero # 无关指令，防止阻塞
j		loop
sll     $zero, $zero, 0

target:
add     $s3, $s1, $zero
compare:
slt     $t3, $s2, $s3 # forwarding
beq     $t3, $zero, s2greater # forwarding
lui     $t5, 0x4000 # 无关指令，防止阻塞
add     $t4, $s2, $zero # if $s3 is greater, swap
add     $s2, $s3, $zero
add     $s3, $t4, $zero # forwarding
s2greater:
sub     $s4, $s2, $s3
beq     $s4, $zero, finish # forwarding
sll     $zero, $zero, 0 # stall
add     $s2, $s3, $zero
add     $s3, $s4, $zero
j		compare
sll     $zero, $zero, 0 # stall

finish: # $s3 is gcd
sw		$s3, 24($t5) # uart_txd
sw      $s3, 12($t5) # led