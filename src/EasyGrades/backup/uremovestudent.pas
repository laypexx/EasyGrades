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
  private

  public

  end;

var
  FormRemoveStudent: TFormRemoveStudent;

implementation

{$R *.lfm}

end.

