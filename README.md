# SMB2EditFix
Project commissioned by DearTruly for 25 hours + 5.  
The executables for Linux and Windows can be found [here](https://github.com/Producks/SMB2EditFix/releases) in the release section.  

## What is this?
This project provides a program to fix some of the issues SMB2Edit introduces and provides a complete replica of version 0.3.0 applied to the ROM in the smb2 disassembly format. It was developed for version 0.3.0 of SMB2edit but should also work on version 0.3.1.

## What's included
By default, all SMB2Editfix patches are enabled in the configuration file, while all miscellaneous patches are disabled. For more details, refer to the configuration file section.
### SMB2Editfix patches:
* Resolves a critical bug preventing proper level loading in World 6-7.
* Fixes incorrectly built levels in World 6 that led to early cutoffs.
* Addresses a bug where sprites from the next area would load on the last screen.
* Corrects an issue where the last color of the sprite palette always loaded incorrectly.
* Resolves incorrect screen display when exiting a jar or subspace.
* Changes all black colors from ```0x0D``` back to their correct ```0x0F``` value

For more info about the SMB2EditFix patches, you can refer to the explanation section on why and what these patches do.
### Miscellaneous patches:
* Quick respawn
* CHR cycle fix
* Player no longer drops an item when doing a super jump
* Single color bomb flash
* Character select after death
* Disable bonus chance
* Disable falling sound in 1-1
* Auto bomb memory corruption fix

## How does this work?
You provide a ROM file of SMB2 that has been saved using SMB2Edit. This program will then:  
1. Create a copy of your original ROM file.
2. Apply fixes enable in the config file to the copy.
3. Prompt you to enter a new name to save the modified ROM.  

### Important Notes:
* It will create a copy of that rom, add the fixes and ask you for a new name to save the new rom. So the old file remain intact!  
* When saving, the `.nes` extension will be automatically added if you don't include it.
* If a file with the same name already exists, you will be asked if you want to overwrite it.
* Run this program every time you make changes using SMB2Edit.  
* ⚠️ Using SMB2Edit after this program has applied the fixes is undefined behavior. ⚠️  

If it still works with SMB2Edit then good, if not I can't do much about it. So always keep a rom of your project without the fixes applied to it.   


## How to run?
### Linux
Launching the executable from the terminal like this:  
```
    ./smb2fix (rom_name)
```  
### Windows
You can drag and drop the ROM directly into the executable.  
Launching the executable directly will prompt you for the file name.  
Or you can always launch it in the command line like this:
```
.\smb2fix.exe .\(rom_name)
```

## Config file
The config file, named ```config.txt```, is in the same place as the program. It lets you control what gets patched and how the program will behave to make it faster to work with. All you need to do is put a 1 when you want something to be patched in, or a 0 when you don't want that patch. That's it! The program options don't affect the rom and will just make it faster to work with. There are comments for every option, so just opening the file and reading should do the trick.

## I have an issue, how can I report it?
If you get an error when patching telling you that space is taken, you're more than likely using a patch that takes the space required for the patch to work. There's no easy solution to this problem, and you'll have to decide if you prefer having the fix or the patch. If you get that warning without any patches, make sure to report an issue, and I'll fix it. Also, if any new bugs are introduced after a fix, please let me know, and they will be addressed!

You can submit an issue in the GitHub section or just contact me directly on Discord at @Producks.

## SMB2Edit rom replica
A disassembly can be found in the folder smb2edit-replica. Compiling with the flag -dSMBEDIT will give you an exact copy of what SMB2edit injects into the rom. This is extremely helpful for anyone that wants to do asm work when using SMB2edit. Some of the comments that I used for this project are there. But this should still extremely helpful for anyone doing asm stuff.

## Technical explanation of the SMB2Editfix patches
### 50 shades of black
Restores all 0x0D to 0x0F, like the original. They will look exactly the same too!

#### Why does this matter?
The NES has multiple black colors, but not all of them should be used.  
SMB2edit changes all black colors to 0x0D. This is an issue for people playing those hacks on console; it can cause flickering and crazy visual effects. If you want to read more about it, you can find more info about it [here](https://www.nesdev.org/wiki/Color_$0D_games)

### Sprite level data is looking for his friend 0x01
Sprite data is now properly formatted by adding the missing $01.

### Why does this matter?
Sprite level data is split into pages for an area. Each page will contain the enemy data for that page; if it's empty, it will just be $01. You have to do this for the number of pages in the area +1. SMB2edit doesn't add the +1, and it ends up resulting in a bug where sprites from the next area clip into the end of the page in the current area.

![](https://i.imgur.com/uUSZNPD.png)  
Here, the bug is in action: in 6-2, birds from the next area clip into this area. This area has no enemies normally.

### Level data gone wild with 0xFF
Fixes some of the levels that had a double terminating `0xFF` early.
This issue seems to be only present in the 0.3.0 version of SMB2edit, but if it's there in later versions, it should catch it and fix it. With how the detection works for the double `0xFF`, it will always list changes, but the result will always be the same!

#### Why does this matter?
Let's take 6-1 area 1 as an example:   
![](https://i.imgur.com/buHO8JJ.png)  

```
.db $89, $ea, $30, $19 ; Level header
.db $f5, $0f, $09 ; Area pointer
.db $f0, $4e ; change ground setting
.db $f1, $75 ; change ground setting
.db $f1, $bc ; change ground setting
.db $46, $13 ; Door
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

SMB2Edit uses a different format than the vanilla game for level data, but the `0xFF` works the same as the original. It signifies the end of reading area data for that area. For whatever reason, a double terminating `0xFF` is present in the middle of some level data. Which ends up creating rooms that render with missing data in them. The fix is just to shift any double `0xFF` sequences to the end so they don't cause issues anymore. Levels will now render properly!

![](https://i.imgur.com/IyfNOWR.png)  
The level now load properly with just that simple fix!

### SEI and his nemesis the NMI
The program will fix a critical bug that makes world 6 and world 7 load the level the wrong way depending on timing.

#### What is SEI, NMI and why does it matter?
This bug is more complex than the others and was a huge nightmare to figure out. The new code that SMB2edit applies is using instructions called `SEI` and `CLI`. `SEI` disables [hardware interrupts](https://en.wikipedia.org/wiki/Interrupt), and `CLI` restores them.But... SMB2 doesn't use regular interrupts, so this doesn't work as intended. So what is it trying to disable? Probably the [NMI](https://www.nesdev.org/wiki/NMI), which is something that launches and can't be stopped by `SEI`. This would normally be fine, but since the code we're calling uses [bank switching](https://en.wikipedia.org/wiki/Bank_switching), and the SMB2edit subroutine doesn't save the current bank in the bank variable, we end up sometimes or always (depending on timing) reading random garbage data from another bank since the NMI switched the bank while we were reading some of the level data. This goes extremely wrong and ends up just creating garbage area. This only happens in world 6 and world 7 since that level data is in a different bank from worlds 1-5.

#### What's the fix?
Since I don't have infinite time left, I just went with the [wrapper](https://en.wikipedia.org/wiki/Wrapper_function) approach. I ended up wrapping all subroutines that use `SEI` and `CLI` to avoid the issue with a wrapper that disables the NMI correctly and restores it after. This is not an efficient and elegant solution. But it gets the job done; if I had more time, I would rewrite these subroutines to just handle it correctly. This comes at the cost of using extra code space, but that code space is not used unless you're using a patch that takes this space.

#### Example
![](https://i.imgur.com/anxE1XB.png) ![](https://i.imgur.com/98P4eoK.png)  
On the left, you can see the level didn't load properly due to bad timing on the bank switch. The picture on the right shows the level now loading properly no matter the timing. No more weird, random loading with this patch!

### The Classic Programmer Mistake: Missing 1 Loop Iteration
Fixes a loop issue that caused the last sprite color palette to load incorrectly.

### Why does it matter?
The last color would always load really far away from what we intended. This goes unnoticed in a lot of levels since people often use the same color palettes for that section. But the bug happens in every section in the game, resulting in colors not matching what the user selected.

### What's the fix?
One of the loop condition was wrong causing an underflow for the index. All that had to be done is just increasing the ```CPY #$0B``` to ```#$0C```  


### MMC3 Inversion? What's that? (CHR A12 inversion)
Adds the CHR A12 inversion flag when bank switching.

### Why does this matter?
SMB2 uses a flag for the [MMC3](https://www.nesdev.org/wiki/MMC3) mapper to invert the graphics slots. This flag needs to be applied at all times, or you'll encounter graphical glitches. SMB2edit's subroutines forgot to set this flag, so the glitch occurs whenever those routines are called. You don't visually see the glitch because rendering is turned off when they are called, except when you are in a subspace area or a jar area.

### Example 
![](https://i.imgur.com/RxzL04k.png) ![](https://i.imgur.com/obXERAk.png)  
Both these areas experience crazy rendering glitches when exiting them if the flag isn't set. No more glitchy area flickering when leaving an area now!

## Closing thought
I would have never touched this without money involve since there are better tools out there that you can use. Since SMB2Edit hasn't received any update in a while, I wouldn't use this tool; this program is just a band-aid over the problem. Maybe one day if I get the time, I'll make some of the tools I use more friendly so people can build levels and everything without any issues.

## Credits
This project wouldn't be possible without these tools or resources:
* Xkeeper0 for the smb2 disassembly
* The Mesen emulator for saving me hours when making the 0.3.0 replica.
* NESdev wiki for the resources.
