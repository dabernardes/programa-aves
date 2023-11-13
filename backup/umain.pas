unit uMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls,
  StdCtrls;

type

  { TFrmMain }

  TFrmMain = class(TForm)
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MIIsumos: TMenuItem;
    MIAviary: TMenuItem;
    MItmGranjas: TMenuItem;
    MMenu: TMainMenu;
    MIRels: TMenuItem;
    MILots: TMenuItem;
    MICadastro: TMenuItem;
    MIAddUser: TMenuItem;
    PnlInf: TPanel;
    PnlMain: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MIIsumosClick(Sender: TObject);
    procedure MIAviaryClick(Sender: TObject);
    procedure MIAddUserClick(Sender: TObject);
    procedure MILotsClick(Sender: TObject);
    procedure MItmGranjasClick(Sender: TObject);
  private

  public

  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.lfm}
 uses ulogin,uadduser,ubirds,ufarm,udmconnect,uaviary,uinputs,ulot,uactivity,utimeline,uclose,
   urels1,urel2,urel3;

 { TFrmMain }

 procedure TFrmMain.MIAddUserClick(Sender: TObject);
 begin
    frmadduser:=tfrmadduser.create(pnlmain);
    frmadduser.parent:=pnlmain;
    frmadduser.Left   := 0;
    frmadduser.Top    := 0;
    frmadduser.Height := pnlmain.Height;
    frmadduser.Width  := pnlmain.Width;
    frmadduser.show;
 end;

procedure TFrmMain.MIAviaryClick(Sender: TObject);
begin
    frmaviary:=tfrmaviary.create(pnlmain);
    frmaviary.parent:=pnlmain;
    frmaviary.Left   := 0;
    frmaviary.Top    := 0;
    frmaviary.Height := pnlmain.Height;
    frmaviary.Width  := pnlmain.Width;
    frmaviary.show;
end;

procedure TFrmMain.MIIsumosClick(Sender: TObject);
begin
    frminputs:=tfrminputs.create(pnlmain);
    frminputs.parent:=pnlmain;
    frminputs.Left   := 0;
    frminputs.Top    := 0;
    frminputs.Height := pnlmain.Height;
    frminputs.Width  := pnlmain.Width;
    frminputs.show;
end;

procedure TFrmMain.MenuItem1Click(Sender: TObject);
begin
    frmlot:=tfrmlot.create(pnlmain);
    frmlot.parent:=pnlmain;
    frmlot.Left   := 0;
    frmlot.Top    := 0;
    frmlot.Height := pnlmain.Height;
    frmlot.Width  := pnlmain.Width;
    frmlot.show;
end;

procedure TFrmMain.Button1Click(Sender: TObject);
begin
     DMConnect.ZQBirds.Close;
      DMConnect.ZQBirds.sql.clear;
      DMConnect.ZQBirds.SQL.add('select max(timelinewight)as peso from timeline where lotid_fk = 6');
      DMConnect.ZQBirds.Open;
      showmessage(DMConnect.ZQBirds.FieldByName('peso').asstring)
end;

procedure TFrmMain.MenuItem3Click(Sender: TObject);
begin
    frmTimeline:=tfrmTimeline.create(pnlmain);
    frmTimeline.parent:=pnlmain;
    frmTimeline.Left   := 0;
    frmTimeline.Top    := 0;
    frmTimeline.Height := pnlmain.Height;
    frmTimeline.Width  := pnlmain.Width;
    frmTimeline.show;
end;

procedure TFrmMain.MenuItem4Click(Sender: TObject);
begin
    frmActivity:=TfrmActivity.create(pnlmain);
    frmActivity.parent:=pnlmain;
    frmActivity.Left   := 0;
    frmActivity.Top    := 0;
    frmActivity.Height := pnlmain.Height;
    frmActivity.Width  := pnlmain.Width;
    frmActivity.show;
end;

procedure TFrmMain.MenuItem5Click(Sender: TObject);
begin
     frmclose:=tfrmclose.create(pnlmain);
    frmclose.parent:=pnlmain;
    frmclose.Left   := 0;
    frmclose.Top    := 0;
    frmclose.Height := pnlmain.Height;
    frmclose.Width  := pnlmain.Width;
    frmclose.show;
end;

procedure TFrmMain.MenuItem6Click(Sender: TObject);
begin
    frmrel1:=tfrmrel1.create(pnlmain);
    frmrel1.parent:=pnlmain;
    frmrel1.Left   := 0;
    frmrel1.Top    := 0;
    frmrel1.Height := pnlmain.Height;
    frmrel1.Width  := pnlmain.Width;
    frmrel1.show;
end;

procedure TFrmMain.MenuItem7Click(Sender: TObject);
begin
   frmrel2:=tfrmrel2.create(pnlmain);
    frmrel2.parent:=pnlmain;
    frmrel2.Left   := 0;
    frmrel2.Top    := 0;
    frmrel2.Height := pnlmain.Height;
    frmrel2.Width  := pnlmain.Width;
    frmrel2.show;
end;

procedure TFrmMain.MenuItem8Click(Sender: TObject);
begin
   frmrel3:=tfrmrel3.create(pnlmain);
    frmrel3.parent:=pnlmain;
    frmrel3.Left   := 0;
    frmrel3.Top    := 0;
    frmrel3.Height := pnlmain.Height;
    frmrel3.Width  := pnlmain.Width;
    frmrel3.show;
end;

procedure TFrmMain.MILotsClick(Sender: TObject);
begin
    frmbirds:=tfrmbirds.create(pnlmain);
    frmbirds.parent:=pnlmain;
    frmbirds.Left   := 0;
    frmbirds.Top    := 0;
    frmbirds.Height := pnlmain.Height;
    frmbirds.Width  := pnlmain.Width;
    frmbirds.show;
end;

procedure TFrmMain.MItmGranjasClick(Sender: TObject);
begin
    frmfarm:=tfrmfarm.create(pnlmain);
    frmfarm.parent:=pnlmain;
    frmfarm.Left   := 0;
    frmfarm.Top    := 0;
    frmfarm.Height := pnlmain.Height;
    frmfarm.Width  := pnlmain.Width;
    frmfarm.show;
end;

end.

