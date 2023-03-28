unit uLehrer;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { TFormLehrer }

  TFormLehrer = class(TForm)
    btn_close: TButton;
    Label4: TLabel;
    Label5: TLabel;
    procedure btn_closeClick(Sender: TObject);
  private

  public

  end;

var
  FormLehrer: TFormLehrer;

implementation

{$R *.lfm}

{ TFormLehrer }

procedure TFormLehrer.btn_closeClick(Sender: TObject);
begin
  if Dialogs.MessageDlg('Wirklich abbrechen?',
    mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes
    then
      FormLehrer.Hide;
end;

end.

