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

unit uAsmPrj;

interface
Uses uasm,Classes;

Type

  TAsmFile=Class
  private
    procedure DoCompile(const AFile: string;clrglobal:boolean=true);
    procedure GetProps; //holds the result of each compilation
    Public
      Compiler:TCompiledList;
      AsmLabels:TDSAsmLabels;
      GlobalLabels:TDSAsmLabels;
      FileName:String;
      Constructor Create;
      Destructor destroy;Override;
      
      Procedure SetProps;
  end;

  TOnBefAftCompile=Procedure (Sender:TObject;FileName:String) of Object;


  TProjectLinker=Class
  private
     FOnBeforeCompile: TOnBefAftCompile;
     FOnAfterCompile: TOnBefAftCompile;
     FOnError:TOnCompileMessage;
     LastDollar: Integer;
     SourcePath: string;
    procedure DoCompile(Asmfile: TAsmFile; Fn: String;clrGlobal:boolean=true);
    protected
    procedure DoOnAfterCompile(Asmfile: TAsmFile; Fn: String); virtual;
    procedure DoOnBeforeCompile(Asmfile: TAsmFile; Fn: String); virtual;
    Public
     Files:TStringlist; //the files to link
     AsmFiles:TList; //  a list of TAsmFile one for each file
     Errors:String;
     FinalCompiler:TCompiledList;
     Constructor Create;
     Destructor destroy;Override;

     function DoLink(lnkFiles, APath: String): Boolean;
    function GetLinkResult: string;
    procedure clear;
    Published
     property OnBeforeCompile: TOnBefAftCompile read FOnBeforeCompile write
         FOnBeforeCompile;
     property OnAfterCompile: TOnBefAftCompile read FOnAfterCompile write
         FOnAfterCompile;

  end;

Var ProjectLinker:TProjectLinker=nil;

implementation
uses sysutils;


{ TAsmFile }

constructor TAsmFile.Create;
begin
  Compiler:=TCompiledList.Create;
  Compiler.IsProject:=true;
  AsmLabels:=TDSAsmLabels.create;
  GlobalLabels:=TDSAsmLabels.create;
  FileName:='';
end;

destructor TAsmFile.destroy;
begin
  Compiler.free;
  AsmLabels.Free;
  GlobalLabels.free;
  inherited;
end;

procedure TAsmFile.SetProps;
begin
  uAsm.Compiler:=Compiler;
end;

procedure TAsmFile.GetProps;
begin
  AsmLabels.CommaText:=uasm.AsmLabels.CommaText;
  GlobalLabels.CommaText:=uasm.GlobalLabels.CommaText;
end;

procedure TAsmFile.DoCompile(const AFile: string;clrglobal:boolean=true);
Var sl:Tstringlist;
    s,PRJPATH:String;
begin
  FileName:=AFile;
  prjpath:=extractfilepath(Filename);
  uasm.AsmLabels.Clear;
//  if clrglobal then
  uasm.GlobalLabels.Clear;
  SetProps;
  sl:=Tstringlist.create;
  try
   sl.LoadFromFile(FileName);
   s:=sl.Text;
  finally
    sl.free;
  end;
  Compiler.ProjectPath:=prjpath;
  Compiler.Compile2(s);
  GetProps;
end;


{ TProjectLinker }

procedure TProjectLinker.clear;
begin
   Errors:='';
   Files:=TStringList.Create;
   FinalCompiler:=TCompiledList.create;
   asmFiles:=nil;
   LastDollar:=-1;
end;

constructor TProjectLinker.Create;
begin
  clear;
end;

destructor TProjectLinker.destroy;
Var i:Integer;
begin
  Files.free;
  FinalCompiler.free;
  if assigned(asmfiles) then
   for i := 0 to asmFiles.Count - 1 do
     TAsmFile(asmfiles[i]).free;
  AsmFiles.free;
  inherited;
end;

procedure TProjectLinker.DoOnBeforeCompile(Asmfile: TAsmFile; Fn: String);
Begin
   if Assigned(FOnBeforeCompile) then
    FOnBeforeCompile(asmfile,Fn);
end;

procedure TProjectLinker.DoOnAfterCompile(Asmfile: TAsmFile; Fn: String);
Begin
   if Assigned(FOnAfterCompile) then
    FOnAfterCompile(asmfile,Fn);
end;

