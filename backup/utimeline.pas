unit uTimeline;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, BufDataset, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, DBGrids, DBCtrls, Buttons, DateTimePicker, rxmemds,
  ZDataset, Grids ;

type

  { TFrmTimeline }

  TFrmTimeline = class(TForm)
    Button1: TButton;
    DataSource1: TDataSource;
    DateTimePicker2: TDateTimePicker;
    DBGridTimeline: TDBGrid;
    DBLookupComboBox1: TDBLookupComboBox;
    DBNavTimeline: TDBNavigator;
    Label6: TLabel;
    LblTitle: TLabel;
    Panel2: TPanel;
    PnlActivity1: TPanel;
    PnlActivity3: TPanel;
    SpBtnClose: TSpeedButton;
    SpBtnSave: TSpeedButton;
    ZQuery1: TZQuery;
    procedure Button1Click(Sender: TObject);
    procedure DateTimePicker2Change(Sender: TObject);
    procedure DateTimePicker2Exit(Sender: TObject);
    procedure DBGridTimelineCellClick(Column: TColumn);
    procedure DBGridTimelineColExit(Sender: TObject);
    procedure DBGridTimelineDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGridTimelineKeyPress(Sender: TObject; var Key: char);
    procedure DBGridTimelineTitleClick(Column: TColumn);
    procedure DBNavTimelineClick(Sender: TObject; Button: TDBNavButtonType);
    procedure FormCreate(Sender: TObject);
    procedure SpBtnCloseClick(Sender: TObject);
    procedure SpBtnSaveClick(Sender: TObject);
  private
     id,a:integer;
  public

  end;

var
  FrmTimeline: TFrmTimeline;

implementation

{$R *.lfm}
  uses udmconnect;
{ TFrmTimeline }

procedure TFrmTimeline.SpBtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmTimeline.SpBtnSaveClick(Sender: TObject);
var

  idave,idlote,idgranja,idinsumo,idmovimento:string;
