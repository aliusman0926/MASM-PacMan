; Author:    Ali Usman      22i-0926
; Program Name:       PAC-MAN
; Program Description:      Assembly Project
; Date:         10th December, 2023

INCLUDE Irvine32.inc
includelib Winmm.lib

PlaySound PROTO,
	pszSound:PTR BYTE,
	hmod:DWORD,
	fdwSound:DWORD

.data
	ConsoleInfo CONSOLE_CURSOR_INFO<1,0>
	deathSound db ".\death_1.wav",0
	startSound db ".\game_start.wav",0
	eatSound db ".\munch_1.wav",0
	pacManTitle db "PAC-MAN",0
	menuBox1 db "========================================================================",0
	menuBox2 db "||                                                                    ||",0
	menuBox3 db "||                                                                    ||",0
	menuBox4 db "||                                                                    ||",0
	menuBox5 db "||                                                                    ||",0
	menuBox6 db "||                                                                    ||",0
	menuBox7 db "||                                                                    ||",0
	menuBox8 db "========================================================================",0
	title1 db    " ______   ______     ______     __    __     ______     __   __    ",0
	title2 db    "/\  == \ /\  __ \   /\  ___\   /\ '-./  \   /\  __ \   /\ '-.\ \   ",0
	title3 db    "\ \  _-/ \ \  __ \  \ \ \____  \ \ \-./\ \  \ \  __ \  \ \ \-.  \  ",0
	title4 db    " \ \_\    \ \_\ \_\  \ \_____\  \ \_\ \ \_\  \ \_\ \_\  \ \_\\'\_\ ",0
	title5 db    "  \/_/     \/_/\/_/   \/_____/   \/_/  \/_/   \/_/\/_/   \/_/ \/_/ ",0
	title6 db    "                                                                   ",0
	inGameTitle1 db "  _______  _______  _______         __   __  _______  __    _  ",0
	inGameTitle2 db " |       ||   _   ||       |       |  |_|  ||   _   ||  |  | | ",0
	inGameTitle3 db " |    _  ||  |_|  ||       | ____  |       ||  |_|  ||   |_| | ",0
	inGameTitle4 db " |   |_| ||       ||       ||____| |       ||       ||       | ",0
	inGameTitle5 db " |    ___||       ||      _|       |       ||       ||  _    | ",0
	inGameTitle6 db " |   |    |   _   ||     |_        | ||_|| ||   _   || | |   | ",0
	inGameTitle7 db " |___|    |__| |__||_______|       |_|   |_||__| |__||_|  |__| ",0
	inGameTitle8 db "                                                               ",0
	pauseTitle1 db  "     _______  _______  __   __  _______  _______  ______       ",0
	pauseTitle2 db  "    |       ||   _   ||  | |  ||       ||       ||      |      ",0
	pauseTitle3 db  "    |    _  ||  |_|  ||  | |  ||  _____||    ___||  _    |     ",0
	pauseTitle4 db  "    |   |_| ||       ||  |_|  || |_____ |   |___ | | |   |     ",0
	pauseTitle5 db  "    |    ___||       ||       ||_____  ||    ___|| |_|   |     ",0
	pauseTitle6 db  "    |   |    |   _   ||       | _____| ||   |___ |       |     ",0
	pauseTitle7 db  "    |___|    |__| |__||_______||_______||_______||______|      ",0
	pauseTitle8 db  "                                                               ",0
	level1Title1 db ".____     _______________   _______________.____       ____ ",0
	level1Title2 db "|    |    \_   _____/\   \ /   /\_   _____/|    |     /_   |",0
	level1Title3 db "|    |     |    __)_  \   Y   /  |    __)_ |    |      |   |",0
	level1Title4 db "|    |___  |        \  \     /   |        \|    |___   |   |",0
	level1Title5 db "|_______ \/_______  /   \___/   /_______  /|_______ \  |___|",0
	level1Title6 db "        \/        \/                    \/         \/       ",0
	level2Title1 db ".____     _______________   _______________.____       ________  ",0
	level2Title2 db "|    |    \_   _____/\   \ /   /\_   _____/|    |      \_____  \ ",0
	level2Title3 db "|    |     |    __)_  \   Y   /  |    __)_ |    |       /  ____/ ",0
	level2Title4 db "|    |___  |        \  \     /   |        \|    |___   /       \ ",0
	level2Title5 db "|_______ \/_______  /   \___/   /_______  /|_______ \  \_______ \",0
	level2Title6 db "        \/        \/                    \/         \/          \/",0
	level3Title1 db ".____     _______________   _______________.____       ________  ",0
	level3Title2 db "|    |    \_   _____/\   \ /   /\_   _____/|    |      \_____  \ ",0
	level3Title3 db "|    |     |    __)_  \   Y   /  |    __)_ |    |        _(__  < ",0
	level3Title4 db "|    |___  |        \  \     /   |        \|    |___    /       \",0
	level3Title5 db "|_______ \/_______  /   \___/   /_______  /|_______ \  /______  /",0
	level3Title6 db "        \/        \/                    \/         \/         \/",0

	mainScores1 db " _____ _____ _____ _____ _____ _____ _____ _____ _____ _____ ",0
	mainScores2 db "|  |  |     |   __|  |  |   __|     |     | __  |   __|   __|",0
	mainScores3 db "|     |-   -|  |  |     |__   |   --|  |  |    -|   __|__   |",0
	mainScores4 db "|__|__|_____|_____|__|__|_____|_____|_____|__|__|_____|_____|",0

	loading1 db " ___      _______  _______  ______   ___   __    _  _______ ",0
	loading2 db "|   |    |       ||   _   ||      | |   | |  |  | ||       |",0
	loading3 db "|   |    |   _   ||  |_|  ||  _    ||   | |   |_| ||    ___|",0
	loading4 db "|   |    |  | |  ||       || | |   ||   | |       ||   | __ ",0
	loading5 db "|   |___ |  |_|  ||       || |_|   ||   | |  _    ||   ||  |",0
	loading6 db "|       ||       ||   _   ||       ||   | | | |   ||   |_| |",0
	loading7 db "|_______||_______||__| |__||______| |___| |_|  |__||_______|",0
	
	gameOver1 db " _______  _______  __   __  _______    _______  __   __  _______  ______   ",0
	gameOver2 db "|       ||   _   ||  |_|  ||       |  |       ||  | |  ||       ||    _ |  ",0
	gameOver3 db "|    ___||  |_|  ||       ||    ___|  |   _   ||  |_|  ||    ___||   | ||  ",0
	gameOver4 db "|   | __ |       ||       ||   |___   |  | |  ||       ||   |___ |   |_||_ ",0
	gameOver5 db "|   ||  ||       ||       ||    ___|  |  |_|  ||       ||    ___||    __  |",0
	gameOver6 db "|   |_| ||   _   || ||_|| ||   |___   |       | |     | |   |___ |   |  | |",0
	gameOver7 db "|_______||__| |__||_|   |_||_______|  |_______|  |___|  |_______||___|  |_|",0

	playPrompt db "Press P to play!",0
	scoresPrompt db "Press H for HighScores!",0
	quitPrompt db "Press Q to quit!",0
	backPrompt db "Press B to go back!",0
	returnPrompt db "Press B to go to Main Menu!",0
	enterNamePrompt db "Enter Username: ",0
	resumePrompt db "Press r to resume! ",0
	restartPrompt db "Press R to restart! ",0
	pauseScoresPrompt db "Press H for HighScores! ",0
	levelPrompt db "Choose difficulty level: ",0
	level1Choice db " LEVEL 1 ",0
	level2Choice db " LEVEL 2 ",0
	level3Choice db " LEVEL 3 ",0
	clearPrompt db "                                         ",0
	clearPrompt2 db "                                                                                                      ",0
	gameArray db 25 dup (45 dup (1))
	temp dd ?
	checkWallTempX dd ?
	checkWallTempY dd ?
	newGame db 0

	level db 5
	score_file db "highscores.txt",0
	score_handle dd ?
	highscores dd 5 dup(?)
	name1 db 50 dup(?)
	name2 db 50 dup(?)
	name3 db 50 dup(?)
	name4 db 50 dup(?)
	name5 db 50 dup(?)
	highscore_level db 5 dup (?)

	pacManX dd 20
	pacManY dd 19
	pacManSpeed = 80

	ghost1X dd 19
	ghost1Y dd 10
	ghost2X dd 17
	ghost2Y dd 10
	ghost3X dd 21
	ghost3Y dd 10
	ghost4X dd 18
	ghost4Y dd 9
	ghost5X dd 20
	ghost5Y dd 9
	ghost1move dd 0
	ghost2move dd 0
	ghost3move dd 0
	ghost4move dd 0
	ghost5move dd 0
	ghostspeed = 80
	
	ghostCollTempX dd 0
	ghostCollTempY dd 0
	ghostMoveTempX dd 0
	ghostMoveTempY dd 0
	ghostMoveTemp dd 0
	ghostTrailTempX dd ?
	ghostTrailTempY dd ?
	ghostTrail db 0
	ghost5Speed dd 0
	ghost4Speed dd 0
	ghost3Speed dd 0
	ghost2Speed dd 0
	ghost1Speed dd 0
	ghostTempSpeed dd 0
	ghost1Direction dd 0
	ghost2Direction dd 0
	ghost3Direction dd 0
	ghost4Direction dd 0
	ghost5Direction dd 0
	ghostDirection dd 0
	ghostChange db 0

	fruitX db 9
	fruitY db 12
	powerUp db 0
	powerUpTimer dd 0
	powerUpX db 19
	powerUpY db 16

	lives db 3
	moveVar db 0
	moveBack db 0
	score dd 0
	score_string db 6 dup(?)
	temp_score dd 0
	temp_score_string db 7 dup(?)
	score_buffer db 5000 dup(?)
	bytes_read dd ?
	score_save db 0

	highscore1 db 7 dup(?)
	highscore2 db 7 dup(?)
	highscore3 db 7 dup(?)
	highscore4 db 7 dup(?)
	highscore5 db 7 dup(?)
	highscores_name1 db 20 dup(?)
	highscores_name2 db 20 dup(?)
	highscores_name3 db 20 dup(?)
	highscores_name4 db 20 dup(?)
	highscores_name5 db 20 dup(?)
	highscore_level1 db ?
	highscore_level2 db ?
	highscore_level3 db ?
	highscore_level4 db ?
	highscore_level5 db ?

	scoreTXT db " Score: ",0
	livesTXT db " Lives: ",0
	userNameTXT db " Username: ",0
	levelTXT db " Level: ",0
	upBool db 0
	downBool db 0
	leftBool db 0
	rightBool db 0
	pacManMoveCount dd 0
	midGameKey db 0
	userNameSize = 20
	userName db 20 dup(?)
	gameWon db 0

