unit uDMConnect;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, forms, ExtCtrls, rxmemds, RxDBGridFooterTools,
  RxAboutDialog, ZDataset, ZConnection;

type

  { TDMConnect }

  TDMConnect = class(TDataModule)
    DSActivity: TDataSource;
    DSTimeLine: TDataSource;
    DSLot: TDataSource;
    DSInput: TDataSource;
    DSAviary: TDataSource;
    DSFarms: TDataSource;
    DSBirds: TDataSource;
    DSusers: TDataSource;
    RxActivityID: TLongintField;
    RxActivityTipo: TStringField;
    RxAviaryCapacidade: TLongintField;
    RxAviaryGranja: TStringField;
    RxAviaryID: TLongintField;
    RxAviaryNome_Avirio: TStringField;
    RxBirds: TRxMemoryData;
    RxBirdsID: TLongintField;
    RxBirdsTipo: TStringField;
    RxFarms: TRxMemoryData;
    RxFarmsCapacidade: TLongintField;
    RxFarmsID: TLongintField;
    RxFarmsLocalizacao: TStringField;
    RxFarmsNome_Granja: TStringField;
    RxAviary: TRxMemoryData;
    RxInput: TRxMemoryData;
    RxInputID: TLongintField;
    RxInputTipo: TStringField;
    RxInputValor: TFloatField;
    RxLot: TRxMemoryData;
    RxActivity: TRxMemoryData;
    RxLotAve: TStringField;
    RxLotAviario: TStringField;
    RxLotData_entrada: TDateField;
    RxLotID: TLongintField;
    RxLotPesoMedio: TFloatField;
    RxLotPesoTotal: TFloatField;
    RxLotQuantidade: TLongintField;
    RxLotStatus: TStringField;
    RxTimeline: TRxMemoryData;
    RxTimelineAve: TStringField;
    RxTimelineAviario: TStringField;
    RxTimelineData: TDateField;
    RxTimelineGranja: TStringField;
    RxTimelineID: TLongintField;
    RxTimelineInsumo: TStringField;
    RxTimelineMortality: TLongintField;
    RxTimelineNumeroLote: TLongintField;
    RxTimelinePeso: TFloatField;
    RxTimelineQnt_Insumo: TLongintField;
    RxTimelineQnt_Lote: TLongintField;
    RxTimelineStatus: TStringField;
    RxTimelineTipo_Movimento: TStringField;
    RxTimelineValor: TStringField;
    RxUsers: TRxMemoryData;
    RxUsersCPF: TStringField;
    RxUsersEmail: TStringField;
    RxUsersID: TLongintField;
    RxUsersNome: TStringField;
    RxUsersSenha: TStringField;
    RxUsersStatus: TStringField;
    ZConnectbirds: TZConnection;
    ZQBirds: TZQuery;
    ZQuery1BIRDID: TFloatField;
    ZQuery1BIRDTYPE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private

  public
   procedure Chamalogin(fClass:TFormClass; Form:TForm);
   function Encrypt(const InString:string; StartKey,MultKey,AddKey:Integer):string;
   function Decrypt(const InString:string; StartKey,MultKey,AddKey:Integer):string;
  end;

var
  DMConnect: TDMConnect;

implementation

{$R *.lfm}
 uses
   ulogin,utimeline;

 { TDMConnect }

 procedure TDMConnect.DataModuleCreate(Sender: TObject);
 begin
   chamalogin(tfrmlogin,frmlogin);
 end;

 procedure TDMConnect.Chamalogin(fClass: TFormClass; Form: TForm);
 begin
    try
      Application.CreateForm(fClass,Form);
      Form.ShowModal;
    Finally
      Form.Release;
      Form:=nil;
    end;
 end;

 function TDMConnect.Encrypt(const InString: string; StartKey, MultKey,
   AddKey: Integer): string;
   var I : Byte;
     begin
     Result := '\';
     for I := 0 to Length(InString) do
       begin
         Result := Result + CHAR(Byte(InString[I]) xor (StartKey));
         StartKey := (Byte(Result[I]) + StartKey) * MultKey + AddKey;
       end;
    end;

 function TDMConnect.Decrypt(const InString: string; StartKey, MultKey,
   AddKey: Integer): string;
 var I : Byte;
   begin
     Result := '\';
     for I := 1 to Length(InString) do
        begin
          Result := Result + CHAR(Byte(InString[I]) xor (StartKey));
          StartKey := (Byte(InString[I]) + StartKey) * MultKey + AddKey;
        end;
   end;
end.

