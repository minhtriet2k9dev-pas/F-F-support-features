unit Unit1;

{$mode objfpc}{$H+}

interface

uses
 Classes,
 SysUtils,
 Forms,
 Controls,
 Graphics,
 Dialogs,
 StdCtrls,
 ExtCtrls,
 Crt;

type

 { TForm1 }

 TForm1 = class(TForm)
   Button1: TButton;
   Button2: TButton;
   Button3: TButton;
   Button4: TButton;
   Button5: TButton;
   TrimBt: TButton;
   FileExBt: TButton;
   GroupBox1: TGroupBox;
   GroupBox2: TGroupBox;
   PreMod: TButton;
   NotBt: TButton;
   CopFiTFiBt: TButton;
   CusHP: TEdit;
   EmpFoldBt: TButton;
   CoPaBt: TButton;
   Label3: TLabel;
   ReLoFoldBt: TButton;
   NFbt: TButton;
   ReNameF: TButton;
   DepFN: TEdit;
   DesFN: TEdit;
   Label1: TLabel;
   Label2: TLabel;
   ReFiBt: TButton;
   ReLoFiBt: TButton;
   DelFiBt: TButton;
   AssFiBt: TButton;
   DelFoBt: TButton;
   AssFoBt: TButton;
   ReNameFold: TButton;
   StdFeatures: TGroupBox;
   AdvFeatures: TGroupBox;
   procedure AAAreLoFoldClick(Sender: TObject);
   procedure AssFiClick(Sender: TObject);
   procedure AssFoldClick(Sender: TObject);
   procedure CheckFileExist(Sender: TObject);
   procedure CheckFoldExist(Sender: TObject);
   procedure CloseClick(Sender: TObject; var CloseAction: TCloseAction);
   procedure CopasFiClick(Sender: TObject);
   procedure CopyFileToFile(Sender: TObject);
   procedure DelFiClick(Sender: TObject);
   procedure DelFoldClick(Sender: TObject);
   procedure DetailsClick(Sender: TObject);
   procedure EditChange(Sender: TObject);
   procedure EmpyfoldClick(Sender: TObject);
   procedure NeFiClick(Sender: TObject);
   procedure OffNotClick(Sender: TObject);
   procedure ReFiClick(Sender: TObject);
   procedure ReLoFiClick(Sender: TObject);
   procedure ReNaFiClick(Sender: TObject);
   procedure ReNameFoldClick(Sender: TObject);
   procedure ResetClick(Sender: TObject);
   procedure SaveClick(Sender: TObject);
   procedure SaveHPClick(Sender: TObject);
   procedure SetHP(Sender: TObject);
   procedure TrimClick(Sender: TObject);
 private

 public
//    function CopyFile(const SrcFileName, DstFileName: AnsiString): Boolean;
 end;

var
 Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }
var
 Success:Boolean;
 Off:Boolean=False;
 PreviousModeChoose:Boolean=False;
 AllowTrim:Boolean=True;
procedure ShowMessages(S:String);
begin
 if not Off then
   ShowMessage(S);
end;

function RenameDir(OldName, NewName: string): boolean;
begin
 // DirectorySeparator at the end of directories avoids some troubles
 OldName:= IncludeTrailingPathDelimiter(OldName);
 NewName:= IncludeTrailingPathDelimiter(NewName);
 // Let's go
 RenameDir := RenameFile(OldName, NewName);
end;

//Success check
function CopyFile(const SrcFileName, DstFileName: AnsiString): Boolean;
var
 Src, Dst: File;
 Buf: array of Byte;
 ReadBytes: Int64;
begin
 Assign(Src, SrcFileName);
{$PUSH}{$I-}
 Reset(Src, 1);
{$POP}
 if IOResult <> 0 then
   Exit(False);

 Assign(Dst, DstFileName);
{$PUSH}{$I-}
 Rewrite(Dst, 1);
{$POP}
 if IOResult <> 0 then begin
   Close(Src);
   Exit(False);
 end;

 SetLength(Buf, 64 * 1024 * 1024);
 while not Eof(Src) do begin
{$PUSH}{$I-}
   BlockRead(Src, Buf[0], Length(Buf), ReadBytes);
{$POP}
   if IOResult <> 0 then begin
     Close(Src);
     Close(Dst);
     Exit(False);
   end;