.code
printHome PROC
	mov eax, blue + (black*16)
	call SetTextColor
	mov dh, 4
	mov dl, 19
	call Gotoxy
	mov edx, offset menuBox1
	call WriteString
	mov dh, 5
	mov dl, 19
	call Gotoxy
	mov edx, offset menuBox2
	call WriteString
	mov dh, 6
	mov dl, 19
	call Gotoxy
	mov edx, offset menuBox3
	call WriteString
	mov dh, 7
	mov dl, 19
	call Gotoxy
	mov edx, offset menuBox4
	call WriteString
	mov dh, 8
	mov dl, 19
	call Gotoxy
	mov edx, offset menuBox5
	call WriteString
	mov dh, 9
	mov dl, 19
	call Gotoxy
	mov edx, offset menuBox6
	call WriteString
	mov dh, 10
	mov dl, 19
	call Gotoxy
	mov edx, offset menuBox7
	call WriteString
	mov dh, 11
	mov dl, 19
	call Gotoxy
	mov edx, offset menuBox8
	call WriteString
	mov eax, brown + (black*16)
	call SetTextColor
	mov dh, 5
	mov dl, 22
	call Gotoxy
	mov edx, offset title1
	call WriteString
	mov eax, 100
	call Delay
	mov dh, 6
	mov dl, 22
	call Gotoxy
	mov edx, offset title2
	call WriteString
	mov eax, 100
	call Delay
	mov dh, 7
	mov dl, 22
	call Gotoxy
	mov edx, offset title3
	call WriteString
	mov eax, 1
	call Delay
	mov dh, 8
	mov dl, 22
	call Gotoxy
	mov edx, offset title4
	call WriteString
	mov eax, 100
	call Delay
	mov dh, 9
	mov dl, 22
	call Gotoxy
	mov edx, offset title5
	call WriteString
	mov eax, 100
	call Delay
	mov dh, 10
	mov dl, 22
	call Gotoxy
	mov edx, offset title6
	call WriteString
	mov eax, 100
	call Delay
	mov dh, 11
	mov dl, 22
	call Gotoxy
	mov eax, green + (black*16)
	call SetTextColor
	mov dh, 15
	mov dl, 45
	call Gotoxy
	mov edx, offset playPrompt
	call WriteString
	mov eax, cyan + (black*16)
	call SetTextColor
	mov dh, 17
	mov dl, 42
	call Gotoxy
	mov edx, offset scoresPrompt
	call WriteString
	mov eax, red + (black*16)
	call SetTextColor
	mov dh, 19
	mov dl, 45
	call Gotoxy
	mov edx, offset quitPrompt
	call WriteString
ret
printHome ENDP

wallHelper PROC
			CMP eax, 0
			JE wall
			CMP eax, 20
			JE wall
			CMP ecx, 1
			JNE skip31
			CMP eax, 10
			JNE wall
			skip31:
			CMP ecx, 40
			JNE skip32
			CMP eax, 10
			JNE wall
			skip32:
			CMP eax, 16
			JG skip1
			CMP eax, 15
			JL skip1
			CMP ecx, 6
			JLE wall
			skip1:
			CMP eax, 16
			JG skip2
			CMP eax, 15
			JL skip2
			CMP ecx, 34
			JG wall
			skip2:
			CMP eax, 18
			JNE skip3
			CMP ecx, 35
			JG skip3
			CMP ecx, 25
			JG wall
			skip3:
			CMP eax, 18
			JNE skip4
			CMP ecx, 5
			JLE skip4
			CMP ecx, 15
			JLE wall
			skip4:
			CMP eax, 18
			JNE skip9
			CMP ecx, 23
			JG skip9
			CMP ecx, 17
			JG wall
			skip9:
			CMP eax, 4
			JL skip5
			CMP eax, 5
			JG skip5
			CMP ecx, 6
			JLE wall
			skip5:
			CMP eax, 4
			JL skip6
			CMP eax, 5
			JG skip6
			CMP ecx, 34
			JG wall
			skip6:
			CMP eax, 2
			JNE skip7
			CMP ecx, 35
			JG skip7
			CMP ecx, 25
			JG wall
			skip7:
			CMP eax, 2
			JNE skip8
			CMP ecx, 5
			JLE skip8
			CMP ecx, 15
			JLE wall
			skip8:
			CMP eax, 2
			JNE skip10
			CMP ecx, 23
			JG skip10
			CMP ecx, 17
			JG wall 
			skip10:
			CMP eax, 9
			JNE skip27
			CMP ecx, 32
			JG wall
			skip27:
			CMP eax, 11
			JNE skip11
			CMP ecx, 32
			JG wall
			skip11:
			CMP ecx, 32
			JNE skip12
			CMP eax, 7
			JL skip12
			CMP eax, 10
			JE skip12
			CMP eax, 13
			JLE wall
			skip12:
			CMP eax, 9
			JNE skip28
			CMP ecx, 9
			JLE wall
			skip28:
			CMP eax, 11
			JNE skip13
			CMP ecx, 9
			JLE wall
			skip13:
			CMP ecx, 9
			JNE skip14
			CMP eax, 7
			JL skip14
			CMP eax, 10
			JE skip14
			CMP eax, 13
			JLE wall
			skip14:
			CMP eax, 11
			JL skip15
			CMP eax, 12
			JG skip15
			CMP ecx, 24
			JG skip15
			CMP ecx, 17
			JGE wall
			skip15:
			CMP ecx, 24
			JNE skip16
			CMP eax, 8
			JL skip16
			CMP eax, 12
			JLE wall
			skip16:
			CMP ecx, 17
			JNE skip17
			CMP eax, 8
			JL skip17
			CMP eax, 12
			JLE wall
			skip17:
			CMP eax, 5
			JNE skip18
			CMP ecx, 25
			JG skip18
			CMP ecx, 16
			JGE wall
			skip18:
			CMP eax, 15
			JNE skip19
			CMP ecx, 25
			JG skip19
			CMP ecx, 16
			JGE wall
			skip19:
			CMP ecx, 12
			JNE skip20
			CMP eax, 11
			JLE skip20
			CMP eax, 15
			JLE wall
			skip20:
			CMP ecx, 12
			JNE skip21
			CMP eax, 5
			JL skip21
			CMP eax, 9
			JL wall
			skip21:
			CMP ecx, 29
			JNE skip22
			CMP eax, 11
			JLE skip22
			CMP eax, 15
			JLE wall
			skip22:
			CMP ecx, 29
			JNE skip23
			CMP eax, 5
			JL skip23
			CMP eax, 9
			JL wall
			skip23:
			CMP eax, 10
			JNE skip24
			CMP ecx, 24
			JG skip24
			CMP ecx, 16
			JG removeFood
			skip24:
			CMP eax, 9
			JNE skip25
			CMP ecx, 24
			JG skip25
			CMP ecx, 16
			JG removeFood
			skip25:
			CMP eax, 8
			JNE skip26
			CMP ecx, 24
			JG skip26
			CMP ecx, 16
			JG removeFood
			skip26:
			CMP eax, 10
			JNE skip29
			CMP ecx, 40
			JE portal
			skip29:
			CMP eax, 10
			JNE skip30
			CMP ecx, 1
			JE portal
			skip30:
			JMP leaveEmpty
			removeFood:
				mov [gameArray+esi], -1
				JMP leaveEmpty
			portal:
				mov [gameArray+esi], 2
				JMP leaveEmpty
			wall:
				mov [gameArray+esi], 0
			leaveEmpty: 
ret
wallHelper ENDP

addWalls PROC
	mov ecx, 21
	mov esi, 0
	mov eax, 0
	L1:
		mov temp, ecx
		mov ecx, 40
		L2:
			mov edx, esi
			call wallHelper
			mov esi, edx
			inc esi
			loop L2
		mov ecx, temp
		inc esi
		inc eax
		loop L1
ret
addWalls ENDP

printBoard PROC
	mov ecx, 21
	mov esi, 0
	L1:
		mov temp, ecx
		mov ecx, 40
		L2:
			CMP [gameArray+esi],0
			JE printWall
			CMP [gameArray+esi],1
			JE printFood
			CMP [gameArray+esi], 2
			JE printPortal
			CMP [gameArray+esi], -1
			JE printEmpty
			leaveEmpty:
			mov eax,  1
			call Delay
			inc esi
			loop L2
		mov eax, 0Ah
		call WriteChar
		mov ecx, temp
		inc esi
		loop L1
		JMP endPrint
			printEmpty:
				mov eax, white + (black*16)
				call SetTextColor
				mov eax, " "
				call WriteChar
				JMP leaveEmpty
			printPortal:
				mov eax, white + (black*16)
				call SetTextColor
				mov eax, " "
				call WriteChar
				JMP leaveEmpty
			printFood:
				mov eax, yellow + (black*16)
				call SetTextColor
				mov eax, 248
				call WriteChar
				JMP leaveEmpty
			printWall:
				mov eax, white + (blue*16)
				call SetTextColor
				mov eax, " "
				call WriteChar
				JMP leaveEmpty
		endPrint:
