unit uMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, odbcconn, sqldb, db, FileUtil, Forms, Controls, Graphics,
  Dialogs, StdCtrls, Buttons, DBGrids, ExtCtrls, Menus, lclintf;

type

  { TFormMain }

  TFormMain = class(TForm)
    Btn_logout: TBitBtn;
    Btn_close: TButton;
    btn_addstudent: TButton;
    btn_removestudent: TButton;
    Btn_lehrer: TButton;
    Btn_addgrade: TButton;
    btn_deletegrade: TButton;
    btn_openDB: TButton;
    btn_owngrades: TButton;
    CB_LKauswahl: TComboBox;
    CB_klasse: TComboBox;
    DSgrid: TDataSource;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label8: TLabel;
    L_acc: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    MI_close: TMenuItem;
    MenuItem7: TMenuItem;
    ODBCnotenbuch: TODBCConnection;
    Shape1: TShape;
    SQLQgrid: TSQLQuery;
    SQLTransGrid: TSQLTransaction;
    procedure Btn_addgradeClick(Sender: TObject);
    procedure btn_deletegradeClick(Sender: TObject);
    procedure Btn_logoutClick(Sender: TObject);
    procedure btn_addstudentClick(Sender: TObject);
    procedure Btn_closeClick(Sender: TObject);
    procedure btn_openDBClick(Sender: TObject);
    procedure btn_owngradesClick(Sender: TObject);
    procedure btn_removestudentClick(Sender: TObject);
    procedure Btn_lehrerClick(Sender: TObject);
    procedure CB_klasseSelect(Sender: TObject);
    procedure CB_LKauswahlSelect(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure MI_closeClick(Sender: TObject);
  private

  public
    accountname: string;
  end;

var
  FormMain: TFormMain;

implementation

{$R *.lfm}

{ TFormMain }

uses uLogin, uaddstudents, uremovestudent, uaccounts, uaddgrade, uremovegrade;

var
  logout: integer;

procedure TFormMain.Btn_closeClick(Sender: TObject);
begin
  if Dialogs.MessageDlg('Wirklich beenden?',
    mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes
    then
      application.terminate;
end;

procedure TFormMain.btn_openDBClick(Sender: TObject);
begin
  if Dialogs.MessageDlg('Sie werden auf eine Internetseite weitergeleitet. Sind sie damit einverstanden?',
    mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes
    then
      OpenUrl('http://127.0.0.1:8080/phpmyadmin/');
end;

procedure TFormMain.btn_owngradesClick(Sender: TObject);
var
  query: ANSIstring;
begin
  query :=
  'SELECT personen.Vorname AS Vorname, personen.Name AS Nachname, fach.Bezeichnung AS Fach, noten.Note AS Noten, noten.Gewichtung AS Gewichtung, noten.Kursnote, schueler.Zeugnisnote '+
  'FROM ((((fach INNER JOIN kurs on fach.F_ID=kurs.F_ID) INNER JOIN schueler on kurs.P_ID=schueler.P_ID) INNER JOIN noten on schueler.S_ID=noten.S_ID) '+
  'INNER JOIN personen on schueler.P_ID=personen.P_ID) '+
  'WHERE personen.Name LIKE '+#39+accountname+#39+';';
  sqlqgrid.active := false;
  sqlqgrid.sql.clear;
  sqlqgrid.sql.add(query);
  sqlqgrid.execsql;
  sqlqgrid.active := true;
end;

procedure TFormMain.btn_removestudentClick(Sender: TObject);
begin
  FormRemoveStudent.show;
end;

procedure TFormMain.Btn_lehrerClick(Sender: TObject);
begin
  FormAccounts.Show;
end;

procedure TFormMain.CB_klasseSelect(Sender: TObject);
var
  query: ANSIstring;
begin
  query :=
  'SELECT fach.BZ_kurz AS Leistungskurs, klasse.Bezeichnung AS Klasse, personen.Name AS Nachname, personen.Vorname AS Vorname, schueler.ZeugnisNote AS Zeugnisnote, kurs.Jahr AS Jahr '+
  'FROM ((((fach INNER JOIN kurs ON fach.F_ID=kurs.F_ID) INNER JOIN personen ON kurs.P_ID=personen.P_ID) INNER JOIN schueler ON personen.P_ID=schueler.P_ID) INNER JOIN klasse ON kurs.KL_ID=klasse.KL_ID) '+
  'WHERE klasse.Bezeichnung='+#39+cb_klasse.text+#39+' '+
  'ORDER BY klasse.Bezeichnung DESC;';
  sqlqgrid.active := false;
  sqlqgrid.sql.clear;
  sqlqgrid.sql.add(query);
  sqlqgrid.execsql;
  sqlqgrid.active := true;
end;

procedure TFormMain.CB_LKauswahlSelect(Sender: TObject);
var
  query: ANSIstring;
begin
  query :=
  'SELECT fach.BZ_kurz AS Leistungskurs, klasse.Bezeichnung AS Klasse, personen.Name AS Nachname, personen.Vorname AS Vorname, schueler.ZeugnisNote AS Zeugnisnote, kurs.Jahr AS Jahr '+
  'FROM ((((fach INNER JOIN kurs ON fach.F_ID=kurs.F_ID) INNER JOIN personen ON kurs.P_ID=personen.P_ID) INNER JOIN schueler ON personen.P_ID=schueler.P_ID) INNER JOIN klasse ON kurs.KL_ID=klasse.KL_ID) '+
  'WHERE fach.Bezeichnung='+#39+cb_lkauswahl.text+#39+' '+
  'ORDER BY klasse.Bezeichnung DESC;';
  sqlqgrid.active := false;
  sqlqgrid.sql.clear;
  sqlqgrid.sql.add(query);
  sqlqgrid.execsql;
  sqlqgrid.active := true;
end;

procedure TFormMain.MenuItem10Click(Sender: TObject);
begin
  showmessage('Das Prgramm EasyGrades und alle dazugehörigen Elemente wurden von Dominic Sprenger implementiert.');
end;

procedure TFormMain.MenuItem11Click(Sender: TObject);
begin
  FormMain.color := $00BFDFFF;
  FormLogin.color := $00BFDFFF;
  FormAddStudent.color := $00BFDFFF;
  FormRemoveStudent.color := $00BFDFFF;
  FormAccounts.color := $00BFDFFF;
end;

procedure TFormMain.MenuItem4Click(Sender: TObject);
begin
  FormMain.color := clDefault;
  FormLogin.color := clDefault;
  FormAddStudent.color := clDefault;
  FormRemoveStudent.color := clDefault;
  FormAccounts.color := clDefault;
end;

procedure TFormMain.MenuItem5Click(Sender: TObject);
begin
  FormMain.Color := clInactiveCaption;
  FormLogin.color := clInactiveCaption;
  FormAddStudent.color := clInactiveCaption;
  FormRemoveStudent.color := clInactiveCaption;
  FormAccounts.color := clInactiveCaption;
end;

procedure TFormMain.MenuItem7Click(Sender: TObject);
begin
  if Dialogs.MessageDlg('Sie werden auf eine externe Internetseite weitergeleitet, auf welcher sie Hilfe beantragen können. Sind sie damit einverstanden?',
    mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes
    then
      OpenUrl('https://www.wiredev.de/');
end;

procedure TFormMain.MenuItem8Click(Sender: TObject);
begin
  FormMain.color := clMoneyGreen;
  FormLogin.color := clMoneyGreen;
  FormAddStudent.color := clMoneyGreen;
  FormRemoveStudent.color := clMoneyGreen;
  FormAccounts.color := clMoneyGreen;
end;

procedure TFormMain.MenuItem9Click(Sender: TObject);
begin
  if FormLogin.cbkontotyp.text = 'Admin'
    then
      showmessage('Sie befinden sich im Admin-Modus und haben somit alle Rechte')
  else if FormLogin.cbkontotyp.text = 'Lehrer'
    then
      showmessage('Sie befinden sich Lehrer-Modus und haben somit keine Rechte Lehrer zu verwalten')
  else if FormLogin.cbkontotyp.text = 'Schueler'
    then
      showmessage('Sie befinden sich im Schüler-Modus und können somit nur ihre eigenen Noten sehen')
  else showmessage('Error... Bitte Programm neustarten!');
end;

procedure TFormMain.MI_closeClick(Sender: TObject);
begin
  application.terminate;
end;

procedure TFormMain.Btn_logoutClick(Sender: TObject);
begin
  if Dialogs.MessageDlg('Wirklich abmelden?',
    mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes
    then
      FormLogin.Show;
      FormMain.Hide;
      btn_lehrer.enabled := true;
      btn_addstudent.enabled := true;
      btn_removestudent.enabled := true;
      cb_lkauswahl.enabled := true;
      cb_klasse.enabled := true;
      Btn_addgrade.enabled := true;
      btn_deletegrade.enabled := true;
      FormMain.btn_openDB.enabled := true;
      btn_owngrades.enabled := true;
      sqlqgrid.active := false;
      dbgrid1.columns.clear;
      anmeldename := '';
end;

procedure TFormMain.Btn_addgradeClick(Sender: TObject);
begin
  Form_AddGrade.Show;
end;

procedure TFormMain.btn_deletegradeClick(Sender: TObject);
begin
  Form_remgrade.show;
end;

procedure TFormMain.btn_addstudentClick(Sender: TObject);
begin
  FormAddStudent.Show;
end;

end.