{$PUSH}{$I-}
   BlockWrite(Dst, Buf[0], ReadBytes);
{$POP}
   if IOResult <> 0 then begin
     Close(Src);
     Close(Dst);
     Exit(False);
   end;
 end;

 Close(Src);
 Close(Dst);
 Exit(True);
end;
// start relocate folder
procedure TForm1.AAAreLoFoldClick(Sender: TObject);
var
 x,i:Integer;
 Name1:String;
begin
 Name1:='';
 if (DepFN.Text='')or(DesFN.Text='') then
   ShowMessages('ERROR: Departure path or destination path is empty!')
 else
 begin
   for i:=length(DepFN.Text) downto 1 do
   begin
     if DepFN.Text[i]='\' then break;
   end;
   Name1:=DesFN.Text;
   for x:=i to length(DepFN.Text) do
   begin
     Name1:=Name1+DepFN.Text[x];
   end;
   if not DirectoryExists(DepFN.Text) then
     ShowMessages('ERROR: Folder: "'+DepFN.Text+'" doesn'+#39+'t exist!')
   else
   begin
     if not RenameDir(DepFN.Text,Name1) then
       ShowMessages('ERROR: Can'+#39+'t relocate folder: "'+DepFN.Text+'" to: "'+DesFN.Text+'"!')
     else
       ShowMessages('Relocate folder success!');
   end;
 end;
end;
// relocate folder end
procedure TForm1.AssFiClick(Sender: TObject);
var
 F:File;
 Name1:String;
 x,i:Integer;
begin
 Success:=False;
 if DepFN.Text <>'' then
 begin
   try
     if not FileExists(DepFN.Text) then
     begin
       for x:=length(DepFN.Text) downto 1 do
       begin
          if DepFN.Text[x]='\' then break;
       end;
       for i:=1 to x do
         Name1:=Name1+DepFN.Text[i];
       if DirectoryExists(Name1) then
       begin
         if Name1<>DepFN.Text then
         begin
           AssignFile(F,DepFN.Text);
           Rewrite(F);
           CloseFile(F);
           Success:=True;
         end else
           ShowMessages('ERROR: Invalid folder/(file) name: "'+Name1+'"!');
       end else
         ShowMessages('ERROR: Folder: "'+Name1+'" doesn'+#39+'t exist!');
     end else
       ShowMessages('ERROR: File: "'+DepFN.Text+'" is already exist!');
   except
     ShowMessages('ERROR: Can'+#39+'t create file: "'+DepFN.Text+'"!');
     Success:=False;
   end;
 end else
 begin
   ShowMessages('ERROR: Empty file name/file directory!');
 end;
 if Success then
  ShowMessages('Create file: "'+DepFN.Text+'" sucess!');
end;

procedure TForm1.AssFoldClick(Sender: TObject);
begin
 if DepFN.Text<>'' then
 begin
   if DirectoryExists(DepFN.Text) then
     ShowMessages('ERROR: Folder: "'+DepFN.Text+'" is already exist!')
   else
   begin
     if not CreateDir(DepFN.Text) then
       ShowMessages('ERROR: Can'+#39+'t assign folder: "'+DepFN.Text+'"!')
     else
       ShowMessages('Create folder: "'+DepFN.Text+'" sucess!');
   end;
 end;
 if DepFN.Text = '' then
   ShowMessages('ERROR: Empty folder name/(folder directory)!');
end;

procedure TForm1.CheckFileExist(Sender: TObject);
var
 Ms:String;
begin
 Ms:='';
 if (DepFN.Text<>'')or(DesFN.Text<>'') then
 begin
   if FileExists(DepFN.Text) then Ms:=Ms+'File: "'+DepFN.Text+'" is existing'+#10;
   if FileExists(DesFN.Text) then Ms:=Ms+'File: "'+DesFN.Text+'" is existing'+#10;
   if Ms <>'' then
     ShowMessage(Ms) else
   begin
     if (not FileExists(DepFN.Text))and(DepFN.Text<>'') then Ms:=Ms+'File: "'+DepFN.Text+'" is NOT existing'+#10;
     if (not FileExists(DesFN.Text))and(DesFN.Text<>'') then Ms:=Ms+'File: "'+DesFN.Text+'" is NOT existing'+#10;
     ShowMessage(Ms);
   end;
 end else
   ShowMessages('ERROR: Departure path or destination path is empty!');
end;

procedure TForm1.CheckFoldExist(Sender: TObject);
var
 Ms:String;
begin
 Ms:='';
 if (DepFN.Text<>'')or(DesFN.Text<>'') then
 begin
   if DirectoryExists(DepFN.Text) then Ms:=Ms+'Folder: "'+DepFN.Text+'" is existing'+#10;
   if DirectoryExists(DesFN.Text) then Ms:=Ms+'Folder: "'+DesFN.Text+'" is existing'+#10;
   if Ms <>'' then
     ShowMessage(Ms) else
   begin
     if (not DirectoryExists(DepFN.Text))and(DepFN.Text<>'') then Ms:=Ms+'Folder: "'+DepFN.Text+'" is NOT existing'+#10;
     if (not DirectoryExists(DesFN.Text))and(DesFN.Text<>'') then Ms:=Ms+'Folder: "'+DesFN.Text+'" is NOT existing'+#10;
     ShowMessage(Ms);
   end;
 end else
   ShowMessages('ERROR: Departure path or destination path is empty!');
end;

procedure TForm1.CloseClick(Sender: TObject; var CloseAction: TCloseAction);
var
 F:Text;
begin
 if PreviousModeChoose then
 begin
   AssignFile(F,'Previous.txt');
   Rewrite(F);
   Writeln(F,DesFN.Text);
   Writeln(F,DepFN.Text);
   CloseFile(F);
 end;
end;

procedure TForm1.CopasFiClick(Sender: TObject);
var
 Name1:String;
 x,i:Integer;
 ok:Boolean=True;
begin
 Name1:='';
 if (DepFN.Text='')or(DesFN.Text='') then
 begin
   ShowMessages('ERROR: Departure path or destination path is empty!');
   ok:=False;
 end
 else
 begin
   for x:=length(DepFN.Text) downto 1 do
   begin
     if DepFN.Text[x]='\' then break;
   end;
   for i:=x to length(DepFN.Text) do
     Name1:=Name1+DepFN.Text[i];
   Name1:=DesFN.Text+Name1;
 end;
 //
 if (DepFN.Text <>'')and(ok) then
 begin
   if not FileExists(DepFN.Text) then
     ShowMessages('ERROR: File: "'+DepFN.Text+'" doesn'+#39+'t exist!')
   else
   begin
     if not CopyFile(DepFN.Text,Name1) then
       ShowMessages('ERROR: Can'+#39+'t relocate file: "'+DepFN.Text+'"!')
     else
        ShowMessages('Copy/Paste file: "'+DepFN.Text+'" sucess!');
   end;
 end;
end;

procedure TForm1.CopyFileToFile(Sender: TObject);
begin
 Success:=False;
 if (DesFN.Text='')or(DepFN.Text='') then
   ShowMessages('ERROR: Departure path or destination path is empty!')
 else if not FileExists(DepFN.Text) then
   ShowMessages('ERROR: File: "'+DepFN.Text+'" doesn'+#39+'t exist!')
 else if not FileExists(DesFN.Text) then
   ShowMessages('ERROR: File: "'+DesFN.Text+'" doesn'+#39+'t exist!')
 else
   Success:=CopyFile(DepFN.Text,DesFN.Text);
 if Success then
  ShowMessages('Copy from file: "'+DepFN.Text+'" to file: "'+DesFN.Text+'" success!');
end;

procedure TForm1.DelFiClick(Sender: TObject);
begin
 Success:=False;
 if DepFN.Text <>'' then
 begin
 if not FileExists(DepFN.Text) then
   ShowMessages('ERROR: File: "'+DepFN.Text+'" doesn'+#39+'t exist!')
 else
   try
     DeleteFile(DepFN.Text);
     Success:=True;
   except
     Success:=False;
     ShowMessages('ERROR: Can'+#39+'t delete file: "'+DepFN.Text+'"!');
   end;
 end else
   ShowMessages('ERROR: Empty file name/(file directory)!');
 if Success then
  ShowMessages('Delete file: "'+DepFN.Text+'" sucess!');
end;
//
procedure DeleteDirectory(const Name: string);
var
 F: TSearchRec;
begin
 if FindFirst(Name + '\*', faAnyFile, F) = 0 then begin
   try
     repeat
       if (F.Attr and faDirectory <> 0) then begin
         if (F.Name <> '.') and (F.Name <> '..') then begin
           DeleteDirectory(Name + '\' + F.Name);
         end;
       end else begin
         DeleteFile(Name + '\' + F.Name);
       end;
     until FindNext(F) <> 0;
   finally
     FindClose(F);
   end;
   RemoveDir(Name);
 end;
end;
//
procedure TForm1.DelFoldClick(Sender: TObject);
begin
 Success:=False;
 if DepFN.Text<>'' then
 begin
   try
     if not DirectoryExists(DepFN.Text) then
       ShowMessages('ERROR: Folder: "'+DepFN.Text+'" doesn'+#39+'t exist!')
     else
     begin
       DeleteDirectory(DepFN.Text);
       RemoveDir(DepFN.Text);
       Success:=True;
     end;
   except
     ShowMessages('ERROR: Can'+#39+'t delete folder: "'+DepFN.Text+'"!')
   end;
 end;
 if DepFN.Text = '' then
   ShowMessages('ERROR: Empty folder name/(folder directory)!');
 if Success then
   ShowMessages('Delete folder: "'+DepFN.Text+'" sucess!');
end;

procedure TForm1.DetailsClick(Sender: TObject);
begin
 ShowMessage(
 'Copyright B.M.Triet 2021!' +#10+
 'This product give you some more helpful features to work with files and folders.' +#10+
 'For more information, read the file Readme.txt in the folder:"C:\F&FSupportFeatures".'+#10+
 'Hope you enjoy !!!'
 );
end;

procedure TForm1.EditChange(Sender: TObject);
begin
 if AllowTrim then
 begin
   DepFN.Text:=Trim(DepFN.Text);
   DesFN.Text:=Trim(DesFN.Text);
 end;
end;

procedure DeleteDirectorys(const Name: string);
var
 F: TSearchRec;
begin
 if FindFirst(Name + '\*', faAnyFile, F) = 0 then begin
   try
     repeat
       if (F.Attr and faDirectory <> 0) then begin
         if (F.Name <> '.') and (F.Name <> '..') then begin
           DeleteDirectory(Name + '\' + F.Name);
         end;
       end else begin
         DeleteFile(Name + '\' + F.Name);
       end;
     until FindNext(F) <> 0;
   finally
     FindClose(F);
   end;
 end;
end;

procedure TForm1.EmpyfoldClick(Sender: TObject);
begin
 Success:=False;
 if DepFN.Text<>'' then
 begin
   try
     if not DirectoryExists(DepFN.Text) then
       ShowMessages('ERROR: Folder: "'+DepFN.Text+'" doesn'+#39+'t exist!')
     else
     begin
       DeleteDirectorys(DepFN.Text);
       CreateDir(DepFN.Text);
       Success:=True;
     end;
   except
     ShowMessages('ERROR: Can'+#39+'t clear file(s) and folder(s) in folder: "'+DepFN.Text+'"!')
   end;
 end;
 if DepFN.Text = '' then
   ShowMessages('ERROR: Empty folder name/(folder directory)!');
 if Success then
   ShowMessages('Clear all file(s) and folder(s) in folder: "'+DepFN.Text+'" sucess!');
end;

procedure TForm1.NeFiClick(Sender: TObject);
begin
 if not FileExists(DepFN.Text) then
   ShowMessages('ERROR: File: "'+DepFN.Text+'" doesn'+#39+'t exist!')
 else
 begin
   Success:=CopyFile(DepFN.Text,DesFN.Text);
   if Success then
     ShowMessages('Create new file: "'+DesFN.Text+'" from file: "'+DepFN.Text+'" success!')
   else
     ShowMessages('ERROR: Can'+#39+'t Create new file: "'+DesFN.Text+'" from file: "'+DepFN.Text+'" success!')
 end;
end;

procedure TForm1.OffNotClick(Sender: TObject);
begin
 if NotBt.Caption='Notification :-ON' then
 begin
   NotBt.Caption:='Notification :-OFF';
   Off:=True;
 end else
 begin
   NotBt.Caption:='Notification :-ON';
   Off:=False;
 end
end;

procedure TForm1.ReFiClick(Sender: TObject);
var
 F:File;
begin
 Success:=False;
 if not FileExists(DepFN.Text) then
   ShowMessages('ERROR: File: "'+DepFN.Text+'" doesn'+#39+'t exist!')
 else
 begin
   try
     AssignFile(F,DepFN.Text);
     Rewrite(F);
     CloseFile(F);
     Success:=True;
   except
     Success:=False;
     ShowMessages('ERROR: Can'+#39+'t rewrite file: "'+DepFN.Text+'"!')
   end;
   if Success then
     ShowMessages('Rewrite file: "'+DepFN.Text+'" sucess!');
 end;
end;
//Relocate
procedure TForm1.ReLoFiClick(Sender: TObject);
var
 Name1:String;
 x,i:Integer;
begin
 Success:=False;
 Name1:='';
 if (DepFN.Text='')or(DesFN.Text='') then
 begin
 end
 else
 begin
   for x:=length(DepFN.Text) downto 1 do
   begin
     if DepFN.Text[x]='\' then break;
   end;
   for i:=x to length(DepFN.Text) do
     Name1:=Name1+DepFN.Text[i];
   Name1:=DesFN.Text+Name1;
 end;
 //
 if (DepFN.Text <>'') then
 begin
   if not FileExists(DepFN.Text) then
     ShowMessages('ERROR: File: "'+DepFN.Text+'" doesn'+#39+'t exist!')
   else
   begin
     if not CopyFile(DepFN.Text,Name1) then
       ShowMessages('ERROR: Can'+#39+'t relocate file: "'+DepFN.Text+'" to: "'+DesFN.Text+'"!')
     else
     try
       DeleteFile(DepFN.Text);
       Success:=True;
     except
       Success:=False;
       ShowMessages('ERROR: Can'+#39+'t delete file: "'+DepFN.Text+'"!');
     end;
   end
 end else
   ShowMessages('ERROR: Empty file name/(file directory!)');
 if Success then
  ShowMessages('Relocate file: "'+DepFN.Text+'" sucess!');
end;
// end relocate
procedure TForm1.ReNaFIClick(Sender: TObject);
var
 Name1:String;
 x,i:Integer;
begin
 Name1:='';
 if (DepFN.Text='')or(DesFN.Text='') then
   ShowMessages('ERROR: Departure path or destination path is empty!')
 else
 begin
   for x:=length(DepFN.Text) downto 1 do
   begin
     if DepFN.Text[x]='\' then break;
   end;
   for i:=1 to x do
   begin
     Name1:=Name1+DepFN.Text[i];
   end;
   Name1:=Name1+DesFN.Text;
   if not FileExists(DepFN.Text) then
     ShowMessages('ERROR: File: "'+DepFN.Text+'" doesn'+#39+'t exist!')
   else
   begin
     if not RenameFile(DepFN.Text,Name1) then
       ShowMessages('ERROR: Can'+#39+'t rename file: "'+DepFN.Text+'"!')
     else
       ShowMessages('Rename file success!');
   end;
 end;
end;

// rename folder
procedure TForm1.ReNameFoldClick(Sender: TObject);
var
 Name1:String;
 x,i:Integer;
begin
 Name1:='';
 if (DepFN.Text='')or(DesFN.Text='') then
   ShowMessages('ERROR: Departure path or destination path is empty!')
 else
 begin
   for x:=length(DepFN.Text) downto 1 do
   begin
     if DepFN.Text[x]='\' then break;
   end;
   for i:=1 to x do
   begin
     Name1:=Name1+DepFN.Text[i];
   end;
   Name1:=Name1+DesFN.Text;
   if Pos('\',DesFN.Text)<>0 then
     Name1:=DesFN.Text;
   if not DirectoryExists(DepFN.Text) then
     ShowMessages('ERROR: Folder: "'+DepFN.Text+'" doesn'+#39+'t exist!')
   else
   begin
     if not RenameDir(DepFN.Text,Name1) then
       ShowMessages('ERROR: Can'+#39+'t rename folder: "'+DepFN.Text+'"!')
     else
       ShowMessages('Rename folder success!');
   end;
 end;
end;

procedure TForm1.ResetClick(Sender: TObject);
var
 F:Text;
 HP:String;
begin
 if FileExists('C:\F&FSupportFeatures\HomePath.txt') then
 begin
   AssignFile(F,'C:\F&FSupportFeatures\HomePath.txt');
   Reset(F);
   Readln(F,HP);
   DepFN.Text:=HP;
   CusHP.Text:=HP;
   CloseFile(F);
 end else
 begin
   ShowMessage('ERROR: can not find folder "C:\F&FSupportFeatures\"');
   Halt;
 end;
 AllowTrim:=True;
 TrimBt.Caption:='TrimSpace :-ON';
 DepFN.Text:=Trim(DepFN.Text);
 DesFN.Text:=Trim(DesFN.Text);
 NotBt.Caption:='Notification :-ON';
 Off:=False;
 PreMod.Caption:='Autosave curent path(s) :-OFF';
 PreviousModeChoose:=False;
 try
   AssignFile(F,'C:\F&FSupportFeatures\Previous.txt');
   Rewrite(F);
   CloseFile(F);
 except
    ShowMessage('ERROR: can not find folder "C:\F&FSupportFeatures\"');
    Halt;
 end;
end;

procedure TForm1.SaveClick(Sender: TObject);
var
 F:text;
begin
 if PreMod.Caption='Autosave curent path(s) :-ON' then
 begin
   PreMod.Caption:='Autosave curent path(s) :-OFF';
   PreviousModeChoose:=False;
   try
     AssignFile(F,'C:\F&FSupportFeatures\Previous.txt');
     Rewrite(F);
     CloseFile(F);
   except
      ShowMessage('ERROR: can not find folder "C:\F&FSupportFeatures\"');
      Halt;
   end;
 end else
 begin
   PreMod.Caption:='Autosave curent path(s) :-ON';
   PreviousModeChoose:=True;
 end;
end;

//rename end
procedure TForm1.SaveHPClick(Sender: TObject);
var
 F:Text;
 HP:String;
begin
 try
   AssignFile(F,'C:\F&FSupportFeatures\HomePath.txt');
   Rewrite(F);
   Writeln(F,CusHP.Text);
   CloseFile(F);
   DepFN.Text:=CusHP.Text;
 except
    ShowMessage('ERROR: can not find folder "C:\F&FSupportFeatures\"');
    Halt;
 end;
end;

procedure TForm1.SetHP(Sender: TObject);
var
 F:Text;
 HP:String;
begin
 if FileExists('C:\F&FSupportFeatures\HomePath.txt') then
 begin
   AssignFile(F,'HomePath.txt');
   Reset(F);
   Readln(F,HP);
   DepFN.Text:=HP;
   CusHP.Text:=HP;
   CloseFile(F);
 end else
 begin
   try
   AssignFile(F,'HomePath.txt');
   Rewrite(F);
   Writeln(F,'C:\');
   DepFN.Text:='C:\';
   CusHP.Text:='C:\';
   CloseFile(F);
   except
      ShowMessage('ERROR: can not find folder "C:\F&FSupportFeatures\"');
      Halt;
   end;
 end;
 if FileExists('C:\F&FSupportFeatures\Previous.txt') then
 begin
   AssignFile(F,'C:\F&FSupportFeatures\Previous.txt');
   Reset(F);
   Readln(F,HP);
   if HP<>'' then
     DesFN.Caption:=HP;
   Readln(F,HP);
   if HP<>'' then
     DepFN.Caption:=HP;
   CloseFile(F);
 end else
 begin
   try
     AssignFile(F,'Previous.txt');
     Rewrite(F);
     CloseFile(F);
   except
      ShowMessage('ERROR: can not find folder "C:\F&FSupportFeatures\"');
      Halt;
   end;
 end;

end;

procedure TForm1.TrimClick(Sender: TObject);
begin
 if TrimBt.Caption='TrimSpace :-ON' then
 begin
   AllowTrim:=False;
   TrimBt.Caption:='TrimSpace :-OFF';
 end else
 begin
   AllowTrim:=True;
   TrimBt.Caption:='TrimSpace :-ON';
 end;
 if AllowTrim then
 begin
   DepFN.Text:=Trim(DepFN.Text);
   DesFN.Text:=Trim(DesFN.Text);
 end;
end;

end.
