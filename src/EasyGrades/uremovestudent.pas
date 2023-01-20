unit uremovestudent;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TFormRemoveStudent }

  TFormRemoveStudent = class(TForm)
    Btn_remove: TButton;
    Btn_cancel: TButton;
    cb_student: TComboBox;
    Ed_nachname: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure Btn_cancelClick(Sender: TObject);
  private

  public

  end;

var
  FormRemoveStudent: TFormRemoveStudent;

implementation

{$R *.lfm}

{ TFormRemoveStudent }

procedure TFormRemoveStudent.Btn_cancelClick(Sender: TObject);
begin
  if Dialogs.MessageDlg('Wirklich abbrechen?',
    mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes
    then
      FormRemoveStudent.Hide;
end;

end.