begin

   DMConnect.ZConnectbirds.StartTransaction;
  try
     DMConnect.ZQBirds.close;
     DMConnect.ZQBirds.SQL.Clear;
      DMConnect.ZQBirds.SQL.add('select * from timeline');
       DMConnect.ZQBirds.open;


     DMConnect.Rxtimeline.First;


    while not DMConnect.Rxtimeline.EOF do
     begin

      if DMConnect.RxTimeline.FieldByName('ID').asinteger = 0 then
      begin
       DMConnect.zqbirds.sql.clear;
       DMConnect.zqbirds.sql.add('insert into timeline');
       DMConnect.zqbirds.sql.add('(activityid_fk, lotid_fk, lotqnt, timelinedate, birdid_fk, farmid_fk, aviaryid_fk, mortality, timelinevalue, timelinewight, inputid_fk, timelineqnt, other )');
       DMConnect.zqbirds.sql.add('values');
       DMConnect.zqbirds.sql.add('(:aactivityid_fk, :alotid_fk, :alotqnt, :atimelinedate, :abirdid_fk, :afarmid_fk, :aaviaryid_fk, :amortality, :atimelinevalue, :atimelinewight, :ainputid_fk, :atimelineqnt, :aother )');
     idmovimento:=copy(DMConnect.Rxtimeline.FieldByName('Tipo_Movimento').asstring,0,(pos('-',DMConnect.Rxtimeline.FieldByName('Tipo_Movimento').asstring)-1));
     idave:=copy(DMConnect.rxtimeline.FieldByName('Ave').asstring,0,(pos('-',DMConnect.Rxtimeline.FieldByName('Ave').asstring)-1));
     idlote:=copy(DMConnect.Rxtimeline.FieldByName('Aviario').asstring,0,(pos('-',DMConnect.Rxtimeline.FieldByName('Aviario').asstring)-1));
     idgranja:=copy(DMConnect.Rxtimeline.FieldByName('Granja').asstring,0,(pos('-',DMConnect.Rxtimeline.FieldByName('Granja').asstring)-1));
     idinsumo:=copy(DMConnect.Rxtimeline.FieldByName('Insumo').asstring,0,(pos('-',DMConnect.Rxtimeline.FieldByName('Insumo').asstring)-1));



       DMConnect.zqbirds.ParamByName('aactivityid_fk').asstring :=idmovimento;

       DMConnect.zqbirds.ParamByName('alotid_fk').asstring :=DMConnect.Rxtimeline.FieldByName('NumeroLote').asstring;
       DMConnect.zqbirds.ParamByName('alotqnt').asstring :=DMConnect.Rxtimeline.FieldByName('qnt_Lote').asstring;
       DMConnect.zqbirds.ParamByName('atimelinedate').asstring :=DMConnect.rxtimeline.FieldByName('Data').asstring;

       DMConnect.zqbirds.ParamByName('abirdid_fk').asstring :=idave;


       DMConnect.zqbirds.ParamByName('aaviaryid_fk').asstring :=idlote;


       DMConnect.zqbirds.ParamByName('afarmid_fk').asstring :=idgranja;

       DMConnect.zqbirds.ParamByName('aMortality').asstring:=DMConnect.Rxtimeline.FieldByName('Mortality').asstring;
       DMConnect.zqbirds.ParamByName('atimelinevalue').asstring:=DMConnect.Rxtimeline.FieldByName('Valor').asstring;
       DMConnect.zqbirds.ParamByName('atimelinewight').asstring:=DMConnect.Rxtimeline.FieldByName('Peso').asstring;


       DMConnect.zqbirds.ParamByName('ainputid_fk').asstring :=idinsumo;

       DMConnect.zqbirds.ParamByName('atimelineqnt').asstring:=DMConnect.Rxtimeline.FieldByName('Qnt_Insumo').asstring;
       //DMConnect.zqbirds.ParamByName('aother').asstring:='ABERTO';
       DMConnect.ZQBirds.ExecSQL;
       DMConnect.Rxtimeline.next;

      end
       else
       begin
         DMConnect.zqbirds.sql.clear;
         DMConnect.zqbirds.sql.add('update timeline set'+
         ' activityid_fk = '+QuotedStr(idmovimento)+
         ', lotid_fk = '+  QuotedStr(DBGridTimeline.Columns[2].field.Text)+
         ', lotqnt = '+  Quotedstr(DBGridTimeline.Columns[3].field.Text)+
         ', timelinedate = '+  Quotedstr(DBGridTimeline.Columns[4].field.Text)+
         ', birdid_fk = '+  Quotedstr(idave)+
         ', farmid_fk = '+  Quotedstr(idgranja)+
         ', aviaryid_fk = '+  Quotedstr(idlote)+
         ', mortality = '+  Quotedstr(DBGridTimeline.Columns[8].field.Text)+
         ', timelinevalue = '+  Quotedstr(DBGridTimeline.Columns[9].field.Text)+
         ', timelinewight = '+  Quotedstr(DBGridTimeline.Columns[10].field.Text)+
         ', inputid_fk = '+  Quotedstr(idinsumo)+
         ', timelineqnt = '+  Quotedstr(DBGridTimeline.Columns[12].field.Text)+
         ', other = '+  Quotedstr(DBGridTimeline.Columns[13].field.Text)+
         ' where timelineid = '+QuotedStr(DBGridTimeline.Columns[0].Field.text));

          DMConnect.ZQBirds.ExecSQL;

       DMConnect.Rxtimeline.next;


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

procedure TFrmTimeline.FormCreate(Sender: TObject);


