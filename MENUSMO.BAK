uses crt, graph, funcsmo, graphsmo;

type 
     buttonClass = object
     x: integer;
     y: integer;        {place}
     focused: boolean;
     name: string;
     procedure draw(m_name: string);
     procedure getFocuse;
     procedure lostFocuse;
     end;

     arraytypeButton = array[1..4] of buttonClass; 
     {arraytypeButtonResult = array[1..3] of buttonClass;}

     list = ^elem;
     elem = record
       data: buttonClass;
       next: list;
       prev: list;
     end;

     helptype = ^menuSecondFloorResult;

     menuFirstFloor = object
     {arrayButton: arraytypeButton; }
     resultSecondFloor: helptype;
     procedure draw;
     procedure init;
     {function getFirstElem: list;}
     procedure choosing(var array_: arraytypeButton);
     procedure firstFloor(max: integer; var array_: arraytypeButton);
     procedure goSecondFloor(var array_: arraytypeButton);
     procedure setSettings;
     procedure showSettings;
     end;

     menuSecondFloorResult = object
     ToFirstFloor: menuFirstFloor;
     procedure init;
     procedure draw;
     procedure showGraphic;
     procedure showTable;
     procedure menuResult;
     procedure goNextFloor;
     procedure complete;
     end;
{--------------------------FROM MAINSMO------------BEGIN--------------------------------}
     arraytypeLongint = array[1..11] of longint;
     arraytypeReal = array[1..11] of real;
{--------------------------FROM MAINSMO------------END----------------------------------}

