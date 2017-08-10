unit uConf;

interface

uses SysUtils, Classes;

type
   TConf = class(TObject)
   private
    FConfFileName : String; //Remove the FConfFileName member and the test memleak is detected.
    FStrings : TStrings;    //Remove this FStrings and the test memleak is detected
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
  //Remove the call to ChangeFileExt and the test memleak is detected.
  //Remove the call to ParamStr(0) and the test memleak is detected.
  FConfFileName := ChangeFileExt(ParamStr(0), '.ini');

  //Remove the "FStrings" initialization, and the test memleak is detected.
  FStrings := TStringList.Create;
end;

destructor TConf.Destroy;
begin
  FStrings.Free;

  if self = FConf then FConf := nil;

  inherited;
end;


initialization
  //Remove the call to gConf that initializes FConf, and the test memleak is detected.
  gConf;

finalization
  if Assigned(FConf) then FreeAndNil(FConf);
end.