Procedure TProjectLinker.DoCompile(Asmfile:TAsmFile;Fn:String;clrGlobal:boolean=true);
Begin
   DoOnBeforeCompile(AsmFile,Fn);
   asmfile.Compiler.MakeAbsolute(LastDollar);
   if not fileexists(fn) then
   Begin
     asmfile.Compiler.AddError('File ['+fn+'] not found');
   End
   else
    asmfile.DoCompile(SourcePath+Fn,clrGlobal);
   DoOnAfterCompile(AsmFile,Fn);
end;

function TProjectLinker.DoLink(lnkFiles, APath: String): Boolean;
Var i,j:integer;
    asmfile:TAsmFile;
    nm,errmsg:string;
    vl,vl2:Integer;
    sl:tstringlist;
begin
  SourcePath:=APath;
  Files.CommaText:=lnkFiles;
  if assigned(AsmFiles) then
    asmfiles.free;
  AsmFiles:=TList.Create;
  asmfile:=nil; LastDollar:=-1;
  //Load external Symbols
  i:=Files.count-1;
  while i>=0 do
  Begin
    if pos('.GSYM',Files[i])>0 then
    Begin //we must include an extrernal symbol table
     ExternLabels.LoadFromFile(SourcePath+Files[i]);
     Files.Delete(i);
    end
    Else
     Dec(I);
  end;

  for i := Files.Count - 1 downto 0 do
  Begin
   if Files[i]='' then files.Delete(i)
   else
     if stringreplace(Files[i],#9,'',[rfReplaceAll])='' then files.Delete(i);
  end;

  //Compile Pass1 and Pass 2 (Not Relative)
  //PASS1
  for i := 0 to Files.Count - 1 do
  Begin
   asmfile:=TAsmFile.create;
   asmfiles.Add(asmfile);

   if files[i][1]=';' then continue;
   try
     DoCompile(asmfile,Files[i]); //Compiling Pass1
   except
      on e:exception do
       raise Exception.Create(e.message);
   end;
   if asmFile.Compiler.Dollar<>-2 then //we didnot compile anything
     LastDollar:=asmFile.Compiler.Dollar;
  end;




  uasm.AsmLabels.Text:='';


  //Transfer all  Global Labels
  for i := 0 to Files.Count - 1 do
  Begin
   asmfile:=TAsmFile(asmfiles[i]);

   //Transfer Global Labels
   for j:= 0 to asmfile.GlobalLabels.Count - 1 do
   Begin
     nm:=asmfile.GlobalLabels.Names[j];
     vl:=asmfile.GlobalLabels.GetLabel(nm);

     vl2:=uasm.GlobalLabels.GetLabel(nm);
     if (vl=asmnotfound) and (vl2<>asmnotfound) then
       continue;

      uasm.GlobalLabels.AddLabel(nm,vl);
   end;
  End;


  //Transfer all compiled op commands to one compiler
  for i := 0 to Files.Count - 1 do
  Begin
   asmfile:=TAsmFile(asmfiles[i]);

      //Transfer Op commands
   for j:= 0 to asmfile.Compiler.Count - 1 do
     FinalCompiler.Add(asmfile.Compiler.Items[j]); //add pointer

   FinalCompiler.Errors:= FinalCompiler.Errors +asmfile.Compiler.Errors;
  End;


   //Check Pass 3 Errors(Warnings) before Pass 3
  { sl:=tstringlist.create;

   for i := 0 to uasm.GlobalLabels.Count - 1 do
   Begin
     nm:=uasm.GlobalLabels.Names[i];
     vl:=uasm.GlobalLabels.GetLabel(nm);
     if vl=AsmNotFound then
     Begin
       Errmsg:=nm+' Value Not Set';
       sl.add(errmsg);
       if Assigned(FOnError) then
          FOnError(Self,Errmsg);
     end;
   end;

   Errors:=sl.CommaText;
   sl.free;}

   //No We Do A Pass 3
   asmfile:=TAsmFile.create;
   try
      asmfile.Compiler.free;
      asmfile.Compiler:=FinalCompiler;
      asmfile.SetProps;
      DoOnBeforeCompile(AsmFile,'---LINKING----');
      FinalCompiler.DoPass2(True);
      DoOnAfterCompile(AsmFile,'---LINKING----');
      asmfile.Compiler:=nil;

   finally
      asmFile.free;
   end;

end;

function TProjectLinker.GetLinkResult: string;
begin
  result:=Errors;
end;

initialization
   ProjectLinker:=TProjectLinker.Create;
end.