begin
  ZQuery1.Active:=true;
        dmconnect.ZQBirds.close;
        DMConnect.ZQBirds.SQL.Clear;
        DMConnect.ZQBirds.sql.Add('select * from birds');
        DMConnect.ZQBirds.Open;


         while not  DMConnect.ZQBirds.eof do
              begin
                DBGridtimeline.Columns[5].PickList.Add( DMConnect.ZQBirds.fieldbyname('birdid').asstring + '-'+DMConnect.ZQBirds.fieldbyname('birdtype').asstring);
                DMConnect.ZQBirds.next;
              end;


         dmconnect.ZQBirds.close;
         DMConnect.ZQBirds.SQL.Clear;
         DMConnect.ZQBirds.sql.Add('select * from farms');
         DMConnect.ZQBirds.Open;


         while not  DMConnect.ZQBirds.eof do
              begin
                DBGridtimeline.Columns[6].PickList.Add( DMConnect.ZQBirds.fieldbyname('farmid').asstring + '-'+DMConnect.ZQBirds.fieldbyname('farmname').asstring);
                DMConnect.ZQBirds.next;
              end;


         dmconnect.ZQBirds.close;
         DMConnect.ZQBirds.SQL.Clear;
         DMConnect.ZQBirds.sql.Add('select * from aviary');
         DMConnect.ZQBirds.Open;


         while not  DMConnect.ZQBirds.eof do
              begin
                DBGridtimeline.Columns[7].PickList.Add( DMConnect.ZQBirds.fieldbyname('aviaryid').asstring + '-'+DMConnect.ZQBirds.fieldbyname('aviaryname').asstring);

                DMConnect.ZQBirds.next;
              end;


         dmconnect.ZQBirds.close;
         DMConnect.ZQBirds.SQL.Clear;
         DMConnect.ZQBirds.sql.Add('select * from lots where status = '+QuotedStr('ABERTO'));
         DMConnect.ZQBirds.Open;


         while not  DMConnect.ZQBirds.eof do
              begin
                DBGridtimeline.Columns[2].PickList.Add( DMConnect.ZQBirds.fieldbyname('lotid').asstring);

                DMConnect.ZQBirds.next;
              end;

         dmconnect.ZQBirds.close;
         DMConnect.ZQBirds.SQL.Clear;
         DMConnect.ZQBirds.sql.Add('select * from activity');
         DMConnect.ZQBirds.Open;


         while not  DMConnect.ZQBirds.eof do
              begin
                DBGridtimeline.Columns[1].PickList.Add( DMConnect.ZQBirds.fieldbyname('activityid').asstring + '-'+DMConnect.ZQBirds.fieldbyname('activitytype').asstring);
                DMConnect.ZQBirds.next;
              end;

         dmconnect.ZQBirds.close;
         DMConnect.ZQBirds.SQL.Clear;
         DMConnect.ZQBirds.sql.Add('select * from inputs');
         DMConnect.ZQBirds.Open;


         while not  DMConnect.ZQBirds.eof do
              begin
                DBGridtimeline.Columns[11].PickList.Add( DMConnect.ZQBirds.fieldbyname('inputid').asstring + '-'+DMConnect.ZQBirds.fieldbyname('inputtype').asstring);
                DMConnect.ZQBirds.next;
              end;

      dmconnect.ZQBirds.close;
      DMConnect.ZQBirds.SQL.Clear;
      DMConnect.ZQBirds.sql.Add('select * from timeline'+
      ' inner join aviary on aviary.aviaryid = timeline.aviaryid_fk'+
      ' inner join lots on lots.lotid = timeline.lotid_fk'+
      ' inner join inputs on inputs.inputid = timeline.inputid_fk'+
      ' inner join farms on farms.farmid = timeline.farmid_fk'+
      ' inner join birds on birds.birdid = timeline.birdid_fk'+
      ' inner join activity on activityid = activityid_fk');
      DMConnect.ZQBirds.Open;
      DMConnect.Rxtimeline.close;
      DMConnect.Rxtimeline.open;
  while not DMConnect.ZQBirds.EOF do
    begin
      dmconnect.rxtimeline.Append;
      dmconnect.rxtimeline.Fieldbyname('ID').asinteger:=DMConnect.ZQBirds.FieldByName('timelineid').asinteger;
      dmconnect.rxtimeline.Fieldbyname('Tipo_Movimento').asstring:=DMConnect.ZQBirds.FieldByName('activityid').asstring + '-'+
      DMConnect.ZQBirds.FieldByName('activitytype').asstring;
      dmconnect.rxtimeline.Fieldbyname('Data').asstring:=DMConnect.ZQBirds.FieldByName('timelinedate').asstring;
      dmconnect.rxtimeline.Fieldbyname('Aviario').asstring:=DMConnect.ZQBirds.FieldByName('aviaryid').asstring + '-'+
      DMConnect.ZQBirds.FieldByName('aviaryname').asstring;
      dmconnect.rxtimeline.Fieldbyname('Ave').asstring:=DMConnect.ZQBirds.FieldByName('birdid_fk').asstring + '-'+
      DMConnect.ZQBirds.FieldByName('birdtype').asstring;
      dmconnect.rxtimeline.Fieldbyname('Peso').asstring:=DMConnect.ZQBirds.FieldByName('timelinewight').asstring;
      dmconnect.rxtimeline.Fieldbyname('NumeroLote').asstring:=DMConnect.ZQBirds.FieldByName('lotid').asstring;
      dmconnect.rxtimeline.Fieldbyname('Qnt_Lote').asstring:=DMConnect.ZQBirds.FieldByName('lotqnt').asstring;
      dmconnect.rxtimeline.Fieldbyname('Granja').asstring:=DMConnect.ZQBirds.FieldByName('farmid').asstring +'-'+
      DMConnect.ZQBirds.FieldByName('farmname').asstring;
      dmconnect.rxtimeline.Fieldbyname('Mortality').asstring:=DMConnect.ZQBirds.FieldByName('Mortality').asstring;
      dmconnect.rxtimeline.Fieldbyname('Valor').asstring:=DMConnect.ZQBirds.FieldByName('timelinevalue').asstring;
      dmconnect.rxtimeline.Fieldbyname('Peso').asstring:=DMConnect.ZQBirds.FieldByName('weightfull').asstring;
      dmconnect.rxtimeline.Fieldbyname('Insumo').asstring:=DMConnect.ZQBirds.FieldByName('inputid').asstring + '-'+
      DMConnect.ZQBirds.FieldByName('inputtype').asstring;
      dmconnect.rxtimeline.Fieldbyname('Qnt_Insumo').asstring:=DMConnect.ZQBirds.FieldByName('timelineqnt').asstring;
      dmconnect.rxtimeline.Fieldbyname('Status').asstring:=DMConnect.ZQBirds.FieldByName('Status').asstring;
       if dmconnect.rxtimeline.Fieldbyname('Status').asstring = 'FECHADO' then
        DBGridTimeline.Columns[13].Font.Color:=clRed
        else
          DBGridTimeline.Columns[13].font.color:=clgreen ;
      dmconnect.rxtimeline.Post;
      DMConnect.zqbirds.next;
    end;
