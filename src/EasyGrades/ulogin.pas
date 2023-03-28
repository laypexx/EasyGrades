unit uLogin;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, FileUtil, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls;

type

  { TFormLogin }

  TFormLogin = class(TForm)
    Btn_login: TButton;
    Btn_exit: TButton;
    CBkontotyp: TComboBox;
    ChB_show: TCheckBox;
    SQLQanmeldung: TSQLQuery;
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
    procedure ChB_showChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private

  public

  end;

var
  FormLogin: TFormLogin;
  anmeldename: string;

implementation

{$R *.lfm}

{ TFormLogin }

uses uMain;

var
  //adminsTXT: TEXTfile;
  //lehrerTXT: TEXT;
  //schuelerTXT: TEXT;
  password: string;
  acc_caption: string;

procedure TFormLogin.Btn_exitClick(Sender: TObject);
begin
  if Dialogs.MessageDlg('Wirklich beenden?',
    mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes
    then
      application.terminate;
end;

procedure TFormLogin.Btn_loginClick(Sender: TObject);
var
  query: ANSIstring;
begin
  if cbkontotyp.text = 'Admin'
     then
         begin
           if TEditUser.text = 'admin'
              then
                  begin
                  //Hier Passwort Verschlüsselung evtl.
                    //hier passwort aus textfile holen und überprüfen mit eingegebenem
                    password := 'adminpw';
                  if teditpassword.text = password
                     then
                         showmessage('Erfolgreich eingeloggt!');
                         FormLogin.Hide;
                         acc_caption := ('Accountname: '+TeditUser.text+' (Typ: '+cbkontotyp.text+')');
                         formmain.l_acc.caption := acc_caption;
                         FormMain.Show;
                         TeditUser.Clear;
                         TeditPassword.Clear;
                         CBkontotyp.text;
                         FormMain.sqlqgrid.active := false;
                         FormMain.sqlqgrid.sql.clear;
                         FormMain.btn_owngrades.enabled := false;
                  end
           else if TeditUser.text <> ''
              then
                  begin
                    query :=
                    'SELECT Name FROM (personen INNER JOIN admin on personen.P_ID=admin.P_ID) WHERE personen.Name='+#39+tedituser.text+#39+';';
                    sqlqanmeldung.active := false;
                    sqlqanmeldung.sql.add(query);
                    sqlqanmeldung.ExecSQL;
                    sqlqanmeldung.active := true;
                    Anmeldename := sqlqanmeldung.fieldbyname('Name').Asstring;
                    sqlqanmeldung.SQL.clear;

                    if anmeldename <> ''
                    then
                       begin
                         password := 'adminpw';
                         if teditpassword.text = password
                            then
                              showmessage('Erfolgreich eingeloggt!');
                              FormLogin.Hide;
                              acc_caption := ('Accountname: '+TeditUser.text+' (Typ: '+cbkontotyp.text+')');
                              formmain.l_acc.caption := acc_caption;
                              FormMain.Show;
                              TeditUser.Clear;
                              TeditPassword.Clear;
                              CBkontotyp.text;
                              FormMain.sqlqgrid.active := false;
                              FormMain.sqlqgrid.sql.clear;
                              FormMain.btn_owngrades.enabled := false;
                       end;
                  end
           else
             showmessage('Anmeldename oder Passwort Falsch! Bitte erneut versuchen.');
             TeditUser.Clear;
             TeditPassword.Clear;
         end

  else if cbkontotyp.text = 'Schueler'
     then
       begin
         if TeditUser.text <> ''
            then
               begin
                 query :=
                 'SELECT Name FROM personen WHERE Name='+#39+tedituser.text+#39+';';
                 sqlqanmeldung.active := false;
                 sqlqanmeldung.sql.add(query);
                 sqlqanmeldung.ExecSQL;
                 sqlqanmeldung.active := true;
                 Anmeldename := sqlqanmeldung.fieldbyname('Name').Asstring;
                 sqlqanmeldung.SQL.clear;
                 if anmeldename <> ''
                    then
                       begin
                 password := 'schuelerpw';
                 if teditpassword.text = password
                    then
                      showmessage('Erfolgreich eingeloggt!');
                      FormLogin.Hide;
                      acc_caption := ('Accountname: '+TeditUser.text+' (Typ: '+cbkontotyp.text+')');
                      formmain.l_acc.caption := acc_caption;
                      FormMain.Show;
                      FormMain.accountname := tedituser.text;
                      TeditUser.Clear;
                      TeditPassword.Clear;
                      CBkontotyp.text;
                      password := '';
                      FormMain.btn_lehrer.enabled := false;
                      FormMain.btn_addstudent.enabled := false;
                      FormMain.btn_removestudent.enabled := false;
                      formmain.cb_lkauswahl.enabled := false;
                      formmain.cb_klasse.enabled := false;
                      formmain.btn_addgrade.enabled := false;
                      formmain.btn_deletegrade.enabled := false;
                      FormMain.btn_openDB.enabled := false;
                      FormMain.sqlqgrid.sql.clear;
                       end;
               end
         else
           showmessage('Anmeldename oder Passwort Falsch! Bitte erneut versuchen.');
           TeditUser.Clear;
           TeditPassword.Clear;
       end
  else showmessage('Bitte Angaben prüfen!');
end;

procedure TFormLogin.ChB_showChange(Sender: TObject);
begin
  if ChB_show.checked
     then
       TEditPassword.PasswordChar := #0
  else TEditPassword.PasswordChar := '*'
end;

procedure TFormLogin.FormActivate(Sender: TObject);
begin
  //sadasd
end;

end.

