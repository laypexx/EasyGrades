unit uremovestudent;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls;

type

  { TFormRemoveStudent }

  TFormRemoveStudent = class(TForm)
    Btn_remove: TButton;
    Btn_cancel: TButton;
    cb_student: TComboBox;
    DS_students: TDataSource;
    Ed_vorname: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SQLQremStudent: TSQLQuery;
    SQLScript: TSQLScript;
    procedure Btn_cancelClick(Sender: TObject);
    procedure Btn_removeClick(Sender: TObject);
    procedure Ed_vornameChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  FormRemoveStudent: TFormRemoveStudent;

implementation

uses uMain;

{$R *.lfm}

{ TFormRemoveStudent }

procedure TFormRemoveStudent.Btn_cancelClick(Sender: TObject);
begin
  if Dialogs.MessageDlg('Wirklich abbrechen?',
    mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes
    then
      FormRemoveStudent.Hide;
      cb_student.items.clear;
      cb_student.text := 'Nachnamen auswählen...';
      ed_vorname.text := '';
      sqlqremstudent.sql.clear;
end;

procedure TFormRemoveStudent.Btn_removeClick(Sender: TObject);
var
  query: ANSIstring;
  P_ID1: string;
  S_ID1: string;
begin
  if ed_vorname.text <> ''
    then
      begin
      if cb_student.text <> 'Nachnamen auswählen...'
        then
      begin
        sqlqremstudent.active := false;
        sqlqremstudent.SQL.clear;
        query :=
        'SELECT P_ID '+
        'FROM personen '+
        'WHERE Vorname= '+#39+ed_vorname.text+#39+' AND Name= '+#39+cb_student.text+#39+';';
        sqlqremstudent.SQL.add(query);
        sqlqremstudent.execsql;
        sqlqremstudent.active := true;
        P_ID1 := sqlqremstudent.fieldbyname('P_ID').Asstring;
        //nächstes statement für s_id
        sqlqremstudent.active := false;
        sqlqremstudent.SQL.clear;
        query :=
        'SELECT S_ID '+
        'FROM (personen INNER JOIN schueler on personen.P_ID=schueler.P_ID) '+
        'WHERE schueler.P_ID='+P_ID1+';';
        sqlqremstudent.SQL.add(query);
        sqlqremstudent.execsql;
        sqlqremstudent.active := true;
        S_ID1 := sqlqremstudent.fieldbyname('S_ID').Asstring;

        //statements zum löschen

        sqlscript.Script.Text :=
                              'DELETE FROM personen '+
                              'WHERE P_ID='+P_ID1+';';
        sqlscript.Execute;
        sqlscript.ExecuteScript;
        FormMain.sqltransgrid.commit;
        sqlscript.script.clear;

        sqlscript.Script.Text :=
                              'DELETE FROM schueler '+
                              'WHERE S_ID='+S_ID1+';';
        sqlscript.Execute;
        sqlscript.ExecuteScript;
        FormMain.sqltransgrid.commit;
        sqlscript.script.clear;

        sqlscript.Script.Text :=
                              'DELETE FROM noten '+
                              'WHERE S_ID='+S_ID1+';';
        sqlscript.Execute;
        sqlscript.ExecuteScript;
        FormMain.sqltransgrid.commit;
        sqlscript.script.clear;

        sqlscript.Script.Text :=
                              'DELETE FROM kurs '+
                              'WHERE P_ID='+P_ID1+';';
        sqlscript.Execute;
        sqlscript.ExecuteScript;
        FormMain.sqltransgrid.commit;
        sqlscript.script.clear;

        showmessage('Schüler '+ed_vorname.text+' '+cb_student.text+' erfolgreich gelöscht');
        sqlqremstudent.sql.clear;
        P_ID1 := '';
        S_ID1 := '';
        cb_student.items.clear;
        cb_student.text := 'Nachnamen auswählen...';
        ed_vorname.text := '';
        FormRemoveStudent.Hide;

      end else showmessage('Bitte Vornamen eintragen!');
      end else showmessage ('Bitte Nachnamen auswählen!');
end;

procedure TFormRemoveStudent.Ed_vornameChange(Sender: TObject);
var
  query: ANSIstring;
begin
  sqlqremstudent.active := false;
  sqlqremstudent.SQL.clear;
  query :=
  'SELECT Name '+
  'FROM personen '+
  'WHERE Vorname= '+#39+ed_vorname.text+#39+';';
  sqlqremstudent.SQL.add(query);
  sqlqremstudent.execsql;
  sqlqremstudent.active := true;
  if Cb_student.items.count = 0
     then
         begin
           sqlqremstudent.First;
           while NOT(sqlqremstudent.EOF) do
           begin
             cb_student.items.add(sqlqremstudent.fieldbyname('Name').Asstring);
             sqlqremstudent.next;
           end;
         end;
  sqlqremstudent.first;
end;

procedure TFormRemoveStudent.FormCreate(Sender: TObject);
begin
  sqlqremstudent.SQL.clear;
end;

end.