end;

procedure TFrmTimeline.DateTimePicker2Change(Sender: TObject);
begin
  if dmconnect.Rxtimeline.state in dsEditModes then
   begin
   DMConnect.RxTimeline.fieldbyname('Data').asdatetime:= DateTimePicker2.Date;
   dmconnect.rxtimeline.Post;
    end;
end;

procedure TFrmTimeline.DateTimePicker2Exit(Sender: TObject);
begin
    DBGridTimeline.SetFocus;
end;

procedure TFrmTimeline.Button1Click(Sender: TObject);
begin
        DMConnect.RxTimeline.Close;

         DMConnect.RxTimeline.open;



        dmconnect.ZQBirds.close;
        DMConnect.ZQBirds.SQL.Clear;
        DMConnect.ZQBirds.sql.Add('select * from birds');
        DMConnect.ZQBirds.Open;

       DBGridtimeline.Columns[5].PickList.Clear;
         while not  DMConnect.ZQBirds.eof do
              begin
                DBGridtimeline.Columns[5].PickList.Add( DMConnect.ZQBirds.fieldbyname('birdid').asstring + '-'+DMConnect.ZQBirds.fieldbyname('birdtype').asstring);
                DMConnect.ZQBirds.next;
              end;


         dmconnect.ZQBirds.close;
         DMConnect.ZQBirds.SQL.Clear;
         DMConnect.ZQBirds.sql.Add('select * from farms');
         DMConnect.ZQBirds.Open;

         DBGridtimeline.Columns[6].PickList.Clear;
         while not  DMConnect.ZQBirds.eof do
              begin
                DBGridtimeline.Columns[6].PickList.Add( DMConnect.ZQBirds.fieldbyname('farmid').asstring + '-'+DMConnect.ZQBirds.fieldbyname('farmname').asstring);
                DMConnect.ZQBirds.next;
              end;


         dmconnect.ZQBirds.close;
         DMConnect.ZQBirds.SQL.Clear;
         DMConnect.ZQBirds.sql.Add('select * from aviary');
         DMConnect.ZQBirds.Open;

         DBGridtimeline.Columns[7].PickList.Clear;
         while not  DMConnect.ZQBirds.eof do
              begin
                DBGridtimeline.Columns[7].PickList.Add( DMConnect.ZQBirds.fieldbyname('aviaryid').asstring + '-'+DMConnect.ZQBirds.fieldbyname('aviaryname').asstring);

                DMConnect.ZQBirds.next;
              end;


         dmconnect.ZQBirds.close;
         DMConnect.ZQBirds.SQL.Clear;
         DMConnect.ZQBirds.sql.Add('select * from lots where status = '+QuotedStr('ABERTO'));
         DMConnect.ZQBirds.Open;

          DBGridtimeline.Columns[2].PickList.Clear;
         while not  DMConnect.ZQBirds.eof do
              begin
                DBGridtimeline.Columns[2].PickList.Add( DMConnect.ZQBirds.fieldbyname('lotid').asstring);

                DMConnect.ZQBirds.next;
              end;

         dmconnect.ZQBirds.close;
         DMConnect.ZQBirds.SQL.Clear;
         DMConnect.ZQBirds.sql.Add('select * from activity');
         DMConnect.ZQBirds.Open;

         DBGridtimeline.Columns[1].PickList.Clear;
         while not  DMConnect.ZQBirds.eof do
              begin
                DBGridtimeline.Columns[1].PickList.Add( DMConnect.ZQBirds.fieldbyname('activityid').asstring + '-'+DMConnect.ZQBirds.fieldbyname('activitytype').asstring);
                DMConnect.ZQBirds.next;
              end;

         dmconnect.ZQBirds.close;
         DMConnect.ZQBirds.SQL.Clear;
         DMConnect.ZQBirds.sql.Add('select * from inputs');
         DMConnect.ZQBirds.Open;

             DBGridtimeline.Columns[11].PickList.Clear;
         while not  DMConnect.ZQBirds.eof do
              begin
                DBGridtimeline.Columns[11].PickList.Add( DMConnect.ZQBirds.fieldbyname('inputid').asstring + '-'+DMConnect.ZQBirds.fieldbyname('inputtype').asstring);
                DMConnect.ZQBirds.next;
              end;

      dmconnect.ZQBirds.close;
      DMConnect.ZQBirds.SQL.Clear;
      DMConnect.ZQBirds.sql.Add('select * from timeline'+
      ' inner join aviary on aviary.aviaryid = timeline.aviaryid_fk'+
      ' inner join lots on lots.lotid = timeline.lotid_fk'+
      ' inner join inputs on inputs.inputid = timeline.inputid_fk'+
      ' inner join farms on farms.farmid = timeline.farmid_fk'+
      ' inner join birds on birds.birdid = timeline.birdid_fk'+
      ' inner join activity on activityid = activityid_fk' +
      ' where lotid_fk = '+QuotedStr(DBLookupComboBox1.KeyValue));
      DMConnect.ZQBirds.Open;
      DMConnect.Rxtimeline.close;
      DMConnect.Rxtimeline.open;
  while not DMConnect.ZQBirds.EOF do
    begin
      dmconnect.rxtimeline.Append;
      dmconnect.rxtimeline.Fieldbyname('ID').asinteger:=DMConnect.ZQBirds.FieldByName('timelineid').asinteger;
      dmconnect.rxtimeline.Fieldbyname('Tipo_Movimento').asstring:=DMConnect.ZQBirds.FieldByName('activityid').asstring + '-'+
      DMConnect.ZQBirds.FieldByName('activitytype').asstring;
      dmconnect.rxtimeline.Fieldbyname('Data').asstring:=DMConnect.ZQBirds.FieldByName('timelinedate').asstring;
      dmconnect.rxtimeline.Fieldbyname('Aviario').asstring:=DMConnect.ZQBirds.FieldByName('aviaryid').asstring + '-'+
      DMConnect.ZQBirds.FieldByName('aviaryname').asstring;
      dmconnect.rxtimeline.Fieldbyname('Ave').asstring:=DMConnect.ZQBirds.FieldByName('birdid_fk').asstring + '-'+
      DMConnect.ZQBirds.FieldByName('birdtype').asstring;
      dmconnect.rxtimeline.Fieldbyname('Peso').asstring:=DMConnect.ZQBirds.FieldByName('timelinewight').asstring;
      dmconnect.rxtimeline.Fieldbyname('NumeroLote').asstring:=DMConnect.ZQBirds.FieldByName('lotid').asstring;
      dmconnect.rxtimeline.Fieldbyname('Qnt_Lote').asstring:=DMConnect.ZQBirds.FieldByName('lotqnt').asstring;
      dmconnect.rxtimeline.Fieldbyname('Granja').asstring:=DMConnect.ZQBirds.FieldByName('farmid').asstring +'-'+
      DMConnect.ZQBirds.FieldByName('farmname').asstring;
      dmconnect.rxtimeline.Fieldbyname('Mortality').asstring:=DMConnect.ZQBirds.FieldByName('Mortality').asstring;
      dmconnect.rxtimeline.Fieldbyname('Valor').asstring:=DMConnect.ZQBirds.FieldByName('timelinevalue').asstring;
      dmconnect.rxtimeline.Fieldbyname('Peso').asstring:=DMConnect.ZQBirds.FieldByName('weightfull').asstring;
      dmconnect.rxtimeline.Fieldbyname('Insumo').asstring:=DMConnect.ZQBirds.FieldByName('inputid').asstring + '-'+
      DMConnect.ZQBirds.FieldByName('inputtype').asstring;
      dmconnect.rxtimeline.Fieldbyname('Qnt_Insumo').asstring:=DMConnect.ZQBirds.FieldByName('timelineqnt').asstring;
      dmconnect.rxtimeline.Fieldbyname('Status').asstring:=DMConnect.ZQBirds.FieldByName('Status').asstring;
      if dmconnect.rxtimeline.Fieldbyname('Status').asstring = 'FECHADO' then
       begin
        DBGridTimeline.Columns[13].Font.Color:=clRed;
        DBGridTimeline.ReadOnly:=True ;
       end
      else
        begin
          DBGridTimeline.Columns[13].font.color:=clgreen ;
           DBGridTimeline.ReadOnly:=false;
        end;
      dmconnect.rxtimeline.Post;
      DMConnect.zqbirds.next;
    end;
  DBGridTimeline.visible:=true;
