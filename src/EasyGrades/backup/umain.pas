unit uMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons, DBGrids, ExtCtrls, Menus;

type

  { TFormMain }

  TFormMain = class(TForm)
    BitBtn1: TBitBtn;
    Btn_close: TButton;
    btn_addstudent: TButton;
    CB_LKauswahl: TComboBox;
    CB_klasse: TComboBox;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    Shape1: TShape;
    procedure BitBtn1Click(Sender: TObject);
    procedure btn_addstudentClick(Sender: TObject);
    procedure Btn_closeClick(Sender: TObject);
  private

  public

  end;

var
  FormMain: TFormMain;

implementation

{$R *.lfm}

{ TFormMain }

uses uLogin;

var
  logout: integer;

procedure TFormMain.Btn_closeClick(Sender: TObject);
begin
  if Dialogs.MessageDlg('Wirklich beenden?',
    mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes
    then
      application.terminate;
end;

procedure TFormMain.BitBtn1Click(Sender: TObject);
begin
  if Dialogs.MessageDlg('Wirklich abmelden?',
    mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes
    then
      FormLogin.Show;
      FormMain.Hide;
end;

procedure TFormMain.btn_addstudentClick(Sender: TObject);
begin
  FormMain.Hide;
  FormAddStudents.Show;
end;

end.