ret
printBoard ENDP

resetBoard PROC
	mov ecx, 21
	mov esi, 0
	mov eax, 0
	L1:
		mov temp, ecx
		mov ecx, 40
		L2:
			mov [gameArray+esi], 1
			inc esi
			loop L2
		mov ecx, temp
		inc esi
		inc eax
		loop L1
	mov ghost1X, 19
	mov ghost1Y, 10
	mov ghost2X, 17
	mov ghost2Y, 10
	mov ghost3X, 21
	mov ghost3Y, 10
	mov ghost4X, 18
	mov ghost4Y, 9
	mov ghost5X, 20
	mov ghost5Y, 9
	mov pacManX, 19
	mov pacManY, 19
ret
resetBoard ENDP

checkWall PROC
	mov ecx, 21
	mov esi, 0
	mov eax, 0
	L1:
		mov temp, ecx
		mov ecx, 40
		L2:
			CMP eax, checkWallTempY
			JNE skip
			mov ebx, checkWallTempX
			inc ebx
			CMP ecx, ebx
			JNE skip
			CMP [gameArray+esi], 0
			JE wallHit
			JMP skip
			wallHit:
				mov moveBack, 1
			skip:
			inc esi
			loop L2
		mov ecx, temp
		inc esi
		inc eax
		loop L1
ret
checkWall ENDP

checkFood PROC
	mov ecx, 21
	mov esi, 0
	mov eax, 0
	L1:
		mov temp, ecx
		mov ecx, 40
		L2:
			CMP eax, pacManY
			JNE skip
			mov ebx, pacManX
			inc ebx
			CMP ecx, ebx
			JNE skip
			CMP [gameArray+esi], 1
			JE food
			JMP skip
			food:
				add score, 1
				;INVOKE PlaySound, offset eatSound, NULL, 0
				;INVOKE PlaySound, offset eatSound, NULL, 11h
				mov [gameArray+esi], -1
			skip:
			inc esi
			loop L2
		mov ecx, temp
		inc esi
		inc eax
		loop L1
ret
checkFood ENDP

checkGhostTrail PROC
	mov ghostTrail, 0
	mov ecx, 21
	mov esi, 0
	mov eax, 0
	L1:
		mov temp, ecx
		mov ecx, 40
		L2:
			CMP eax, ghostTrailTempY
			JNE skip
			mov ebx, ghostTrailTempX
			inc ebx
			CMP ecx, ebx
			JNE skip
			CMP [gameArray+esi], 1
			JE food
			JMP skip
			food:
				mov ghostTrail,1
			skip:
			inc esi
			loop L2
		mov ecx, temp
		inc esi
		inc eax
		loop L1
ret
checkGhostTrail ENDP

printPacMan PROC
	mov edx, pacManX
	mov eax, pacManY
	mov dh, al
	call Gotoxy
	mov eax, brown + (black*16)
	call SetTextColor
	mov eax, "C"
	call WriteChar
	mov dh, 20
	call Gotoxy
ret
printPacMan ENDP

printGhost1 PROC
	mov edx, ghost1X
	mov eax, ghost1Y
	mov dh, al
	call Gotoxy
	CMP powerUp, 0
	JE noPower
		mov eax, white + (cyan*16)
		call SetTextColor
		JMP skip
	noPower:
	mov eax, white + (red*16)
	call SetTextColor
	skip:
	mov eax, 34
	call WriteChar
	mov dh, 20
	call Gotoxy
ret
printGhost1 ENDP

printGhost2 PROC
	mov edx, ghost2X
	mov eax, ghost2Y
	mov dh, al
	call Gotoxy
	CMP powerUp, 0
	JE noPower
		mov eax, white + (cyan*16)
		call SetTextColor
		JMP skip
	noPower:
	mov eax, white + (green*16)
	call SetTextColor
	skip:
	mov eax, 34
	call WriteChar
	mov dh, 20
	call Gotoxy
ret
printGhost2 ENDP

printGhost3 PROC
	mov edx, ghost3X
	mov eax, ghost3Y
	mov dh, al
	call Gotoxy
	CMP powerUp, 0
	JE noPower
		mov eax, white + (cyan*16)
		call SetTextColor
		JMP skip
	noPower:
	mov eax, white + (magenta*16)
	call SetTextColor
	skip:
	mov eax, 34
	call WriteChar
	mov dh, 20
	call Gotoxy
ret
printGhost3 ENDP

printGhost4 PROC
	mov edx, ghost4X
	mov eax, ghost4Y
	mov dh, al
	call Gotoxy
	CMP powerUp, 0
	JE noPower
		mov eax, white + (cyan*16)
		call SetTextColor
		JMP skip
	noPower:
	mov eax, white + (gray*16)
	call SetTextColor
	skip:
	mov eax, 34
	call WriteChar
	mov dh, 20
	call Gotoxy
ret
printGhost4 ENDP

printGhost5 PROC
	mov edx, ghost5X
	mov eax, ghost5Y
	mov dh, al
	call Gotoxy
	CMP powerUp, 0
	JE noPower
		mov eax, white + (cyan*16)
		call SetTextColor
		JMP skip
	noPower:
	mov eax, white + (lightBlue*16)
	call SetTextColor
	skip:
	mov eax, 34
	call WriteChar
	mov dh, 20
	call Gotoxy
ret
printGhost5 ENDP

ghostMovement PROC
	mov ghostTrail, 0
	mov moveBack, 0
	CMP ghostChange, 0
	JE skipMatch
	mov ghostChange, 0
	mov eax, 4
	call RandomRange
	inc eax
	CMP eax, 1
	JNE randomMove
	mov ebx, pacManX
	CMP ghostMoveTempX, ebx
	JE skipX
	JL lessX
		mov ghostMoveTemp, 2
		JMP skipMatch
	lessX:
		mov ghostMoveTemp, 4
		JMP skipMatch
	skipX:
	mov ebx, pacManY
	CMP ghostMoveTempY, ebx
	JL lessY
		mov ghostMoveTemp, 1
		JMP skipMatch
	lessY:
		mov ghostMoveTemp, 3
		JMP skipMatch
	skipMatch:
	randomMove:
	CMP ghostMoveTemp, 1
	JE moveUp
	CMP ghostMoveTemp, 2
	JE moveLeft
	CMP ghostMoveTemp, 3
	JE moveDown
	CMP ghostMoveTemp, 4
	JE moveRight

	moveUp:
		dec ghostMoveTempY
		mov eax, ghostMoveTempY
		mov checkWallTempY, eax
		mov eax, ghostMoveTempX
		mov checkWallTempX, eax
		call checkWall
		CMP moveBack, 1
		JE wallHit1
			inc ghostMoveTempY
			CMP level, 1
			JNE notLevel1_1
			CMP ghostTempSpeed, 80
			JMP afterCheck1
			notLevel1_1:
			CMP level, 2
			JNE notLevel2_1
			CMP ghostTempSpeed, 50
			JMP afterCheck1
			notLevel2_1:
			CMP level, 3
			JNE notLevel3_1
			CMP ghostTempSpeed, 30
			JMP afterCheck1
			notLevel3_1:
			afterCheck1:
			JL skip
			mov ghostTempSpeed, 0
			mov edx, ghostMoveTempX
			mov eax, ghostMoveTempY
			mov ghostTrailTempY, eax
			mov ghostTrailTempX, edx
			mov dh, al
			call Gotoxy
			call checkGhostTrail
			CMP ghostTrail, 1
			JE printFood
				mov eax, white + (black*16)
				call SetTextColor
				mov eax, " "
				call WriteChar
				JMP noFood
			printFood:
				mov eax, yellow + (black*16)
				call SetTextColor
				mov eax, 248
				call WriteChar
			noFood:
			dec ghostMoveTempY
			JMP skip
		wallHit1:
		mov ghostChange, 1
		inc ghostMoveTempY
		mov eax, 4
		call RandomRange
		inc eax
		mov ghostMoveTemp, eax
		JMP skip

	moveLeft:
		dec ghostMoveTempX
		mov eax, ghostMoveTempY
		mov checkWallTempY, eax
		mov eax, ghostMoveTempX
		mov checkWallTempX, eax
		call checkWall
		CMP moveBack, 1
		JE wallHit2
			inc ghostMoveTempX
			CMP level, 1
			JNE notLevel1_2
			CMP ghostTempSpeed, 80
			JMP afterCheck2
			notLevel1_2:
			CMP level, 2
			JNE notLevel2_2
			CMP ghostTempSpeed, 50
			JMP afterCheck2
			notLevel2_2:
			CMP level, 3
			JNE notLevel3_2
			CMP ghostTempSpeed, 30
			JMP afterCheck2
			notLevel3_2:
			afterCheck2:
			JL skip
			mov ghostTempSpeed, 0
			mov edx, ghostMoveTempX
			mov eax, ghostMoveTempY
			mov ghostTrailTempY, eax
			mov ghostTrailTempX, edx
			mov dh, al
			call Gotoxy
			call checkGhostTrail
			CMP ghostTrail, 1
			JE printFood2
				mov eax, white + (black*16)
				call SetTextColor
				mov eax, " "
				call WriteChar
				JMP noFood2
			printFood2:
				mov eax, yellow + (black*16)
				call SetTextColor
				mov eax, 248
				call WriteChar
			noFood2:
			dec ghostMoveTempX
			JMP skip
		wallHit2:
		mov ghostChange, 1
		inc ghostMoveTempX
		mov eax, 4
		call RandomRange
		inc eax
		mov ghostMoveTemp, eax
		JMP skip

	moveDown:
		inc ghostMoveTempY
		mov eax, ghostMoveTempY
		mov checkWallTempY, eax
		mov eax, ghostMoveTempX
		mov checkWallTempX, eax
		call checkWall
		CMP moveBack, 1
		JE wallHit3
			dec ghostMoveTempY
			CMP level, 1
			JNE notLevel1_3
			CMP ghostTempSpeed, 80
			JMP afterCheck3
			notLevel1_3:
			CMP level, 2
			JNE notLevel2_3
			CMP ghostTempSpeed, 50
			JMP afterCheck3
			notLevel2_3:
			CMP level, 3
			JNE notLevel3_3
			CMP ghostTempSpeed, 30
			JMP afterCheck3
			notLevel3_3:
			afterCheck3:
			JL skip
			mov ghostTempSpeed, 0
			mov edx, ghostMoveTempX
			mov eax, ghostMoveTempY
			mov ghostTrailTempY, eax
			mov ghostTrailTempX, edx
			mov dh, al
			call Gotoxy
			call checkGhostTrail
			CMP ghostTrail, 1
			JE printFood3
				mov eax, white + (black*16)
				call SetTextColor
				mov eax, " "
				call WriteChar
				JMP noFood3
			printFood3:
				mov eax, yellow + (black*16)
				call SetTextColor
				mov eax, 248
				call WriteChar
			noFood3:
			inc ghostMoveTempY
			JMP skip
		wallHit3:
		mov ghostChange, 1
		dec ghostMoveTempY
		mov eax, 4
		call RandomRange
		inc eax
		mov ghostMoveTemp, eax
		JMP skip

	moveRight:
		inc ghostMoveTempX
		mov eax, ghostMoveTempY
		mov checkWallTempY, eax
		mov eax, ghostMoveTempX
		mov checkWallTempX, eax
		call checkWall
		CMP moveBack, 1
		JE wallHit4
			dec ghostMoveTempX
			CMP level, 1
			JNE notLevel1_4
			CMP ghostTempSpeed, 80
			JMP afterCheck4
			notLevel1_4:
			CMP level, 2
			JNE notLevel2_4
			CMP ghostTempSpeed, 50
			JMP afterCheck4
			notLevel2_4:
			CMP level, 3
			JNE notLevel3_4
			CMP ghostTempSpeed, 30
			JMP afterCheck4
			notLevel3_4:
			afterCheck4:
			JL skip
			mov ghostTempSpeed, 0
			mov edx, ghostMoveTempX
			mov eax, ghostMoveTempY
			mov ghostTrailTempY, eax
			mov ghostTrailTempX, edx
			mov dh, al
			call Gotoxy
			call checkGhostTrail
			CMP ghostTrail, 1
			JE printFood4
				mov eax, white + (black*16)
				call SetTextColor
				mov eax, " "
				call WriteChar
				JMP noFood4
			printFood4:
				mov eax, yellow + (black*16)
				call SetTextColor
				mov eax, 248
				call WriteChar
			noFood4:
			inc ghostMoveTempX
			JMP skip
		wallHit4:
		mov ghostChange, 1
		dec ghostMoveTempX
		mov eax, 4
		call RandomRange
		inc eax
		mov ghostMoveTemp, eax
		JMP skip

	skip:
	CMP ghostDirection, 700
	JL noChange
		mov ghostChange, 1
		mov ghostDirection, 0
		mov eax, 4
		call RandomRange
		inc eax
		mov ghostMoveTemp, eax
	noChange:
	inc ghostDirection
	inc ghostTempSpeed
	mov moveBack, 0