{--------------------------FROM MAINSMO------------BEGIN--------------------------------}
var source_:source;
    buffer_:buffer;
    device_:device;
    graphik_:graphik;
    w: integer;
    f, f2: text;
    lengthRealization: integer;
    graph_: graphik;



    a:char;
    driver, mode, i: integer;
    menu: menuFirstFloor;
    buttonStart: buttonClass;                 {FROM MENUSMO}
    buttonSettings: buttonClass;
    buttonResult: buttonClass;
    buttonExit: buttonClass;
    buttonResultGraphic: buttonClass;
    buttonResultTable: buttonClass;
    buttonResultGoBack: buttonClass;
    arrayButton, arrayButtonResult: arraytypeButton;




    outDataAllRequests: array[1..11] of longint;

    outDataAllRequests1: array[1..11] of longint;
    outDataDoneRequests1: array[1..11] of longint;
    outDataRefuseRequests1: array[1..11] of longint;
    outDataTimeWaiting1: array[1..11] of real;

    outDataAllRequests2: array[1..11] of longint;
    outDataDoneRequests2: array[1..11] of longint;
    outDataRefuseRequests2: array[1..11] of longint;
    outDataTimeWaiting2: array[1..11] of real;

    outDataAllRequests3: array[1..11] of longint;
    outDataDoneRequests3: array[1..11] of longint;
    outDataRefuseRequests3: array[1..11] of longint;
    outDataTimeWaiting3: array[1..11] of real;

    procedure RecAllReq;
    begin
      if source_.minTimeIndex=1 then
        outDataAllRequests1[w]:=outDataAllRequests1[w]+1;
      if source_.minTimeIndex=2 then
        outDataAllRequests2[w]:=outDataAllRequests2[w]+1;
      if source_.minTimeIndex=3 then
        outDataAllRequests3[w]:=outDataAllRequests3[w]+1;
    end;

    procedure RecDoneReq(t: byte);
    begin
      if t =1 then
        outDataDoneRequests1[w]:=outDataDoneRequests1[w]+1;
      if t =2 then
        outDataDoneRequests2[w]:=outDataDoneRequests2[w]+1;
      if t =3 then
        outDataDoneRequests3[w]:=outDataDoneRequests3[w]+1;
    end;

    procedure RecRefReq;
    begin
     if source_.minTimeIndex=1 then
        outDataRefuseRequests1[w]:=outDataRefuseRequests1[w]+1;
     if source_.minTimeIndex=2 then
        outDataRefuseRequests2[w]:=outDataRefuseRequests2[w]+1;
     if source_.minTimeIndex=3 then
        outDataRefuseRequests3[w]:=outDataRefuseRequests3[w]+1;
    end;

    procedure RecWaitReq(a: integer; max: real);
      
      begin
      
        if a=1 then
          outDataTimeWaiting1[w]:=outDataTimeWaiting1[w]+abs(device_.afterProcess-max);
        if a=2 then
          outDataTimeWaiting2[w]:=outDataTimeWaiting2[w]+abs(device_.afterProcess-max);
        if a=3 then
          outDataTimeWaiting3[w]:=outDataTimeWaiting3[w]+abs(device_.afterProcess-max);
      end;

    procedure takeFromBuff;
    var i, t: byte;
        maxPriority: real;

      begin
        if buffer_.buffIndex=2 then
          begin
            if buffer_.sourceIndex[1]<buffer_.sourceIndex[2] then
              begin
                maxPriority:=buffer_.buff[1];
                t:=buffer_.sourceIndex[1];
                buffer_.buff[1]:=buffer_.buff[2];
                buffer_.sourceIndex[1]:=buffer_.sourceIndex[2];
                buffer_.buff[2]:=0;
                buffer_.sourceIndex[2]:=0;

              end
            else if buffer_.sourceIndex[1]>buffer_.sourceIndex[2] then
              begin
                maxPriority:=buffer_.buff[2];
                t:=buffer_.sourceIndex[2];
                buffer_.buff[2]:=0;
                buffer_.sourceIndex[2]:=0;
              end
            else if buffer_.sourceIndex[1]=buffer_.sourceIndex[2] then
              begin
                if buffer_.buff[1]<buffer_.buff[2] then
                  begin
                    maxPriority:=buffer_.buff[1];
                    t:=buffer_.sourceIndex[1];
                    buffer_.buff[1]:=buffer_.buff[2];
                    buffer_.buff[2]:=0;
                    buffer_.sourceIndex[2]:=0;
                  end
                else
                  begin
                    maxPriority:=buffer_.buff[2];
                    t:=buffer_.sourceIndex[2];
                    buffer_.buff[2]:=0;
                    buffer_.sourceIndex[2]:=0;
                  end;
              end;
          end;
        if buffer_.buffIndex=1 then
          begin
            maxPriority:=buffer_.buff[1];
            t:=buffer_.sourceIndex[1];
          end;
          buffer_.timeWaiting:=buffer_.timeWaiting+device_.afterProcess-maxPriority;
          RecWaitReq(t, maxPriority);
          device_.getNewRealizationTime(w);
          device_.afterProcess:=maxPriority+device_.timeRealization;
          source_.doneRequests:=source_.doneRequests+1;  
          RecDoneReq(t);                  
      end;

    procedure realization(key: byte);
     var i, kmin, k, percentint, dx, dy, x, y: integer;
         percentreal, num: real;
     begin
      assign(f, 'd:/smo/foutsmo.txt');
      assign(f2, 'd:/smo/foutsmo2.txt');
      rewrite(f);
      rewrite(f2);
      kmin:=10;
      k:=1;
      {device_.lyambda:=0.4;    {make it changable}
      {device_.arrayLyambdas[1]:=1;
      for i:=2 to 11 do
        begin
          device_.arrayLyambdas[i]:=device_.arrayLyambdas[i-1]+device_.lyambda;
        end;}

    {  for i:=1 to 3 do
        begin}
          {source_.arraySourceLyambdas[1]:=1;
          source_.arraySourceLyambdas[2]:=2;
          source_.arraySourceLyambdas[3]:=3;   }   {make it changable}
      {  end;  }

     for i:=1 to 11 do
       begin
         outDataAllRequests1[i]:=0;
         outDataDoneRequests1[i]:=0;
         outDataRefuseRequests1[i]:=0;
         outDataTimeWaiting1[i]:=0;

         outDataAllRequests2[i]:=0;
         outDataDoneRequests2[i]:=0;
         outDataRefuseRequests2[i]:=0;
         outDataTimeWaiting2[i]:=0;

         outDataAllRequests3[i]:=0;
         outDataDoneRequests3[i]:=0;
         outDataRefuseRequests3[i]:=0;
         outDataTimeWaiting3[i]:=0;
       end;

      w:=1;
      while (w <= 11) do begin
      source_.makeFree;
      buffer_.makeFree;
      randomize;

      for i:=1 to 3 do
        begin
          source_.getGenerationTime(i);
          source_.arraySourceTime[i]:=source_.TimeGeneration;
        end;
      source_.allRequests:=3;
      outDataAllRequests1[w]:=1;
      outDataAllRequests2[w]:=1;
      outDataAllRequests3[w]:=1;
      source_.findMIN;
      device_.getNewRealizationTime(w);

      device_.afterProcess:=source_.arraySourceTime[source_.minTimeIndex]+device_.timeRealization;
      source_.doneRequests:=1;
      RecDoneReq(source_.minTimeIndex);

      source_.getGenerationTime(source_.minTimeIndex);
      source_.arraySourceTime[source_.minTimeIndex]:=
        source_.arraySourceTime[source_.minTimeIndex]+source_.timeGeneration;
      source_.allRequests:=source_.allRequests+1;
      RecAllReq;


      while (outDataAllRequests1[w]<lengthRealization) or 
            (outDataAllRequests2[w]<lengthRealization) or 
            (outDataAllRequests3[w]<lengthRealization) do
        begin
          source_.findMIN;
          while device_.afterProcess>source_.minTime do
            begin
              if buffer_.buffIndex<>bufferSize then
                begin
                  if buffer_.buffIndex=0 then
                    begin
                      buffer_.buff[1]:=source_.arraySourceTime[source_.minTimeIndex];
                      buffer_.sourceIndex[1]:=source_.minTimeIndex;
                      source_.getGenerationTime(source_.minTimeIndex);
                      source_.arraySourceTime[source_.minTimeIndex]:=
                         source_.arraySourceTime[source_.minTimeIndex]+source_.timeGeneration;
                      RecAllReq;
                      source_.findMIN;
                      source_.allRequests:=source_.allRequests+1;
                      buffer_.buffIndex:=buffer_.buffIndex+1;
                    end
                  else if buffer_.buffIndex=1 then
                    begin
                      buffer_.buff[2]:=source_.arraySourceTime[source_.minTimeIndex];
                      buffer_.sourceIndex[2]:=source_.minTimeIndex;
                      source_.getGenerationTime(source_.minTimeIndex);
                      source_.arraySourceTime[source_.minTimeIndex]:=
                         source_.arraySourceTime[source_.minTimeIndex]+source_.timeGeneration;
                      RecAllReq;
                      source_.findMIN;
                      source_.allRequests:=source_.allRequests+1;
                      buffer_.buffIndex:=buffer_.buffIndex+1;
                    end;
                end
              else if buffer_.buffIndex=2 then
                begin
                  source_.refuseRequests:=source_.refuseRequests+1;
                  RecRefReq;
                  source_.getGenerationTime(source_.minTimeIndex);
                  source_.arraySourceTime[source_.minTimeIndex]:=
                     source_.arraySourceTime[source_.minTimeIndex]+source_.timeGeneration;
                  source_.allRequests:=source_.allRequests+1;
                  RecAllReq;
                  source_.findMIN;
                  {if (outDataAllRequests1[w]=2000) or (outDataAllRequests2[w]=2000) or (outDataAllRequests3[w]=2000) then
                    break}
                end;
            end;


            if buffer_.buffIndex=0  then
              begin
                device_.getNewRealizationTime(w);
                device_.afterProcess:=source_.arraySourceTime[source_.minTimeIndex]+
                   device_.timeRealization;
                source_.doneRequests:=source_.doneRequests+1;
                RecDoneReq(source_.minTimeIndex);
                source_.getGenerationTime(source_.minTimeIndex);
                source_.arraySourceTime[source_.minTimeIndex]:=
                   source_.arraySourceTime[source_.minTimeIndex]+source_.timeGeneration;
                source_.allRequests:=source_.allRequests+1;
                RecAllReq;
              end;

              if buffer_.buffIndex<>0 then
                 begin
                  takeFromBuff;
                  buffer_.buffIndex:=buffer_.buffIndex-1;
                end;
              
              if (key=1) and (w=1) then
                begin
                  {kmin:=10;}
                  if k=1 then
                    begin
                      cleardevice;
                      graph_.drawOXOY(device_.lyambda, 'P');
                      k:=k+1;
                    end;
                  if  outDataAllRequests1[w] >= kmin then
                    begin
                      if k = 2 then
                        begin
                          num:= 570/(lengthRealization/kmin);
                          dx:=round(num);   {number of points}
                          writeln(f2, 'dx ', dx);
                          {dx:=5;}
                          x:=53;
                          y:=GetMaxY-115;
                          k:=k+1;
                        end;
                  
                  {if all = kmin then
                    begin}
                      percentreal:=outDataRefuseRequests1[w]/outDataAllRequests1[w]*100;
                      percentint:=round(percentreal);
                      percentint:= percentint*3;
                      setfillstyle(solidfill, white);
                      bar(x, y - percentint, x-1, y - percentint -1);
                      delay(50);
                      x:=x+dx;
                      kmin:=kmin+10;
                    end;
                end;

              writeln(f2, 'All: ', outDataAllRequests1[w]);
              writeln(f2, 'Refuse: ', outDataRefuseRequests1[w]);
            end;

              outDataAllRequests[w]:=source_.allRequests;
              source_.arrayMathWait1[w]:=outDataTimeWaiting1[w]/outDataDoneRequests1[w]*100;
              source_.arrayMathWait2[w]:=outDataTimeWaiting2[w]/outDataDoneRequests2[w]*100;
              source_.arrayMathWait3[w]:=outDataTimeWaiting3[w]/outDataDoneRequests3[w]*100;
              source_.arrayPosibility1[w]:=outDataRefuseRequests1[w]/outDataAllRequests1[w]*100;
              source_.arrayPosibility2[w]:=outDataRefuseRequests2[w]/outDataAllRequests2[w]*100;
              source_.arrayPosibility3[w]:=outDataRefuseRequests3[w]/outDataAllRequests3[w]*100;

              {if (outDataAllRequests1[w]=2000) or (outDataAllRequests2[w]=2000) or (outDataAllRequests3[w]=2000) then
                exit;}

              {if key=2 then
                begin
                end;}

              w:=w+1;



      end;

    for i:= 1 to 11 do
      begin
        writeln(f, i, ' realization');
        writeln(f, 'All Requests from 1 Source in ', i, ' realization: ', outDataAllRequests1[i]);
        writeln(f, 'Done Requests from 1 Source in ', i, 'realization: ', outDataDoneRequests1[i]);
        writeln(f, 'Refuse Requests from 1 Source in ', i, 'realization: ', outDataRefuseRequests1[i]);
        writeln(f, '-------------------------------------');
        writeln(f, 'All Requests from 2 Source in ', i, ' realization: ', outDataAllRequests2[i]);
        writeln(f, 'Done Requests from 2 Source in ', i, 'realization: ', outDataDoneRequests2[i]);
        writeln(f, 'Refuse Requests from 2 Source in ', i, 'realization: ', outDataRefuseRequests2[i]);
        writeln(f, '-------------------------------------');
        writeln(f, 'All Requests from 3 Source in ', i, ' realization: ', outDataAllRequests3[i]);
        writeln(f, 'Done Requests from 3 Source in ', i, 'realization: ', outDataDoneRequests3[i]);
        writeln(f, 'Refuse Requests from 3 Source in ', i, 'realization: ', outDataRefuseRequests3[i]);
        writeln(f, '-------------------------------------');
      end;
    for i:=1 to 11 do
      begin
        if i = 1 then
          begin
           writeln(f, '   1 source      2 source      3 source   ');
           writeln(f, 'P'); 
          end;
        writeln(f,'    ',outDataRefuseRequests1[i]/outDataAllRequests1[i]:1:4, '         ',
          outDataRefuseRequests2[i]/outDataAllRequests2[i]:1:4, '       ',
          outDataRefuseRequests3[i]/outDataAllRequests3[i]:1:4);
      end;
      writeln(f,'M');
      for i:=1 to 11 do
        begin
          writeln(f,'    ',outDataTimeWaiting1[i]/outDataAllRequests1[i]:1:4, '      ',
            outDataTimeWaiting2[i]/outDataAllRequests2[i]:1:4, '      ',
            outDataTimeWaiting3[i]/outDataAllRequests3[i]:1:4);
        end;
    close(f);
    end;
{-----------------------------------FROM MAINSMO-----END------------------------------}

    

procedure buttonClass.draw(m_name: string);
  begin
    setTextStyle(6, 0, 6);
    outtextXY(x, y, m_name);
  end;

procedure buttonClass.getFocuse;
  var dx, dy: integer;
  begin
    dx := x - 24;
    dy := y + 25;
    setFillStyle(SolidFill, White);
    setColor(White);
    bar(dx, dy, dx + 10, dy + 10);
    focused := true;
  end;

procedure buttonClass.lostFocuse;
  var dx, dy: integer;
  begin
    dx := x - 24;
    dy := y + 25;
    setFillStyle(SolidFill, Black);
    setColor(Black);
    bar(dx, dy, dx + 10, dy + 10);
    focused := false;
  end;

procedure menuFirstFloor.goSecondFloor(var array_:arraytypeButton);
  var i: byte;
  begin
  end;

procedure menuFirstFloor.draw;
  begin
    buttonStart.x := 50;
    buttonStart.y := 70;
    buttonStart.name := 'Start';
    buttonStart.draw(buttonStart.name);

    buttonResult.x := 50;
    buttonResult.y := 153;
    buttonResult.name := 'Result';
    buttonResult.draw(buttonResult.name);

    buttonSettings.x := 50;
    buttonSettings.y := 243;
    buttonSettings.name := 'Settings';
    buttonSettings.draw(buttonSettings.name);

    buttonExit.x := 50;
    buttonExit.y := getMaxY - 145;
    buttonExit.name := 'Exit';
    buttonExit.draw(buttonExit.name);
  end;

  procedure menuFirstFloor.init;
    begin
      arrayButton[1]:= buttonStart;
      arrayButton[2]:= buttonResult;
      arrayButton[3]:= buttonSettings;
      arrayButton[4]:= buttonExit;
    end;

  procedure menuFirstFloor.firstFloor(max: integer; var array_: arraytypeButton);
    var i, k: byte;
    begin
      i:=1;
      k:=0;
      array_[i].getFocuse;
      while true do
        begin
          if keypressed then
            begin
              case(readkey) of
                #80:              {#80 - down}
                  begin
                    if i <> max then
                      begin
                        array_[i].lostFocuse;
                        i:=i+1;
                        array_[i].getFocuse;
                      end;
                  end;
                #72:              {#72 - up}
                  begin
                    if i <> 1 then
                      begin
                        array_[i].lostFocuse;
                        i:=i-1;
                        array_[i].getFocuse;
                      end;
                  end;
                #13:              {#13 - enter}
                  begin
                    for k:=1 to max do
                      begin
                        if array_[k].focused then
                          begin
                            if max = 4 then
                              choosing(array_);
                            if max = 3 then
                              resultSecondFloor^.goNextFloor;
                            exit;
                          end;
                      end;
                   { exit;}
                  end;
              end;
            end;
        end;
    end;

  procedure menuFirstFloor.choosing(var array_:arraytypeButton);
    var i: byte;
    begin
      cleardevice;
      for i:=1 to 4 do
          if array_[i].focused then
            begin
              if array_[i].name = 'Start' then
                begin
                  array_[i].focused:=false;
                  outtextXY(50, 140, '1: graphics');
                  outtextXY(50, 240, '2: "Modeling..."');
                  while true do
                    begin
                      if keypressed then
                        begin
                          case(readkey) of
                            '1':
                              begin
                                realization(1);
                                cleardevice;   {!!!!!!}
                                draw;
                                firstFloor(4, arrayButton);
                                exit;
                              end;
                            '2':
                              begin
                                graph_.modeling;
                                realization(2);
                                cleardevice;   {!!!!!!}
                                draw;
                                firstFloor(4, arrayButton);
                                exit;
                              end;
                          end;
                        end;
                    end;
                end;
              if array_[i].name = 'Result' then
                begin
                  array_[i].focused:=false;
                  resultSecondFloor^.complete;
                  firstFloor(3, arrayButtonResult);
                end;
              if array_[i].name = 'Settings' then
                begin
                  array_[i].focused:=false;
                  setTextStyle(6,0,4);
                  outtextXY(130,140, 'press "1" to set settings');
                  outtextXY(290, 170, 'or');
                  outtextXY(120, 200, 'press "2" to show settings');
                  setTextStyle(6,0,3);
                  outtextXY(133,400, 'press "Left" to get back to menu');
                  setTextStyle(6,0,6);
                    while true do
                      begin
                        if keypressed then
                          begin
                            case(readkey) of
                              '1': begin  
                                     setSettings; 
                                     cleardevice;   {!!!!!!}
                                     draw;
                                     firstFloor(4, arrayButton);
                                     exit; 
                                   end;
                              '2': begin  
                                     showSettings; 
                                     cleardevice;   {!!!!!!}
                                     draw;
                                     firstFloor(4, arrayButton);
                                     exit; 
                                   end;
                              #75:
                                begin
                                  cleardevice;   {!!!!!!}
                                  draw;
                                  firstFloor(4, arrayButton);
                                  exit;        {!!!!}
                                end;
                            end;
                          end;
                      end;
                  end;
              if array_[i].name = 'Exit' then
                begin
                  outtextXY(160, 150, 'Are you sure?');
                  setTextStyle(6,0,3);
                  outtextXY(20, 250, 'Press "Enter" to escape or "Left" to get back to menu');
                  while true do
                    begin
                      if keypressed then
                        begin
                          case(readkey) of
                            #13: halt;
                            #75:
                              begin
                                cleardevice;   {!!!!!!}
                                draw;
                                arrayButton[i].focused:=false;  {!!!!!}
                                firstFloor(4, arrayButton);
                                exit;       {!!!!}
                              end;
                          end;
                        end;
                    end;
                end;
            end;
    end;

  procedure menuFirstFloor.setSettings;
    var x, LYA, step, L1, L2, L3: real;
        xstr: string;
        i: byte;
    begin
      cleardevice;
      closegraph;
      restorecrtmode;
      gotoxy(50,50);
      write('First Lambda: ');
      readln(LYA);
      write('Step: ');
      readln(step);
      device_.lyambda:=step;
      device_.arrayLyambdas[1]:=LYA;
      for i:=2 to 11 do
        begin
          device_.arrayLyambdas[i]:=device_.arrayLyambdas[i-1]+device_.lyambda;
        end;
      writeln('Last Lambda will be: ', device_.arrayLyambdas[11]:4:2);
      writeln('');
      write('Lambda 1 Source: ');
      readln(L1);
      write('Lambda 2 Source: ');
      readln(L2);
      write('Lambda 3 Source: ');
      readln(L3);
      source_.arraySourceLyambdas[1]:=L1;
      source_.arraySourceLyambdas[2]:=L2;
      source_.arraySourceLyambdas[3]:=L3;
      writeln('');
      write('Length of realization: ');
      readln(lengthRealization);
      writeln('');
      writeln('');
      writeln('Processing...');
      delay(1000);
      initGraph(driver, mode, ''); 
      cleardevice;   {!!!!!!}
      draw;
      firstFloor(4, arrayButton);
      exit;       {!!!!}
    end;

  procedure menuFirstFloor.showSettings;
    var s: string;
    begin
      cleardevice;
      setTextStyle(6,0,2);
      str(device_.arrayLyambdas[1]:3:2, s);
      outtextXY(50,30, 'First Lambda = ');
      outtextXY(203,30, s);
      outtextXY(50, 60, 'Step = ');
      str(device_.lyambda:3:2, s);
      outtextXY(130, 60, s);
      outtextXY(50,90, 'Last Lambda = ');
      str(device_.arrayLyambdas[11]:3:2, s);
      outtextXY(207, 90, s);
      outtextXY(50, 140, 'Lambda 1 Source = ');
      str(source_.arraySourceLyambdas[1]:3:2, s);
      outtextXY(250, 140, s);
      outtextXY(50, 170, 'Lambda 2 Source = ');
      str(source_.arraySourceLyambdas[2]:3:2, s);
      outtextXY(250,170, s);
      outtextXY(50, 200, 'Lambda 3 Source = ');
      str(source_.arraySourceLyambdas[3]:3:2, s);
      outtextXY(250,200, s);
      outtextXY(50, 250, 'Length of Realization = ');
      str(lengthRealization, s);
      outtextXY(280, 250, s);
      setTextStyle(6,0,6);
      readln;
    end;

  procedure menuSecondFloorResult.init;
    begin
      arrayButtonResult[1] := buttonResultGraphic;
      arrayButtonResult[2] := buttonResultTable;
      arrayButtonResult[3] := buttonResultGoBack;
    end;

  procedure menuSecondFloorResult.draw;
    begin
      setcolor(white);

      buttonResultGraphic.x := 50;
      buttonResultGraphic.y := 102;
      buttonResultGraphic.name := 'Graphic';
      buttonResultGraphic.draw(buttonResultGraphic.name);

      buttonResultTable.x := 50;
      buttonResultTable.y := 198;
      buttonResultTable.name := 'Table';
      buttonResultTable.draw(buttonResultTable.name);

      buttonResultGoBack.x := 50;
      buttonResultGoBack.y := 294;
      buttonResultGoBack.name := 'go back';
      buttonResultGoBack.draw(buttonResultGoBack.name);
    end;

  procedure menuSecondFloorResult.goNextFloor;
    var i: byte;
    begin
      cleardevice;
      for i:= 1 to 3 do
        begin
          if (arrayButtonResult[i].name = 'Graphic') and (arrayButtonResult[i].focused) then
            begin
              {outtextXY(100,100,'Graphic was pushed');}
              showGraphic;
              cleardevice;   {!!!!!!}
              ToFirstFloor.draw;
              ToFirstFloor.firstFloor(4, arrayButton);
              arrayButtonResult[i].focused:=false;
              exit;
            end;
          if (arrayButtonResult[i].name = 'Table') and (arrayButtonResult[i].focused) then
            begin
              {outtextxy(100,100, 'Table');}
              showTable;
              cleardevice;   {!!!!!!}
              ToFirstFloor.draw;
              ToFirstFloor.firstFloor(4, arrayButton);
              arrayButtonResult[i].focused:=false;
              exit;
            end;
          if (arrayButtonResult[i].name = 'go back') and (arrayButtonResult[i].focused) then
          begin
            cleardevice;   {!!!!!!}
            ToFirstFloor.draw;
            arrayButtonResult[i].focused:=false;  {!!!!!}
            ToFirstFloor.firstFloor(4, arrayButton);
            exit;       {!!!!}
          end;
        end;
    end;

  procedure menuSecondFloorResult.menuResult;
    var i, k: byte;
        x: char;
    begin
    end;

  procedure menuSecondFloorResult.complete;
    begin
      draw;
      init;
    end;

  procedure menuSecondFloorResult.showTable;
    var i, dx, dy, x, y: integer;
        s: string;
    begin
      x:=100;
      y:=15;
      setTextStyle(6,0,1);
      outtextXY(x,y,'Refusal Probability');
      outtextXY(15,45,'1 Source   2 Source   3 Source');
      x:=28;
      y:=75;
      for i:=1 to 11 do
        begin
          str(outDataRefuseRequests1[i]/outDataAllRequests1[i]:5:4, s);
          outtextXY(x,y,s);
          y:=y+29;
        end;
      x:=125;
      y:=75;
      for i:=1 to 11 do
        begin
          str(outDataRefuseRequests2[i]/outDataAllRequests2[i]:5:4, s);
          outtextXY(x,y,s);
          y:=y+29;
        end;
      x:=225;
      y:=75;
      for i:=1 to 11 do
        begin
          str(outDataRefuseRequests3[i]/outDataAllRequests3[i]:5:4, s);
          outtextXY(x,y,s);
          y:=y+29;
        end;
      outtextXY(400,15,'Math Waiting');
      outtextXY(345,45,'1 Source   2 Source   3 Source');
      x:=358;
      y:=75;
      for i:=1 to 11 do
        begin
          str(outDataRefuseRequests1[i]/outDataAllRequests1[i]:5:4, s);
          outtextXY(x,y,s);
          y:=y+29;
        end;
      x:=458;
      y:=75;
      for i:=1 to 11 do
        begin
          str(outDataRefuseRequests2[i]/outDataAllRequests2[i]:5:4, s);
          outtextXY(x,y,s);
          y:=y+29;
        end;
      x:=558;
      y:=75;
      for i:=1 to 11 do
        begin
          str(outDataRefuseRequests3[i]/outDataAllRequests3[i]:5:4, s);
          outtextXY(x,y,s);
          y:=y+29;
        end;
      readln;
    end;

  procedure menuSecondFloorResult.showGraphic;
    begin
      cleardevice;
      graph_.drawOXOY(device_.lyambda, 'P');
      graph_.drawGraph(source_.arrayPosibility1, 
        source_.arrayPosibility2, source_.arrayPosibility3);
      while true do
        begin
          if keypressed then
            case(readkey) of
              #75:
                begin
                  cleardevice;
                  graph_.drawOXOY(device_.lyambda, 'P');
                  graph_.drawGraph(source_.arrayPosibility1, 
                    source_.arrayPosibility2, source_.arrayPosibility3);
                end;
              #77:
                begin
                  cleardevice;
                  graph_.drawOXOY(device_.lyambda, 'M');
                  graph_.drawGraph(source_.arrayMathWait1, 
                    source_.arrayMathWait2, source_.arrayMathWait3);
                end;
              #13:
                begin
                  cleardevice;
                  complete;
                  ToFirstFloor.firstFloor(3, arrayButtonResult);
                  exit;
                end;
            end;
        end;
      {graph_.drawOXOY(device_.lyambda, 'P');
      graph_.drawGraph(source_.arrayPosibility1, source_.arrayPosibility2, source_.arrayPosibility3);
      readln;
      cleardevice;
      graph_.drawOXOY(device_.lyambda, 'M');
      graph_.drawGraph(source_.arrayMathWait1, source_.arrayMathWait2, source_.arrayMathWait3);
      readln;}
    end;


begin
  driver:=detect;
  initGraph(driver, mode, '');
  if graphresult <> 0 then 
    begin
      writeln('Mistake');
      halt;
    end;
  setbkcolor(0);

  device_.lyambda:=0.2;  
  device_.arrayLyambdas[1]:=1;
  for i:=2 to 11 do
    begin
      device_.arrayLyambdas[i]:=device_.arrayLyambdas[i-1]+device_.lyambda;
    end;
  for i:=1 to 3 do
    begin
      source_.arraySourceLyambdas[1]:=3;
      source_.arraySourceLyambdas[2]:=3;
      source_.arraySourceLyambdas[3]:=3;
    end;  
  lengthRealization:=1000;

  {initGraph(driver, mode, '');  }

  menu.draw;
  menu.init;
  menu.firstFloor(4, arrayButton); 

end.