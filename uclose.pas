unit uClose;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  DBGrids, ExtCtrls, LR_Class, LR_DBSet, ZDataset,DateUtils;

type

  { TFrmclose }

  TFrmclose = class(TForm)
    Button1: TButton;
    Button2: TButton;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DBLookupComboBox1: TDBLookupComboBox;
    frDBDataSet1: TfrDBDataSet;
    frReport1: TfrReport;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label3: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Lbltitulo: TLabel;
    LblIDLote: TLabel;
    Lblvlridlote: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    ZQuery1: TZQuery;
    ZQuery2: TZQuery;
    ZQuery3: TZQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DBLookupComboBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Frmclose: TFrmclose;

implementation

{$R *.lfm}
 uses uDMConnect;
{ TFrmclose }

procedure TFrmclose.DBLookupComboBox1Change(Sender: TObject);
var
  vlrM,vlrl,vlrd:integer;
  tipoM,TIPOALIMENTO:string;
  VLRALIMENTO,vlrmedicacao:double;
  dat1,dat2:tDatetime;
begin
  vlrM:=0;
  vlrl:=0;
  vlrd:=0;
  tipoM:='';
  tipoalimento:='';
  vlralimento:=0;
  vlrmedicacao:=0;
  ZQuery1.Close;
  zquery1.SQL.clear;
  zquery1.sql.add('select * from timeline'+
  ' inner join aviary on aviary.aviaryid = timeline.aviaryid_fk'+
      ' inner join lots on lots.lotid = timeline.lotid_fk'+
      ' inner join inputs on inputs.inputid = timeline.inputid_fk'+
      ' inner join farms on farms.farmid = timeline.farmid_fk'+
      ' inner join birds on birds.birdid = timeline.birdid_fk'+
      ' inner join activity on activityid = timeline.activityid_fk'+
      ' where timeline.lotid_fk = '+ QuotedStr(DBLookupComboBox1.Caption));
  zquery1.open;
  Lblvlridlote.caption:=zquery1.FieldByName('lotid_fk').Asstring;
  label14.caption:=zquery1.FieldByName('timelinedate').Asstring;
  label4.caption:=zquery1.FieldByName('birdtype').asstring;
  label26.caption:=zquery1.FieldByName('weightfull').asstring;
  label3.caption:=zquery1.FieldByName('farmname').asstring;
  label8.caption:=zquery1.FieldByName('aviaryname').asstring;
  label10.caption:=zquery1.FieldByName('qnt').asstring;
  dat1:= zquery1.FieldByName('timelinedate').Asdatetime;
  label28.caption:=zquery1.FieldByName('timelinewight').Asstring;
  label30.caption:=inttostr(DaysBetween(now,dat1 ));
  while not zquery1.eof do
      begin
      vlrM:=vlrM+ zquery1.FieldByName('mortality').Asinteger;
      vlrd:=vlrd+ zquery1.FieldByName('timelinevalue').Asinteger;

      zquery1.next
      end;
    label1.caption:=inttostr(vlrm);
    vlrl:= zquery1.FieldByName('lotqnt').Asinteger - vlrm;
    label2.caption:=inttostr(vlrl);
    label16.caption:=inttostr(vlrd);

    zquery1.close;
    zquery1.SQL.clear;
    zquery1.SQL.Add('select * from timeline '+
    ' inner join inputs on inputid =inputid_fk'+
    ' inner join activity on activityid = activityid_fk '+
    ' where activitytype = '+QuotedStr('MEDICACAO')+' ANd lotid_fk = '+
    QuotedStr(DBLookupComboBox1.caption));
    zquery1.Open;
     while not zquery1.eof do
      begin
     tipom:=tipoM + zquery1.FieldByName('inputtype').Asstring + ', ';
     vlrmedicacao:=vlrmedicacao + zquery1.FieldByName('timelinevalue').Asfloat;
      zquery1.next
      end;

    label18.caption:=tipom;
    label20.caption:=floattostr(vlrmedicacao);

     zquery1.close;
    zquery1.SQL.clear;
    zquery1.SQL.Add('select * from timeline '+
    ' inner join inputs on inputid =inputid_fk'+
    ' inner join activity on activityid = activityid_fk '+
    ' where activitytype = '+QuotedStr('ALIMENTO')+' ANd lotid_fk = '+
    QuotedStr(DBLookupComboBox1.caption));
    zquery1.Open;
     while not zquery1.eof do
      begin
        TIPOALIMENTO:=tipoALIMENTO + zquery1.FieldByName('inputtype').Asstring + ', ';
        vlrALIMENTO:=vlrALIMENTO + zquery1.FieldByName('timelinevalue').Asfloat;
        zquery1.next
      end;
    label22.caption:=TIPOALIMENTO;

    label24.caption:=floattostr(vlrALIMENTO);
    panel3.Visible:=true;

