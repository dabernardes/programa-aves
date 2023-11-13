unit uInputs;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  DBGrids, DBCtrls, Buttons;

type

  { TFrmInputs }

  TFrmInputs = class(TForm)
    DBGridInput: TDBGrid;
    DBNavInput: TDBNavigator;
    LblTitle: TLabel;
    PnlInput2: TPanel;
    PnlInput1: TPanel;
    SpBtnClose: TSpeedButton;
    SpBtnSave: TSpeedButton;
    procedure DBGridInputKeyPress(Sender: TObject; var Key: char);
    procedure DBNavInputClick(Sender: TObject; Button: TDBNavButtonType);
    procedure FormCreate(Sender: TObject);
    procedure SpBtnCloseClick(Sender: TObject);
    procedure SpBtnSaveClick(Sender: TObject);
  private
    a:integer;
  public

  end;

var
  FrmInputs: TFrmInputs;

implementation

{$R *.lfm}

{ TFrmInputs }
 uses udmconnect;
procedure TFrmInputs.SpBtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmInputs.SpBtnSaveClick(Sender: TObject);

begin
  DMConnect.ZConnectbirds.StartTransaction;
  try

    DMConnect.RxInput.First;

    while not DMConnect.RxInput.EOF do
     begin

       if DMConnect.RxInput.FieldByName('ID').asinteger = 0 then
         begin
           DMConnect.zqbirds.sql.clear;
           DMConnect.zqbirds.sql.add('insert into Inputs');
           DMConnect.zqbirds.sql.add('( inputtype, valor)');
           DMConnect.zqbirds.sql.add('values');
           DMConnect.zqbirds.sql.add('( :ainputtype, :avalor)');

           DMConnect.zqbirds.ParamByName('ainputtype').asstring :=DMConnect.RxInput.FieldByName('Tipo').asstring;
           DMConnect.zqbirds.ParamByName('avalor').asstring :=DMConnect.RxInput.FieldByName('Valor').asstring;
           DMConnect.ZQBirds.ExecSQL;
           DMConnect.RxInput.next;
         end
       else
        begin
          DMConnect.zqbirds.sql.clear;
          DMConnect.zqbirds.sql.add('Update inputs set'+
          ' inputtype = '+QuotedStr(DBGridInput.Columns[1].Field.text)+
          ', valor = '+QuotedStr(DBGridInput.Columns[2].Field.text)+
          ' where inputid = '+QuotedStr(DBGridInput.Columns[0].Field.text));
          DMConnect.ZQBirds.ExecSQL;

          DMConnect.RxInput.next;
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

procedure TFrmInputs.FormCreate(Sender: TObject);
begin
      dmconnect.ZQBirds.close;
      DMConnect.ZQBirds.SQL.Clear;
      DMConnect.ZQBirds.sql.Add('select * from inputs');
      DMConnect.ZQBirds.Open;
      DMConnect.Rxinput.close;
      DMConnect.Rxinput.open;
  while not DMConnect.ZQBirds.EOF do
    begin
      dmconnect.Rxinput.Append;
      dmconnect.Rxinput.Fieldbyname('ID').asinteger:=DMConnect.ZQBirds.FieldByName('inputid').asinteger;
      dmconnect.Rxinput.Fieldbyname('Tipo').asstring:=DMConnect.ZQBirds.FieldByName('Inputtype').asstring;
      dmconnect.Rxinput.Fieldbyname('Valor').asstring:=DMConnect.ZQBirds.FieldByName('Valor').asstring;
      a:= dmconnect.Rxinput.Fieldbyname('ID').asinteger;
      dmconnect.Rxinput.Post;
      DMConnect.zqbirds.next;
    end;
end;

procedure TFrmInputs.DBNavInputClick(Sender: TObject; Button: TDBNavButtonType);
begin
   case button of
   nbInsert:
     begin

     DBGridinput.Columns[0].Field.text:='0';
     DBGridinput.Columns[1].Field.FocusControl;
     end;
   nbPost:
       DMConnect.Rxinput.SortOnFields('ID');
   end;
end;

procedure TFrmInputs.DBGridInputKeyPress(Sender: TObject; var Key: char);
begin
  Key := AnsiUpperCase(Key)[1];
end;

end.

