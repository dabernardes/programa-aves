unit uActivity;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  DBCtrls, Buttons, Grids, DBGrids;

type

  { TFrmActivity }

  TFrmActivity = class(TForm)
    DBGridActivity: TDBGrid;
    DBNavActivity: TDBNavigator;
    LblTitle: TLabel;
    PnlActivity1: TPanel;
    PnlActivity2: TPanel;
    SpBtnSave: TSpeedButton;
    SpBtnClose: TSpeedButton;
    procedure DBGridActivityKeyPress(Sender: TObject; var Key: char);
    procedure DBNavActivityClick(Sender: TObject; Button: TDBNavButtonType);
    procedure FormCreate(Sender: TObject);
    procedure SpBtnCloseClick(Sender: TObject);
    procedure SpBtnSaveClick(Sender: TObject);
  private
   a:integer;
  public

  end;

var
  FrmActivity: TFrmActivity;

implementation

{$R *.lfm}
 uses udmconnect;
{ TFrmActivity }

procedure TFrmActivity.SpBtnCloseClick(Sender: TObject);
begin
  close;
end;

procedure TFrmActivity.SpBtnSaveClick(Sender: TObject);


begin
  DMConnect.ZConnectbirds.StartTransaction;
  try


     DMConnect.Rxactivity.First;
    while not DMConnect.Rxactivity.EOF do
     begin
       if  DMConnect.RxActivity.FieldByName('ID').asinteger = 0 then
       begin
       DMConnect.zqbirds.sql.clear;
       DMConnect.zqbirds.sql.add('insert into activity');
       DMConnect.zqbirds.sql.add('(activitytype)');
       DMConnect.zqbirds.sql.add('values');
       DMConnect.zqbirds.sql.add('( :activitytype)');

       DMConnect.zqbirds.ParamByName('activitytype').asstring :=DMConnect.Rxactivity.FieldByName('TIPO').asstring;
       DMConnect.ZQBirds.ExecSQL;
       DMConnect.Rxactivity.next;

       end
       else
       begin
         DMConnect.zqbirds.sql.clear;
          DMConnect.zqbirds.sql.add('update activity set'+
          ' activitytype = '+QuotedStr(DBGridActivity.Columns[1].Field.text )+
          ' where activityid = '+QuotedStr(DBGridActivity.Columns[0].Field.text ));
          DMConnect.ZQBirds.ExecSQL;
       DMConnect.Rxactivity.next;

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

procedure TFrmActivity.FormCreate(Sender: TObject);
begin
  dmconnect.ZQBirds.close;
      DMConnect.ZQBirds.SQL.Clear;
      DMConnect.ZQBirds.sql.Add('select * from activity');
      DMConnect.ZQBirds.Open;
      DMConnect.RxActivity.close;
      DMConnect.Rxactivity.Open;
  while not DMConnect.ZQBirds.EOF do
    begin
      dmconnect.RxActivity.Append;
      dmconnect.RxActivity.Fieldbyname('ID').asinteger:=DMConnect.ZQBirds.FieldByName('activityid').asinteger;
      dmconnect.RxActivity.Fieldbyname('Tipo').asstring:=DMConnect.ZQBirds.FieldByName('activitytype').asstring;
      a:= dmconnect.Rxactivity.Fieldbyname('ID').asinteger;
      dmconnect.RxActivity.Post;
      DMConnect.zqbirds.next;
    end;
end;

procedure TFrmActivity.DBGridActivityKeyPress(Sender: TObject; var Key: char);
begin
  Key := AnsiUpperCase(Key)[1];
end;

procedure TFrmActivity.DBNavActivityClick(Sender: TObject;
  Button: TDBNavButtonType);
begin
    case button of
   nbInsert:
     begin

     DBGridactivity.Columns[0].Field.text:='0');
     DBGridactivity.Columns[1].Field.FocusControl;

     end;
   nbPost:
       DMConnect.RxActivity.SortOnFields('ID');
   end;
end;

end.

