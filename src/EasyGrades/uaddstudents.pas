unit uAddStudents;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TFormAddStudents }

  TFormAddStudents = class(TForm)
    btn_add: TButton;
    btn_undo: TButton;
    Cb_klasse: TComboBox;
    Cb_lk1: TComboBox;
    cb_lk2: TComboBox;
    Ed_name: TEdit;
    Edit_vorname: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
  private

  public

  end;

var
  FormAddStudents: TFormAddStudents;

implementation

{$R *.lfm}

end.

