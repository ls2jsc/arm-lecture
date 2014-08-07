	.syntax unified
	.arch armv7-a
	.text

	.equ locked, 1
	.equ unlocked, 0

	.global lock_mutex
	.type lock_mutex, function
lock_mutex:
        @ INSERT CODE BELOW
	PUSH {R1, R2}
	ldr R1, =locked

.check_lock:
	LDREX R2, [R0]
	CMP R2, #locked
	BEQ .check_lock
	STREX R2, R1, [R0]
	CMP R2, #unlocked
	BNE .check_lock
	POP {R1, R2}	
        @ END CODE INSERT
	bx lr
	.size lock_mutex, .-lock_mutex

	.global unlock_mutex
	.type unlock_mutex, function
unlock_mutex:
	@ INSERT CODE BELOW
   PUSH {R1}
	ldr R1, =unlocked
	STR R1, [R0]
	POP {R1}
        @ END CODE INSERT
	bx lr
	.size unlock_mutex, .-unlock_mutex

	.end
