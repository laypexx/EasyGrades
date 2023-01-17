unit uMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons, DBGrids, ExtCtrls;

type

  { TFormMain }

  TFormMain = class(TForm)
    BitBtn1: TBitBtn;
    Btn_close: TButton;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Shape1: TShape;
    procedure BitBtn1Click(Sender: TObject);
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
  application.terminate;
end;

procedure TFormMain.BitBtn1Click(Sender: TObject);
begin
  logout := MessageDLG('Wirklich abmelden?', mtConfirmation, mbYesNo, 0);
  if logout = 6
     then
         FormMain.Hide;
         FormLogin.Show;
end;

end.