ret
ghostMovement ENDP

PacManMovement PROC
	mov moveBack, 0
	CMP moveVar, "w"
	JNE skip1
		dec pacManY
		mov eax, pacManY
		mov checkWallTempY, eax
		mov eax, pacManX
		mov checkWallTempX, eax
		call checkWall
		CMP moveBack, 1
		JE skip1_2
		mov upBool, 1
		mov downBool, 0
		mov leftBool, 0
		mov rightBool, 0
	skip1_2:
	inc pacManY
	skip1:
	mov moveBack,0
	CMP moveVar, "a"
	JNE skip2
		dec pacManX
		mov eax, pacManY
		mov checkWallTempY, eax
		mov eax, pacManX
		mov checkWallTempX, eax
		call checkWall
		CMP moveBack, 1
		JE skip2_2
		mov upBool, 0
		mov downBool, 0
		mov leftBool, 1
		mov rightBool, 0
	skip2_2:
		inc pacManX
	skip2:
	mov moveBack,0
	CMP moveVar, "s"
	JNE skip3
		inc pacManY
		mov eax, pacManY
		mov checkWallTempY, eax
		mov eax, pacManX
		mov checkWallTempX, eax
		call checkWall
		CMP moveBack, 1
		JE skip3_2
		mov upBool, 0
		mov downBool, 1
		mov leftBool, 0
		mov rightBool, 0
	skip3_2:
		dec pacManY
	skip3:
	mov moveBack,0
	CMP moveVar, "d"
	JNE skip4
		inc pacManX
		mov eax, pacManY
		mov checkWallTempY, eax
		mov eax, pacManX
		mov checkWallTempX, eax
		call checkWall
		CMP moveBack, 1
		JE skip4_2
		mov upBool, 0
		mov downBool, 0
		mov leftBool, 0
		mov rightBool, 1
	skip4_2:
		dec pacManX
	skip4:
	mov moveBack,0
	CMP upBool, 1
	JE moveUp
	CMP downBool, 1
	JE moveDown
	CMP leftBool, 1
	JE moveLeft
	CMP rightBool, 1
	JE moveRight
	JMP skip
	moveUp:
		CMP level , 1
		JNE notLevel1_1
		CMP pacManMoveCount, 80
		JMP afterCheck1
		notLevel1_1:
		CMP level , 2
		JNE notLevel2_1
		CMP pacManMoveCount, 50
		JMP afterCheck1
		notLevel2_1:
		CMP level, 3
		JNE notLevel3_1
		CMP pacManMoveCount, 30
		JMP afterCheck1
		notLevel3_1:
		afterCheck1:
		JLE skip
		mov pacManMoveCount, 0
		mov edx, pacManX
		mov eax, pacManY
		mov dh, al
		call Gotoxy
		mov eax, white + (black*16)
		call SetTextColor
		mov eax, " "
		call WriteChar
		mov dh, 19
		call Gotoxy
		dec pacManY
		mov eax, pacManY
		mov checkWallTempY, eax
		mov eax, pacManX
		mov checkWallTempX, eax
		call checkWall
		CMP moveBack, 1
		JE wallHit
		JMP skip
		wallHit:
			inc pacManY
		JMP skip
	moveLeft:
		CMP level , 1
		JNE notLevel1_2
		CMP pacManMoveCount, 80
		JMP afterCheck2
		notLevel1_2:
		CMP level , 2
		JNE notLevel2_2
		CMP pacManMoveCount, 50
		JMP afterCheck2
		notLevel2_2:
		CMP level, 3
		JNE notLevel3_2
		CMP pacManMoveCount, 30
		JMP afterCheck2
		notLevel3_2:
		afterCheck2:
		JLE skip
		mov pacManMoveCount, 0
		mov edx, pacManX
		mov eax, pacManY
		mov dh, al
		call Gotoxy
		mov eax, white + (black*16)
		call SetTextColor
		mov eax, " "
		call WriteChar
		mov dh, 19
		call Gotoxy
		dec pacManX
		mov eax, pacManY
		mov checkWallTempY, eax
		mov eax, pacManX
		mov checkWallTempX, eax
		call checkWall
		CMP moveBack, 1
		JE wallHit2
		JMP skip
		wallHit2:
			inc pacManX
		JMP skip
	moveDown:
		CMP level , 1
		JNE notLevel1_3
		CMP pacManMoveCount, 80
		JMP afterCheck3
		notLevel1_3:
		CMP level , 2
		JNE notLevel2_3
		CMP pacManMoveCount, 50
		JMP afterCheck3
		notLevel2_3:
		CMP level, 3
		JNE notLevel3_3
		CMP pacManMoveCount, 30
		JMP afterCheck3
		notLevel3_3:
		afterCheck3:
		JLE skip
		mov pacManMoveCount, 0
		mov edx, pacManX
		mov eax, pacManY
		mov dh, al
		call Gotoxy
		mov eax, white + (black*16)
		call SetTextColor
		mov eax, " "
		call WriteChar
		mov dh, 19
		call Gotoxy
		inc pacManY
		mov eax, pacManY
		mov checkWallTempY, eax
		mov eax, pacManX
		mov checkWallTempX, eax
		call checkWall
		CMP moveBack, 1
		JE wallHit3
		JMP skip
		wallHit3:
			dec pacManY
		JMP skip
	moveRight:
		CMP level , 1
		JNE notLevel1_4
		CMP pacManMoveCount, 80
		JMP afterCheck4
		notLevel1_4:
		CMP level , 2
		JNE notLevel2_4
		CMP pacManMoveCount, 50
		JMP afterCheck4
		notLevel2_4:
		CMP level, 3
		JNE notLevel3_4
		CMP pacManMoveCount, 30
		JMP afterCheck4
		notLevel3_4:
		afterCheck4:
		JLE skip
		mov pacManMoveCount, 0
		mov edx, pacManX
		mov eax, pacManY
		mov dh, al
		call Gotoxy
		mov eax, white + (black*16)
		call SetTextColor
		mov eax, " "
		call WriteChar
		mov dh, 19
		call Gotoxy
		inc pacManX
		mov eax, pacManY
		mov checkWallTempY, eax
		mov eax, pacManX
		mov checkWallTempX, eax
		call checkWall
		CMP moveBack, 1
		JE wallHit4
		JMP skip
		wallHit4:
			dec pacManX
		JMP skip
	skip:
		inc pacManMoveCount
		mov moveBack, 0
ret
PacManMovement ENDP

