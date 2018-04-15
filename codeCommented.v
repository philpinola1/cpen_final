/*		ADDRESS	OPCODE	ASSEMBLY			*/
9001_00A0 /*	0	100100	LBU R1,$A0(R0)			*/
3402_00B0 /*	4	001101	ORI R2,R0,#$B0			*/
3403_00C0 /*	8	001101	ORI R3,R0,#$C0			*/
0000_0020 /*	C	000000	NOP (ADD R0,R0,R0)		*/
0000_0020 /*	10						*/
0000_0020 /*	14						*/
9044_0000 /*	18	100100	LBU R4,0(R2)			*/
0000_0020 /*	1C	000000	NOP				*/
0000_0020 /*	20						*/
0000_0020 /*	24						*/
0024_2828 /*	28	000000 	SEQ R5,R1,R4			*/
0000_0020 /*	2C	000000	NOP				*/
0000_0020 /*	30						*/
0000_0020 /*	34						*/
14A0_0040 /*	38	000101 	BNEZ R5 +40 (TO ADDRESS 78)	*/
0000_0020 /*	3C	000000	NOP				*/
0000_0020 /*	40						*/
0000_0020 /*	44						*/
2042_0001 /*	48	001000 	ADDI R2,R2,#1			*/
0000_0020 /*	4C	000000	NOP				*/
0000_0020 /*	50						*/
0000_0020 /*	54						*/
0043_3028 /*	58	000000 	SEQ R6,R2,R3			*/
0000_0020 /*	5C	000000	NOP				*/
0000_0020 /*	60						*/
0000_0020 /*	64						*/
10C0_FFB0 /*	68	000100 	BEQZ R6 -50  (TO ADDRESS 18)	*/
0000_0020 /*	6C	000000	NOP				*/
0000_0020 /*	70						*/
0000_0020 /*	74						*/
AC05_00A4 /*	78	101011 	SW $A4(R0),R5			*/
0000_0020 /*	7C	000000	NOP				*/
0000_0020 /*	80						*/
0000_0020 /*	84						*/
FC00_0000 /*    88	111111 	HALT				*/
0000_0020 /*	8C	000000	NOP				*/
0000_0020 /*	90						*/
0000_0020 /*	94						*/

/*	R1 <-- A5							*/
/*	R2 <-- B0							*/
/*	R3 <-- C0							*/
/*	R4 <-- 00							*/
/*	check to see if R1 is equal to R4 (false) set R5 to 0   	*/
/*	branch to address 7C if R5 is not equal to zero (never taken)	*/
/* 	increment R2 							*/
/*	check to see if R2 is equal to R3, set the result in R6		*/
/*	branch to address 1C if R6 is not equal to zero (taken until R2=R3=C0) */
/*	Store R5 (00000001) to address A4 in memory			*/
