program Assembler;

uses
  Vcl.Forms,
  frmAbout in 'frmAbout.pas' {fAbout},
  frmChrDsgn in 'frmChrDsgn.pas' {fchrdsgn},
  frmDisassembly in 'frmDisassembly.pas' {frmdis},
  frmInstructions in 'frmInstructions.pas' {fInstructions},
  frmOptions in 'frmOptions.pas' {foptions},
  frmSplash in 'frmSplash.pas' {fsplash},
  strings in 'strings.pas',
  uAsm in 'uAsm.pas',
  uAsmPrj in 'uAsmPrj.pas',
  uNBParser in 'uNBParser.pas',
  uprogr in 'uprogr.pas' {frmProgress},
  Ustopwatch in 'Ustopwatch.pas',
  ustrings in 'ustrings.pas',
  uUpdate in 'uUpdate.pas' {frmUpdate};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrmdis, frmdis);
  Application.CreateForm(TfrmProgress, frmProgress);
  Application.CreateForm(Tfoptions, foptions);
  Application.CreateForm(Tfsplash, fsplash);
  Application.CreateForm(TfrmUpdate, frmUpdate);
  Application.Run;
end.
