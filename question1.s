			AREA question1, CODE, READWRITE
			ENTRY
			
char_null	EQU 0x00										;null character constant - "0x00"
char_t		EQU 0x74										;lower case t character constant - "t"
char_h		EQU 0x68										;lower case t character constant - "t"
char_e		EQU 0x65										;lower case t character constant - "t"
char_space	EQU 0x20										;blank space character constant - " "

			ADR r1, STRING1									;Set r1 to point to the beginning of string1
			ADR r2, STRING2									;Set r2 to point to the beginning of string2
			
FIRST_WORD	LDRB r5, [r1]									;Load r5 with the first character in String1
			CMP r5, #char_t									;Check if the first character in String1 is the character "t"
			LDRBEQ r5, [r1, #1]								;Load r5 with the second character in String1
			CMPEQ r5, #char_h								;Check if the second character in String1 is the character "h"
			LDRBEQ r5, [r1, #2]								;Load r5 with the third character in String1
			CMPEQ r5, #char_e								;Check if the third character in String1 is the character "e"
			LDRBEQ r5, [r1, #3]								;Load r5 with the fourth character in String1
			CMPEQ r5, #char_null							;Check if the fourth character in String1 is the null character
			STRBEQ r5, [r2], #1								;If the character after the first word is the null character, copy it into String2
			BEQ DONE										;If the character after the first word is the null character, jump to DONE
			CMPNE r5, #char_space							;Check if the fourth character in String1 is a blank space character " "
			ADDEQ r1, #3									;If the first word is "the", skip over it and jump to NEXT_WORD
			
COPY_CHAR	LDRB r4, [r1], #1								;Load r4 with the current character of STRING1 
			STRB r4, [r2], #1								;Copy the character in r4 from String1 to String2 and increment r2 to point to the next character in String2
			CMP r4, #char_null								;Check if the current character in String1 is the null character
			BEQ DONE										;If the end of String1 has been reached jump to DONE
			CMP r4, #char_space								;Check if the current character in String1 is a blank space character
			BNE COPY_CHAR									;If the end of the word has not been reached then jump to COPY_CHAR			
			
NEXT_WORD	LDRB r5, [r1, #-1]								;Load r5 with the character before the current word
			CMP r5, #char_space								;Check if the character before the current word is a blank space character " "
			LDRBEQ r5, [r1]									;Load r5 with the first character of the current word
			CMPEQ r5, #char_t								;Check if the first character of the current word is the character "t"
			LDRBEQ r5, [r1, #1]								;Load r5 with the second character of the current word
			CMPEQ r5, #char_h								;Check if the second character of the current word is the character "h"
			LDRBEQ r5, [r1, #2]								;Load r5 with the third character of the current word
			CMPEQ r5, #char_e								;Check if the first character of the current word is the character "e"
			LDRBEQ r5, [r1, #3]								;Load r5 with the fourth character of the current word
			CMPEQ r5, #char_space							;Check if the fourth character is a blank space character " "
			CMPNE r5, #char_null							;Check if the fourth character is the null character
			ADDEQ r1, #3									;If the word "the" is found then skip over it and jump to COPY_CHAR
			B COPY_CHAR
		
DONE		B DONE											;Done copying String1 to String2

STRING1		DCB "and the man said they must go"				;String1
EoS			DCB 0x00										;End of String1
STRING2		space 0x7F										;Just allocating 127 bytes

			END