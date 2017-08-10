unit uLeakTests;

interface

uses
  TestFrameWork;


type
  TLeakTests = class(TTestCase)
  private
  protected
    procedure TearDown; override;
  published
    procedure ShouldFailWithALeak;
  end;

implementation

uses
  Classes, uConf;

{ TLeakTests }

procedure TLeakTests.TearDown;
begin
  //Comment out the next line, and the test works.
  gConf.Free; // cleanup and trigger recreation by next testcase
  inherited;
end;

procedure TLeakTests.ShouldFailWithALeak;
var
  stl : TStringList;
begin
  stl := TStringList.Create;
  stl.Add('leaked string in a leaked stringlist');
end;

initialization
  RegisterTest(TLeakTests.Suite);

end.
