# PicoCalcSoftware
Software for the PicoCalc running the PicoMite Basic OS

## Utils ##

Utils.bas contains some helper function to deal with string manipulating. Specially, the ability to use Trim$(<input>), 
which removes spaces from the start and end of the input string.

## Help2

Help2 is a replacement for the "help" command in picomite, it has the ability to search the full_text help file

![unnamed](https://github.com/user-attachments/assets/789fbb16-655c-4bbc-8545-6bdd854179e8)


Requirements:
- SD Card

## Recommened installation. 

Copy 

utils.bas
help2.bas
preplib.bas
helpind.dat
full_help.txt

 to the root of the SD Card. Load and run prelib.bas. This will copy both utils.bas and help2.base into
another file called "libsrc.bas". 

Load "libsrc.bas" and execute "Library save". This will save utils.bas and help2.bas into the library

Now, the "help2" command will always be availible.

## Usage

Help2 "<search text>"
or
Help2 "<search text>*"

Help2 can do an exact search, where the help entry has to be equal to the search text, or a wildcard search.
The wildcard search is used by adding a '*' the end of the search text.

## How it works

The full_help.txt file is examined for the help entries, and the location of those entries are 
stored in the helpind.dat file.

When a search is execute, the helpind.dat file is seached for matching entries (up to 20 matched),
and the the offset is used to read the full_help.txt.

Output is word wrapped when it is displayed to the screen.
