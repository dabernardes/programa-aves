unit uAddUser;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  DBGrids, Buttons, DBCtrls;

type

  { TFrmAddUser }

  TFrmAddUser = class(TForm)
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    LblTitle: TLabel;
    Panel2: TPanel;
    Panel4: TPanel;
    PnlUsers: TPanel;
    SpSave: TSpeedButton;
    SpClose: TSpeedButton;
    procedure BtnCloseClick(Sender: TObject);
    procedure DBNavigator1Click(Sender: TObject; Button: TDBNavButtonType);
    procedure FormCreate(Sender: TObject);
    procedure Panel3Click(Sender: TObject);
    procedure SpCloseClick(Sender: TObject);
    procedure SpSaveClick(Sender: TObject);
  private

  public

  end;

var
  FrmAddUser: TFrmAddUser;

implementation

{$R *.lfm}
 uses udmconnect;
{ TFrmAddUser }

procedure TFrmAddUser.FormCreate(Sender: TObject);
begin
  dmconnect.ZQBirds.close;
      DMConnect.ZQBirds.SQL.Clear;
      DMConnect.ZQBirds.sql.Add('select * from users');
      DMConnect.ZQBirds.Open;
  DMConnect.RxUsers.close;
  DMConnect.RxUsers.Open;
  while not DMConnect.ZQBirds.EOF do
    begin
      dmconnect.Rxusers.Append;
      dmconnect.Rxusers.Fieldbyname('ID').asinteger:=DMConnect.ZQBirds.FieldByName('UserId').asinteger;
      dmconnect.Rxusers.Fieldbyname('Nome').asstring:=DMConnect.ZQBirds.FieldByName('UserName').asstring;
      dmconnect.Rxusers.Fieldbyname('CPF').asinteger:=DMConnect.ZQBirds.FieldByName('CPF').asinteger;
      dmconnect.Rxusers.Fieldbyname('Email').asstring:=DMConnect.ZQBirds.FieldByName('Email').asstring;
      dmconnect.Rxusers.Fieldbyname('Senha').asstring:=DMConnect.ZQBirds.FieldByName('userpass').asstring;
      dmconnect.Rxusers.Fieldbyname('Status').asstring:=DMConnect.ZQBirds.FieldByName('userstatus').asstring;
      dmconnect.Rxusers.Post;
      DMConnect.ZQBirds.next;
    end;

end;

procedure TFrmAddUser.Panel3Click(Sender: TObject);
begin
  close;
end;

procedure TFrmAddUser.SpCloseClick(Sender: TObject);
begin
  close;
end;

procedure TFrmAddUser.SpSaveClick(Sender: TObject);
var
  a:string;
begin
  DMConnect.ZConnectbirds.StartTransaction;
  try


    DMConnect.RxUsers.First;
    while not DMConnect.RxUsers.EOF do
     begin
       if DMConnect.RxUsers.FieldByName('ID').asinteger = 0 then
       begin
       DMConnect.zqbirds.sql.clear;
       DMConnect.zqbirds.sql.add('insert into users');
       DMConnect.zqbirds.sql.add('(username,CPF,userpass,email,userstatus)');
       DMConnect.zqbirds.sql.add('values');
       DMConnect.zqbirds.sql.add('(:ausername, :aCPF, :auserpass, :aemail, :auserstatus)');
       DMConnect.zqbirds.ParamByName('ausername').asstring :=DMConnect.RxUsers.FieldByName('Nome').asstring;
       DMConnect.zqbirds.ParamByName('acpf').asstring :=DMConnect.RxUsers.FieldByName('CPF').asstring;
       DMConnect.zqbirds.ParamByName('auserpass').asstring :=DMConnect.Encrypt(DMConnect.RxUsers.FieldByName('Senha').asstring,12,26,29);
       DMConnect.zqbirds.ParamByName('aemail').asstring :=DMConnect.RxUsers.FieldByName('Email').asstring;
       DMConnect.zqbirds.ParamByName('auserstatus').asstring :=DMConnect.RxUsers.FieldByName('Status').asstring;
       dmconnect.ZQBirds.ExecSQL;
       dmconnect.RxUsers.next;

       end
       else
       begin
       DMConnect.zqbirds.sql.clear;
       DMConnect.zqbirds.sql.add('update users set');
       DMConnect.zqbirds.sql.add('username=:ausername,CPF=:acpf,userpass=:auserpass,email=:aemail,userstatus=:auserstatus'+
       ' where userid = '+ QuotedStr(DBGrid1.Columns[0].field.text));
       DMConnect.zqbirds.ParamByName('ausername').asstring :=DMConnect.RxUsers.FieldByName('Nome').asstring;
       DMConnect.zqbirds.ParamByName('acpf').asstring :=DMConnect.RxUsers.FieldByName('CPF').asstring;
       a:=Copy(DMConnect.RxUsers.FieldByName('Senha').asstring,1,1);
       if a = '\'then
       DMConnect.zqbirds.ParamByName('auserpass').asstring :=DMConnect.RxUsers.FieldByName('Senha').asstring
       else
       DMConnect.zqbirds.ParamByName('auserpass').asstring :=DMConnect.Encrypt(DMConnect.RxUsers.FieldByName('Senha').asstring,12,26,29);
       DMConnect.zqbirds.ParamByName('aemail').asstring :=DMConnect.RxUsers.FieldByName('Email').asstring;
       DMConnect.zqbirds.ParamByName('auserstatus').asstring :=DMConnect.RxUsers.FieldByName('Status').asstring;

       dmconnect.ZQBirds.ExecSQL;
       dmconnect.RxUsers.next;
       end;
     end;

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

procedure TFrmAddUser.BtnCloseClick(Sender: TObject);
begin
  close;
end;

procedure TFrmAddUser.DBNavigator1Click(Sender: TObject;
  Button: TDBNavButtonType);
begin
  case button of
   nbInsert:
     begin
     DBGrid1.Columns[0].Field.text:='0';
     DBGrid1.Columns[1].Field.FocusControl;
     end;
   nbPost:
       DMConnect.Rxfarms.SortOnFields('ID');

   end;
end;

end.

