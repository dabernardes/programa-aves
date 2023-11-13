unit Urels1;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBCtrls, StdCtrls,
  ZDataset;

type

  { TFrmRel1 }

  TFrmRel1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    DSRel1: TDataSource;
    DTComboBox: TDataSource;
    DBLookupComboBox1: TDBLookupComboBox;
    Label1: TLabel;
    ZQcombobox: TZQuery;
    ZQrel1: TZQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  FrmRel1: TFrmRel1;

implementation

{$R *.lfm}
 uses uRelatorio;
{ TFrmRel1 }

procedure TFrmRel1.Button1Click(Sender: TObject);


begin

   frmrelatorio:=tfrmrelatorio.Create(self);


   try

     ZQrel1.close;
     ZQrel1.SQL.clear;
     ZQrel1.sql.Add('Select * from Historic'+
     ' where historic.lotid = '+QuotedStr(DBLookupComboBox1.Caption)+
     ' order by historic.lotid');
     ZQrel1.open;


  frmrelatorio.RLReport1.Preview();


   finally
     frmrelatorio.free
   end;


end;

procedure TFrmRel1.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TFrmRel1.FormCreate(Sender: TObject);
begin
  ZQcombobox.Active:=true;
end;

end.

