unit funcSMO;

Interface
uses crt;

const bufferSize = 2;
const numberOfSources = 3;

type

  arraytypeTime = array[1..NumberOfSources] of real;
  arraytypeBuffer = array[1..bufferSize] of real;
  arraytypeBufferInt=array[1..bufferSize] of integer;
  arraytypeLyambdas = array[1..11] of real;
  arraytypeSourceLyambdas = array[1..3] of real;
  array11= array[1..11] of real;

  source = object
    arraySourceLyambdas: arraytypeSourceLyambdas;
    arraySourceTime: arraytypeTime;
    arrayMathWait1: array11;
    arrayMathWait2: array11;
    arrayMathWait3: array11;
    arrayPosibility1: array11;
    arrayPosibility2: array11;
    arrayPosibility3: array11;
    doneRequests: longint;
    refuseRequests: longint;
    allrequests: longint;
    minTime: real;
    minTimeIndex: byte;
    timeGeneration: real;
    procedure getGenerationTime(numberSource: byte);
    procedure findMIN;
    procedure makeFree;
    end;

  buffer = object
    buff: arraytypeBuffer;
    sourceIndex: arraytypeBufferInt;
    buffIndex: byte;
    timeWaiting: real;
    procedure makeFree;
    end;

  device = object
    lyambda: real;
    arrayLyambdas: arraytypeLyambdas;
    timeRealization: real;
    afterProcess: real;
    procedure getNewRealizationTime(LyambdaIndex: byte);
    end;

Implementation

procedure source.makeFree;
  var i: byte;
  begin
    for i:=1 to 3 do
      begin
        arraySourceTime[i]:=0;
      end;
    doneRequests:=0;
    refuseRequests:=0;
    allRequests:=0;
    minTime:=0;
    minTimeIndex:=0;
  end;

procedure buffer.makeFree;
  var i: byte;
  begin
    for i:=1 to 2 do
      begin
        buff[i]:=0;
        sourceIndex[i]:=0;
      end;
    buffIndex:=0;
    timeWaiting:=0;
  end;


procedure source.getGenerationTime(numberSource: byte);
  var R1, R2: real;
  begin
        R1:=random;
        R2:=random;
    timeGeneration:=(-1/arraySourceLyambdas[numberSource])*(ln(R1)+ln(R2)); {.......................}
  end;

procedure source.findMIN;
  begin
    if arraySourceTime[1]<=arraySourceTime[2] then
      begin
        minTime:=arraySourceTime[1];
        minTimeIndex:=1;
      end
    else
      begin
        minTime:=arraySourceTime[2];
        minTimeIndex:=2;
      end;
    if arraySourceTime[3]<minTime then
      begin
        minTime:=arraySourceTime[3];
        minTimeIndex:=3;
      end;
  end;

procedure device.getNewRealizationTime(LyambdaIndex: byte);
  var R: real;
  begin
  R := random;
  while (R=0) do
     begin
      R:=random;
     end;
    timeRealization:=-1/arrayLyambdas[LyambdaIndex]*ln(R);
  end;

begin
end.

