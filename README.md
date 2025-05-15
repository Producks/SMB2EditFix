# SMB2EditFix
Project commissioned by DearTruly for 25 hours.

## What is this?
This project provides a program to fix some of the issues SMB2Edit introduces and provides a complete replica of version 0.3.0 applied to the ROM in the smb2 disassembly format. It was developed for version 0.30 of SMB2edit but should also work on version 0.3.1.

## How to run/How does this work?
The executables for Linux and Windows can be found [here]() in the release section.
The program will not overwrite the ROM you are using and will create a new copy with the fixes. 
Once the program is done, it will prompt you for a new file name; it will also add the .nes extension at the end for you if you didn't include it. If the file already exists, it will warn you, and not accepting will result in the program not saving anything.

### Linux
Launching the executable from the terminal like this:  
```
    ./smb2fix (rom_name)
```  
If no arguments are provided, it will prompt you to enter the file name/path.  
The relative or absolute path to the file will also work! It will also add ".nes" for you if you just want to type the file name.

### Windows
You can drag and drop the ROM directly into the executable.  
Launching it will also prompt you for the file name.  
Or you can always launch it in the command line like this:
```
.\smb2fix.exe .\(rom_name)
```


## But what does this fix?
### 50 shades of black
Restores all 0x0D to 0x0F, like the original. The number of fixes applied will be listed under color fix.  
They will look exactly the same too!

#### Why does this matter?
The NES has multiple black colors, but not all of them should be used.  
Smb2edit changes all black colors to 0x0D. This is an issue for people playing those hacks on console; it can cause flickering and crazy visual effects. If you want to read more about it, you can find more info about it [here](https://www.nesdev.org/wiki/Color_$0D_games)

### Sprite level data is looking for his friend 0x01
Sprite data is now properly formatted by adding the missing $01, and it will get rid of unused data. The changes for the sprite data can be found under sprite level data fix, old the sprite data size, and new the new size after the fix.

Since the program rebuilds the sprite data every time, the sprite level data fix count should always be 600. However, the size between old and new should be the same if nothing has changed.

#### Why does this matter?
Sprite level data is split into pages for an area. Each page will contain the enemy data for that page; if it's empty, it will just be $01. You have to do this for the number of pages in the area ***+ 1***. Smb2edit doesn't add the +1, and it ends up resulting in a bug where sprites from the next area clip into the end of the page in the current area. Here's an example picture of the bug []()

#### How is it saving space?
There is dummy data that is never used or read between the areas. Even the vanilla game does this in some levels. This data doesn't do anything, and I just update the pointer to what is used. Don't worry, it's not deleting anything important; it's just formatting things efficiently.

### Level data gone wild with 0xFF
Fixes some of the levels that had a double terminating 0xFF early. This is listed under level data fix in the summary.  
This issue seems to be only present in the 0.3.0 version of smb2edit, but if it's there in later versions, it should catch it and fix it. With how the detection works for the double 0xFF, it will always list changes, but the result will always be the same!

#### Why does this matter?
Let's take 6-1 area 1 as an example
```
.db $89, $ea, $30, $19 ; header?
.db $f5, $0f, $09 ; area pointer
.db $f0, $4e ; change ground setting
.db $f1, $75 ; change ground setting
.db $f1, $bc ; change ground setting
.db $46, $13 ; door
.db $ff ; This ends the level stuff early, so nothing after spawn
.db $ff
; The level data under here is never read :(
.db $6d, $81, $6e, $81, $6f, $80, $9b, $81, $f2, $f5, $0f, $50, $60, $80, $61, $80
.db $a4, $00, $a9, $06, $af, $00, $b0, $07, $b2, $07, $b4, $06, $b5, $08, $b6, $08
.db $b7, $07, $ba, $07, $bb, $08, $bc, $06, $bd, $07, $be, $07, $bf, $08, $f2, $f5
.db $0f, $30, $f1, $71, $a7, $00, $b0, $07, $b1, $07, $b2, $08, $b3, $06, $b4, $07
.db $b5, $07, $b6, $08, $b7, $08, $f2, $f5, $0f, $20, $f1, $4f, $f1, $ca
.db $6b, $32
.db $7b, $32, $8b, $32, $8c, $09
.db $9b, $30, $9d, $30, $f2
.db $ff ; The real end of the area data is here!
```

SMB2Edit uses a different format than the vanilla game for level data, but the 0xFF works the same as the original. It signifies the end of reading area data for that area. For whatever reason, a double terminating sequence in the middle of the level data can create a cutoff. The fix is just to shift any double 0xFF sequences to the end so they don't cause issues anymore. Levels will now render properly!


### SEI and his nemesis the NMI
This will fix a critical bug that makes world 6 and world 7 load the level the wrong way sometimes or always. This change is listed under code injection since it requires code to be changed.

#### What is SEI, NMI and why does it matter?
This bug is more complex than the others and was a huge nightmare to figure out. The new code that SMB2edit applies is using instructions called SEI and CLI. SEI disables [hardware interrupts](https://en.wikipedia.org/wiki/Interrupt), and CLI restores them.But... SMB2 doesn't use regular interrupts, so this doesn't work as intended. So what is it trying to disable? Probably the [NMI](https://www.nesdev.org/wiki/NMI), which is something that launches and can't be stopped by SEI. This would normally be fine, but since the code we're calling uses [bank switching](https://en.wikipedia.org/wiki/Bank_switching), and the SMB2edit subroutine doesn't save the current bank in the bank variable, we end up sometimes or always (depending on timing) reading random garbage data from another bank since the NMI switched the bank while we were reading some of the level data. This goes extremely wrong and ends up just creating garbage area. This only happens in world 6 and world 7 since that level data is in a different bank from worlds 1-5.

#### What's the fix?
Since I don't have infinite time left, I just went with the [wrapper](https://en.wikipedia.org/wiki/Wrapper_function) approach. I ended up wrapping all subroutines that use SEI and CLI to avoid the issue with a wrapper that disables the NMI correctly and restores it after. This is not an efficient and elegant solution. But it gets the job done; if I had more time, I would rewrite these subroutines to just handle it correctly. This comes at the cost of using extra code space, but that code is usually not used unless you're using a patch that takes this space.

## SMB2Edit rom replica
A disassembly can be found in the folder smb2edit-replica. Compiling with the flag -dSMBEDIT will give you an exact copy of what smb2edit injects into the rom. This is extremely helpful for anyone that wants to do asm work when using smb2edit. The labels are probably wrong in some areas, and some of the comments that I used for this project are there. But this should still be helpful.

## I have an issue, how can I report it?
You can submit an issue in the GitHub section or just contact me on Discord at @Producks.

## Closing thought
I would have never touched this without money since there are better tools out there that you can use. Since SMB2Edit hasn't received any update in a while, I wouldn't use this tool; this program is just a band-aid over the problem. Maybe one day if I get the time, I'll make some of the tools I use more friendly so people can build levels and everything without any issues.

## Credit
This project wouldn't be possible without these tools or resources:
* Xkeeper0 for the smb2 disassembly
* The Mesen emulator for saving me hours when making the 0.3.0 replica.
* NESdev wiki for the resources.