end;

procedure TFrmTimeline.DBGridTimelineCellClick(Column: TColumn);
begin
   if Column.FieldName = 'NumeroLote' then
    begin
     DMConnect.ZQBirds.close;
     DMConnect.ZQBirds.sql.clear;
     DMConnect.ZQBirds.sql.add('Select * from lots'+
     ' inner join birds on birds.birdid = lots.birdid_fk'+
     ' inner join aviary on aviary.aviaryid = lots.aviaryid_fk'+
     ' inner join farms on farms.farmid = aviary.farmid_Afk'+
     ' where lotid = '+QuotedStr(DBGridTimeline.Columns[2].field.text));
     DMConnect.ZQBirds.open;

     DBGridTimeline.Columns[3].field.text:=DMConnect.ZQBirds.FieldByName('QNT').AsString;
     //DBGridTimeline.Columns[4].field.text:=DMConnect.ZQBirds.FieldByName('lotdate').AsString;
     DBGridTimeline.Columns[5].field.text:=DMConnect.ZQBirds.FieldByName('birdid_fk').AsString + '-'+
     DMConnect.ZQBirds.FieldByName('birdtype').AsString;
     DBGridTimeline.Columns[6].field.text:=DMConnect.ZQBirds.FieldByName('farmid').AsString + '-'+
     DMConnect.ZQBirds.FieldByName('farmname').AsString;
     DBGridTimeline.Columns[7].field.text:=DMConnect.ZQBirds.FieldByName('aviaryid_fk').AsString + '-'+
     DMConnect.ZQBirds.FieldByName('aviaryname').AsString;
     if DBGridTimeline.Columns[1].field.text = '1-ABERTURA' then
     DBGridTimeline.Columns[10].field.text:=DMConnect.ZQBirds.FieldByName('weightfull').AsString;

    end;


