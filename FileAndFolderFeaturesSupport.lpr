program FileAndFolderFeaturesSupport;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms,
  Unit1
  //,Dialogs
  { you can add units after this };

{$R *.res}
begin
//ShowMessage('This is B.M.Triet'+#39+'s product.'+#10+'Copyright 2021.'+#10+'Important: Please READ THE FILE Readme.txt in your recent folder before work with this product if you want to really understand how to use this product.'+#10+'Note: This product code by Object Pascal.');
  RequireDerivedFormResource:=True;
  Application.Title:='File And Folder Support Features';
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

