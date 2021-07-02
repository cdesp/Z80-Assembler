{
Grundy NewBrain Emulator Pro Made by Despsoft

Copyright (c) 2004, Despoinidis Chris
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice,
this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation and/or
other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors
may be used to endorse or promote products derived from this software without
specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON A
NY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
}
unit frmDisassembly;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, ExtDlgs, Buttons, Tabs, DockTabSet,
  OoMisc, AdPort, ADTrmEmu, Vcl.Menus, Vcl.FileCtrl;

Const
  cLnSpace=0;
  unitname='ASSEMBLER';
  Version='1.09';

type

  TInstr=Record
     Addr:Integer;
     Nob:SmallInt; //no of bytes 1,2,3
     Bytes:Array[1..4] of byte;
     Instr:String[16];
     Comments:String[128];
     CommentsPre:String[9];
  end;
  PInstr=^TInstr;

  TInstrList=Class(TList)
  private
     Procedure New;
  protected
     function GetInstr(Index: Integer): pInstr;
     procedure PutInstr(Index: Integer; Item: PInstr);
  public
     procedure Clear; override;
     Function GetInstrIdxFromAddr(Addr:Integer):Integer;
     property Instr[Index: Integer]: pInstr read GetInstr write PutInstr; default;

  end;


  Tfrmdis = class(TForm)
    PageControl1: TPageControl;
    TSAsm: TTabSheet;
    Panel4: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    OpenTextFileDialog1: TOpenTextFileDialog;
    SaveTextFileDialog1: TSaveTextFileDialog;
    SpeedButton3: TSpeedButton;
    PageControl2: TPageControl;
    TSSource: TTabSheet;
    asmText: TMemo;
    TSBinary: TTabSheet;
    BinText: TMemo;
    TSSymbols: TTabSheet;
    memLabels: TMemo;
    TSMessages: TTabSheet;
    memMessages: TMemo;
    StatusBar1: TStatusBar;
    Label6: TLabel;
    lblCombo: TComboBox;
    lblEdit: TEdit;
    SpeedButton4: TSpeedButton;
    SpeedButton6: TSpeedButton;
    TSErrors: TTabSheet;
    memErrors: TMemo;
    SaveBinFileDialog: TSaveTextFileDialog;
    Bevel1: TBevel;
    Bevel2: TBevel;
    TSGlob: TTabSheet;
    GlobLabels: TMemo;
    TSProj: TTabSheet;
    ProjText: TMemo;
    Bevel3: TBevel;
    SpeedButton10: TSpeedButton;
    TSZ80: TTabSheet;
    AdTerminal1: TAdTerminal;
    ApdComPort1: TApdComPort;
    Button1: TButton;
    ProgressBar1: TProgressBar;
    Edit1: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    Button2: TButton;
    Edit2: TEdit;
    Button3: TButton;
    cominfolabel: TLabel;
    TrackBar1: TTrackBar;
    Button5: TButton;
    OpenTextFileDialog2: TOpenTextFileDialog;
    Label10: TLabel;
    Label11: TLabel;
    Button6: TButton;
    ListBox1: TListBox;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Shape1: TShape;
    Shape2: TShape;
    Timer1: TTimer;
    Button11: TButton;
    Button12: TButton;
    Button14: TButton;
    CheckBox1: TCheckBox;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    File2: TMenuItem;
    ools1: TMenuItem;
    CharDesigner1: TMenuItem;
    OpenProjectFile1: TMenuItem;
    OpenProjectFile2: TMenuItem;
    Save1: TMenuItem;
    SaveSourceFile1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    Label1: TLabel;
    CheckBox3: TCheckBox;
    Label4: TLabel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Edit6: TEdit;
    Edit7: TEdit;
    Button13: TButton;
    FileListBox1: TFileListBox;
    Button15: TButton;
    CheckBox4: TCheckBox;
    SpeedButton5: TSpeedButton;
    GroupBox2: TGroupBox;
    Label12: TLabel;
    Edit5: TEdit;
    Button4: TButton;
    CheckBox2: TCheckBox;
    Button10: TButton;
    Button16: TButton;
    ComboBox1: TComboBox;
    Button17: TButton;
    procedure asmTextKeyPress(Sender: TObject; var Key: Char);
    procedure asmTextMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure BinTextKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta:
        Integer; MousePos: TPoint; var Handled: Boolean);
    procedure lblComboChange(Sender: TObject);
    procedure PageControl2Change(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure StatusBar1DblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure ApdComPort1TriggerAvail(CP: TObject; Count: Word);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure ApdComPort1TriggerModemStatus(Sender: TObject);
    procedure ApdComPort1TriggerStatus(CP: TObject; TriggerHandle: Word);
    procedure ApdComPort1TriggerTimer(CP: TObject; TriggerHandle: Word);
    procedure ApdComPort1PortOpen(Sender: TObject);
    procedure ApdComPort1PortClose(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure AdTerminal1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure File2Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure OpenProjectFile1Click(Sender: TObject);
    procedure OpenProjectFile2Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure SaveSourceFile1Click(Sender: TObject);
    procedure CharDesigner1Click(Sender: TObject);
    procedure AdTerminal1KeyPress(Sender: TObject; var Key: Char);
    procedure Button15Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button17Click(Sender: TObject);
  private
    msgref:integer;
    cx,cy:Integer;
    ActMem:TMemo;
    ChrX: Integer;
    ChrY: Integer;
    CommentsChanged: Boolean;
    CurFile: string;
    DatAddr: Integer;
    DataLineBytes: Integer;
    DataTopMargin: Integer;
    DataVisLines: Integer;
    DataWidthBytes: Integer;
    DatLen: Integer;
    DatPage: Integer;
    DatWid: Integer;
    Errors: Integer;
    fisNewfile: Boolean;
    { Private declarations }
    PageNo: Integer;
    nLen:Integer;
    TotalInstr:Integer;
    SelectedLine:Integer;
    SelPage: Integer;
    procedure DoAftCompile(Sender: TObject; Fname: String);
    procedure DoBefCompile(Sender: TObject; Fname: String);
    procedure ShowCompErrors;
    procedure DoCompMes(Sender: TObject; msg: String);
    procedure ShowCompiledCode;
    procedure DoData(Pg, Addr, Leng:Integer);
    function GetDefaultName: String;
    function GetCompleteInstruction(no: Integer): String;
    procedure LoadComments(CmnF: TFileName = ''; DestSl: TStringList=Nil);
    function LS: Integer;
    function PVisibleLines: Integer;
    function SendChar(c: AnsiChar):boolean;
    procedure checkModemStatus;
    function DsrReady: boolean;
    procedure SetSrcCurrentLine;
    procedure savepath;
    procedure Loadpath;
    procedure setcominfolabel;
    procedure setz80baudrate;
  public
    function IsProject: Boolean;
    { Public declarations }
  end;

  TBreakPointList=Class(TstringList);

Procedure   ShowDisassembler;

var
  frmdis: Tfrmdis;
  Instructions:TInstrList;
  BreakPList:TBreakPointList;
  WorkingDir:String='';

implementation
uses ustrings,uDisAsm,math,Printers,uAsm,uNBTypes, uAsmPrj, frmAbout,
  frmChrDsgn,inifiles;

{$R *.dfm}

Procedure   ShowDisassembler;
Begin
  frmdis:= Tfrmdis.create(nil);
  frmdis.Show;
end;


procedure Tfrmdis.SetSrcCurrentLine;
Begin
//todo:Find the current line other way caretpos is a byte
  StatusBar1.Panels[1].Text:=Format('%5d / %5d',[ActMem.CaretPos.Y+1,ActMem.Lines.Count+1]);
end;


procedure Tfrmdis.AdTerminal1DblClick(Sender: TObject);
begin
 adTerminal1.Clearall;
end;

procedure Tfrmdis.AdTerminal1KeyPress(Sender: TObject; var Key: Char);
begin
 if key=#8 then   //backspace
  key:=#6;
 if checkbox4.Checked then
 Begin
  if key=#13 then
  begin
    AdTerminal1.WriteChar(Ansichar(#10));
    AdTerminal1.WriteChar(Ansichar(#13));
  end
  else
  if key=#6 then
    AdTerminal1.WriteChar(Ansichar(#8))
  else
  Begin
    AdTerminal1.WriteChar(Ansichar(key));
  End;
 End;

end;

procedure Tfrmdis.ApdComPort1PortClose(Sender: TObject);
begin
 checkModemStatus;
end;

procedure Tfrmdis.checkModemStatus;
begin
if ApdComPort1.DTR then
  SHAPE1.Brush.Color:=clGreen
 else
  SHAPE1.Brush.Color:=clRed;
 if ApdComPort1.DSR then
  SHAPE2.Brush.Color:=clGreen
 else
  SHAPE2.Brush.Color:=clRed;
End;

procedure Tfrmdis.ComboBox1Change(Sender: TObject);
begin
  if ApdComPort1.baud<>strtoint(ComboBox1.Text) then
  Begin
    ApdComPort1.open:=false;
    ApdComPort1.baud:=strtoint(ComboBox1.Text);
    ApdComPort1.open:=true;
  End;
  setcominfolabel;
end;

procedure Tfrmdis.ApdComPort1PortOpen(Sender: TObject);
begin
 checkModemStatus

end;

procedure Tfrmdis.ApdComPort1TriggerAvail(CP: TObject; Count: Word);
VAR C:ansiCHAR;
    k:integer;
begin
  if button11.Tag=1 then exit;
  if count=0 then exit;
  try
   c:= ApdComPort1.PeekChar(1);
   k:=ord(c);
   listbox1.Items.Add(inttostr(k))
  except

  end;
end;

procedure Tfrmdis.ApdComPort1TriggerModemStatus(Sender: TObject);
begin
  checkModemStatus
end;

procedure Tfrmdis.ApdComPort1TriggerStatus(CP: TObject; TriggerHandle: Word);
begin
  checkModemStatus
end;

procedure Tfrmdis.ApdComPort1TriggerTimer(CP: TObject; TriggerHandle: Word);
begin
  checkModemStatus
end;

procedure Tfrmdis.asmTextKeyPress(Sender: TObject; var Key: Char);
begin
  SetSrcCurrentLine;
end;

procedure Tfrmdis.asmTextMouseMove(Sender: TObject; Shift: TShiftState; X, Y:
    Integer);
begin
  SetSrcCurrentLine;
end;


function Tfrmdis.GetCompleteInstruction(no:Integer):String;
Var i:Integer;
Begin
  //Addr
  Result:=InttoHex(Instructions[no].Addr,4)+' ';
  //Bytes
  for i := 1 to Instructions[no].Nob  do
    Result:=Result+inttohex(Instructions[no].Bytes[i],2)+' ';
  for i := Instructions[no].Nob to 5 do
    Result:=Result+'   ';
  //Characters
  for i := 1 to Instructions[no].Nob  do
    if Instructions[no].Bytes[i]>31 then
      Result:=Result+chr(Instructions[no].Bytes[i])
    Else
      Result:=Result+'.';
  for i := Instructions[no].Nob to 5 do
    Result:=Result+' ';
  // Labels
  Result:=Result+Instructions[no].CommentsPre;
  for i := Length(Instructions[no].CommentsPre) to 9 do
   Result:=Result+' ';
  //Instruction
  Result:=Result+' ';
  Result:=Result+Instructions[no].Instr;
  for i := Length(Instructions[no].Instr) to 20 do
    Result:=Result+' ';
  //Comments
  Result:=Result+'; ';
  Result:=Result+Instructions[no].Comments;
end;

procedure Tfrmdis.Edit1Change(Sender: TObject);
begin
 edit1.Hint:=inttohex(strtoint(edit1.Text),4)+'h';
end;

procedure Tfrmdis.Edit2Change(Sender: TObject);
begin
  edit2.Hint:=inttohex(strtoint(edit2.Text),4)+'h';
end;

procedure Tfrmdis.Edit6Change(Sender: TObject);
begin
  edit6.Hint:=inttohex(strtoint(edit6.Text),4)+'h';
end;

procedure Tfrmdis.Edit7Change(Sender: TObject);
begin
  edit7.Hint:=inttohex(strtoint(edit7.Text),4)+'h';
end;


procedure Tfrmdis.File2Click(Sender: TObject);
begin
   fAbout:=TfAbout.Create(self);
   fabout.ShowModal;
end;

procedure Tfrmdis.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ApdComPort1.Open:=false;
end;

procedure Tfrmdis.FormCreate(Sender: TObject);
Var i:integer;
begin
 AdTerminal1.ScrollbackRows:=2000;
  label9.Font.Color:=clBlue;
  PageNo:=-1;
  nLen := 0;
  DatPage:=-2;
  ActMem:=asmText;
  DoubleBuffered:=true;
  PageControl1.DoubleBuffered:=true;
  PageControl2.DoubleBuffered:=true;
  PageControl1.ActivePage:=TSAsm;
  PageControl2.ActivePage:=TSZ80;
  PageControl2Change(nil);
   try
    ApdComPort1.Open:=true;
   except
      //may be same port opened by the emulator
   end;
  

end;

procedure Tfrmdis.FormMouseWheel(Sender: TObject; Shift: TShiftState;
    WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
Var mp:TPoint;
begin
 mp:=screentoclient(MousePos);
end;

procedure Tfrmdis.FormShow(Sender: TObject);
begin
   caption:=caption+' - Ver. '+version;
 edit1.Text:='32768';
   edit2.Text:='255';
   edit6.Text:='0';
   edit7.Text:='255';
   loadpath;
end;

Function Tfrmdis.GetDefaultName:String;
Begin
   Result:='';
   if SelPage<>-1 then
     Result:=Result+'PG_'+inttostr(SelPage)+'.dbg'
   Else
    Result:=Result+'NoPaging.dbg';
end;

procedure Tfrmdis.ListBox1DblClick(Sender: TObject);
begin
 listbox1.Clear;
end;

procedure Tfrmdis.LoadComments(CmnF: TFileName = ''; DestSl: TStringList=Nil);
Begin
end;


procedure Tfrmdis.CharDesigner1Click(Sender: TObject);
begin
 fchrdsgn:=Tfchrdsgn.Create(self);
 fchrdsgn.ShowModal;
end;


procedure Tfrmdis.CheckBox4Click(Sender: TObject);
begin
    adTerminal1.SetFocus;
end;

procedure Tfrmdis.Save1Click(Sender: TObject);
begin
   PageControl2.ActivePage:=TSProj;
   Speedbutton2.Click;

end;


procedure Tfrmdis.SaveSourceFile1Click(Sender: TObject);
begin
   PageControl2.ActivePage:=TSSource;
   Speedbutton1.Click;
end;


//Create Patch File to be used with the rom burner
procedure Tfrmdis.SpeedButton10Click(Sender: TObject);
Var sts,ses:String;
    st,se:Integer;
    sf:TFileStream;
    b,i:Integer;
    F:TextFile;

    j:Integer;
    p:PCmpInst;
    addr:Integer;
    RomWriteable:Boolean;
    TotBytes:Integer;
    FileByte:Integer;
    sl:tstringlist;
begin
 if not Assigned(Compiler) then Exit;
 //Put Compiled Object in a Patch File
 if Compiler.ERRORSFOUND then
 Begin
   ShowMessage('Errors were found!!');
   Exit;
 end;

 try
  sl:=tstringlist.create;
 TotBytes:=0;
 FileByte:=0;
 for i := 0 to Compiler.Count-1 do
 Begin
   p:=Compiler.Items[i];
   addr:=p.Addr;
   for j:=1 to p.ByteCnt do
   Begin
      b:=p.bytes[j];
      sl.values[tohex(addr+j-1,4)]:=tohex(b,2);
      inc(TotBytes);  //Only compiled data
   end;
  end;
   sl.SaveToFile('PATCH.txt');
 finally
   sl.Free;
 end;
 Showmessage('PATCH FILE CREATED!!!');
end;


//Load Assembly File
procedure Tfrmdis.SpeedButton1Click(Sender: TObject);
var f1,f2:string;
begin
 if pagecontrol2.ActivePageIndex<>0 then
 Begin
  OpenTextFileDialog1.Title:='Open Assembly Source';
  OpenTextFileDialog1.InitialDir:=AppPath+DefaultAsmDir;
  if OpenTextFileDialog1.Execute then
  Begin
   asmText.Lines.LoadFromFile(OpenTextFileDialog1.FileName);
   WorkingDir:=extractfilepath(OpenTextFileDialog1.FileName);
   ProjText.Lines.clear;
   SaveTextFileDialog1.FileName:=OpenTextFileDialog1.FileName;
   SaveBinFileDialog.FileName:=changefileext(OpenTextFileDialog1.FileName,'.bin');
  end;
  PageControl2.ActivePage:= TSSource
 end
 else
 Begin //load project
  OpenTextFileDialog1.Title:='Open Assembly Project File';
  f1:=OpenTextFileDialog1.filter;
  f2:=OpenTextFileDialog1.title;
  OpenTextFileDialog1.filter:='*.PRJ|*.prj';
  OpenTextFileDialog1.InitialDir:=AppPath+DefaultAsmDir;
  if OpenTextFileDialog1.Execute then
   ProjText.Lines.LoadFromFile(OpenTextFileDialog1.FileName);
  OpenTextFileDialog1.filter:=f1;
  OpenTextFileDialog1.title:=f2;

 end;
 statusbar1.panels[2].text:=SaveTextFileDialog1.FileName;
end;

//Save Assembly File
procedure Tfrmdis.SpeedButton2Click(Sender: TObject);
var f1,f2:string;
begin
 if pagecontrol2.ActivePageIndex<>0 then
 Begin
  SaveTextFileDialog1.Title:='Save Assembly Source File';
  SaveTextFileDialog1.InitialDir:=AppPath+DefaultAsmDir;
  if (SaveTextFileDialog1.FileName<>'') or SaveTextFileDialog1.Execute then
  Begin
   if extractfileext(SaveTextFileDialog1.FileName)='' then
     SaveTextFileDialog1.FileName:=changefileext(SaveTextFileDialog1.FileName,'.s');
   asmText.Lines.SaveToFile(SaveTextFileDialog1.FileName);
  End;
 end
 else
 Begin //save project
  SaveTextFileDialog1.Title:='Save Assembly Project File';
  f1:=SaveTextFileDialog1.filter;
  f2:=SaveTextFileDialog1.title;
  SaveTextFileDialog1.filter:='*.PRJ|*.prj';
  SaveTextFileDialog1.InitialDir:=AppPath+DefaultAsmDir;
  if SaveTextFileDialog1.Execute then
  Begin
   if extractfileext(SaveTextFileDialog1.FileName)='' then
     SaveTextFileDialog1.FileName:=changefileext(SaveTextFileDialog1.FileName,'.prj');
   ProjText.Lines.SaveToFile(SaveTextFileDialog1.FileName);
  End;
  SaveTextFileDialog1.filter:=f1;
  SaveTextFileDialog1.title:=f2;
 end;
end;

//Compile Source Code
procedure Tfrmdis.SpeedButton3Click(Sender: TObject);
Var i:integer;
    errs:String;
begin
Errors:=0;
 msgref:=0;
if not isproject then
Begin
 memMessages.Lines.Clear;
 memErrors.Lines.Clear;
 PageControl2.ActivePage:= TSMessages;
 if assigned(Compiler) then
   try
    Compiler.Free;
   except
   end;
 Compiler:=CreateCompiler;
// Compiler.Compile(asmtext.Text);
// ShowCompiledCode;
 Compiler.OnCompileMessage:= DoCompMes;
 Compiler.Compile2(asmtext.Text);
 edit1.text:=Inttostr(Compiler.org);
 edit1.hint:=inttohex(Compiler.org,4)+'h';
 memLabels.Text:=asmLabels.Text;
 GlobLabels.Text:=GlobalLabels.Text;
 ShowCompiledCode;
 Errors:=Compiler.Errors;
 if Errors>0 then
   PageControl2.ActivePage:= TSErrors
 Else
  PageControl2.ActivePage:= TSBinary;
 PageControl2Change(nil);


 lblcombo.Items.Clear;
 for I := 0 to asmlabels.Count - 1 do
  lblcombo.Items.Add(asmLabels.Names[i]);
 ShowCompErrors;
end
else
Begin
 memMessages.Lines.Clear;
 memErrors.Lines.Clear;
 ProjectLinker.clear;

 ProjectLinker.OnBeforeCompile:=DoBefCompile;
 ProjectLinker.OnAfterCompile:=DoAftCompile;
 ProjectLinker.DoLink(projtext.Lines.CommaText,ExtractFilePath(OpenTextFileDialog1.FileName));
 GlobLabels.Text:=GlobalLabels.Text;
 errs:=ProjectLinker.GetLinkResult;
 MemErrors.Lines.Add('');
 MemErrors.Lines.Add('');
 MemErrors.Lines.Add('--------------------------');
 MemErrors.Lines.Add('PASS 3 WARNINGS - LINKING');
 MemErrors.Lines.Add('--------------------------');
 MemErrors.Lines.Add('');
 MemErrors.Lines.CommaText:=MemErrors.Lines.CommaText+ProjectLinker.GetLinkResult;
 Errors:=Compiler.Errors;
 ShowCompErrors;

 if Errors=0 then
   Statusbar1.Panels[2].Text:='Project Link Has Ended !!! '
  Else
   Statusbar1.Panels[2].Text:='ERRORS DETECTED !!! ';
 ShowCompiledCode;

 memMessages.Lines.EndUpdate;
 SendMessage(memMessages.handle, WM_VSCROLL, SB_TOP, 0);

 if Errors>0 then
   PageControl2.ActivePage:= TSErrors
 Else
  PageControl2.ActivePage:= TSBinary;
 PageControl2Change(nil);

 lblcombo.Items.Clear;
 for I := 0 to Globallabels.Count - 1 do
  lblcombo.Items.Add(Globallabels.Names[i]);


end;


End;

procedure Tfrmdis.DoBefCompile(Sender:TObject;Fname:String);
Begin
   Statusbar1.Panels[2].Text:='Now Compiling file '+Fname;
   Statusbar1.Repaint;
   Application.ProcessMessages;
   PageControl2.ActivePage:= TSMessages;
   curfile:=fname;
   fisnewfile:=true;
   TAsmFile(Sender).Compiler.OnCompileMessage:=DoCompMes;
//   TAsmFile(Sender).Compiler.OnCompileProgress

end;

procedure Tfrmdis.DoAftCompile(Sender:TObject;Fname:String);
Begin
 Errors:=Errors+TAsmFile(Sender).Compiler.Errors;

end;


procedure Tfrmdis.ShowCompErrors;
Begin
 StatusBar1.Panels[3].Text:='ERRORS:'+inttostr(Errors);

end;

Type Tmemohack=Class(TMemo);

procedure Tfrmdis.BinTextKeyDown(Sender: TObject; var Key: Word; Shift:
    TShiftState);
begin
SetSrcCurrentLine;
end;

//Abort sending
procedure Tfrmdis.Button10Click(Sender: TObject);
begin
 button10.Tag:=1;
end;

//Test Serial Communication with NB Laptop
procedure Tfrmdis.Button11Click(Sender: TObject);
var
  I: Integer;
  c:ansichar;
  errors:integer;
    S:TSTRINGLIST;
begin
  listbox1.Clear;
   button11.Tag:=1;
   adterminal1.Active:=false;
   errors:=0;
  SendChar('Y');
    S:=TSTRINGLIST.Create;

  for I := 0 to 255 do
  Begin
   SendChar(ansichar(ord(i)));
   if i<255 then
   Begin
     while not apdcomport1.CharReady do
     Begin
      application.ProcessMessages;
      sleep(2);
     End;
    try
     c:=apdcomport1.GetChar;
     if i<>ord(c) then begin
       inc(errors);
       s.Values[inttostr(i)]:=inttostr(ord(c));
     end;

     listbox1.items.Add(inttostr(ord(c)));
    except

    end;
   End;
  end;
  listbox1.Items.Add('Errors:'+inttostr(errors));
  button11.Tag:=0;
  adterminal1.Active:=true;
  s.SaveToFile('Xmiterrors.txt');
  s.Free;
end;

//Test Serial Communication with NB Laptop
procedure Tfrmdis.Button12Click(Sender: TObject);
var
  I: Integer;
  c:ansichar;
  errors:integer;
    S:TSTRINGLIST;
begin
  listbox1.Clear;
   button12.Tag:=1;
   adterminal1.Active:=false;
   errors:=0;
   SendChar('H');
    S:=TSTRINGLIST.Create;

  for I := 255 downto 0 do
  Begin

   if i>0 then
   Begin
     while not apdcomport1.CharReady do
     Begin
      application.ProcessMessages;
      sleep(2);
     End;
    try
     c:=apdcomport1.GetChar;
     if i<>ord(c) then begin
       inc(errors);
       s.Values[inttostr(i)]:=inttostr(ord(c));
     end;

     listbox1.items.Add(inttostr(ord(c)));
    except

    end;
   End;
  end;
  listbox1.Items.Add('Errors:'+inttostr(errors));
  button12.Tag:=0;
  adterminal1.Active:=true;
  s.SaveToFile('Recverrors.txt');
  s.Free;
end;

//Get Data from NB Laptop Memory to a file
procedure Tfrmdis.Button13Click(Sender: TObject);
VAR HL,BC:INTEGER;
    H,L,B,C:Byte;
    s:tstringlist;
    i:integer;
    q:ansichar;
    f:Tfilestream;
    pth:string;
begin

  pth:=extractfilepath(application.ExeName);
  adterminal1.Active:=false;
  BUTTON11.Tag:=1;
  HL:=strtoint(edit6.Text);
  BC:=strtoint(edit7.Text);
  H:=HL DIV 256;
  L:=HL-(H*256);
  B:=BC DIV 256;
  C:=BC-(H*256);
  s:=tstringlist.Create;
  if BC>0 then
  Begin
   SendChar('J');
   Sleep(5);
   SendChar(ANSICHAR(L));
   Sleep(5);
   SendChar(ANSICHAR(H));
   Sleep(5);
   SendChar(ANSICHAR(C));
   Sleep(5);
   SendChar(ANSICHAR(B));
   Sleep(5);
   f:=Tfilestream.Create(pth+'NewM_'+edit6.text+'.dmp',fmCreate);
    for i := 0 to BC-1 do
    Begin
     while not apdcomport1.CharReady do
     Begin
      application.ProcessMessages;
      sleep(2);
     End;
     try
      q:=apdcomport1.GetChar;
     except

     end;
     s.Values[inttostr(HL+i)]:=inttostr(ord(q));
     f.Write(q,1);
    End;
  End;
  f.Free;
  s.SaveToFile(pth+'NewMachineMemDump.txt');
  s.Free;
   adterminal1.Active:=true;
   BUTTON11.Tag:=0;
   showmessage('DONE at '+pth);
end;


function Pow(i, k: Integer): Integer;
var
  j, Count: Integer;
begin
  if k>0 then j:=2
    else j:=1;
  for Count:=1 to k-1 do
    j:=j*2;
  Result:=j;
end;

function BinToDec(Str: string): Integer;
var
  Len, Res, i: Integer;
  Error: Boolean;
begin
  Error:=False;
  Len:=Length(Str);
  Res:=0;
  for i:=1 to Len do
    if (Str[i]='0')or(Str[i]='1') then
      Res:=Res+Pow(2, Len-i)*StrToInt(Str[i])
    else
    begin
      MessageDlg('It is not a binary number', mtInformation, [mbOK], 0);
      Error:=True;
      Break;
    end;
  if Error=True then Result:=0
    else Result:=Res;
end;

function rgb888to666(d:longint):word;
var
 dr,dg,db,rnew,gnew,bnew,gup,glo:byte;
 rgb:word;

Begin
 dr:=d shr 16;
 dg:=d shr 8;
 db:=d;

 //r5,r4,r3,r2,r1,r0  r5 allways 0
 //g5,g4,g3,g2,g1,g0  g2 allways 0
 //b5,b4,b3,b2,b1,b0

 bnew:= db and BinToDec('11111100'); //shift 2 right to lower byte
 rnew:= dr and BinToDec('11111000'); //shift left to upperbyte
 gnew:= (dg and BinToDec('11101100')); //omit bit 2 of 6pack
 gup:= (gnew shr 5) and BinToDec('00000111');
 glo:=(gnew shl 4) and BinToDec('11000000');

 rgb:=((rnew+gup) shl 8)+(glo+(bnew shr 2));

 result:= rgb;
end;

procedure Tfrmdis.Button14Click(Sender: TObject);
var cols:string;
    col,newcol:longint;
begin
   if InputQuery('Color RGB 888','Color',cols) then
   Begin
    if cols[1]='$' then
     col:=HexToInt(cols)
   ELSE
    try
      col:=strtoint(cols);
    except
      try
       col:=HexToInt(cols);
      except
      end;
    end;

    newcol:=rgb888to666(col);
    showmessage(inttohex(newcol));
   End;

end;

procedure Tfrmdis.savepath;
var pth:string;
    inif:TInifile;
Begin
 pth:=ExtractFilePath(Application.Exename);

  Inif:=TIniFile.create(pth+'Config.Ini');
  inif.WriteString('General','Basic Path',Filelistbox1.Directory);

  inif.free;
End;

procedure Tfrmdis.Loadpath;
var pth:string;
    inif:TInifile;
    s:string;
Begin
 pth:=ExtractFilePath(Application.Exename);

  Inif:=TIniFile.create(pth+'Config.Ini');
  s:=inif.readString('General','Basic Path','');
  if s<>'' then
   Filelistbox1.Directory:=s;

  inif.free;
End;


procedure Tfrmdis.Button15Click(Sender: TObject);
Var Dir:String;
begin
   Dir:=Filelistbox1.Directory;
   if SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt],0) then
   Begin
    Filelistbox1.Directory := Dir;
    //save dir to options file.
    savepath;
   End;
end;

procedure Tfrmdis.Button16Click(Sender: TObject);
var nmd:boolean;
    c:ansichar;
    i:integer;
begin
 try
   apdcomport1.Open:=true;
 except
 end;

     label11.Caption:=inttostr(length(asmtext.Lines.Text));
     for i := 1 to Length(asmtext.Lines.Text) do
     Begin
       c:=Ansichar(asmtext.Lines.Text[i]);
        try
         SendChar(c);
        except
           break;
        end;
        sleep(trackbar1.Position);
        label10.Caption:=inttostr(i);
        application.ProcessMessages;
     end;
    // showmessage('Text Sent');
         listbox1.Items.Add('Source text sent.');
  adterminal1.SetFocus;
end;

procedure Tfrmdis.Button17Click(Sender: TObject);
begin
  setz80baudrate;
end;

//Send a Program through RS232 to NBLaptop
procedure Tfrmdis.Button1Click(Sender: TObject);
Var HL,BC:Integer;
    H,L,B,C:Byte;
    i:Integer;
    o:AnsiChar;
    siz:integer;

    j:Integer;
    p:PCmpInst;
    addr:Integer;
    RomWriteable:Boolean;
    TotBytes:Integer;
    FileByte:Integer;
    sf:TMemoryStream;

begin

 if not Assigned(Compiler) then Exit;

 //Put Compiled Object in a File
 if Compiler.ERRORSFOUND then
 Begin
   ShowMessage('Errors were found!!');
   Exit;
 end;
 try

  sf:=TMemoryStream.create;
 TotBytes:=0;
 FileByte:=0;

 for i := 0 to Compiler.Count-1 do
 Begin

   p:=Compiler.Items[i];
   if not checkbox3.checked then
    if sametext(p.Instruct,'DEFS') //or sametext(p.Instruct,'DS')
        then continue;   //do not write DEFS

   addr:=p.Addr;

 {  if checkbox1.checked and (sf.Position<p.Addr) then
    begin
     sf.Size:=p.addr;
     if sf.position<>(p.addr) then
      sf.Seek(p.addr,soFromBeginning);
    end;}

    for j:=1 to p.ByteCnt do
    Begin
       b:=p.bytes[j];
       sf.Write(b,1);
       Inc(FileByte);  //All data written
       inc(TotBytes);  //Only compiled data
    end;
 End;
 b:=0;
 //sf.Write(b,1);sf.Write(b,1);sf.Write(b,1);sf.Write(b,1);
 sf.Position:=0;


   //sent data to rs232
   label9.Font.Color:=clBlue;

  HL:=strtoint(edit1.Text);
  siz:=sf.Size;
  label1.caption:=inttostr(siz);

  BC:=siz;
  H:=HL DIV 256;
  L:=HL mod 256;
  B:=BC DIV 256;
  C:=BC mod 256;
  progressbar1.Min:=0;
  progressbar1.Max:=BC;
  progressbar1.Position:=0;
  if BC>0 then
  Begin
   SendChar('U');
   Sleep(500);
   SendChar(ANSICHAR(L));
   Sleep(5);
   SendChar(ANSICHAR(H));
   Sleep(5);
   SendChar(ANSICHAR(C));
   Sleep(5);
   SendChar(ANSICHAR(B));
   Sleep(5);
    for i := 0 to siz do
    Begin
       sf.Read(o,1);
       if not SendChar(o) then break;
       if CheckBox1.Checked then
         progressbar1.Position:=sf.Position-HL
       else
         progressbar1.Position:=sf.Position;
       label9.Caption:=inttostr(progressbar1.Position)+'/'+inttostr(siz);
       Application.ProcessMessages;
       if application.Terminated then
        break;
    End;

  End;
  progressbar1.Position:=0;
  Finally
      sf.Free;
  end;
end;

//Execute the program previously sent to NB Laptop
procedure Tfrmdis.Button2Click(Sender: TObject);
begin
 ApdComPort1.PutChar('X');
 AdTerminal1.SetFocus;
end;

//Send a single byte to the specified address on NB Laptop
procedure Tfrmdis.Button3Click(Sender: TObject);
var HL,BC:Integer;
    H,L,B,C:Byte;
    o:AnsiChar;
begin
  o:=AnsiChar(strtoint(edit2.Text));
  HL:=strtoint(edit1.Text);
  BC:=1;
  H:=HL DIV 256;
  L:=HL-(H*256);
  B:=BC DIV 256;
  C:=BC-(H*256);

  SendChar('U');
  SendChar(ANSICHAR(L));
  SendChar(ANSICHAR(H));
  SendChar(ANSICHAR(C));
  SendChar(ANSICHAR(B));
  SendChar(o);
end;

//Send the chars on edit box to NB Laptop
procedure Tfrmdis.Button4Click(Sender: TObject);
VAR O:ANSICHAR;
    i:integer;
    s:String;
begin
try
   apdcomport1.Open:=true;
 except

 end;
  s:=edit5.Text;

  for i:=1  to length(s) do
  Begin
    o:=AnsiChar(s[i]);
    if not  SendChar(o) then break;
    Label12.Caption:=inttostr(i)+'/'+inttostr(length(s));
    Label12.Repaint;
    //sleep(trackbar1.Position*10);
  End;
  if checkbox2.Checked then
   SendChar(#13);

end;

function Tfrmdis.DsrReady:boolean;
Begin
    result:=true;
    if apdcomport1.HWFlowOptions=[] then exit;

    While not apdcomport1.DSR and (button10.tag=0) do
    Begin
      APPLICATION.ProcessMessages;
      sleep(5);
    End;
    result:=button10.tag=0;
    button10.tag:=0;
End;

//Send a Disk basic file through RS232
procedure Tfrmdis.Button5Click(Sender: TObject);
var sf:TFileStream;
    c:Ansichar;
    nmd:boolean;
begin
 try
   apdcomport1.Open:=true;
 except
 end;
  if fileexists(filelistbox1.FileName) then
  Begin
     sf:=TFileStream.create(filelistbox1.FileName,fmOpenRead);
     label11.Caption:=inttostr(sf.Size);
     repeat
       nmd:=sf.Read(c,1)=0;
       if not nmd then
       Begin
        try
         SendChar(c);
        except
           break;
        end;
         sleep(trackbar1.Position);
         label10.Caption:=inttostr(sf.position);
         application.ProcessMessages;
       End;
     until nmd;
     sf.Free;
     listbox1.Items.Add('File Sent');
  End
  else
   showmessage('Select a file.');
  adterminal1.SetFocus;
end;

//Stop transmitting
procedure Tfrmdis.Button6Click(Sender: TObject);
begin
try
 apdcomport1.Open:=false;
 application.ProcessMessages;
finally
end;
end;

//Set up Com Port
var data:ARRAY[0..28] OF Byte =  ($3E,$80,$D3,$23,$3E,$FF,$D3,$20,$3E,$00,$D3,$21,$3E,$03,$D3,$23,$3E,$00,$D3,$22,$3E,$00,$D3,$21,$C3,$04,$00,$00,$00);
procedure Tfrmdis.setz80baudrate;
var
   i:integer;
   br:byte;
   HL,BC:Integer;
   H,L,B,C:Byte;
Begin
  HL:=$9000;
  BC:=length(data)-1;
  H:=HL DIV 256;
  L:=HL-(H*256);
  B:=BC DIV 256;
  C:=BC-(H*256);
  if BC>0 then
  Begin
   SendChar('U');
   Sleep(500);
   SendChar(ANSICHAR(L));
   Sleep(5);
   SendChar(ANSICHAR(H));
   Sleep(5);
   SendChar(ANSICHAR(C));
   Sleep(5);
   SendChar(ANSICHAR(B));
   Sleep(5);
  End
  else exit;

   br:=1;//115200 bps
   for I := 0 to length(data)-1 do
   begin
     b:=data[i];
     if b=$ff then
       b:=br;
      ApdComPort1.PutChar(ansichar(b));
      sleep(4);
   end;
   application.ProcessMessages;
   sleep(5);
   ApdComPort1.PutChar(' ');
   application.ProcessMessages;
   sleep(5);
   ApdComPort1.PutChar('X');
   sleep(500);
   combobox1.Text:='115200';
   ComboBox1Change(nil);
   application.ProcessMessages;
   adTerminal1.ClearAll;
   application.ProcessMessages;
   ApdComPort1.PutChar(' ');
   trackbar1.Position:=0;
   AdTerminal1.SetFocus;
End;

procedure Tfrmdis.setcominfolabel;
var s1,s2,s3:string;
Begin

  if hwfUseDTR in ApdComPort1.HWFlowOptions then s2:='HW' else s2:='SW';
  s1:=inttostr(ApdComPort1.Baud);
  cominfolabel.Caption:='COM Port '+inttostr(ApdComPort1.ComNumber)+' at '+s1+',N,8,1 '+s2;
End;

procedure Tfrmdis.Button7Click(Sender: TObject);
begin
  try
  ApdComPort1.Open:=false;
  ApdComPort1.ComNumber:=0;
  ApdComPort1.PromptForPort:=true;
  finally
   try
    ApdComPort1.Open:=true;
    setcominfolabel
   except
     on e:exception do
      showmessage(e.Message);
   end;
  end;
end;

//Set hardware Flow control
procedure Tfrmdis.Button8Click(Sender: TObject);
begin
  ApdComPort1.Open:=false;
  ApdComPort1.HWFlowOptions:=[hwfUseDTR,hwfRequireDSR];
   try
    ApdComPort1.Open:=true;
    setcominfolabel;
   except
     on e:exception do
      showmessage(e.Message);
   end;

end;

//remove hardware Flow control
procedure Tfrmdis.Button9Click(Sender: TObject);
begin
  ApdComPort1.Open:=false;
  ApdComPort1.HWFlowOptions:=[];
   try
    ApdComPort1.Open:=true;
    setcominfolabel;
   except
     on e:exception do
      showmessage(e.Message);
   end;
end;

procedure Tfrmdis.DoCompMes(Sender:TObject;msg:String);
Var i:integer;
    IsInfoOnly:Boolean;
     p:PCmpInst;
Begin
 if msgref=0 then
   memMessages.Lines.BeginUpdate;
 try
   if TCompiledList(Sender).Count=1 then
   Begin
     p:=TCompiledList(Sender).Items[TCompiledList(Sender).Count-1];
     edit1.text:=inttostr(p.addr);
     edit1.hint:=inttohex(p.Addr,4)+'h';
   End;

 except

 end;
   if Copy(msg,1,3)=#9#9#9 then
   Begin
      IsInfoOnly:=True;
      msg:=copy(msg,2,Length(msg));
   end;
   if IsProject then
   Begin
     if fisnewfile then
     Begin
       MemMessages.Lines.add(''); MemMessages.Lines.add(''); MemMessages.Lines.add('');
       MemMessages.Lines.add('-------------------------------------------');
       MemMessages.Lines.add('               '+CurFile+'                 ');
       MemMessages.Lines.add('-------------------------------------------');
       MemMessages.Lines.add('');
       fisnewfile:=false;
     end;
     if not IsInfoOnly then
       msg:=msg+'   ['+CurFile+']';
   end;
   MemMessages.Lines.add(msg);
   if Compiler.ISError then
    memErrors.Lines.add(msg);
 //  Tmemohack(MemMessages).SetCaretPos(Point(5,MemMessages.Lines.Count-1));
 //  Application.ProcessMessages;
   SetSrcCurrentLine;
   ShowCompErrors;
   //
   inc(msgref);
   if msgref=40 then
   Begin
     msgref:=0;
     memMessages.Lines.EndUpdate;
     SendMessage(memMessages.handle, WM_VSCROLL, SB_BOTTOM, 0);
     Statusbar1.Repaint;
   End;

   //MemMessages.RePaint;
//   Application.ProcessMessages;
end;

procedure Tfrmdis.DoData(Pg, Addr, Leng: Integer);
begin

end;

function Tfrmdis.IsProject: Boolean;
begin
  Result := projtext.Lines.Count>1;
end;

procedure Tfrmdis.lblComboChange(Sender: TObject);
Var txt:String;
    k:Integer;
    w:word;
begin
  txt:=lblCombo.Text;
  if  Isproject then
   k:=GlobalLabels.GetLabel(txt)
  Else
   k:=asmLabels.GetLabel(txt);
  w:=Word(k);
  lblEdit.Text:=Inttostr(w)+' ('+Inttohex(w,4)+'h)';
end;

function Tfrmdis.LS: Integer;
begin
  //top and bottom margin for instructions
  Result :=   15;
end;

procedure Tfrmdis.N2Click(Sender: TObject);
begin
Close;
end;

procedure Tfrmdis.OpenProjectFile1Click(Sender: TObject);
begin
   PageControl2.ActivePage:=TSProj;
   Speedbutton1.Click;
end;

procedure Tfrmdis.OpenProjectFile2Click(Sender: TObject);
begin
   PageControl2.ActivePage:=TSSource;
   Speedbutton1.Click;

end;

procedure Tfrmdis.PageControl2Change(Sender: TObject);
begin
   case PageControl2.tabIndex Of
     0:ActMem:=projText;
     1:ActMem:=asmText;
     2:ActMem:=BinText;
     3:ActMem:=memLabels;
     4:ActMem:=GlobLabels;
     5:ActMem:=memMessages;
     6:ActMem:=memErrors;
   end;
   SetSrcCurrentLine;
   if ActMem=projText then
   Begin
    SpeedButton1.hint:='Load Assembly Project';
    SpeedButton2.hint:='Save Assembly Project';
   end
    else
   Begin
    SpeedButton1.hint:='Load Assembly Source File';
    SpeedButton2.hint:='Save Assembly Source File';
   End;

end;


function Tfrmdis.PVisibleLines: Integer;
begin

end;

procedure Tfrmdis.ShowCompiledCode;
Begin
   bintext.text:=Compiler.getcompilationastext
end;

//Print to Default Windows Printer
procedure Tfrmdis.SpeedButton4Click(Sender: TObject);
Var f:textFile;
    i:Integer;
begin
 //Print Active Memo
 if ActMem<>nil then
Begin
  AssignPrn(F);
  Rewrite(F);
  WriteLn(f,'-----------------------------------------------------------');
  WriteLn(f,'      '+unitname);
  WriteLn(f,'              '+PageControl2.ActivePage.Caption);
  WriteLn(f,'-----------------------------------------------------------');
  WriteLn(f,'');
  for i := 0 to ActMem.Lines.Count - 1 do
   WriteLn(f,Actmem.Lines[i]);
  CloseFile(f);
 end;
end;

procedure Tfrmdis.SpeedButton5Click(Sender: TObject);
begin
 Filelistbox1.Refresh;
end;

//put object code to file
procedure Tfrmdis.SpeedButton6Click(Sender: TObject);
Var sts,ses:String;
    st,se:Integer;
    sf:TFileStream;
    b,i:Integer;
    F:TextFile;
    j:Integer;
    p:PCmpInst;
    addr:Integer;
    RomWriteable:Boolean;
    TotBytes:Integer;
    FileByte:Integer;
    sl:tstringlist;
    si:integer;
    dataline:integer;
    line:string;
    staddr:integer;

    procedure makeloader(adr,tot:integer);
    Begin
      sl.Insert(0,'10 Reserve top-'+inttostr(adr));
      sl.Insert(1,'20 For i=0 to '+inttostr(tot-1));
      sl.Insert(2,'30 Read a:poke '+inttostr(adr)+'+i,a');
      sl.Insert(3,'40 next i');
      sl.Insert(4,'50 ?"type CALL TOP to run your code."');
      sl.Insert(5,'100 END');
    End;

begin
 if not Assigned(Compiler) then Exit;
 //Put Compiled Object in a File
 if Compiler.ERRORSFOUND then
 Begin
   ShowMessage('Errors were found!!');
   Exit;
 end;
 if (SaveBinFileDialog.FileName<>'') or  SaveBinFileDialog.Execute then
 Begin

 try
  sf:=TFileStream.Create(SaveBinFileDialog.FileName,fmCreate);
  sl:=tstringlist.create;
 TotBytes:=0;
 FileByte:=0;
 dataline:=10000;
 line:=inttostr(dataline)+' DATA ';
 si:=0;
 for i := 0 to Compiler.Count-1 do
 Begin
   p:=Compiler.Items[i];
   addr:=p.Addr;
   if i=0 then staddr:=addr;
    if checkbox1.checked and (sf.Position<p.Addr) then
    begin
     sf.Size:=p.addr;
     if sf.position<>(p.addr) then
      sf.Seek(p.addr,soFromBeginning);
    end;
    if not CheckBox3.Checked then
     if sametext(p.Instruct,'DEFS')// or sametext(p.Instruct,'DS')
        then continue;   //do not write DEFS OR DS
    for j:=1 to p.ByteCnt do
    Begin
       b:=p.bytes[j];
       sf.Write(b,1);
       Inc(FileByte);  //All data written
       inc(TotBytes);  //Only compiled data
       line:=line+inttostr(b);
       inc(si);if si>9 then Begin si:=0;inc(dataline,10);end
        else begin line:=line+',';end;
       if si=0 then
       Begin
            sl.Add(line);
            line:=inttostr(dataline)+' DATA ';
       End;
    end;
 end; //end save bytes
  makeloader(staddr,totbytes);
  sl.SaveToFile(ChangeFileEXt(SaveBinFileDialog.FileName,'.txt'));
    //Save Global Symbol Table
  GlobLabels.Lines.SaveToFile(ChangeFileEXt(SaveBinFileDialog.FileName,'.GSYM'));
  sl.Assign(GlobLabels.Lines);
  for I := 0 to sl.Count-1 do
   sl[i]:=stringreplace(sl[i],'=',' EQU ',[]);
  sl.SaveToFile(ChangeFileEXt(SaveBinFileDialog.FileName,'.SYM'));
    //Save Binary Listing
  BinText.Lines.SaveToFile(ChangeFileEXt(SaveBinFileDialog.FileName,'.BLST'));
  if memErrors.Lines.Count>0 then
     memErrors.Lines.SaveToFile(ChangeFileEXt(SaveBinFileDialog.FileName,'.ERR'));
 finally
   sl.Free;
   sf.Free;
 end;
  Showmessage(inttostr(totbytes)+' bytes put in file!!!');
 End;
end;

procedure Tfrmdis.StatusBar1DblClick(Sender: TObject);
begin
 //  OpenTextFileDialog1.FileName:='';
   SaveTextFileDialog1.FileName:='';
   SaveBinFileDialog.FileName:='';
   statusbar1.Panels[2].Text:='<no filename>';
end;


procedure Tfrmdis.Timer1Timer(Sender: TObject);
begin
checkModemStatus;
end;

procedure Tfrmdis.TrackBar1Change(Sender: TObject);
begin
 TRACKBAR1.Hint:='Delay:'+inttostr(trackbar1.position);
end;

function Tfrmdis.SendChar(c:AnsiChar):boolean;
Begin
  result:=DsrReady AND (BUTTON10.TAG=0);
  if not result then exit;
  ApdComPort1.PutChar(c);
  Sleep(trackbar1.position);
End;


procedure TInstrList.Clear;
Var i:Integer;
begin
  for i := 1 to Count  do
     Freemem(Instr[i]);
  Inherited;
end;

function TInstrList.GetInstr(Index: Integer): pInstr;
begin
  Result :=  PInstr(Get(Index-1));
end;

function TInstrList.GetInstrIdxFromAddr(Addr: Integer): Integer;
var
  I: Integer;
begin
   Result:=-1;
   for I := 0 to Count - 1 do
   Begin
      if PInstr(Get(i)).Addr=addr then
      Begin
        Result:=i;
        Break;
      end;
   end;
end;

{ TInstrList }

procedure TInstrList.New;
Var p:PInstr;
begin
  System.New(p);
  Add(p);
  p.Addr:=0;
  p.Nob:=0;
  p.Bytes[1]:=0;  p.Bytes[2]:=0;  p.Bytes[3]:=0;  p.Bytes[4]:=0;
  p.Instr:='';
  p.Comments:='';
  p.CommentsPre:='';
end;

procedure TInstrList.PutInstr(Index: Integer; Item: PInstr);
begin
  Put(Index-1,Item);
end;


Initialization
 Instructions:=TInstrList.create;
 BreakPList:=TBreakPointList.create;
 Instructions.Clear;
 if not DirectoryExists(AppPath+DefaultAsmDir) then
    CreateDir(AppPath+DefaultAsmDir);

Finalization
 Instructions.Free;
 BreakPList.free;

end.