printScore PROC
	mov dh, 10
	mov dl, 45
	call Gotoxy
	mov eax, white + (green*16)
	call SetTextColor
	mov edx, offset scoreTXT
	call WriteString
	mov eax, score
	call WriteInt
	mov eax, " "
	call WriteChar
	mov dh, 12
	mov dl, 45
	call Gotoxy
	mov eax, white + (red*16)
	call SetTextColor
	mov edx, offset livesTXT
	call WriteString
	mov eax, 0
	mov al, lives
	call WriteInt
	mov eax, " "
	call WriteChar
	mov dh, 14
	mov dl, 45
	call Gotoxy
	mov eax, yellow + (blue*16)
	call SetTextColor
	mov edx, offset userNameTXT
	call WriteString
	mov edx, offset userName
	call WriteString
	mov eax, " "
	call WriteChar
	mov dh, 16
	mov dl, 45
	call Gotoxy
	mov eax, white + (magenta*16)
	call SetTextColor
	mov edx, offset levelTXT
	call WriteString
	movzx eax, level
	call WriteInt
	mov eax, " "
	call WriteChar
	mov eax, blue + (brown*16)
	call SetTextColor
	mov dh, 1
	mov dl, 45
	call Gotoxy
	mov edx, offset inGameTitle1
	call WriteString
	mov dh, 2
	mov dl, 45
	call Gotoxy
	mov edx, offset inGameTitle2
	call WriteString
	mov dh, 3
	mov dl, 45
	call Gotoxy
	mov edx, offset inGameTitle3
	call WriteString
	mov dh, 4
	mov dl, 45
	call Gotoxy
	mov edx, offset inGameTitle4
	call WriteString
	mov dh, 5
	mov dl, 45
	call Gotoxy
	mov edx, offset inGameTitle5
	call WriteString
	mov dh, 6
	mov dl, 45
	call Gotoxy
	mov edx, offset inGameTitle6
	call WriteString
	mov dh, 7
	mov dl, 45
	call Gotoxy
	mov edx, offset inGameTitle7
	call WriteString
	mov dh, 8
	mov dl, 45
	call Gotoxy
	mov edx, offset inGameTitle8
	call WriteString
ret
printScore ENDP

enterName PROC
	mov eax, blue + (black*16)
	call SetTextColor
	mov dh, 4
	mov dl, 19
	call Gotoxy
	mov edx, offset menuBox1
	call WriteString
	mov dh, 5
	mov dl, 19
	call Gotoxy
	mov edx, offset menuBox2
	call WriteString
	mov dh, 6
	mov dl, 19
	call Gotoxy
	mov edx, offset menuBox3
	call WriteString
	mov dh, 7
	mov dl, 19
	call Gotoxy
	mov edx, offset menuBox4
	call WriteString
	mov dh, 8
	mov dl, 19
	call Gotoxy
	mov edx, offset menuBox5
	call WriteString
	mov dh, 9
	mov dl, 19
	call Gotoxy
	mov edx, offset menuBox6
	call WriteString
	mov dh, 10
	mov dl, 19
	call Gotoxy
	mov edx, offset menuBox7
	call WriteString
	mov dh, 11
	mov dl, 19
	call Gotoxy
	mov edx, offset menuBox8
	call WriteString
	mov eax, brown + (black*16)
	call SetTextColor
	mov dh, 5
	mov dl, 22
	call Gotoxy
	mov edx, offset title1
	call WriteString
	mov dh, 6
	mov dl, 22
	call Gotoxy
	mov edx, offset title2
	call WriteString
	mov dh, 7
	mov dl, 22
	call Gotoxy
	mov edx, offset title3
	call WriteString
	mov dh, 8
	mov dl, 22
	call Gotoxy
	mov edx, offset title4
	call WriteString
	mov dh, 9
	mov dl, 22
	call Gotoxy
	mov edx, offset title5
	call WriteString
	mov dh, 10
	mov dl, 22
	call Gotoxy
	mov edx, offset title6
	call WriteString
	mov dh, 11
	mov dl, 20
	call Gotoxy
	mov eax, blue + (black*16)
	call SetTextColor
	mov dh, 15
	mov dl, 45
	call Gotoxy
	mov edx, offset enterNamePrompt
	call WriteString
	mov dh, 17
	mov dl, 45
	call Gotoxy
	mov eax, brown + (black*16)
	call SetTextColor
	mov edx, offset userName
	mov ecx, userNameSize
	call ReadString
ret
enterName ENDP

checkGhostCollision PROC
	mov eax, ghostCollTempX
	CMP pacManX, eax
	JNE skip
	mov eax, ghostCollTempY
	CMP pacManY, eax
	JNE skip
	CMP powerUp, 0
	JE noPower
		mov ghostCollTempX, 19
		mov ghostCollTempY, 10
		INVOKE PlaySound, offset eatSound, NULL, 11h
		add score, 20
		JMP skip
	noPower:
	dec lives
	INVOKE PlaySound, offset deathSound, NULL, 0
	;INVOKE PlaySound, offset deathSound, NULL, 11h
	mov pacManX, 20
	mov pacManY, 19
	skip:
ret
checkGhostCollision ENDP

printLoading PROC
	mov eax, magenta + (black*16)
	call SetTextColor
	mov dh, 1
	mov dl, 45
	call Gotoxy
	mov edx, offset loading1
	call WriteString
	mov dh, 2
	mov dl, 45
	call Gotoxy
	mov edx, offset loading2
	call WriteString
	mov dh, 3
	mov dl, 45
	call Gotoxy
	mov edx, offset loading3
	call WriteString
	mov dh, 4
	mov dl, 45
	call Gotoxy
	mov edx, offset loading4
	call WriteString
	mov dh, 5
	mov dl, 45
	call Gotoxy
	mov edx, offset loading5
	call WriteString
	mov dh, 6
	mov dl, 45
	call Gotoxy
	mov edx, offset loading6
	call WriteString
	mov dh, 7
	mov dl, 45
	call Gotoxy
	mov edx, offset loading7
	call WriteString
ret
printLoading ENDP

pauseScreen PROC
	mov eax, black + (black*16)
	call SetTextColor
	mov dh, 21
	mov dl, 45
	call Gotoxy
	mov edx, offset clearPrompt
	call WriteString
	mov dh, 10
	mov dl, 45
	call Gotoxy
	mov eax, white + (green*16)
	call SetTextColor
	mov edx, offset scoreTXT
	call WriteString
	mov eax, score
	call WriteInt
	mov eax, " "
	call WriteChar
	mov dh, 12
	mov dl, 45
	call Gotoxy
	mov eax, white + (red*16)
	call SetTextColor
	mov edx, offset livesTXT
	call WriteString
	mov eax, 0
	mov al, lives
	call WriteInt
	mov eax, " "
	call WriteChar
	mov dh, 14
	mov dl, 45
	call Gotoxy
	mov eax, yellow + (blue*16)
	call SetTextColor
	mov edx, offset userNameTXT
	call WriteString
	mov edx, offset userName
	call WriteString
	mov eax, " "
	call WriteChar
	mov dh, 16
	mov dl, 45
	call Gotoxy
	mov eax, white + (magenta*16)
	call SetTextColor
	mov edx, offset levelTXT
	call WriteString
	movzx eax, level
	call WriteInt
	mov eax, " "
	call WriteChar
	mov dh, 10
	mov dl, 75
	call Gotoxy
	mov eax, green + (black*16)
	call SetTextColor
	mov edx, offset resumePrompt
	call WriteString
	mov dh, 12
	mov dl, 75
	call Gotoxy
	mov eax, magenta + (black*16)
	call SetTextColor
	mov edx, offset restartPrompt
	call WriteString
	mov dh, 14
	mov dl, 75
	call Gotoxy
	mov eax, white + (black*16)
	call SetTextColor
	mov edx, offset returnPrompt
	call WriteString
	mov dh, 16
	mov dl, 75
	call Gotoxy
	mov eax, red + (black*16)
	call SetTextColor
	mov edx, offset quitPrompt
	call WriteString
	mov eax, green + (black*16)
	call SetTextColor
	mov dh, 1
	mov dl, 45
	call Gotoxy
	mov edx, offset pauseTitle1
	call WriteString
	mov dh, 2
	mov dl, 45
	call Gotoxy
	mov edx, offset pauseTitle2
	call WriteString
	mov dh, 3
	mov dl, 45
	call Gotoxy
	mov edx, offset pauseTitle3
	call WriteString
	mov dh, 4
	mov dl, 45
	call Gotoxy
	mov edx, offset pauseTitle4
	call WriteString
	mov dh, 5
	mov dl, 45
	call Gotoxy
	mov edx, offset pauseTitle5
	call WriteString
	mov dh, 6
	mov dl, 45
	call Gotoxy
	mov edx, offset pauseTitle6
	call WriteString
	mov dh, 7
	mov dl, 45
	call Gotoxy
	mov edx, offset pauseTitle7
	call WriteString
	mov dh, 8
	mov dl, 45
	call Gotoxy
	mov edx, offset pauseTitle8
	call WriteString
ret
pauseScreen ENDP

clearPause PROC
	mov dh, 10
	mov dl, 75
	call Gotoxy
	mov eax, green + (black*16)
	call SetTextColor
	mov edx, offset clearPrompt
	call WriteString
	mov dh, 12
	mov dl, 75
	call Gotoxy
	mov eax, red + (black*16)
	call SetTextColor
	mov edx, offset clearPrompt
	call WriteString
	mov dh, 14
	mov dl, 75
	call Gotoxy
	mov eax, red + (black*16)
	call SetTextColor
	mov edx, offset clearPrompt
	call WriteString
	mov dh, 16
	mov dl, 75
	call Gotoxy
	mov eax, red + (black*16)
	call SetTextColor
	mov edx, offset clearPrompt
	call WriteString
ret
clearPause ENDP

checkWin PROC
	mov ecx, 21
	mov esi, 0
	L1:
		mov temp, ecx
		mov ecx, 40
		L2:
			CMP [gameArray+esi], 1
			JE loss
			inc esi
			loop L2
		mov ecx, temp
		inc esi
		loop L1
			mov gameWon, 1
			JMP skip
		loss:
			mov gameWon, 0
		skip:
