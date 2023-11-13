unit uBirds;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  DBGrids, Buttons, DBCtrls;

type

  { TFrmBirds }

  TFrmBirds = class(TForm)
    DBGBirds: TDBGrid;
    DBNavigator1: TDBNavigator;
    LblTitle1: TLabel;
    PnlBirds3: TPanel;
    PnlBirds2: TPanel;
    SpSave: TSpeedButton;
    SpClose: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure SpAddClick(Sender: TObject);
    procedure SpCloseClick(Sender: TObject);
    procedure SpDeleteClick(Sender: TObject);
    procedure SpSaveClick(Sender: TObject);
  private

  public

  end;

var
  FrmBirds: TFrmBirds;

implementation

{$R *.lfm}
 uses udmconnect;
{ TFrmBirds }

procedure TFrmBirds.FormCreate(Sender: TObject);
begin


  dmconnect.ZQBirds.close;
      DMConnect.ZQBirds.SQL.Clear;
      DMConnect.ZQBirds.sql.Add('select * from birds');
      DMConnect.ZQBirds.Open;
      DMConnect.Rxbirds.close;
      DMConnect.Rxbirds.Open;
  while not DMConnect.ZQBirds.EOF do
    begin
      dmconnect.Rxbirds.Append;
      dmconnect.Rxbirds.Fieldbyname('ID').asinteger:=DMConnect.ZQBirds.FieldByName('Birdid').asinteger;
      dmconnect.Rxbirds.Fieldbyname('Tipo').asstring:=DMConnect.ZQBirds.FieldByName('Birdtype').asstring;
      dmconnect.Rxbirds.Post;
      DMConnect.zqbirds.next;
    end;

end;

procedure TFrmBirds.SpAddClick(Sender: TObject);
begin
      dmconnect.Rxbirds.Append;
      dmconnect.Rxbirds.Fieldbyname('ID').asinteger:=0;
      dmconnect.Rxbirds.Fieldbyname('Tipo').asstring:=EdtType.text;
      dmconnect.Rxbirds.Post;
end;

procedure TFrmBirds.SpCloseClick(Sender: TObject);
begin
  close;
end;

procedure TFrmBirds.SpDeleteClick(Sender: TObject);

begin
     dmconnect.RxBirds.delete;
end;

    procedure TFrmBirds.SpSaveClick(Sender: TObject);

begin


     DMConnect.ZConnectbirds.StartTransaction;
  try


     DMConnect.Rxbirds.first;
    while not DMConnect.RxBirds.EOf do

        begin


       if DMConnect.RxBirds.FieldByName('ID').ASinteger  = 0 then
        begin

         DMConnect.zqbirds.sql.clear;


       DMConnect.zqbirds.sql.add('insert into birds');
       DMConnect.zqbirds.sql.add('(birdtype)');
       DMConnect.zqbirds.sql.add('values');
       DMConnect.zqbirds.sql.add('(:abirdtype)');

       DMConnect.zqbirds.ParamByName('abirdtype').asstring :=DMConnect.Rxbirds.FieldByName('tipo').asstring;
       DMConnect.ZQBirds.ExecSQL;

       DMConnect.RxBirds.next;
        end
       else

        begin

         DMConnect.zqbirds.sql.clear;


       DMConnect.zqbirds.sql.add('update birds set'+
       ' birdtype = '+QuotedStr(DBGbirds.Columns[1].field.text)+
       ' where birdid = '+ QuotedStr(DBGbirds.Columns[0].field.text));
       DMConnect.ZQBirds.ExecSQL;

       DMConnect.RxBirds.next;
        end;
     end ;

    showmessage('Salvo com sucesso');
    DMConnect.ZConnectbirds.Commit;

  except
    on E:Exception do
  begin
   showmessage('Ocorreu um erro'+e.Message);
   DMConnect.ZConnectbirds.Rollback;
  end;
  end;
end;

end.

