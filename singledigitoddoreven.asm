.MODEL SMALL
.STACK 100H
.DATA
    msg1 DB 'Enter a single-digit number: $'
    evenMsg DB 0DH, 0AH, 'The number is even.$'
    oddMsg  DB 0DH, 0AH, 'The number is odd.$'

.CODE
START:
    ; Initialize the data segment
    MOV AX, @DATA
    MOV DS, AX
    
    ; Display prompt to enter a number
    LEA DX, msg1
    MOV AH, 09H
    INT 21H
    
    ; Take a single-digit number as input
    MOV AH, 01H    ; DOS service to read a character from input
    INT 21H        ; Character entered is now in AL
    SUB AL, '0'    ; Convert ASCII to integer by subtracting '0'
    
    ; Check if the number is even or odd
    MOV BL, AL     ; Store the number in BL for comparison
    MOV AH, 0      ; Clear AH to ensure division works correctly
    MOV AL, BL     ; Move the input number to AL
    MOV CL, 2      ; Divisor = 2 (to check for even/odd)
    DIV CL         ; Divide AX by CL (AL / 2), result in AL, remainder in AH
    
    ; Check remainder in AH to determine odd/even
    CMP AH, 0      ; If remainder is 0, the number is even
    JE IS_EVEN     ; Jump to even message if AH is 0
    
IS_ODD:
    ; Display odd message
    LEA DX, oddMsg
    MOV AH, 09H
    INT 21H
    JMP EXIT       ; Jump to program exit
    
IS_EVEN:
    ; Display even message
    LEA DX, evenMsg
    MOV AH, 09H
    INT 21H
    
EXIT:
    ; Exit program
    MOV AH, 4CH
    INT 21H
    
END START

