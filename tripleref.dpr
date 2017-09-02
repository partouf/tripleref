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
  Result := PTHING(AllocMem(sizeof(THING)));
  Result^.item := text;
  Result^.next := nil;
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

procedure RemoveThing(thing: PPTHING; const text: string);
var
  present: Boolean;
  old: PTHING;
  tracer: PPTHING;
begin
  present := False;
  tracer := thing;

  // note: can't do assignment while comparing in Pascal like you can do in C
  // original C: while((*tracer) && !(present = (strcmp(text,(*tracer)->item) == 0 )  )) {tracer = &(*tracer)->next;}
  while (tracer^ <> nil) do
  begin
    present := (CompareStr(text, tracer^^.item) = 0);
    if present then
      break;

    tracer := Addr(tracer^^.next);
  end;

  if present then
  begin
    old := tracer^;
    tracer^ := tracer^^.next;
    FreeMem(old);
  end;
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

  WriteLn('');
  Writeln('INITIAL LIST');
  PrintList(@start);

  RemoveThing(@start, 'pizza');
  RemoveThing(@start, 'zucchini');
  RemoveThing(@start, 'burgers');

  WriteLn('');
  Writeln('ALTERED LIST');
  PrintList(@start);
end;

begin
  start := nil;

  main;
end.

