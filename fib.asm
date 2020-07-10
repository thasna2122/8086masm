;Assembly language program to print n fibonacci numbers;
;Date:30/06/2020;
;THASNA C A;;


.model small

.stack 100h

.data
 
msg1 DB 'Enter limit: $'
msg2 DB 10,13,'The fibonacci numbers are:$'
comma DB  ',$'
space DB ' $'
array DW 50 DUP(?)
limit DW ?
fib DW ?
fib1 DW ?
fib2 DW ?
count DW ?
.code

.startup
 
  MOV DX,OFFSET msg1
  CALL displaymsg
  
  CALL readnum
  MOV limit,SI

  MOV fib1,0001H
  MOV fib2,0000H
  MOV count,0000H
  MOV DI,OFFSET array
  MOV [DI],0000H
  INC count
  MOV AX,limit
  CMP count,AX
  JZ  l2
  ADD DI,0002H
  MOV [DI],0001H
  INC count
  MOV AX,limit
  CMP count,AX
  JZ  l2
  

l1:  MOV  CX,fib2
     ADD  CX,fib1
     MOV  fib,CX
     ADD  DI,0002H
     MOV  AX,fib
     MOV  [DI],AX
     MOV  CX,fib1
     MOV  fib2,CX
     MOV  CX,fib
     MOV  fib1,CX
     INC count
     MOV AX,limit
     CMP count,AX
     JNZ  l1
     

l2:  MOV  DX,OFFSET msg2
     CALL displaymsg

     MOV count,0000H
     MOV DI,OFFSET array
l3:  MOV SI,[DI]
     CALL displaynum
     ADD DI,0002H
     INC count
     MOV AX,count
     CMP limit,AX
     JZ  l4
     MOV DX,OFFSET comma
     CALL displaymsg
     JMP l3
     
l4:  MOV  DX,OFFSET space
     CALL displaymsg  

.exit

displaymsg PROC NEAR
 	MOV AH,09H
        INT 21H
        
        RET
displaymsg ENDP
displaynum PROC NEAR
	MOV AX,SI
	MOV CX,0000H
	MOV DX,0000H
back1:	MOV BX,000AH
	DIV BX
	PUSH DX
	INC CX
	MOV DX,0000H
	CMP AX,0000H
	JNZ back1
	
there:	POP AX
	
	ADD AH,30H
	ADD AL,30H
	MOV DL,AL
	MOV AH,02H
	INT 21H
	DEC CX
	CMP CX,0000H
	JNZ there
	
	RET
displaynum ENDP
	

readnum PROC NEAR
	
	MOV SI,0000H
	MOV DX,0000h
	MOV BX,000AH
first:	MOV AH,01H
	INT 21H

	CMP AL,30H
	JB here
	CMP AL,39H
	JA here
        
	SUB AL,30H
	MOV CL,AL
	MOV CH,00H
	
	

	MOV AX,SI
	MOV SI,CX
	

	
	
	MUL BX
	ADD AX,CX
	MOV SI,AX
	
	JMP first
	
here:	MOV AX,SI
	RET
	

readnum ENDP

end
