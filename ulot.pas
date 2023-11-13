unit uLot;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  DBGrids, DBCtrls, Buttons, EditBtn, DBDateTimePicker, DateTimePicker, Grids,db;

type

  { TFrmLot }

  TFrmLot = class(TForm)
    DateTimePicker1: TDateTimePicker;
    DBGridlot: TDBGrid;
    DBNavLot: TDBNavigator;
    LblTitle: TLabel;
    PnlLot1: TPanel;
    Pnllot2: TPanel;
    SpBtnSave: TSpeedButton;
    SpBtnClose: TSpeedButton;



    procedure DateTimePicker1Change(Sender: TObject);
    procedure DateTimePicker1Exit(Sender: TObject);
    procedure DBGridlotCellClick(Column: TColumn);
    procedure DBGridlotColExit(Sender: TObject);
    procedure DBGridlotDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGridlotKeyPress(Sender: TObject; var Key: char);
    procedure DBNavLotClick(Sender: TObject; Button: TDBNavButtonType);
    procedure FormCreate(Sender: TObject);
    procedure SpBtnCloseClick(Sender: TObject);
    procedure SpBtnSaveClick(Sender: TObject);
  private
    a:integer;
  public

  end;

var
  FrmLot: TFrmLot;

implementation

{$R *.lfm}
  uses udmconnect;
{ TFrmLot }

procedure TFrmLot.SpBtnCloseClick(Sender: TObject);
begin
  close;
end;

procedure TFrmLot.SpBtnSaveClick(Sender: TObject);
var
  idave,idlote: string;

begin
    DMConnect.ZConnectbirds.StartTransaction;
  try

     DMConnect.Rxlot.First;

    while not DMConnect.Rxlot.EOF do
     begin
      idave:=copy(DMConnect.RxLot.FieldByName('Ave').asstring,0,(pos('-',DMConnect.RxLot.FieldByName('Ave').asstring)-1));
      idlote:=copy(DMConnect.RxLot.FieldByName('Aviario').asstring,0,(pos('-',DMConnect.RxLot.FieldByName('Aviario').asstring)-1));

       if DMConnect.RxLot.FieldByName('ID').asinteger = 0 then
       begin
       DMConnect.zqbirds.sql.clear;
       DMConnect.zqbirds.sql.add('insert into lots');
       DMConnect.zqbirds.sql.add('(lotdate, qnt,birdid_fk, aviaryid_fk, weight , weightfull,status)');
       DMConnect.zqbirds.sql.add('values');
       DMConnect.zqbirds.sql.add('(:alotdate, :aqnt, :abirdid_fk, :aaviaryid_fk, :aweight, :aweightfull,:astatus)');

       DMConnect.zqbirds.ParamByName('alotdate').asstring:=DMConnect.RxLot.FieldByName('Data_Entrada').asstring;
       DMConnect.zqbirds.ParamByName('aqnt').asstring :=DMConnect.RxLot.FieldByName('Quantidade').asstring;

       DMConnect.zqbirds.ParamByName('abirdid_fk').asstring :=idave;

       DMConnect.zqbirds.ParamByName('aaviaryid_fk').asstring :=idlote;
       DMConnect.zqbirds.ParamByName('aweight').asstring:=DMConnect.RxLot.FieldByName('Peso (Medio)').asstring;
       DMConnect.zqbirds.ParamByName('aweightfull').asstring:=DMConnect.RxLot.FieldByName('Peso (Total)').asstring;
       DMConnect.zqbirds.ParamByName('astatus').asstring:='ABERTO';
       DMConnect.ZQBirds.ExecSQL;
       DMConnect.Rxlot.next;

       end
       else
        begin
         DMConnect.zqbirds.sql.clear;
         DMConnect.zqbirds.sql.add('update lots set'+
         ' lotdate = '+ QuotedStr(DBGridlot.Columns[1].Field.text)+
         ', qnt = '+ QuotedStr(DBGridlot.Columns[2].Field.text)+
         ', aviaryid_fk = '+QuotedStr(idlote) +
         ', birdid_fk = '+QuotedStr(idave) +
         ', weight = '+ QuotedStr(DBGridlot.Columns[5].Field.text)+
         ', weightfull = '+ QuotedStr(DBGridlot.Columns[6].Field.text)+
         'where lotid = '+  QuotedStr(DBGridlot.Columns[0].Field.text));
         DMConnect.ZQBirds.ExecSQL;

       DMConnect.Rxlot.next;
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