ret
checkWin ENDP

portal PROC
	CMP ecx, 0
	JGE skip1
		mov ecx, 39
	skip1:
	CMP eax, 10
	JNE no_teleport
	CMP ecx, 40
	JLE no_teleport
		mov ecx, 0
	no_teleport:

ret
portal ENDP

printFruit PROC
	movzx edx, fruitX
	movzx eax, fruitY
	mov dh, al
	call Gotoxy
	mov eax, red + (black*16)
	call SetTextColor
	mov eax, 254
	call WriteChar
	mov dh, 20
	call Gotoxy
ret
printFruit ENDP

eatFruit PROC
	movzx eax, fruitX
	CMP pacManX, eax
	JNE skip
	movzx eax, fruitY
	CMP pacManY, eax
	JNE skip
		INVOKE PlaySound, offset eatSound, NULL, 11h
		add score, 9
		L1:
		mov moveBack, 0
		mov eax, 19
		call RandomRange
		inc eax
		inc eax
		mov fruitY, al
		mov eax, 38
		call RandomRange
		inc eax
		inc eax
		mov fruitX, al

		movzx eax, fruitX
		mov checkWallTempX, eax
		movzx eax, fruitY
		mov checkWallTempY, eax
		call checkWall
		CMP moveBack, 1
		JE L1
	skip:
		mov moveBack, 0
ret
eatFruit ENDP

printPower PROC
	movzx edx, powerUpX
	movzx eax, powerUpY
	mov dh, al
	call Gotoxy
	mov eax, brown + (black*16)
	call SetTextColor
	mov eax, 254
	call WriteChar
	mov dh, 20
	call Gotoxy
ret
printPower ENDP

eatPower PROC
	movzx eax, powerUpX
	CMP pacManX, eax
	JNE skip
	movzx eax, powerUpY
	CMP pacManY, eax
	JNE skip
		INVOKE PlaySound, offset eatSound, NULL, 11h
		mov powerUpTimer, 0
		mov powerUp, 1
		L1:
		mov moveBack, 0
		mov eax, 19
		call RandomRange
		inc eax
		inc eax
		mov powerUpY, al
		mov eax, 38
		call RandomRange
		inc eax
		inc eax
		mov powerUpX, al

		movzx eax, powerUpX
		mov checkWallTempX, eax
		movzx eax, powerUpY
		mov checkWallTempY, eax
		call checkWall
		CMP moveBack, 1
		JE L1
	skip:
		mov moveBack, 0
ret
eatPower ENDP

levelMenu PROC
	mov eax, blue + (black*16)
	call SetTextColor
	mov dh, 4
	mov dl, 19
	call Gotoxy
	mov edx, offset menuBox1
	call WriteString
	mov dh, 5
	mov dl, 19
	call Gotoxy
	mov edx, offset menuBox2
	call WriteString
	mov dh, 6
	mov dl, 19
	call Gotoxy
	mov edx, offset menuBox3
	call WriteString
	mov dh, 7
	mov dl, 19
	call Gotoxy
	mov edx, offset menuBox4
	call WriteString
	mov dh, 8
	mov dl, 19
	call Gotoxy
	mov edx, offset menuBox5
	call WriteString
	mov dh, 9
	mov dl, 19
	call Gotoxy
	mov edx, offset menuBox6
	call WriteString
	mov dh, 10
	mov dl, 19
	call Gotoxy
	mov edx, offset menuBox7
	call WriteString
	mov dh, 11
	mov dl, 19
	call Gotoxy
	mov edx, offset menuBox8
	call WriteString
	mov eax, brown + (black*16)
	call SetTextColor
	mov dh, 5
	mov dl, 22
	call Gotoxy
	mov edx, offset title1
	call WriteString
	mov dh, 6
	mov dl, 22
	call Gotoxy
	mov edx, offset title2
	call WriteString
	mov dh, 7
	mov dl, 22
	call Gotoxy
	mov edx, offset title3
	call WriteString
	mov dh, 8
	mov dl, 22
	call Gotoxy
	mov edx, offset title4
	call WriteString
	mov dh, 9
	mov dl, 22
	call Gotoxy
	mov edx, offset title5
	call WriteString
	mov dh, 10
	mov dl, 22
	call Gotoxy
	mov edx, offset title6
	call WriteString
	mov dh, 11
	mov dl, 20
	call Gotoxy
	mov eax, blue + (black*16)
	call SetTextColor
	mov dh, 15
	mov dl, 45
	call Gotoxy
	mov edx, offset levelPrompt
	call WriteString
	mov dh, 17
	mov dl, 50
	call Gotoxy
	mov eax, green + (black*16)
	call SetTextColor
	mov edx, offset level1Choice
	call WriteString
	mov dh, 19
	mov dl, 50
	call Gotoxy
	mov eax, brown + (black*16)
	call SetTextColor
	mov edx, offset level2Choice
	call WriteString
	mov dh, 21
	mov dl, 50
	call Gotoxy
	mov eax, red + (black*16)
	call SetTextColor
	mov edx, offset level3Choice
	call WriteString
	mov dh, 23
	mov dl, 47
	call Gotoxy
	mov eax, white + (black*16)
	call SetTextColor
	mov edx, offset backPrompt
	call WriteString
ret
levelMenu ENDP

printLevel1 PROC
	mov dh, 9
	mov dl, 29
	call Gotoxy
	mov eax, green + (black*16)
	call SetTextColor
	mov edx, offset level1Title1
	call WriteString
	mov dh, 10
	mov dl, 29
	call Gotoxy
	mov edx, offset level1Title2
	call WriteString
	mov dh, 11
	mov dl, 29
	call Gotoxy
	mov edx, offset level1Title3
	call WriteString
	mov dh, 12
	mov dl, 29
	call Gotoxy
	mov edx, offset level1Title4
	call WriteString
	mov dh, 13
	mov dl, 29
	call Gotoxy
	mov edx, offset level1Title5
	call WriteString
	mov dh, 14
	mov dl, 29
	call Gotoxy
	mov edx, offset level1Title6
	call WriteString

	mov dh, 16
	mov dl, 44
	call Gotoxy
	call WaitMsg
ret
printLevel1 ENDP

printLevel2 PROC
	mov dh, 9
	mov dl, 26
	call Gotoxy
	mov eax, blue + (black*16)
	call SetTextColor
	mov edx, offset level2Title1
	call WriteString
	mov dh, 10
	mov dl, 26
	call Gotoxy
	mov edx, offset level2Title2
	call WriteString
	mov dh, 11
	mov dl, 26
	call Gotoxy
	mov edx, offset level2Title3
	call WriteString
	mov dh, 12
	mov dl, 26
	call Gotoxy
	mov edx, offset level2Title4
	call WriteString
	mov dh, 13
	mov dl, 26
	call Gotoxy
	mov edx, offset level2Title5
	call WriteString
	mov dh, 14
	mov dl, 26
	call Gotoxy
	mov edx, offset level2Title6
	call WriteString

	mov dh, 16
	mov dl, 41
	call Gotoxy
	call WaitMsg
ret
printLevel2 ENDP

printLevel3 PROC
	mov dh, 9
	mov dl, 26
	call Gotoxy
	mov eax, red + (black*16)
	call SetTextColor
	mov edx, offset level3Title1
	call WriteString
	mov dh, 10
	mov dl, 26
	call Gotoxy
	mov edx, offset level3Title2
	call WriteString
	mov dh, 11
	mov dl, 26
	call Gotoxy
	mov edx, offset level3Title3
	call WriteString
	mov dh, 12
	mov dl, 26
	call Gotoxy
	mov edx, offset level3Title4
	call WriteString
	mov dh, 13
	mov dl, 26
	call Gotoxy
	mov edx, offset level3Title5
	call WriteString
	mov dh, 14
	mov dl, 26
	call Gotoxy
	mov edx, offset level3Title6
	call WriteString

	mov dh, 16
	mov dl, 41
	call Gotoxy
	call WaitMsg
ret
printLevel3 ENDP

intToString PROC
	mov [score_string+6], 0
	mov esi, 5
	mov edx, 0
	mov eax, score
	mov ebx, 10
	idiv ebx
	mov [score_string+esi], dl
	add [score_string+esi], 48

	dec esi
	mov edx, 0
	mov ebx, 10
	idiv ebx
	mov [score_string+esi], dl
	add [score_string+esi], 48

	dec esi
	mov edx, 0
	mov ebx, 10
	idiv ebx
	mov [score_string+esi], dl
	add [score_string+esi], 48

	dec esi
	mov edx, 0
	mov ebx, 10
	idiv ebx
	mov [score_string+esi], dl
	add [score_string+esi], 48

	dec esi
	mov edx, 0
	mov ebx, 100000
	idiv ebx
	mov [score_string+esi], dl
	add [score_string+esi], 48

	dec esi
	mov edx, 0
	mov ebx, 10
	idiv ebx
	mov [score_string+esi], dl
	add [score_string+esi], 48
ret
intToString ENDP

stringToInt PROC
	mov esi, 0
	sub [temp_score_string+esi], 48
	movzx eax, [temp_score_string+esi]
	imul eax, 10
	mov temp_score, eax

	inc esi
	sub [temp_score_string+esi], 48
	movzx eax, [temp_score_string+esi]
	mov ebx, temp_score
	add ebx, eax
	imul ebx, 10
	mov temp_score, ebx

	inc esi
	sub [temp_score_string+esi], 48
	movzx eax, [temp_score_string+esi]
	mov ebx, temp_score
	add ebx, eax
	imul ebx, 10
	mov temp_score, ebx

	inc esi
	sub [temp_score_string+esi], 48
	movzx eax, [temp_score_string+esi]
	mov ebx, temp_score
	add ebx, eax
	imul ebx, 10
	mov temp_score, ebx

	inc esi
	sub [temp_score_string+esi], 48
	movzx eax, [temp_score_string+esi]
	mov ebx, temp_score
	add ebx, eax
	imul ebx, 10
	mov temp_score, ebx

	inc esi
	sub [temp_score_string+esi], 48
	movzx eax, [temp_score_string+esi]
	mov ebx, temp_score
	add ebx, eax
	mov temp_score, ebx
