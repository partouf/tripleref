program tripleref;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  SysUtils;

type
  PTHING = ^THING;
  PPTHING = ^PTHING;

  THING = record
    item: string;
    next: PTHING;
  end;

var
  start: ^THING;


function NewElement(const text: string): PTHING;
begin
  NewElement := PTHING(AllocMem(sizeof(THING)));
  NewElement^.item := text;
  NewElement^.next := nil;
end;

procedure InsertThing(head: PPTHING; newp: PTHING);
var
  tracer: PPTHING;
begin
  tracer := head;

  while (tracer^ <> nil) and (CompareStr(tracer^^.item, newp^.item) < 1) do
  begin
    tracer := Addr(tracer^^.next);
  end;

  newp^.next := tracer^;
  tracer^ := newp;
end;

procedure PrintList(head: PPTHING);
var
  tracer: PPTHING;
begin
  tracer := head;
  while (tracer^ <> nil) do
  begin
    Writeln(tracer^^.item);
    tracer := Addr(tracer^^.next);
  end;
end;

procedure main;
begin
  InsertThing(@start, NewElement('chips'));
  InsertThing(@start, NewElement('wine'));
  InsertThing(@start, NewElement('burgers'));
  InsertThing(@start, NewElement('beer'));
  InsertThing(@start, NewElement('pizza'));
  InsertThing(@start, NewElement('zucchini'));
  InsertThing(@start, NewElement('burgers'));
  InsertThing(@start, NewElement('slaw'));
  PrintList(@start);
end;

begin
  start := nil;

  main;
end.

