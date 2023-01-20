program EasyGrades;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, uLogin, uMain, uAddStudents, uremovestudent
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(TFormLogin, FormLogin);
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormAddStudent, FormAddStudent);
  Application.CreateForm(TFormRemoveStudent, FormRemoveStudent);
  Application.Run;
end.