ret
stringToInt ENDP

saveInFile PROC
	mov edx, offset score_file
	call OpenInputFile
	mov score_handle, eax

	mov edx, offset score_buffer
	mov ecx, 5000
	call ReadFromFile
	mov bytes_read, eax

	mov eax, score_handle
	call CloseFile

	mov edx, offset score_file
	call CreateOutputFile
	mov score_handle, eax

	mov eax, score_handle
	mov edx, offset score_buffer
	mov ecx, bytes_read
	call WriteToFile

	mov eax, score_handle
	mov edx, offset userName
	mov ecx, 20
	call WriteToFile

	mov eax, score_handle
	mov edx, offset score_string
	mov ecx, 7
	call WriteToFile

	add level, 48
	mov edx, offset level
	mov eax, score_handle
	mov ecx, 1
	call WriteToFile
	sub level, 48

	mov eax, score_handle
	call CloseFile
ret
saveInFile ENDP

printScores PROC
	mov edx, offset score_file
	call OpenInputFile
	mov score_handle, eax

	mov edx, offset highscores_name1
	mov eax, score_handle
	mov ecx, 20
	call ReadFromFile

	mov edx, offset highscore1
	mov eax, score_handle
	mov ecx, 7
	call ReadFromFile

	mov edx, offset highscore_level1
	mov eax, score_handle
	mov ecx, 1
	call ReadFromFile

	mov edx, offset highscores_name2
	mov eax, score_handle
	mov ecx, 20
	call ReadFromFile

	mov edx, offset highscore2
	mov eax, score_handle
	mov ecx, 7
	call ReadFromFile

	mov edx, offset highscore_level2
	mov eax, score_handle
	mov ecx, 1
	call ReadFromFile

	mov edx, offset highscores_name3
	mov eax, score_handle
	mov ecx, 20
	call ReadFromFile

	mov edx, offset highscore3
	mov eax, score_handle
	mov ecx, 7
	call ReadFromFile

	mov edx, offset highscore_level3
	mov eax, score_handle
	mov ecx, 1
	call ReadFromFile

	mov edx, offset highscores_name4
	mov eax, score_handle
	mov ecx, 20
	call ReadFromFile

	mov edx, offset highscore4
	mov eax, score_handle
	mov ecx, 7
	call ReadFromFile

	mov edx, offset highscore_level4
	mov eax, score_handle
	mov ecx, 1
	call ReadFromFile

	mov edx, offset highscores_name5
	mov eax, score_handle
	mov ecx, 20
	call ReadFromFile

	mov edx, offset highscore5
	mov eax, score_handle
	mov ecx, 7
	call ReadFromFile

	mov edx, offset highscore_level5
	mov eax, score_handle
	mov ecx, 1
	call ReadFromFile

	mov eax, score_handle
	call CloseFile
ret
printScores ENDP

mainMenuScores PROC
	call printScores
	mov eax, brown + (black*16)
	call SetTextColor
	mov dh, 6
	mov dl, 26
	call Gotoxy
	mov edx, offset mainScores1
	call WriteString
	mov dh, 7
	mov dl, 26
	call Gotoxy
	mov edx, offset mainScores2
	call WriteString
	mov dh, 8
	mov dl, 26
	call Gotoxy
	mov edx, offset mainScores3
	call WriteString
	mov dh, 9
	mov dl, 26
	call Gotoxy
	mov edx, offset mainScores4
	call WriteString

	mov dh, 12
	mov dl, 35
	call Gotoxy
	mov edx, offset highscores_name1
	call WriteString
	mov dh, 12
	mov dl, 50
	call Gotoxy
	mov edx, offset highscore1
	call WriteString
	mov dh, 12
	mov dl, 56
	call Gotoxy
	mov edx, offset clearPrompt2
	call WriteString
	mov dh, 12
	mov dl, 60
	call Gotoxy
	movzx eax, highscore_level1
	call WriteChar
	mov dh, 14
	mov dl, 10
	call Gotoxy
	mov edx, offset clearPrompt2
	call WriteString
	mov dh, 14
	mov dl, 35
	call Gotoxy
	mov edx, offset highscores_name2
	call WriteString
	mov dh, 14
	mov dl, 50
	call Gotoxy
	mov edx, offset highscore2
	call WriteString
	mov dh, 14
	mov dl, 56
	call Gotoxy
	mov edx, offset clearPrompt2
	call WriteString
	mov dh, 14
	mov dl, 60
	call Gotoxy
	movzx eax, highscore_level2
	call WriteChar
	mov dh, 16
	mov dl, 10
	call Gotoxy
	mov edx, offset clearPrompt2
	call WriteString
	mov dh, 16
	mov dl, 35
	call Gotoxy
	mov edx, offset highscores_name3
	call WriteString
	mov dh, 16
	mov dl, 50
	call Gotoxy
	mov edx, offset highscore3
	call WriteString
	mov dh, 16
	mov dl, 56
	call Gotoxy
	mov edx, offset clearPrompt2
	call WriteString
	mov dh, 16
	mov dl, 60
	call Gotoxy
	movzx eax, highscore_level3
	call WriteChar
	mov dh, 18
	mov dl, 10
	call Gotoxy
	mov edx, offset clearPrompt2
	call WriteString
	mov dh, 18
	mov dl, 35
	call Gotoxy
	mov edx, offset highscores_name4
	call WriteString
	mov dh, 18
	mov dl, 50
	call Gotoxy
	mov edx, offset highscore4
	call WriteString
	mov dh, 18
	mov dl, 56
	call Gotoxy
	mov edx, offset clearPrompt2
	call WriteString
	mov dh, 18
	mov dl, 60
	call Gotoxy
	movzx eax, highscore_level4
	call WriteChar
	mov dh, 20
	mov dl, 10
	call Gotoxy
	mov edx, offset clearPrompt2
	call WriteString
	mov dh, 20
	mov dl, 35
	call Gotoxy
	mov edx, offset highscores_name5
	call WriteString
	mov dh, 20
	mov dl, 50
	call Gotoxy
	mov edx, offset highscore5
	call WriteString
	mov dh, 20
	mov dl, 56
	call Gotoxy
	mov edx, offset clearPrompt2
	call WriteString
	mov dh, 20
	mov dl, 60
	call Gotoxy
	movzx eax, highscore_level5
	call WriteChar
	mov eax, white + (black*16)
	call SetTextColor
	mov dh, 22
	mov dl, 40
	call Gotoxy
	mov edx, offset backPrompt
	call WriteString
ret
mainMenuScores ENDP

gameOverScreen PROC
	mov eax, red + (black*16)
	call SetTextColor
	mov dh, 1
	mov dl, 43
	call Gotoxy
	mov edx, offset gameOver1
	call WriteString
	mov dh, 2
	mov dl, 43
	call Gotoxy
	mov edx, offset gameOver2
	call WriteString
	mov dh, 3
	mov dl, 43
	call Gotoxy
	mov edx, offset gameOver3
	call WriteString
	mov dh, 4
	mov dl, 43
	call Gotoxy
	mov edx, offset gameOver4
	call WriteString
	mov dh, 5
	mov dl, 43
	call Gotoxy
	mov edx, offset gameOver5
	call WriteString
	mov dh, 6
	mov dl, 43
	call Gotoxy
	mov edx, offset gameOver6
	call WriteString
	mov dh, 7
	mov dl, 43
	call Gotoxy
	mov edx, offset gameOver7
	call WriteString
	mov dh, 8
	mov dl, 43
	call Gotoxy
	mov edx, offset clearPrompt
	call WriteString
	mov dh, 8
	mov dl, 60
	call Gotoxy
	mov edx, offset clearPrompt
	call WriteString
	mov dh, 8
	mov dl, 70
	call Gotoxy
	mov edx, offset clearPrompt
	call WriteString

	mov dh, 12
	mov dl, 75
	call Gotoxy
	mov eax, magenta + (black*16)
	call SetTextColor
	mov edx, offset restartPrompt
	call WriteString
	mov dh, 14
	mov dl, 75
	call Gotoxy
	mov eax, white + (black*16)
	call SetTextColor
	mov edx, offset returnPrompt
	call WriteString
	mov dh, 16
	mov dl, 75
	call Gotoxy
	mov eax, red + (black*16)
	call SetTextColor
	mov edx, offset quitPrompt
	call WriteString
ret
gameOverScreen ENDP

