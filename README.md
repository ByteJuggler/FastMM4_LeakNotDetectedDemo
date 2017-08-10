This is a DUnit test project setup with a test that leaks memory that is not detected by FastMM4, that ought to be.  Here's what will happen if you run the project as it stands:
https://vgy.me/q2m4MO.png

I am trying to get to the bottom of why it's not being detected.

The failure to detect the memory leak can however  be "fixed" (to  detect the deliberate memory leak), 
by doing any one of the following things:
- in uLeakTests.pas line 27: Comment out "gConf.Free;" and the test memory leak is detected.
- in uConf.pas line 10: Remove the FConfFileName member (and related code) and the test memleak is detected.
- in uConf.pas line 11: Remove this FStrings and the test memleak is detected
- in uConf.pas line 34: Remove the call to ChangeFileExt and the test memleak is detected.
- in uConf.pas line 35: Remove the call to ParamStr(0) and the test memleak is detected.
- in uConf.pas line 39: Remove the "FStrings" initialization, and the test memleak is detected.
- in uConf.pas line 54: Remove the call to gConf that initializes FConf, and the test memleak is detected.

This has been tested on Delphi 10.1 (Berlin) and Delpho 10.2 Tokyo (the latter a clean install), both of which 
exhibit this strange behaviour.
