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
    btn_removestudent: TButton;
    Button1: TButton;
    Button2: TButton;
    CB_LKauswahl: TComboBox;
    CB_klasse: TComboBox;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    Shape1: TShape;
    procedure BitBtn1Click(Sender: TObject);
    procedure btn_addstudentClick(Sender: TObject);
    procedure Btn_closeClick(Sender: TObject);
    procedure btn_removestudentClick(Sender: TObject);
  private

  public

  end;

var
  FormMain: TFormMain;

implementation

{$R *.lfm}

{ TFormMain }

uses uLogin, uaddstudents, uremovestudent;

var
  logout: integer;

procedure TFormMain.Btn_closeClick(Sender: TObject);
begin
  if Dialogs.MessageDlg('Wirklich beenden?',
    mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes
    then
      application.terminate;
end;

procedure TFormMain.btn_removestudentClick(Sender: TObject);
begin
  FormRemoveStudent.show;
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
  FormAddStudent.Show;
end;

end.

