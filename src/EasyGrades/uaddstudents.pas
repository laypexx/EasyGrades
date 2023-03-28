unit uAddStudents;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls;

type

  { TFormAddStudent }

  TFormAddStudent = class(TForm)
    btn_add: TButton;
    btn_undo: TButton;
    Cb_klasse: TComboBox;
    Cb_lk1: TComboBox;
    Ed_name: TEdit;
    Edit_vorname: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    SQLQaddstudent: TSQLQuery;
    SQLScript: TSQLScript;
    procedure btn_addClick(Sender: TObject);
    procedure btn_undoClick(Sender: TObject);
  private

  public

  end;

var
  FormAddStudent: TFormAddStudent;

implementation

{$R *.lfm}

{ TFormAddStudent }

uses uMain;

procedure TFormAddStudent.btn_undoClick(Sender: TObject);
begin
  if Dialogs.MessageDlg('Wirklich abbrechen?',
    mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes
    then
      FormAddStudent.Hide;
end;

procedure TFormAddStudent.btn_addClick(Sender: TObject);
var
  query: ANSIstring;
  P_ID1: integer;
  S_ID1: integer;
  K_ID1: integer;
  KL_ID1: integer;
  F_ID1: integer;
  Jahr: integer;
begin
  if ed_name.text <> ''
    then
      begin
        if edit_vorname.text <> ''
          then
            begin
              if cb_klasse.Text <> 'Klassenstufe auswählen...'
                then
                  begin
                    if cb_lk1.text <> 'LK 1 auswählen...'
                      then
                        begin
                          sqlqaddstudent.active := false;
                          sqlqaddstudent.SQL.clear;
                          query :=
                          'SELECT P_ID '+
                          'FROM personen;';
                          sqlqaddstudent.SQL.add(query);
                          sqlqaddstudent.execsql;
                          sqlqaddstudent.active := true;
                          sqlqaddstudent.last;
                          P_ID1 := sqlqaddstudent.fieldbyname('P_ID').Asinteger;
                          P_ID1 := P_ID1+1;
                          //nächstes statement für s_id
                          sqlqaddstudent.active := false;
                          sqlqaddstudent.SQL.clear;
                          query :=
                          'SELECT S_ID '+
                          'FROM schueler;';
                          sqlqaddstudent.SQL.add(query);
                          sqlqaddstudent.execsql;
                          sqlqaddstudent.active := true;
                          sqlqaddstudent.last;
                          S_ID1 := sqlqaddstudent.fieldbyname('S_ID').Asinteger;
                          S_ID1 := S_ID1+1;
                          sqlqaddstudent.active := false;
                          sqlqaddstudent.SQL.clear;
                          query :=
                          'SELECT K_ID '+
                          'FROM kurs;';
                          sqlqaddstudent.SQL.add(query);
                          sqlqaddstudent.execsql;
                          sqlqaddstudent.active := true;
                          sqlqaddstudent.last;
                          K_ID1 := sqlqaddstudent.fieldbyname('K_ID').Asinteger;
                          K_ID1 := K_ID1+1;

                          if cb_klasse.text = 'Klasse 11'
                            then
                              KL_ID1 := 1
                          else if cb_klasse.text = 'Klasse 12'
                            then
                              KL_ID1 := 2
                          else if cb_klasse.text = 'Klasse 13'
                            then
                              KL_ID1 := 3;

                          if cb_lk1.text = 'Agrartechnik'
                            then
                              F_ID1 := 1
                          else if cb_lk1.text = 'Biotechnik'
                            then
                              F_ID1 := 2
                          else if cb_lk1.text = 'Ernährungslehre'
                            then
                              F_ID1 := 3
                          else if cb_lk1.text = 'Informatiksysteme'
                            then
                              F_ID1 := 4
                          else if cb_lk1.text = 'Gesunheit&Soziales'
                            then
                              F_ID1 := 5
                          else if cb_lk1.text = '(Maschinen-)Bautechnik'
                            then
                              F_ID1 := 6
                          else if cb_lk1.text = 'Volks und Betriebswirtschaftslehre mit Rechnungswesen'
                            then
                              F_ID1 := 7;

                          Jahr := 2023;

                          sqlscript.Script.Text :=
                          'INSERT INTO personen(P_ID, Name, Vorname) '+
                          'VALUES ('+IntToStr(P_ID1)+', '+#39+ed_name.text+#39+', '+#39+edit_vorname.text+#39+');';
                          sqlscript.Execute;
                          sqlscript.ExecuteScript;
                          FormMain.sqltransgrid.commit;
                          sqlscript.script.clear;

                          sqlscript.Script.Text :=
                          'INSERT INTO schueler(S_ID, P_ID, K_ID) '+
                          'VALUES ('+IntToStr(S_ID1)+', '+IntToStr(P_ID1)+', '+IntToStr(K_ID1)+');';
                          sqlscript.Execute;
                          sqlscript.ExecuteScript;
                          FormMain.sqltransgrid.commit;
                          sqlscript.script.clear;

                          sqlscript.Script.Text :=
                          'INSERT INTO kurs(K_ID, KL_ID, F_ID, P_ID, Jahr) '+
                          'VALUES ('+IntToStr(K_ID1)+', '+IntToStr(KL_ID1)+', '+IntToStr(F_ID1)+', '+IntToStr(P_ID1)+', '+IntToStr(Jahr)+');';
                          sqlscript.Execute;
                          sqlscript.ExecuteScript;
                          FormMain.sqltransgrid.commit;
                          sqlscript.script.clear;

                          showmessage('Schüler '+edit_vorname.text+' '+ed_name.text+' erfolgreich hinzugefügt!');
                          sqlscript.script.clear;
                          P_ID1 := 0;
                          S_ID1 := 0;
                          K_ID1 := 0;
                          KL_ID1 := 0;
                          F_ID1 := 0;
                          Jahr := 0;
                          cb_klasse.text := 'Klassenstufe auswählen...';
                          cb_lk1.text := 'LK auswählen...';
                          edit_vorname.text := '';
                          ed_name.text := '';
                          FormAddStudent.Hide;

                        end else showmessage('Leistungskurs auswählen!')
                  end else showmessage('Klassenstufe auswählen!')
            end else showmessage('Vorname eintragen!')
      end else showmessage('Name eintragen!')
end;

end.

