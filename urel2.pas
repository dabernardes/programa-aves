unit urel2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBCtrls, StdCtrls,
  ZDataset;

type

  { TFrmRel2 }

  TFrmRel2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    DataSource2: TDataSource;
    Label1: TLabel;
    ZQuery2: TZQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

  public

  end;

var
  FrmRel2: TFrmRel2;

implementation

{$R *.lfm}
  uses urelatorio2;
{ TFrmRel2 }

procedure TFrmRel2.Button1Click(Sender: TObject);

begin
   frmrelatorio2:=tfrmrelatorio2.Create(self);
   try
     frmrelatorio2.RLReport1.Preview();
   finally
     frmrelatorio2.free;
   end;
end;

procedure TFrmRel2.Button2Click(Sender: TObject);
begin
  close;
end;

end.

