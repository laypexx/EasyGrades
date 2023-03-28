unit uAccountsClass;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type

  { Accounts }

  Accounts = class
    private
       Account_typ: string;
       Account_PW: string;
       Account_Name: string;
    public
      constructor Create(OAccount_typ: string; OAccount_PW:string; OAccount_Name: string);
      function get_typ: string;
      function get_pw: string;
      function get_name: string;
  end;

implementation

{ Accounts }

constructor Accounts.Create(OAccount_typ: string; OAccount_PW: string;
  OAccount_Name: string);
begin
  inherited create;
  Account_typ := OAccount_typ;
  Account_PW := OAccount_PW;
  Account_Name := OAccount_Name;
end;

function Accounts.get_typ: string;
begin

end;

function Accounts.get_pw: string;
begin

end;

function Accounts.get_name: string;
begin

end;

end.