end;

procedure TFrmclose.FormCreate(Sender: TObject);
begin
    ZQuery1.active:=true;
    ZQuery2.active:=true;
    ZQuery3.active:=true;

end;

procedure TFrmclose.Button1Click(Sender: TObject);
var
  idgranja,idaviario,idaves:integer;
  peso:double;
begin
  DMConnect.ZConnectbirds.StartTransaction;
  try
    zquery1.Close;
  zquery1.SQL.clear;
  zquery1.sql.add('select * from timeline'+
  ' inner join aviary on aviary.aviaryid = timeline.aviaryid_fk'+
      ' inner join lots on lots.lotid = timeline.lotid_fk'+
      ' inner join inputs on inputs.inputid = timeline.inputid_fk'+
      ' inner join farms on farms.farmid = timeline.farmid_fk'+
      ' inner join birds on birds.birdid = timeline.birdid_fk'+
      ' inner join activity on activityid = timeline.activityid_fk'+
      ' where timeline.lotid_fk = '+ QuotedStr(DBLookupComboBox1.Caption));
  zquery1.open;
       idgranja:=zquery1.FieldByName('farmid').asinteger;
       idaviario:=zquery1.FieldByName('aviaryid').asinteger;
       idaves:=zquery1.FieldByName('birdid').asinteger;
       peso:=zquery1.FieldByName('timelinewight').asinteger;
  zquery1.Close;
  zquery1.sql.clear;
  zquery1.sql.add('select * from historic');
   zquery1.open;
  zquery1.sql.clear;
  zquery1.sql.Add('insert into historic'+
  '(lotid,lotqnt,closedate,farmid,aviaryid,mortality,weight,allvalue,'+
  'age,medicinetype,medicinevalue,foodtype,foodvalue,birdid)');
  zquery1.sql.Add('values');
  zquery1.sql.Add('(:alotid,:alotqnt,:aclosedate,:afarmid,:aaviaryid,:amortality,:aweight,:aallvalue,'+
  ':aage,:amedicinetype,:amedicinevalue,:afoodtype,:afoodvalue,:abirdid)');
   zquery1.ParamByName('alotid').asstring:=Lblvlridlote.caption;
   zquery1.ParamByName('alotqnt').asstring:=Label10.caption;
   zquery1.ParamByName('aclosedate').asstring:=datetostr(now);
   zquery1.ParamByName('afarmid').asstring:=inttostr(idgranja);
   zquery1.ParamByName('aaviaryid').asstring:=inttostr(idaviario);
   zquery1.ParamByName('amortality').asstring:=Label1.caption;
   zquery1.ParamByName('aweight').asstring:=floattostr(peso);
   zquery1.ParamByName('aallvalue').asstring:=Label16.caption;
   zquery1.ParamByName('aage').asstring:=Label30.caption;
   zquery1.ParamByName('amedicinetype').asstring:=Label18.caption;
   zquery1.ParamByName('amedicinevalue').asstring:=Label20.caption;
   zquery1.ParamByName('afoodtype').asstring:=Label22.caption;
   zquery1.ParamByName('afoodvalue').asstring:=Label28.caption;
   zquery1.ParamByName('abirdid').asinteger:=idaves;
   zquery1.ExecSQL;

    zquery1.sql.clear;
    zquery1.SQL.add('update lots set status = '+QuotedStr('FECHADO')+
    ' where lotid = '+QuotedStr(DBLookupComboBox1.caption));
    zquery1.ExecSQL;
    showmessage('Salvo com sucesso');

    DMConnect.ZConnectbirds.Commit;
    zquery3.Close;
    zquery3.sql.clear;
    zquery3.sql.Add('select * from historic'+
    ' inner join farms on historic.farmid = farms.farmid'+
    ' inner join aviary on aviary.aviaryid = historic.aviaryid'+
    ' inner join birds on birds.birdid= historic.birdid'+
    ' where lotid = '+QuotedStr(DBLookupComboBox1.caption));
     zquery3.open;
    frReport1.ShowReport;
  except
    on E:Exception do
  begin
   showmessage('Ocorreu um erro'+e.Message);
   DMConnect.ZConnectbirds.Rollback;
  end;
  end;
end;

procedure TFrmclose.Button2Click(Sender: TObject);
begin
  close;
end;

end.

