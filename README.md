# Pac-Man Game in Assembly

## Overview
This project is a simple implementation of the classic **Pac-Man** game written in Assembly language using the Irvine32 library. The game features a console-based interface where players control Pac-Man to navigate a maze, eat food pellets, avoid ghosts, and collect power-ups and fruits to score points. The game supports multiple difficulty levels, a high score system, and sound effects for an enhanced experience.

## Features
- **Gameplay Mechanics**:
  - Control Pac-Man using `W`, `A`, `S`, `D` keys to move up, left, down, and right.
  - Collect food pellets to increase the score (1 point per pellet).
  - Eat fruits for bonus points (9 points).
  - Collect power-ups to temporarily make ghosts vulnerable (20 points per ghost eaten).
  - Avoid ghosts to maintain lives (3 lives at the start).
  - Portals on the maze edges allow Pac-Man and ghosts to teleport to the opposite side.
- **Difficulty Levels**:
  - **Level 1**: 3 ghosts, slower movement speed.
  - **Level 2**: 4 ghosts, moderate movement speed.
  - **Level 3**: 5 ghosts, faster movement speed.
- **Menus and Interface**:
  - Main menu with options to play, view high scores, or quit.
  - Level selection menu to choose difficulty.
  - Pause menu with options to resume, restart, return to the main menu, or quit.
  - Game over screen displaying options to restart, return to the main menu, or quit.
- **High Score System**:
  - Stores top 5 scores with usernames and levels in a `highscores.txt` file.
  - Displays high scores in the main menu.
- **Sound Effects**:
  - Game start sound (`game_start.wav`).
  - Food and power-up eating sound (`munch_1.wav`).
  - Death sound when Pac-Man collides with a ghost (`death_1.wav`).

## Prerequisites
- **MASM (Microsoft Macro Assembler)**: Required to assemble and link the code.
- **Irvine32 Library**: Provides console I/O and utility functions (included via `INCLUDE Irvine32.inc`).
- **Winmm.lib**: Required for sound playback (included via `includelib Winmm.lib`).
- **Sound Files**: Ensure `game_start.wav`, `munch_1.wav`, and `death_1.wav` are in the same directory as the executable.
- **Windows Environment**: The game is designed to run on Windows due to the use of Irvine32 and Winmm libraries.

## File Structure
- **Source.asm**: The main Assembly source code file containing the game logic.
- **highscores.txt**: Stores high scores, usernames, and levels (generated/updated during gameplay).
- **Sound Files**:
  - `game_start.wav`: Played at the start of the game.
  - `munch_1.wav`: Played when eating food, fruits, or power-ups.
  - `death_1.wav`: Played when Pac-Man loses a life.

## How to Run
1. **Set Up Environment**:
   - Install MASM and configure your development environment (e.g., Visual Studio with MASM support or a standalone assembler).
   - Ensure the Irvine32 library is properly linked.
   - Place the sound files (`game_start.wav`, `munch_1.wav`, `death_1.wav`) in the same directory as the assembled executable.
2. **Assemble and Link**:
   - Assemble the `Source.asm` file using MASM:
     ```bash
     ml /c /Zd /Zi Source.asm
     ```
   - Link the object file with Irvine32.lib and Winmm.lib:
     ```bash
     link Source.obj Irvine32.lib Winmm.lib /SUBSYSTEM:CONSOLE
     ```
3. **Run the Game**:
   - Execute the generated `.exe` file.
   - Follow the on-screen prompts:
     - Press `P` to play, `H` for high scores, or `Q` to quit from the main menu.
     - Choose a difficulty level (1, 2, or 3) or press `B` to return to the main menu.
     - Enter a username when prompted.
     - Use `W`, `A`, `S`, `D` to move Pac-Man, `P` to pause, or `Q` to quit during gameplay.

## Gameplay Instructions
- **Objective**: Eat all food pellets in the maze to progress to the next level (or win at Level 3).
- **Controls**:
  - `W`: Move up
  - `A`: Move left
  - `S`: Move down
  - `D`: Move right
  - `P`: Pause the game
  - `Q`: Quit the game
  - `R`: Restart the game (from pause or game over screen)
  - `B`: Return to the main menu (from pause or game over screen)
- **Scoring**:
  - Food pellet: 1 point
  - Fruit: 9 points
  - Ghost (with power-up): 20 points
- **Lives**: Start with 3 lives. Lose a life when colliding with a ghost (without a power-up). The game ends when lives reach 0.
- **Power-Ups**: Temporarily make ghosts vulnerable for 3000 game cycles, allowing Pac-Man to eat them for bonus points.
- **Portals**: Located at maze edges (row 10, columns 1 and 40), teleport Pac-Man and ghosts to the opposite side.

## Code Structure
- **Data Section**:
  - Defines game elements (e.g., `gameArray` for the maze, `pacManX`, `pacManY` for Pac-Man's position).
  - Stores ASCII art for menus and titles (e.g., `title1`, `inGameTitle1`, `gameOver1`).
  - Manages high scores, usernames, and sound file paths.
- **Procedures**:
  - `printHome`: Displays the main menu.
  - `addWalls` and `wallHelper`: Set up the maze walls.
  - `printBoard`: Renders the game board (walls, food, portals, empty spaces).
  - `printPacMan`, `printGhost1` to `printGhost5`: Display Pac-Man and ghosts.
  - `PacManMovement` and `ghostMovement`: Handle movement logic for Pac-Man and ghosts.
  - `checkWall`, `checkFood`, `checkGhostCollision`: Handle collisions and interactions.
  - `printFruit`, `eatFruit`, `printPower`, `eatPower`: Manage fruit and power-up mechanics.
  - `checkWin`: Checks if all food pellets are eaten to progress or win.
  - `saveInFile`, `printScores`, `mainMenuScores`: Manage high score storage and display.
  - `levelMenu`, `printLevel1` to `printLevel3`: Handle level selection and display.
  - `pauseScreen`, `gameOverScreen`: Display pause and game over screens.
  - `main`: Orchestrates the game flow (menu navigation, level selection, gameplay loop).

## Limitations
- **Console-Based**: The game uses a text-based interface, limiting graphical capabilities.
- **Sound Dependency**: Requires specific `.wav` files; missing files may cause silent gameplay.
- **Fixed Maze**: The maze layout is hardcoded in `wallHelper`.
- **Windows Only**: Relies on Irvine32 and Winmm, making it Windows-specific.
- **No Save/Load Game**: No feature to save or resume a game in progress.

## Future Improvements
- Add support for customizable maze layouts.
- Implement graphical rendering using a library like SDL.
- Add more levels or dynamic difficulty scaling.
- Include additional power-ups or game modes.
- Port to other platforms by replacing Irvine32 with cross-platform libraries.

## Author
- **Name**: Ali Usman
- **Date**: December 10, 2023

## License
This project is for educational purposes and is not licensed for commercial use. The Irvine32 library and sound files may have their own licensing terms.
