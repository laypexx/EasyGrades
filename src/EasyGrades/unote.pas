unit uNote;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type

  { Note }

  Note = class
    private
      Noten: string;
      Ergebnis: integer;
      Kursnote: integer;
      Zeugnisnote: integer;
    public
      Constructor Create(ONoten: string; OErgebnis: integer; OKursnote: integer; OZeugnisnote: integer);
      function get_noten: string;
      function get_ergebnis: integer;
      function get_kursnote: integer;
      function get_Zeugnisnote: integer;
  end;

implementation

{ Note }

constructor Note.Create(ONoten: string; OErgebnis: integer;
  OKursnote: integer; OZeugnisnote: integer);
begin
  inherited Create;
  Noten := ONoten;
  Ergebnis := OErgebnis;
  Kursnote := OKursnote;
  Zeugnisnote := OZeugnisnote;
end;

function Note.get_noten: string;
begin

end;

function Note.get_ergebnis: integer;
begin

end;

function Note.get_kursnote: integer;
begin

end;

function Note.get_Zeugnisnote: integer;
begin

end;

end.

