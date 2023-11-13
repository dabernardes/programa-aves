unit uFarm;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  DBGrids, Buttons, DBCtrls, RTTIGrids, ZDataset, rxlookup, rxmemds,
  RxDBGridFooterTools;

type

  { TFrmFarm }

  TFrmFarm = class(TForm)
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    LblTitle1: TLabel;
    PnlFarm2: TPanel;
    PnlFarm3: TPanel;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    procedure DBNavigator1Click(Sender: TObject; Button: TDBNavButtonType);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
  private
    a:integer;
  public

  end;

var
  FrmFarm: TFrmFarm;

implementation

{$R *.lfm}
 uses udmconnect;
{ TFrmFarm }

procedure TFrmFarm.FormCreate(Sender: TObject);
begin
 //Carrega o combobox do grid com a o campo birdtype


         {zquery1.Close;
         zquery1.SQL.clear;
         zquery1.sql.add('select * from birds');
         zquery1.open;
         zquery1.first;
         while not zquery1.eof do
           begin
             DBGrid1.Columns[3].PickList.Add(zquery1.fieldbyname('birdtype').asstring);
             zquery1.next;
           end;}



      dmconnect.ZQBirds.close;
      DMConnect.ZQBirds.SQL.Clear;
      DMConnect.ZQBirds.sql.Add('select * from farms');
      DMConnect.ZQBirds.Open;
      DMConnect.Rxfarms.close;
      DMConnect.Rxfarms.Open;

  while not DMConnect.ZQBirds.EOF do
    begin

      dmconnect.Rxfarms.Append;
      dmconnect.Rxfarms.Fieldbyname('ID').asinteger:=DMConnect.ZQBirds.FieldByName('FarmID').asinteger;
      dmconnect.Rxfarms.Fieldbyname('Nome_Granja').asstring:=DMConnect.ZQBirds.FieldByName('FarmName').asstring;
      dmconnect.Rxfarms.Fieldbyname('Localizacao').asstring:=DMConnect.ZQBirds.FieldByName('Location').asstring;
      dmconnect.Rxfarms.Fieldbyname('Capacidade').asstring:=DMConnect.ZQBirds.FieldByName('capacity').asstring;
      //dmconnect.Rxfarms.Fieldbyname('Ave').asstring:=DMConnect.ZQBirds.FieldByName('birdtype').asstring;
      dmconnect.Rxfarms.Post;
      a:= dmconnect.Rxfarms.Fieldbyname('ID').asinteger;
      DMConnect.zqbirds.next;
    end;
end;

procedure TFrmFarm.DBNavigator1Click(Sender: TObject; Button: TDBNavButtonType);
begin
   case button of
   nbInsert:
     begin
     DBGrid1.Columns[0].Field.text:='0';
     end;
   nbPost:
       DMConnect.Rxfarms.SortOnFields('ID');
   end;

end;

procedure TFrmFarm.SpeedButton2Click(Sender: TObject);

begin
       DMConnect.ZConnectbirds.StartTransaction;
  try



     DMConnect.RxFarms.First;
    while not DMConnect.RxFarms.EOF do
     begin

       if DMConnect.rxfarms.FieldByName('ID').asinteger = 0 then
       begin
       DMConnect.zqbirds.sql.clear;
       DMConnect.zqbirds.sql.add('insert into farms');
       DMConnect.zqbirds.sql.add('(farmname,location,capacity)');
       DMConnect.zqbirds.sql.add('values');
       DMConnect.zqbirds.sql.add('( :afarmname,:alocation,:acapacity)');
       DMConnect.zqbirds.ParamByName('afarmname').asstring :=DMConnect.Rxfarms.FieldByName('Nome_Granja').asstring;
       DMConnect.zqbirds.ParamByName('alocation').asstring :=DMConnect.Rxfarms.FieldByName('Localizacao').asstring;
       DMConnect.zqbirds.ParamByName('acapacity').asstring :=DMConnect.Rxfarms.FieldByName('Capacidade').asstring;
       DMConnect.ZQBirds.ExecSQL;
       DMConnect.RxFarms.next;

       end
       else
       begin
        DMConnect.zqbirds.sql.clear;
        DMConnect.zqbirds.sql.add('update farms set'+
        ' farmname = '+QuotedStr(DBGrid1.Columns[1].field.text)+
        ', location = '+QuotedStr(DBGrid1.Columns[2].field.text)+
        ', capacity = '+QuotedStr(DBGrid1.Columns[3].field.text)+
        ' where farmid = '+ QuotedStr(DBGrid1.Columns[0].field.text));
        DMConnect.zqbirds.ExecSQL;
         DMConnect.RxFarms.next;
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

procedure TFrmFarm.SpeedButton3Click(Sender: TObject);
begin
      Close;
end;

procedure TFrmFarm.SpeedButton4Click(Sender: TObject);
begin
   DMConnect.RxFarms.delete;
end;

end.

