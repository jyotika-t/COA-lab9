.MODEL SMALL
.STACK 100H
.DATA
    msg1 DB 'Enter first single-digit number: $'
    msg2 DB 0DH, 0AH, 'Enter second single-digit number: $'
    equalMsg DB 0DH, 0AH, 'The numbers are equal.$'
    notEqualMsg DB 0DH, 0AH, 'The numbers are not equal.$'
    
.CODE
START:
    ; Initialize the data segment
    MOV AX, @DATA
    MOV DS, AX
    
    ; Display first prompt
    LEA DX, msg1
    MOV AH, 09H
    INT 21H
    
    ; Take first digit as input
    MOV AH, 01H    ; DOS service to read a character from input
    INT 21H        ; Character entered is now in AL
    SUB AL, '0'    ; Convert ASCII to integer by subtracting '0'
    MOV BL, AL     ; Store the first number in BL
    
    ; Display second prompt
    LEA DX, msg2
    MOV AH, 09H
    INT 21H
    
    ; Take second digit as input
    MOV AH, 01H    ; DOS service to read a character from input
    INT 21H        ; Character entered is now in AL
    SUB AL, '0'    ; Convert ASCII to integer by subtracting '0'
    MOV BH, AL     ; Store the second number in BH
    
    ; Compare the two numbers
    CMP BL, BH
    JE NUM_EQUAL   ; If equal, jump to display equal message
    
NUM_NOT_EQUAL:
    ; Display not equal message
    LEA DX, notEqualMsg
    MOV AH, 09H
    INT 21H
    JMP EXIT       ; Jump to end of program

NUM_EQUAL:
    ; Display equal message
    LEA DX, equalMsg
    MOV AH, 09H
    INT 21H
    
EXIT:
    ; Exit program
    MOV AH, 4CH
    INT 21H
    
END START
                   