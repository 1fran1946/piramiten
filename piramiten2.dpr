program piramiten2;

uses
  Vcl.Forms,
  Unit2pir in 'Unit2pir.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