main PROC
	mov eax, STD_OUTPUT_HANDLE
	invoke getstdhandle, eax
	mov esi, offset ConsoleInfo
	invoke setConsoleCursorInfo, eax, esi

	homePage:
	mov lives, 3
	mov score, 0
	mov powerUp, 0
	call Clrscr
	mov eax, 0
	mov eax, white+(black*16)
	call SetTextColor
	call printHome
	call ReadChar
	CMP al, "p"
	JNE next1
	JMP levelSelect
	next1:
	CMP al, "h"
	JNE next2
	JMP mainScores
	next2:
	CMP al, "q"
	JE quit
	JMP homePage

	mainScores:
	call Clrscr
	call printScores
	call mainMenuScores
	call ReadChar
	CMP al, "b"
	JNE mainScores
	JMP homePage

	levelSelect:
	mov eax, 0
	call Clrscr
	call levelMenu
	call ReadChar
	CMP al, "3"
	JE level3
	CMP al, "2"
	JE level2
	CMP al, "1"
	JE level1
	CMP al, "b"
	JE homePage
	JMP levelSelect

	level1:
	mov level, 1
	JMP playGame

	level2:
	mov level, 2
	JMP playGame

	level3:
	mov level, 3
	JMP playGame

	playGame:
	mov lives, 3
	mov score, 0
	mov score_save, 0
	CMP newGame, 0
	JNE notNewGame
	call Clrscr
	call enterName
	mov newGame, 1
	notNewGame:
	call Clrscr
	CMP level, 1
	JNE notLevel1
		call printLevel1
		JMP afterPrint
	notLevel1:
	CMP level, 2
	JNE notLevel2
		call printLevel2
		JMP afterPrint
	notLevel2:
	CMP level, 3
	JNE notLevel3
		call printLevel3
		JMP afterPrint
	notLevel3:
	afterPrint:
	call Clrscr
	mov dh,0
	mov dl,0
	call Gotoxy
	call resetBoard
	call addWalls
	call printLoading
	mov dh, 0
	mov dl, 0
	call Gotoxy
	call printBoard
	mov ghost1move, 1
	mov ghost2move, 1
	mov ghost3move, 1
	mov ghost4move, 1
	CMP level, 3
	JL noGhost5
		call printGhost5
	noGhost5:
	CMP level, 2
	JL noGhost4
		call printGhost4
	noGhost4:
	call printGhost3
	call printGhost2
	call printGhost1
	call printScore
	call printPacMan
	INVOKE PlaySound, offset startSound, NULL, 0
	;INVOKE PlaySound, offset startSound, NULL, 11h
	MainLoop:
		inc powerUpTimer
		CMP powerUpTimer, 3000
		JL endPower
			mov powerUp, 0
		endPower:
		call printFruit
		call printPower
		call printGhost1
		call printGhost2
		call printGhost3
		CMP level, 3
		JL noGhost5_2
			call printGhost5
		noGhost5_2:
		CMP level, 2
		JL noGhost4_2
			call printGhost4
		noGhost4_2:
		call printScore
		CMP pacManX, 40
		JE skipPrint
		call printPacMan
		skipPrint:
		
		call ReadKey
		mov moveVar, al
		CMP moveVar, "p"
		JNE noPause
		JMP pauseMenu
		noPause:
		CMP moveVar, "q"
		JNE noQuit
		JMP quit
		noQuit:
		call PacManMovement
		mov ecx, pacManX 
		mov eax, pacManY
		call portal
		mov pacManX, ecx
		mov pacManY, eax
		call checkFood
		call eatFruit
		call eatPower
		;Ghost 1 collision
			mov eax, ghost1X
			mov ghostCollTempX, eax
			mov eax, ghost1Y
			mov ghostCollTempY, eax
			call checkGhostCollision
			mov eax, ghostCollTempX
			mov ghost1X, eax
			mov eax, ghostCollTempY
			mov ghost1Y, eax
		;Ghost 2 collision
			mov eax, ghost2X
			mov ghostCollTempX, eax
			mov eax, ghost2Y
			mov ghostCollTempY, eax
			call checkGhostCollision
			mov eax, ghostCollTempX
			mov ghost2X, eax
			mov eax, ghostCollTempY
			mov ghost2Y, eax
		;Ghost 3 collision
			mov eax, ghost3X
			mov ghostCollTempX, eax
			mov eax, ghost3Y
			mov ghostCollTempY, eax
			call checkGhostCollision
			mov eax, ghostCollTempX
			mov ghost3X, eax
			mov eax, ghostCollTempY
			mov ghost3Y, eax
		;Ghost 4 collision
		CMP level, 2
		JL noColl_1
			mov eax, ghost4X
			mov ghostCollTempX, eax
			mov eax, ghost4Y
			mov ghostCollTempY, eax
			call checkGhostCollision
			mov eax, ghostCollTempX
			mov ghost4X, eax
			mov eax, ghostCollTempY
			mov ghost4Y, eax
		noColl_1:
		;Ghost 5 collision
		CMP level, 3
		JL noColl_2
			mov eax, ghost5X
			mov ghostCollTempX, eax
			mov eax, ghost5Y
			mov ghostCollTempY, eax
			call checkGhostCollision
			mov eax, ghostCollTempX
			mov ghost5X, eax
			mov eax, ghostCollTempY
			mov ghost5Y, eax
		noColl_2:

		;Ghost 1 move
			mov eax, ghost1move
			mov ghostMoveTemp, eax
			mov eax, ghost1X
			mov ghostMoveTempX, eax
			mov eax, ghost1Y
			mov ghostMoveTempY, eax
			mov eax, ghost1Speed
			mov ghostTempSpeed, eax
			mov eax, ghost1Direction
			mov ghostDirection, eax
			call ghostMovement
			mov eax, ghostMoveTemp
			mov ghost1move, eax
			mov eax, ghostMoveTempX
			mov ghost1X, eax
			mov eax, ghostMoveTempY
			mov ghost1Y, eax
			mov eax, ghostTempSpeed
			mov ghost1Speed, eax
			mov eax, ghostDirection
			mov ghost1Direction, eax
			mov ecx, ghost1X 
			mov eax, ghost1Y
			call portal
			mov ghost1X, ecx
			mov ghost1Y, eax
		;Ghost 2 move
			mov eax, ghost2move
			mov ghostMoveTemp, eax
			mov eax, ghost2X
			mov ghostMoveTempX, eax
			mov eax, ghost2Y
			mov ghostMoveTempY, eax
			mov eax, ghost2Speed
			mov ghostTempSpeed, eax
			mov eax, ghost2Direction
			mov ghostDirection, eax
			call ghostMovement
			mov eax, ghostMoveTemp
			mov ghost2move, eax
			mov eax, ghostMoveTempX
			mov ghost2X, eax
			mov eax, ghostMoveTempY
			mov ghost2Y, eax
			mov eax, ghostTempSpeed
			mov ghost2Speed, eax
			mov eax, ghostDirection
			mov ghost2Direction, eax
			mov ecx, ghost2X 
			mov eax, ghost2Y
			call portal
			mov ghost2X, ecx
			mov ghost2Y, eax
		;Ghost 3 move
			mov eax, ghost3move
			mov ghostMoveTemp, eax
			mov eax, ghost3X
			mov ghostMoveTempX, eax
			mov eax, ghost3Y
			mov ghostMoveTempY, eax
			mov eax, ghost3Speed
			mov ghostTempSpeed, eax
			mov eax, ghost3Direction
			mov ghostDirection, eax
			call ghostMovement
			mov eax, ghostMoveTemp
			mov ghost3move, eax
			mov eax, ghostMoveTempX
			mov ghost3X, eax
			mov eax, ghostMoveTempY
			mov ghost3Y, eax
			mov eax, ghostTempSpeed
			mov ghost3Speed, eax
			mov eax, ghostDirection
			mov ghost3Direction, eax
			mov ecx, ghost3X 
			mov eax, ghost3Y
			call portal
			mov ghost3X, ecx
			mov ghost3Y, eax
		;Ghost 4 move
			mov eax, ghost4move
			mov ghostMoveTemp, eax
			mov eax, ghost4X
			mov ghostMoveTempX, eax
			mov eax, ghost4Y
			mov ghostMoveTempY, eax
			mov eax, ghost4Speed
			mov ghostTempSpeed, eax
			mov eax, ghost4Direction
			mov ghostDirection, eax
			call ghostMovement
			mov eax, ghostMoveTemp
			mov ghost4move, eax
			mov eax, ghostMoveTempX
			mov ghost4X, eax
			mov eax, ghostMoveTempY
			mov ghost4Y, eax
			mov eax, ghostTempSpeed
			mov ghost4Speed, eax
			mov eax, ghostDirection
			mov ghost4Direction, eax
			mov ecx, ghost4X 
			mov eax, ghost4Y
			call portal
			mov ghost4X, ecx
			mov ghost4Y, eax
		;Ghost 5 move
			mov eax, ghost5move
			mov ghostMoveTemp, eax
			mov eax, ghost5X
			mov ghostMoveTempX, eax
			mov eax, ghost5Y
			mov ghostMoveTempY, eax
			mov eax, ghost5Speed
			mov ghostTempSpeed, eax
			mov eax, ghost5Direction
			mov ghostDirection, eax
			call ghostMovement
			mov eax, ghostMoveTemp
			mov ghost5move, eax
			mov eax, ghostMoveTempX
			mov ghost5X, eax
			mov eax, ghostMoveTempY
			mov ghost5Y, eax
			mov eax, ghostTempSpeed
			mov ghost5Speed, eax
			mov eax, ghostDirection
			mov ghost5Direction, eax
			mov ecx, ghost5X 
			mov eax, ghost5Y
			call portal
			mov ghost5X, ecx
			mov ghost5Y, eax

		call checkWin
		CMP gameWon, 1
		JNE continueLevel
		CMP level, 1
		JNE notLevel1_2
			inc level
			JMP level2
		notLevel1_2:
		CMP level, 2
		JNE notLevel2_2
			inc level
			JMP level3
		notLevel2_2:
		CMP level, 3
		JNE notLevel3_3
			JMP gameOver
		notLevel3_3:
		continueLevel:
		CMP lives, 0
		JG MainLoop

		gameOver:
			CMP score_save, 0
			JNE scoreSaved
				call intToString
				call saveInFile
				call printScores
				mov score_save, 1
			scoreSaved:
			call gameOverScreen
			call ReadChar
			CMP al, "r"
			JNE skip_1
			JMP playGame
			skip_1:
			CMP al, "b"
			JNE skip_2
			JMP homePage
			skip_2:
			CMP al, "q"
			JE quit
			JMP gameOver
		pauseMenu:
			call pauseScreen
			call ReadChar
			CMP al, "r"
			JNE noResume
			call clearPause
			JMP MainLoop
			noResume:
			CMP al, "b"
			JNE noMain
			JMP homePage
			noMain:
			CMP al, "R"
			JNE noRestart
			JMP playGame
			noRestart:
			CMP al, "q"
			JE quit
			JMP pauseMenu
	quit:
 mov dh, 22
 mov dl, 0 
 call Gotoxy
 exit
main ENDP
END main