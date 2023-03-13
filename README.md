# Motionsmall Konglig Datasektion

Det här är en LaTeX designad för att vara så lik som möjligt Google Docs mallen för motioner av Konglig Datasektionen vid KTH.
Jag skapade denna mall då jag finner Google Docs *kefft* och vill ge övriga sektionsmedlemmar möjligheten att fortsätta
använda LaTeX för motionsskrivande samtidigt som vi har en enhetlig utseende för motionerna.

## Dependencies

Du kommer att behöva en LaTeX-kompilator för att skapa PDF-filen. I detta repo finns det dessutom
en make-fil som automatiskt borde hämta nödvändiga filer samt kompilera din LaTeX-text. Denna make-fil
behöver paketen

- wget
- make

för att användas. Lathundar för installationer på olika OS finns nedan. Make-filen har bara testats
på ett Linux-system.


### Lathundar

#### Debian/Ubuntu

```sh
apt install make wget
```

#### RHEL/Fedora

```sh
dnf install make wget
```

#### Arch

```sh
pacman -S make wget
```

#### MacOS

```sh
brew install wget make
```

#### Windows

```sh
winget install wget make
```

## Latex-paket

Mallen beror på ett gäng paket, mer exakt:

- fontaxes
- lastpage
- lato
- xcolor
- babel-swedish
- fancyhdr
- lastpage
- latex

Dessa paket måste antingen installeras av ditt operativsystems pakethanterare, eller av annan
latex-pakethanterare. I make-filen finns ett kommando för att installera dessa paket med
*tlmgr*, så om du skulle ha denna pakethanterare installerad kan du hämta alla nödvändiga paket med:

```sh
make install_texlive_depends
```

Om du har Nix finns allt som behövs i paketet `texlive.combined.scheme-full`.

## Kompilera LaTeX-filen

Att kompilera din LaTeX-fil, efter att du installerat alla dependencies borde vara så enkelt som:

```sh
make
```

## Frågor eller problem

Detta projekt är inte utförligt testat för alla plattformar, så att något inte fungerar som väntat
är nog mer förväntat än oväntat. Vid problem eller frågor kontakta mig, Erik Hedlund, erhed@kth.se,
på passande sätt eller öppna ett issue.
