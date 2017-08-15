unit graphsmo;
interface
uses crt, graph,  funcsmo;

type
  {array20 = array[1..20] of real;}

  graphik = object
    procedure drawOXOY(L: real; Ch: char);
    procedure drawGraph(M1: array20; M2: array20; M3: array20);
    end;

var driver_1, mode_1:integer;  {NOT TO USE SAME NAMES IN MODULES}

implementation

procedure graphik.drawOXOY(L: real; Ch: char);
var driver, mode: integer;
    s: string;
 begin
   str(L:2:1, s);
   line(50, GetMaxY-100, GetMaxX-55, GetMaxY-100);  {ox}  {535 pix}
   line(getmaxx-55, getmaxy-100, GetmaxX-64, GetmaxY-103);
   line(getmaxx-55, getmaxy-100, getmaxx-64, getmaxy-97);
   line(50, getmaxy-100, 50, 47);  {oy}
   line(50, 47, 46, 57);
   line(50, 47, 54, 57);
   outtextxy(GetMaxx-49, getMaxY-103, 'L dev');      
   outtextxy(77, GetMaxY-90, '1');
   outtextxy(GetMaxX-120, GetMaxY-90, '1+10L');   {working area ox = 488, dx = 48}
   outtextxy(130, getMaxY-50, 'L=');
   outtextxy(150, getMaxY-50, s);    {L VALUE}
   if Ch='M' then
     begin
       outtextxy(50, 20, 'M');       
     end;
   if Ch='P' then
     begin
       outtextxy(50,20, 'P');
     end;
   outtextxy(5, 70, '100%');
   outtextxy(10, getmaxy-140, '10%');     {working area oy = 300, dx = 30}
   delay(3000);                {DELETE}
 end;

procedure graphik.drawGraph(M1: array20; M2: array20; M3:array20);    {1,4,14}
var point, color, i: integer;
    arrayOX: array [1..11] of integer;
    arrayOY: array[1..11] of integer;
 begin
   color:=1;
   setcolor(color);
   point:=round(M1[1]);
   arrayOY[1]:=GetMaxY-100-point*3;
   arrayOX[1]:=77;
   for i:=2 to 11 do
     begin
       point:=round(M1[i]);
       arrayOX[i]:=arrayOX[i-1]+48;
       arrayOY[i]:=GetMaxY-100-point*3;
     end;
   for i:=1 to 10 do
     begin
       line(arrayOX[i], arrayOY[i], arrayOX[i+1], arrayOY[i+1]);
     end;
   color:=4;
   setcolor(color);
   point:=round(M2[1]);
   arrayOY[1]:=GetMaxY-100-point*3;
   arrayOX[1]:=77;
   for i:=2 to 11 do
     begin
       point:=round(M2[i]);
       arrayOX[i]:=arrayOX[i-1]+48;
       arrayOY[i]:=GetMaxY-100-point*3;
     end;
   for i:=1 to 10 do
     begin
       line(arrayOX[i], arrayOY[i], arrayOX[i+1], arrayOY[i+1]);
     end;
   color:=14;
   setcolor(color);
   point:=round(M3[1]);
   arrayOY[1]:=GetMaxY-100-point*3;
   arrayOX[1]:=77;
   for i:=2 to 11 do
     begin
       point:=round(M3[i]);
       arrayOX[i]:=arrayOX[i-1]+48;
       arrayOY[i]:=GetMaxY-100-point*3;
     end;
   for i:=1 to 10 do
     begin
       line(arrayOX[i], arrayOY[i], arrayOX[i+1], arrayOY[i+1]);
     end;
   delay(4000);
 end;

begin
end.