procedure TFrmLot.FormCreate(Sender: TObject);
begin


          DMConnect.ZQBirds.Close;
          DMConnect.ZQBirds.SQL.clear;
          DMConnect.ZQBirds.sql.add('select * from birds');
          DMConnect.ZQBirds.open;
          DMConnect.ZQBirds.first;
         while not  DMConnect.ZQBirds.eof do
           begin
             DBGridlot.Columns[4].PickList.Add( DMConnect.ZQBirds.fieldbyname('birdid').asstring + '-'+DMConnect.ZQBirds.fieldbyname('birdtype').asstring);
             DMConnect.ZQBirds.next;
           end;

          DMConnect.ZQBirds.Close;
          DMConnect.ZQBirds.SQL.clear;
          DMConnect.ZQBirds.sql.add('select * from aviary');
          DMConnect.ZQBirds.open;
          DMConnect.ZQBirds.first;
         while not  DMConnect.ZQBirds.eof do
           begin
             DBGridlot.Columns[3].PickList.Add( DMConnect.ZQBirds.fieldbyname('aviaryid').asstring + '-'+DMConnect.ZQBirds.fieldbyname('aviaryname').asstring);
             DMConnect.ZQBirds.next;
           end;

      dmconnect.ZQBirds.close;
      DMConnect.ZQBirds.SQL.Clear;
      DMConnect.ZQBirds.sql.Add('select * from lots'+
      ' inner join aviary on aviaryid = aviaryid_fk'+
      ' inner join birds on birdid = birdid_fk');
      DMConnect.ZQBirds.Open;
      DMConnect.Rxlot.close;
      DMConnect.Rxlot.open;
  while not DMConnect.ZQBirds.EOF do
    begin
      dmconnect.Rxlot.Append;
      dmconnect.Rxlot.Fieldbyname('ID').asinteger:=DMConnect.ZQBirds.FieldByName('lotid').asinteger;
      dmconnect.Rxlot.Fieldbyname('Data_entrada').asstring:=DMConnect.ZQBirds.FieldByName('lotdate').asstring;
      dmconnect.Rxlot.Fieldbyname('Aviario').asstring:=DMConnect.ZQBirds.FieldByName('aviaryid_fk').asstring +'-'+
      DMConnect.ZQBirds.FieldByName('aviaryname').asstring;
      dmconnect.Rxlot.Fieldbyname('Quantidade').asstring:=DMConnect.ZQBirds.FieldByName('qnt').asstring;
      dmconnect.Rxlot.Fieldbyname('Ave').asstring:=DMConnect.ZQBirds.FieldByName('birdid_fk').asstring +'-'+
      DMConnect.ZQBirds.FieldByName('birdtype').asstring;
      dmconnect.Rxlot.Fieldbyname('Peso (Medio)').asstring:=DMConnect.ZQBirds.FieldByName('weight').asstring;
      dmconnect.Rxlot.Fieldbyname('Peso (Total)').asstring:=DMConnect.ZQBirds.FieldByName('weightfull').asstring;
      dmconnect.Rxlot.Fieldbyname('Status').asstring:=DMConnect.ZQBirds.FieldByName('Status').asstring;
      dmconnect.Rxlot.Post;
      DMConnect.zqbirds.next;
    end;

    dmconnect.RxLot.Edit;
end;

procedure TFrmLot.DateTimePicker1Change(Sender: TObject);
begin
    if dmconnect.RxLot.state in dsEditModes then
    begin
    DMConnect.RxLot.FieldByName('Data_entrada').asdatetime:= DateTimePicker1.Date;
    dmconnect.rxlot.post;
    end;

end;

procedure TFrmLot.DateTimePicker1Exit(Sender: TObject);
begin
   DBGridlot.SetFocus;
end;

procedure TFrmLot.DBGridlotCellClick(Column: TColumn);
var
x, y,total:double;
begin
  if  (Column.field.FieldName = 'Peso (Total)') then
  begin
  x:=strtoint(DBGridlot.Columns[2].Field.Text);
  y:=StrToFloat(DBGridlot.Columns[6].Field.Text);
  total:= (y/x);
  DBGridlot.Columns[5].Field.Text:=FloatToStr(total);
  end;
end;

procedure TFrmLot.DBGridlotColExit(Sender: TObject);
begin
  if DBGridlot.SelectedField.FieldName = 'Data_entrada' then
    DateTimePicker1.Visible := False;
end;

procedure TFrmLot.DBGridlotDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);

begin
   if (gdFocused in State) then
  begin

    if (Column.Field.FieldName = 'Data_entrada') then
      with DateTimePicker1 do
      begin
        Left := Rect.Left + DBGridlot.Left + 1;
        Top := Rect.Top + DBGridlot.Top + 1;
        Width := Rect.Right - Rect.Left + 2;
        Width := Rect.Right - Rect.Left + 2;
        Height := Rect.Bottom - Rect.Top + 2;

        Visible := True;
      end;
  end;



end;

procedure TFrmLot.DBGridlotKeyPress(Sender: TObject; var Key: char);
begin
   Key := AnsiUpperCase(Key)[1];
   if (Key = Chr(9)) then
    Exit;

  { Seta os eventos de key press do dbgrid para o DateTimePicker1 }
  if (DBGridlot.SelectedField.FieldName = 'Data_entrada') then
  begin
    DateTimePicker1.SetFocus;
    //SendMessage(DateTimePicker1.Handle, WM_Char, word(Key), 0);
  end;
end;

procedure TFrmLot.DBNavLotClick(Sender: TObject; Button: TDBNavButtonType);
begin
  case button of
   nbInsert:
     begin

     DBGridlot.Columns[0].Field.text:='0';
     DBGridlot.Columns[1].Field.FocusControl;
     DBGridlot.Columns[6].Field.text:='0' ;
     DBGridlot.Columns[5].Field.text:='0' ;
     DBGridlot.Columns[2].Field.text:='0' ;
     end;
   nbPost:
       DMConnect.Rxlot.SortOnFields('ID');
   end;
end;

end.

