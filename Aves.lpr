program Aves;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, uMain, uDMConnect, uLogin, rxnew, zcomponent, uAddUser, uBirds, uFarm,
  runtimetypeinfocontrols, datetimectrls, uAviary, uInputs, uLot, uTimeline,
  uActivity, uClose, Urels1, uRelatorio, urel2, urelatorio2, uRelatiorio3, uRel3
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TDMConnect, DMConnect);
  Application.CreateForm(TFrmRel2, FrmRel2);
  Application.CreateForm(TFrmRelatorio2, FrmRelatorio2);
  Application.CreateForm(TFrmRelatorio3, FrmRelatorio3);
  Application.CreateForm(TFrmRel3, FrmRel3);
  Application.Run;
end.

