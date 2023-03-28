unit uaccounts;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, DbCtrls;

type

  { TFormAccounts }

  TFormAccounts = class(TForm)
    btn_close: TButton;
    btn_add: TButton;
    btn_remove: TButton;
    cb_acc: TComboBox;
    ed_name: TEdit;
    ed_vorname: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Shape1: TShape;
    SQLQacc: TSQLQuery;
    SQLScript: TSQLScript;
    procedure btn_addClick(Sender: TObject);
    procedure btn_closeClick(Sender: TObject);
    procedure btn_removeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  FormAccounts: TFormAccounts;

implementation

uses uMain;

{$R *.lfm}

{ TFormAccounts }

procedure TFormAccounts.btn_closeClick(Sender: TObject);
begin
  if Dialogs.MessageDlg('Wirklich abbrechen?',
    mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes
    then
      FormAccounts.Hide;
end;

procedure TFormAccounts.btn_removeClick(Sender: TObject);
var
  query: ANSIstring;
  P_ID1: string;
begin
  if cb_acc.text <> 'Namen auswählen..'
    then
      begin
        sqlqacc.active := false;
        sqlqacc.SQL.clear;
        query :=
        'SELECT P_ID '+
        'FROM personen '+
        'WHERE Name= '+#39+cb_acc.text+#39+';';
        sqlqacc.SQL.add(query);
        sqlqacc.execsql;
        sqlqacc.active := true;
        P_ID1 := sqlqacc.fieldbyname('P_ID').Asstring;

        showmessage(P_ID1);

        sqlscript.Script.Text :=
                              'DELETE FROM personen '+
                              'WHERE P_ID='+P_ID1+';';
        sqlscript.Execute;
        sqlscript.ExecuteScript;
        FormMain.sqltransgrid.commit;
        sqlscript.script.clear;

        sqlscript.Script.Text :=
                              'DELETE FROM admin '+
                              'WHERE P_ID='+P_ID1+';';
        sqlscript.Execute;
        sqlscript.ExecuteScript;
        FormMain.sqltransgrid.commit;
        showmessage('Account '+cb_acc.text+' gelöscht!');
        sqlscript.script.clear;
        sqlqacc.active := false;
        sqlqacc.sql.clear;
        sqlqacc.SQL.add('SELECT Name FROM (personen INNER JOIN Admin on personen.P_ID=admin.P_ID);');
        sqlqacc.execsql;
        sqlqacc.active := true;
        sqlqacc.applyupdates;
        sqlqacc.refresh;
        cb_acc.items.clear;
        if Cb_acc.items.count = 0
           then
               begin
                sqlqacc.First;
                 while NOT(sqlqacc.EOF) do
                  begin
                    cb_acc.items.add(sqlqacc.fieldbyname('Name').Asstring);
                    sqlqacc.next;
                  end;
               end;
               sqlqacc.first;
        cb_acc.text := 'Namen auswählen..';
        FormAccounts.hide;
      end
  else showmessage('Bitte Namen auswählen!');
end;

procedure TFormAccounts.FormCreate(Sender: TObject);
begin
  if Cb_acc.items.count = 0
     then
         begin
           sqlqacc.First;
           while NOT(sqlqacc.EOF) do
           begin
             cb_acc.items.add(sqlqacc.fieldbyname('Name').Asstring);
             sqlqacc.next;
           end;
         end;
  sqlqacc.first;
end;

procedure TFormAccounts.btn_addClick(Sender: TObject);
var
  query: ANSIstring;
  P_ID1: integer;
begin
  if ed_vorname.text <> ''
    then
      begin
        if ed_name.text <> ''
          then
            begin
              sqlqacc.active := false;
              sqlqacc.SQL.clear;
              query :=
              'SELECT P_ID '+
              'FROM personen;';
              sqlqacc.SQL.add(query);
              sqlqacc.execsql;
              sqlqacc.active := true;
              sqlqacc.last;
              P_ID1 := sqlqacc.fieldbyname('P_ID').Asinteger;
              P_ID1 := P_ID1+1;
              sqlscript.Script.Text :=
              'INSERT INTO personen(P_ID, Name, Vorname) '+
              'VALUES ('+IntToStr(P_ID1)+', '+#39+ed_name.text+#39+', '+#39+ed_vorname.text+#39+');';
              sqlscript.Execute;
              sqlscript.ExecuteScript;
              FormMain.sqltransgrid.commit;
              sqlscript.script.clear;
              sqlscript.Script.Text :=
              'INSERT INTO Admin(P_ID) '+
              'VALUES ('+IntToStr(P_ID1)+');';
              sqlscript.Execute;
              sqlscript.ExecuteScript;
              FormMain.sqltransgrid.commit;
              sqlscript.script.clear;
              showmessage('Admin-Account/Person '+ed_vorname.text+' '+ed_name.text+' erfolgreich hinzugefügt!');
              sqlqacc.active := false;
              sqlqacc.sql.clear;
              sqlqacc.SQL.add('SELECT Name FROM (personen INNER JOIN Admin on personen.P_ID=admin.P_ID);');
              sqlqacc.execsql;
              sqlqacc.active := true;
              sqlqacc.applyupdates;
              sqlqacc.refresh;
              cb_acc.items.clear;
              if Cb_acc.items.count = 0
                 then
                     begin
                          sqlqacc.First;
                          while NOT(sqlqacc.EOF) do
                                begin
                                     cb_acc.items.add(sqlqacc.fieldbyname('Name').Asstring);
                                     sqlqacc.next;
                                end;
                     end;
               sqlqacc.first;
              ed_vorname.text := '';
              ed_name.text := '';
              FormAccounts.hide;
            end;
      end
  else showmessage('Bitte Anmeldenamen eintragen!');
end;

end.

