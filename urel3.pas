unit uRel3;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBCtrls, StdCtrls,
  ZDataset;

type

  { TFrmRel3 }

  TFrmRel3 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DBLookupComboBox1: TDBLookupComboBox;
    Label1: TLabel;
    ZQuery1: TZQuery;
    ZQuery2: TZQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

  public

  end;

var
  FrmRel3: TFrmRel3;

implementation

{$R *.lfm}
  uses urelatiorio3;
{ TFrmRel3 }

procedure TFrmRel3.Button1Click(Sender: TObject);
begin

   frmrelatorio3:=tfrmrelatorio3.Create(self);
   try
    if DBLookupComboBox1.caption = '' then
     frmrelatorio3.RLReport1.Preview()
    else
      begin
        ZQuery2.Close;
        ZQuery2.SQL.clear;
        ZQuery2.sql.add('select  (timeline.timelinedate - lots.lotdate)as idade,lotid,mortality,status'+
        ' from  timeline inner join lots on lotid = lotid_fk '+
        ' where lotid_fk = '+QuotedStr(DBLookupComboBox1.Keyvalue)+
        ' and mortality > 0 order by lotid');
        ZQuery2.open;
        frmrelatorio3.RLReport1.Preview();
      end;


   finally
     frmrelatorio3.free;
   end;
end;

procedure TFrmRel3.Button2Click(Sender: TObject);
begin
  close;
end;


end.

