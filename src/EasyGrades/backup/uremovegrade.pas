unit uRemoveGrade;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls;

type

  { TForm_RemGrade }

  TForm_RemGrade = class(TForm)
    btn_remGrade: TButton;
    btn_cancel: TButton;
    cb_student: TComboBox;
    cb_grade: TComboBox;
    ed_gewichtung: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    SQLQstudent: TSQLQuery;
    SQLQgrade: TSQLQuery;
    SQLScript: TSQLScript;
    procedure btn_cancelClick(Sender: TObject);
    procedure btn_remGradeClick(Sender: TObject);
    procedure cb_gradeSelect(Sender: TObject);
    procedure cb_studentSelect(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form_RemGrade: TForm_RemGrade;

implementation

uses uMain;

{$R *.lfm}

{ TForm_RemGrade }

procedure TForm_RemGrade.btn_cancelClick(Sender: TObject);
begin
    if Dialogs.MessageDlg('Wirklich abbrechen?',
    mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes
      then
        Form_REMGrade.Hide;
end;

procedure TForm_RemGrade.btn_remGradeClick(Sender: TObject);
var
  query: ANSIstring;
  P_ID1: integer;
  S_ID1: integer;
  Gewichtung: string;
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
  'FROM schueler WHERE P_ID='+InttoStr(P_ID1)+';';
  sqlqgrade.SQL.add(query);
  sqlqgrade.execsql;
  sqlqgrade.active := true;
  sqlqgrade.last;
  S_ID1 := sqlqgrade.fieldbyname('S_ID').Asinteger;

  sqlqgrade.sql.clear;
  query :=
  'SELECT Gewichtung From noten WHERE Note='+cb_grade.text+' AND S_ID='+IntToStr(S_ID1)+';';
  sqlqgrade.active := false;
  sqlqgrade.sql.add(query);
  sqlqgrade.ExecSQL;
  sqlqgrade.active := true;
  Gewichtung := sqlqgrade.fieldbyname('Gewichtung').Asstring;

   sqlscript.Script.Text :=
                         'DELETE FROM noten '+
                         'WHERE S_ID='+IntToStr(S_ID1)+' AND Note='+cb_grade.text+';';
   sqlscript.Execute;
   sqlscript.ExecuteScript;
   FormMain.sqltransgrid.commit;
   showmessage('Note '+cb_grade.text+' von '+cb_student.text+' erfolgreich gelöscht');
   sqlscript.script.clear;

   cb_grade.text := 'Note auswählen...';
   cb_student.text := 'Schüler auswählen...';
   ed_gewichtung.text := '';
   sqlqstudent.sql.clear;
   sqlqstudent.active := false;
   sqlqgrade.sql.clear;
   sqlqgrade.active := false;
   Form_remgrade.hide;
end;

procedure TForm_RemGrade.cb_gradeSelect(Sender: TObject);
var
  query: ANSIstring;
  P_ID1: integer;
  S_ID1: integer;
  Gewichtung: string;
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
  'FROM schueler WHERE P_ID='+InttoStr(P_ID1)+';';
  sqlqgrade.SQL.add(query);
  sqlqgrade.execsql;
  sqlqgrade.active := true;
  sqlqgrade.last;
  S_ID1 := sqlqgrade.fieldbyname('S_ID').Asinteger;

  sqlqgrade.sql.clear;
  query :=
  'SELECT Gewichtung From noten WHERE Note='+cb_grade.text+' AND S_ID='+IntToStr(S_ID1)+';';
  sqlqgrade.active := false;
  sqlqgrade.sql.add(query);
  sqlqgrade.ExecSQL;
  sqlqgrade.active := true;
  Gewichtung := sqlqgrade.fieldbyname('Gewichtung').Asstring;

  ed_gewichtung.text := Gewichtung;
end;

procedure TForm_RemGrade.cb_studentSelect(Sender: TObject);
var
  query: ANSIstring;
  P_ID1: integer;
  S_ID1: integer;
begin
  cb_grade.text := 'Note auswählen...';
  cb_grade.items.clear;
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
  'FROM schueler WHERE P_ID='+InttoStr(P_ID1)+';';
  sqlqgrade.SQL.add(query);
  sqlqgrade.execsql;
  sqlqgrade.active := true;
  sqlqgrade.last;
  S_ID1 := sqlqgrade.fieldbyname('S_ID').Asinteger;

  sqlqgrade.sql.clear;
  query :=
  'SELECT * From noten WHERE S_ID='+IntToStr(S_ID1)+';';
  sqlqgrade.active := false;
  sqlqgrade.sql.add(query);
  sqlqgrade.ExecSQL;
  sqlqgrade.active := true;
  if Cb_grade.items.count = 0
     then
         begin
           sqlqgrade.First;
           while NOT(sqlqgrade.EOF) do
           begin
             cb_grade.items.add(sqlqgrade.fieldbyname('Note').Asstring);
             sqlqgrade.next;
           end;
         end;
  sqlqgrade.first;
end;

procedure TForm_RemGrade.FormCreate(Sender: TObject);
var
  query: ANSIstring;
begin
  sqlqstudent.sql.clear;
  query :=
  'SELECT * From personen;';
  sqlqstudent.active := false;
  sqlqstudent.sql.add(query);
  sqlqstudent.ExecSQL;
  sqlqstudent.active := true;
  if Cb_student.items.count = 0
     then
         begin
           sqlqstudent.First;
           while NOT(sqlqstudent.EOF) do
           begin
             cb_student.items.add(sqlqstudent.fieldbyname('Name').Asstring);
             sqlqstudent.next;
           end;
         end;
  sqlqstudent.first;
end;

end.

