unit uAviary;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  DBGrids, Buttons, DBCtrls;

type

  { TFrmAviary }

  TFrmAviary = class(TForm)
    DBGridAviary: TDBGrid;
    DBNavigator1: TDBNavigator;
    LblTitle: TLabel;
    PnlAviary1: TPanel;
    PnlAviary2: TPanel;
    SpBtnClose: TSpeedButton;
    SpBtnSave: TSpeedButton;
    procedure DBGridAviaryKeyPress(Sender: TObject; var Key: char);
    procedure DBNavigator1Click(Sender: TObject; Button: TDBNavButtonType);
    procedure FormCreate(Sender: TObject);
    procedure SpBtnCloseClick(Sender: TObject);
    procedure SpBtnSaveClick(Sender: TObject);
    procedure SpdbtnAddClick(Sender: TObject);
  private
     A:INTEGER;
  public

  end;

var
  FrmAviary: TFrmAviary;

implementation

{$R *.lfm}
uses udmconnect;
{ TFrmAviary }

procedure TFrmAviary.SpdbtnAddClick(Sender: TObject);
begin
  DMConnect.RxAviary.last;


end;

procedure TFrmAviary.SpBtnSaveClick(Sender: TObject);
var
  id:string;

begin
     DMConnect.ZConnectbirds.StartTransaction;
  try



     DMConnect.RxAviary.First;

    while not DMConnect.RxAviary.EOF do
     begin
       id:=copy(DMConnect.Rxaviary.FieldByName('Granja').asstring,0,(pos('-',DMConnect.Rxaviary.FieldByName('Granja').asstring)-1));
       if DMConnect.RxAviary.FieldByName('ID').asinteger =0 then
       begin
       DMConnect.zqbirds.sql.clear;
       DMConnect.zqbirds.sql.add('insert into aviary');
       DMConnect.zqbirds.sql.add('(aviaryname,capacity,farmid_Afk)');
       DMConnect.zqbirds.sql.add('values');
       DMConnect.zqbirds.sql.add('(:aaviaryname,:acapacity,:aFARMid_Afk)');

       DMConnect.zqbirds.ParamByName('acapacity').asstring :=DMConnect.RxAviary.FieldByName('Capacidade').asstring;
       DMConnect.zqbirds.ParamByName('aaviaryname').asstring :=DMConnect.RxAviary.FieldByName('Nome_Aviário').asstring;

       DMConnect.zqbirds.ParamByName('afarmid_Afk').asstring :=id;
       DMConnect.ZQBirds.ExecSQL;
       DMConnect.rxaviary.next;

       end
       else
       BEGIN
        DMConnect.zqbirds.sql.clear;

       DMConnect.zqbirds.sql.add('update aviary set'+
       ' aviaryname = '+QuotedStr(DBGridAviary.Columns[1].Field.text)+
       ', capacity = '+QuotedStr(DBGridAviary.Columns[2].Field.text)+
       ', farmid_afk = '+QuotedStr(id) +
       ' where aviaryid = '+ QuotedStr(DBGridAviary.Columns[0].Field.text));
       DMConnect.ZQBirds.ExecSQL;

       DMConnect.rxaviary.next;

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

procedure TFrmAviary.FormCreate(Sender: TObject);
begin
          DMConnect.ZQBirds.Close;
          DMConnect.ZQBirds.SQL.clear;
          DMConnect.ZQBirds.sql.add('select * from farms');
          DMConnect.ZQBirds.open;
          DMConnect.ZQBirds.first;
         while not  DMConnect.ZQBirds.eof do
           begin
             DBGridAviary.Columns[3].PickList.Add( DMConnect.ZQBirds.fieldbyname('farmid').asstring + '-'+DMConnect.ZQBirds.fieldbyname('farmname').asstring);


             DMConnect.ZQBirds.next;
           end;


      dmconnect.ZQBirds.close;
      DMConnect.ZQBirds.SQL.Clear;
      DMConnect.ZQBirds.sql.Add('select * from aviary'+
      ' INNER JOIN Farms ON FARMID = FARMID_AFK');
      DMConnect.ZQBirds.Open;
      DMConnect.RxAviary.close;
      DMConnect.RxAviary.Open;
  while not DMConnect.ZQBirds.EOF do
    begin
      dmconnect.RxAviary.Append;
      dmconnect.RxAviary.Fieldbyname('ID').asinteger:=DMConnect.ZQBirds.FieldByName('Aviaryid').asinteger;
      dmconnect.RxAviary.Fieldbyname('Nome_Aviário').asstring:=DMConnect.ZQBirds.FieldByName('Aviaryname').asstring;
      dmconnect.RxAviary.Fieldbyname('Capacidade').asstring:=DMConnect.ZQBirds.FieldByName('Capacity').asstring;
      dmconnect.RxAviary.Fieldbyname('Granja').asstring:=DMConnect.ZQBirds.FieldByName('farmid_AFK').asstring + '-'+
      DMConnect.ZQBirds.FieldByName('farmname').asstring;
      a:= dmconnect.RxAVIARY.Fieldbyname('ID').asinteger;
      dmconnect.RxAviary.Post;
      DMConnect.zqbirds.next;
    end;

end;

procedure TFrmAviary.DBNavigator1Click(Sender: TObject; Button: TDBNavButtonType
  );
begin
  case button of
   nbInsert:
     begin

     DBGridaviary.Columns[0].Field.text:='0';
     DBGridaviary.Columns[1].Field.FocusControl;
     end;
   nbPost:
       DMConnect.RxAVIARY.SortOnFields('ID');
   end;
end;

procedure TFrmAviary.DBGridAviaryKeyPress(Sender: TObject; var Key: char);
begin
  Key := AnsiUpperCase(Key)[1];
end;

procedure TFrmAviary.SpBtnCloseClick(Sender: TObject);
begin
  Close;
end;

end.

