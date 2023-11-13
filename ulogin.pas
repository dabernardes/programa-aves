unit uLogin;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons;

type

  { TFrmLogin }

  TFrmLogin = class(TForm)
    BtnLogin: TButton;
    EdtUser: TEdit;
    EdtPass: TEdit;
    LblTitle: TLabel;
    LblUser: TLabel;
    LblPass: TLabel;
    SpeedButton1: TSpeedButton;
    SpBtneyesO: TSpeedButton;
    SpBtneyesC: TSpeedButton;
    procedure BtnLoginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpBtneyesCClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpBtneyesOClick(Sender: TObject);
  private

  public
   function checklogin(const usuario, senha: String): Boolean;
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.lfm}
  uses udmconnect,umain;
{ TFrmLogin }

procedure TFrmLogin.SpeedButton1Click(Sender: TObject);
begin
  Application.terminate;
end;

procedure TFrmLogin.SpBtneyesOClick(Sender: TObject);
begin
  EdtPass.PasswordChar:= '*';
  SpBtneyesO.Visible:= false;
  SpBtneyesC.visible:= true;
end;

function TFrmLogin.checklogin(const usuario, senha: String): Boolean;
begin
  DMConnect.ZQBirds.Close;
  DMConnect.ZQBirds.sql.clear;
  DMConnect.ZQBirds.sql.add('SELECT COUNT(1) FROM users ' +
  ' WHERE email = :aemail and userpass = :auserpass');
  DMConnect.ZQBirds.ParamByName('aemail').asstring := EdtUser.text;
  DMConnect.ZQBirds.ParamByName('auserpass').asstring:= DMConnect.Encrypt(EdtPass.text,12,26,29);
 // DMConnect.ZQBirds.ParamByName('auserpass').asstring:= EdtPass.text;
  DMConnect.ZQBirds.Active:=true;
  DMConnect.ZQBirds.Open;
  Result := (  DMConnect.ZQBirds.Fields[0].AsInteger > 0);
end;

procedure TFrmLogin.SpBtneyesCClick(Sender: TObject);
begin
  edtpass.PasswordChar:=#0;
  SpBtneyesO.Visible:= true;
  SpBtneyesC.visible:= false;
end;

procedure TFrmLogin.BtnLoginClick(Sender: TObject);
begin


 try
    if edtuser.text = '' then
       begin
         messagedlg('O Campo "Email" deve ser preenchido!', mtinformation,[mbOK],0);
         EdtUser.setfocus;
         exit;
       end;
    if edtpass.text = '' then
       begin
         messagedlg('O Campo "Senha" deve ser preenchido!', mtinformation,[mbOK],0);
         edtpass.setfocus;
         exit;
       end;
    if checklogin(EdtUser.text,EdtPass.text) then
       begin
         frmmain:=tfrmmain.create(self);
         hide;
         frmmain.Show;
       end
    else
       begin
         showmessage('E-mail ou Senha invalido, tente novamente');
         EdtUser.text:='';
         edtpass.text:='';
         edtuser.SetFocus;
       end;
 finally
   freeandnil(frmlogin);
 end;

end;

procedure TFrmLogin.FormCreate(Sender: TObject);
begin
  EdtUser.text := 'douglas';
  EdtPass.text := 'douglas';
end;

end.

