program EasyGrades;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, uLogin, uMain, uAddStudents, uremovestudent, uaccounts, uAccountsClass,
  uNote, uAddGrade, uRemoveGrade
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(TFormLogin, FormLogin);
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormAddStudent, FormAddStudent);
  Application.CreateForm(TFormRemoveStudent, FormRemoveStudent);
  Application.CreateForm(TFormAccounts, FormAccounts);
  Application.CreateForm(TForm_AddGrade, Form_AddGrade);
  Application.CreateForm(TForm_RemGrade, Form_RemGrade);
  Application.Run;
end.

