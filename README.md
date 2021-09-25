# F-F-support-features
Files and folders support features

@This is B.M.Triet's product, copyright 2021

########################################################################################################################################
#!!IMPORTANT: Make sure that you have downloaded all the files and put it into the folder: "F&FSupportFeatures" in "Windows(C:)" disk!!#
########################################################################################################################################

!!IMPORTANT: Make sure that the folder: "F&FSupportFeatures" in "Windows(C:)" disk only contains 3 files:
{
  +"FileAndFolderFeaturesSupport.exe"
  +"Homepath.txt"
  +"Previous.txt"
  +"Readme.txt"
} 
!!And DO NOT remove one of these files (except "Readme.txt")!!
      ^^^^^^
>##################################################################################################################################################################################
>#!!CAUTION: Always keep the file "FileAndFolderSupportFeatures.exe" and all files mention above in the folder "F&FSupportFeatures" in "Windows(C:)" disk (except "Readme.txt") !!#
>##################################################################################################################################################################################

>>> To allow create a new file directly on "Windows(C:)" disk, do this things below:
#WARNING: After you do all these, UAC is DISABLED !! ( This works with Windows 8 and up)
1)  Press Windows + R to open Run dialogs box.
2)  Type "regedit" and press enter or click "OK".
3)  After the Registry Editor appeared, find the folder:"HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System".
4)  After that, find the keyword "EnableLUA", then double click on it.
5)  Then goto the:"Value data:" box, edit it to 0 then exit Registry Editor and restart your computer.
6)  Good luck !!
-------------------------------------------------------------------------------
  #Note: THis product may not works well with some OS (works best with Windows (8 and up)).
  #Note: This product written in Object Pascal. 
-------------------------Implementation of all buttons-------------------------    
.Standard features: 
  +"Create new file": Create a new file with address and name in the "DEPATURE" box.
  +"Delete file": Delete a outstanding file with address and name in the "DEPATURE" box.
  +"Create new folder": Create a new folder with address and name in the "DEPATURE" box.
  +"Delete ffolder": Delete a outstanding folder with address and name in the "DEPATURE" box.
.Advance features:
  +"Rewrite file": Rewrite a outstanding file with address and name in the "DEPATURE" box.
  +"Rename file": Rename a outstanding file with address and name in the "DEPATURE" box and the new name in "DESTINATION" box.
  +"New file from": Create a new copy file with address and name in the "DEPATURE" box with another name and address in "DESTINATION" box.
  +"Relocate file": Relocate a outstanding file with address and name in the "DEPATURE" box to address in "DESTINATION" box.
  +"Relocate folder": Relocate a outstanding folder with address and name in the "DEPATURE" box to address in "DESTINATION" box.
  +"Rename folder": Rename a outstanding folder with address and name in the "DEPATURE" box and the new name in "DESTINATION" box.
  +"Copy file to file": All the contents of the file with name and address in "DESTINATION" box replace with all the contents of the file with name and address in "DEPATURE" box.
  +"Empty folder": Delete all the folders and files in side the folder with address and name in "DEPARTURE" box.
  +"Copy/Paste file": Make a copy from the file with address and name in "DEPARTURE" box to the address in the "DESTINATION" box.
.Setting:
  +"Reset": Reset to your custom path and every features to default.
  +"Notification": Turn on/off notification (the notifications show you the result of any action and report the ERROR).
  +"Auto save current path(s)": Allow to save the current path(s) in "DEPARTURE" and(or) "DESTINATION" box so when you reopen the program, the previous path(s) are(is) still there.
  +"TrimSpace": Allow to delete all superflous space of the text(s) in the in "DEPARTURE" and(or) "DESTINATION" box.
.Tools:
  +"Check file(s) existence": Check the file(s) in "DEPARTURE" box and(or) "DESTINATION" box existence.
  +"Check folder(s) existence": Check the folder(s) in "DEPARTURE" box and(or) "DESTINATION" box existence.
>>>---{ E N D }---<<<
@Hope you enjoy!<3 ~