end;

procedure TFrmTimeline.DBGridTimelineColExit(Sender: TObject);
begin
  if DBGridTimeline.SelectedField.FieldName = 'Data' then
    DateTimePicker2.Visible := False;



end;

procedure TFrmTimeline.DBGridTimelineDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (gdFocused in State) then
  begin
    if (Column.Field.FieldName = 'Data') then
      with DateTimePicker2 do
      begin
        Left := Rect.Left + DBGridTimeline.Left + 1;
        Top := Rect.Top + DBGridTimeline.Top + 1;
        Width := Rect.Right - Rect.Left + 2;
        Width := Rect.Right - Rect.Left + 2;
        Height := Rect.Bottom - Rect.Top + 2;

        Visible := True;
      end;

  end;

end;

procedure TFrmTimeline.DBGridTimelineKeyPress(Sender: TObject; var Key: char);
begin
    Key := AnsiUpperCase(Key)[1];
  if (Key = Chr(9)) then
    Exit;


  if (DBGridTimeline.SelectedField.FieldName = 'Data') then
  begin
    DateTimePicker2.SetFocus;

  end;

end;

procedure TFrmTimeline.DBGridTimelineTitleClick(Column: TColumn);
begin

  DMConnect.RxTimeline.SortOnFields(Column.FieldName);
end;

procedure TFrmTimeline.DBNavTimelineClick(Sender: TObject;
  Button: TDBNavButtonType);
begin
      case button of
   nbInsert:
     begin

     DBGridtimeline.Columns[0].Field.text:='0';
     DBGridtimeline.Columns[1].Field.FocusControl;

     end;
   nbPost:
       DMConnect.Rxtimeline.SortOnFields('ID');
   end;
end;



end.

