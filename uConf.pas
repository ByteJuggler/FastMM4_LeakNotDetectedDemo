unit uConf;

interface

uses SysUtils, Classes;

type
   //Rename TSharedConf to TConf and the test works.
   TConf = class(TObject)
   private
    FConfFileName : String; //remove this member and the test works.
    FStrings : TStrings;    //remove this member and the test works.
   public
    constructor Create;
    destructor Destroy; override;
   end;

function gConf : TConf;

implementation

uses Forms;

var FConf : TConf;
function gConf : TConf;
begin
  if ((not Assigned(FConf)) and Assigned(Application) and (not (csDestroying in Application.ComponentState))) then
    FConf := TConf.Create();
  Result := FConf;
end;

constructor TConf.Create;
begin
  inherited;
  //Remove the call to ChangeFileExt and the test works.
  //Remove the call to ParamStr(0) and the test works
  FConfFileName := ChangeFileExt(ParamStr(0), '.ini');

  //Remove this and the test works
  FStrings := TStringList.Create;
end;

destructor TConf.Destroy;
begin
  FStrings.Free;

  if self = FConf then FConf := nil;

  inherited;
end;


initialization
  //Remove this call that initializes the global to an instance, and the test works:
  gConf;

finalization
  if Assigned(FConf) then FreeAndNil(FConf);
end.











