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
    procedure ShouldFailWithALeakButDoesnt;
  end;

implementation

uses
  Classes, uConf;

{ TLeakTests }

procedure TLeakTests.TearDown;
begin
  //Comment out "gConf.Free;" and the test memory leak is detected.
  gConf.Free; // cleanup to trigger recreation by the next testcase
  inherited;
end;

procedure TLeakTests.ShouldFailWithALeakButDoesnt;
var
  stl : TStringList;
begin
  stl := TStringList.Create;
  stl.Add('leaked string in a leaked stringlist');
end;

initialization
  RegisterTest(TLeakTests.Suite);

end.
