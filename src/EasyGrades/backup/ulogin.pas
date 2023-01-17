unit uLogin;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TFormLogin }

  TFormLogin = class(TForm)
    Btn_login: TButton;
    Btn_exit: TButton;
    CBkontotyp: TComboBox;
    TEditUser: TEdit;
    TEditPassword: TEdit;
    Image_logo: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure Btn_exitClick(Sender: TObject);
    procedure Btn_loginClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private

  public

  end;

var
  FormLogin: TFormLogin;

implementation

{$R *.lfm}

{ TFormLogin }

uses uMain;

var
  adminsTXT: TEXTfile;
  lehrerTXT: TEXT;
  schuelerTXT: TEXT;
  password: string;

procedure TFormLogin.Btn_exitClick(Sender: TObject);
begin
  application.terminate;
end;

procedure TFormLogin.Btn_loginClick(Sender: TObject);
begin
  if cbkontotyp.text = 'Admin'
     then
         begin
           if TEditUser.text = 'admin'
              then
                  begin
                  //AssignFile(adminsTXT, '\txt\admins.txt');
                  //Reset(adminsTXT);
                  //ReadLn(adminsTXT,password);
                  //CloseFile(adminsTXT);
                  //password := LoadFromFile('\txt\admins.txt');
                    password := '123';
                  if teditpassword.text = password
                     then
                         showmessage('Erfolgreich eingeloggt!');
                         FormLogin.visibe = false;
                         FormMain.visible = true;
                  end
           else
              showmessage('Anmeldename oder Passwort Falsch! Bitte erneut versuchen.');
              TeditUser.Clear;
              TeditPassword.Clear;
         end
  else showmessage('Bitte Eingabefelder ausfüllen!');
end;

procedure TFormLogin.FormActivate(Sender: TObject);
begin
  //showmessage('welcome');
end;

end.

