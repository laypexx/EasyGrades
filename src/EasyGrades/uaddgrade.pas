unit uAddGrade;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls;

type

  { TForm_AddGrade }

  TForm_AddGrade = class(TForm)
    btn_addgrade: TButton;
    btn_cancel: TButton;
    cb_gewichtung: TComboBox;
    cb_student: TComboBox;
    ed_grade: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    SQLQgrade: TSQLQuery;
    SQLScript: TSQLScript;
    procedure btn_addgradeClick(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form_AddGrade: TForm_AddGrade;

implementation

uses uMain;

{$R *.lfm}

{ TForm_AddGrade }

procedure TForm_AddGrade.btn_cancelClick(Sender: TObject);
begin
  if Dialogs.MessageDlg('Wirklich abbrechen?',
    mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes
    then
      Form_AddGrade.Hide;
end;

procedure TForm_AddGrade.FormCreate(Sender: TObject);
begin
  if Cb_student.items.count = 0
     then
         begin
           sqlqgrade.First;
           while NOT(sqlqgrade.EOF) do
           begin
             cb_student.items.add(sqlqgrade.fieldbyname('Name').Asstring);
             sqlqgrade.next;
           end;
         end;
  sqlqgrade.first;
end;

procedure TForm_AddGrade.btn_addgradeClick(Sender: TObject);
var
  query: ANSIstring;
  P_ID1: integer;
  S_ID1: integer;
  K_ID1: integer;
  N_ID1: integer;
begin
  if cb_student.text <> 'Schüler auswählen...'
    then
      begin
              if ed_grade.text <> ''
                then
                  begin
                    sqlqgrade.active := false;
                    sqlqgrade.SQL.clear;
                    query :=
                    'SELECT P_ID '+
                    'FROM personen WHERE Name='+#39+cb_student.text+#39+';';
                    sqlqgrade.SQL.add(query);
                    sqlqgrade.execsql;
                    sqlqgrade.active := true;
                    sqlqgrade.last;
                    P_ID1 := sqlqgrade.fieldbyname('P_ID').Asinteger;

                    sqlqgrade.active := false;
                    sqlqgrade.SQL.clear;
                    query :=
                    'SELECT * '+
                    'FROM kurs WHERE P_ID='+InttoStr(P_ID1)+';';
                    sqlqgrade.SQL.add(query);
                    sqlqgrade.execsql;
                    sqlqgrade.active := true;
                    sqlqgrade.last;
                    P_ID1 := sqlqgrade.fieldbyname('P_ID').Asinteger;
                    K_ID1 := sqlqgrade.fieldbyname('K_ID').Asinteger;

                    sqlqgrade.active := false;
                    sqlqgrade.SQL.clear;
                    query :=
                    'SELECT * '+
                    'FROM schueler WHERE P_ID='+InttoStr(P_ID1)+';';
                    sqlqgrade.SQL.add(query);
                    sqlqgrade.execsql;
                    sqlqgrade.active := true;
                    sqlqgrade.last;
                    S_ID1 := sqlqgrade.fieldbyname('S_ID').Asinteger;

                    sqlqgrade.active := false;
                    sqlqgrade.SQL.clear;
                    query :=
                    'SELECT N_ID '+
                    'FROM noten;';
                    sqlqgrade.SQL.add(query);
                    sqlqgrade.execsql;
                    sqlqgrade.active := true;
                    sqlqgrade.last;
                    sqlqgrade.sql.clear;
                    N_ID1 := sqlqgrade.fieldbyname('N_ID').Asinteger;
                    N_ID1 := N_ID1+1;

                    sqlscript.Script.Text :=
                    'INSERT INTO Noten(N_ID, S_ID, K_ID, Note, Gewichtung) '+
                    'VALUES ('+IntToStr(N_ID1)+', '+IntToStr(S_ID1)+', '+IntToStr(K_ID1)+', '+#39+ed_grade.text+#39+', '+#39+cb_gewichtung.text+#39+');';
                    sqlscript.Execute;
                    sqlscript.ExecuteScript;
                    FormMain.sqltransgrid.commit;
                    showmessage('Note '+ed_grade.text+' erfolgreich zu '+cb_student.text+' hinzugefügt');
                    sqlscript.script.clear;
                    query := 'SELECT * FROM personen;';
                    sqlqgrade.active := false;
                    sqlqgrade.sql.add(query);
                    sqlqgrade.execsql;
                    sqlqgrade.Active := true;
                    cb_student.text := 'Schüler auswählen...';
                    ed_grade.text := '';
                    cb_gewichtung.text := 'Gewichtung auswählen...';

                  end else showmessage('Note einschreiben!');
      end else showmessage('Schüler auswählen!');
end;

end.

