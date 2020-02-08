program TANK_action;
uses crt,ptcgraph,mouse,dos;
label yog,repifwin;
type vec=array[1..8] of string;
     sjds=(s,j,d,st);
     articol=record
                   nume:string[20];
                   h,m,s:word;
                   end;
     personalizat=file of articol;
var
   fis:personalizat;
   adv:array[1..20,1..5] of integer;
   eu:array[1..4] of integer;
   coord:array[1..20,1..2] of integer;
   gd,gm,mylife:integer;
   rmeniu,np,nadv,nadvaj,level,decndtrs:byte;
   limit,curent:array[1..20] of integer;
   sus1,jos1,dr1,st1,sus2,jos2,dr2,st2,per,bmb,dead:pointer;
   men:vec;
   misc:sjds;
   c:char;
   s100,hi,mi,si,hh,mm,ss:word;
   poate,winner,ambelit:boolean;
   art:articol;
procedure plimbareprinmeniu(n:integer;v:vec;x,y:integer);
var
     p,rant:byte;
     c:char;
     modif,selectat,ok:boolean;
     xm,ym,xa,ya:integer;
     buton:word;
begin
     settextstyle(0,0,0);
     rmeniu:=1;
     for p:=0 to n-1 do begin
                             setcolor(black);
                             if p=0 then setcolor(lightred);
                             outtextxy(x,y+20*p,v[p+1]);
                        end;
     c:=#14;ok:=false;
     initmouse;
     showmouse;
     while (c<>#13) and not ok do begin
                  modif:=false;
                  xm:=getmousex;
                  ym:=getmousey;

                  setcolor(white);
                  buton:=getmousebuttons;
                  xa:=xm;ya:=ym;
                  if (xa<>xm) or (ya<>ym) then begin
                  for p:=0 to n-1 do begin
                     if (xm>=x) and (xm<=x+80) and (ym>=y+20*p-5) and (ym<=y+20*p+10)
                      then begin rant:=rmeniu;rmeniu:=p+1;if rant<>rmeniu then modif:=true;
                      selectat:=true;break;end
                      else selectat:=false;
                                      end;
                                               end;
                  if (selectat=true) and (buton=mouseleftbutton) then ok:=true;
                  if keypressed then begin
                  modif:=true;
                  c:=readkey;
                  if c=#0 then begin
                  c:=readkey;
                          case c of
                            #80:begin
                                    rmeniu:=rmeniu+1;
                                    if rmeniu=n+1 then rmeniu:=1;
                                    end;
                            #72:begin
                                     rmeniu:=rmeniu-1;
                                     if rmeniu=0 then rmeniu:=n;
                                     end;
                              end;
                                 end;

                               end;{if keypressed}
                  if modif then begin
                  hidemouse;
                  for p:=0 to n-1 do begin
                           setcolor(black);
                           if p+1=rmeniu then setcolor(lightred);
                           outtextxy(x,y+20*p,v[p+1]);
                                     end;
                  showmouse;
                  sound(220);delay(10);nosound;
                           end; {if modif}
      end;
      for p:=1 to 10 do begin
                     sound(565-50*p);delay(15);
                     nosound;
                     end;
      hidemouse;

end;
procedure start;
var
   i,p,r:integer;
   t:real;
begin
     setbkcolor(black);cleardevice;
     for p:=0 to 12 do begin
     for i:=0 to 16 do begin
                 r:=random(4);
                 if r=0 then putimage(40*i,40*p,sus1^,xorput);
                 if r=1 then putimage(40*i,40*p,dr1^,xorput);
                 if r=2 then putimage(40*i,40*p,jos2^,xorput);
                 if r=3 then putimage(40*i,40*p,st2^,xorput);
                 end;
                     end;
                 p:=0;
                 repeat
                 p:=p+2;t:=0;i:=0;
                 repeat
                 t:=t+1/30;i:=i+2;
                 if p mod 10=0 then begin
                 putpixel(-20+round(10*sin(t))+p,i,lightred);
                 putpixel(660+round(10*sin(t))-p,i,lightred);
                 end
                 else begin
                 putpixel(-20+round(10*sin(t))+p,i,red);
                 putpixel(660+round(10*sin(t))-p,i,red);
                       end;
                 until i=480;
                 until p>350;
                 setcolor(black);
                 settextstyle(10,0,8);
                 for i:=1 to 12 do begin
                 if i=3 then setcolor(blue);
                 if i=5 then setcolor(lightblue);
                 if i=7 then setcolor(cyan);
                 if i=9 then setcolor(lightcyan);
                 if i=11 then setcolor(white);
                 outtextxy(150-i,220+i,'TANK');
                 delay(10);
                                  end;
                 settextstyle(0,0,3);
                 outtextxy(340,400,'a c t i o n');
                 {sigla(30,360);}
                 for i:=1 to 2 do begin
                 r:=40;if i=2 then r:=430;
                                   end;
                 for i:=1 to 200 do begin
                     setcolor(black);line(200+i,50,200+i,210);
                     setcolor(yellow);line(190+i,60,190+i,220);
                     delay(5);
                     end;
                 setlinestyle(0,0,3);setcolor(lightgray);
                 line(195,65,195,215);
                 line(195,65,385,65);
                 setcolor(darkgray);
                 line(195,215,385,215);
                 line(385,215,385,65);
                 setcolor(black);settextstyle(0,0,2);
                 outtextxy(245,80,'MENIU');
                 men[1]:='Start';men[2]:='Readme';men[3]:='Credits';
                 men[4]:='Hall of fame';men[5]:='Exit';
                 plimbareprinmeniu(5,men,210,120);
end;
procedure afisarehall;
var
   c:integer;
   s1:string;
begin
     cleardevice;
     settextstyle(8,0,4);setcolor(blue);
     for c:=1 to 5 do outtextxy(150-2*c,5+2*c,'THE HALL OF FAME');
     setcolor(lightblue);
     outtextxy(140,15,'THE HALL OF FAME');
     settextstyle(6,0,3);
     outtextxy(50,90,'These are the Captains that entered in history :');
     reset(fis);
     settextstyle(0,0,0);
     for c:=1 to filesize(fis) do begin
                  read(fis,art);
                  with art do begin
                      outtextxy(10,140+30*c,nume);
                      str(h,s1);outtextxy(300,140+30*c,s1);outtextxy(310,140+30*c,':');
                      str(m,s1);outtextxy(320,140+30*c,s1);outtextxy(330,140+30*c,':');
                      str(s,s1);outtextxy(340,140+30*c,s1);
                      end;
                  end;
     close(fis);
     repeat until keypressed;
     readkey;
end;

procedure initpic;
var
   size1,i:word;
   col,lcol:byte;
begin
for i:=1 to 2 do begin
    if i=1 then begin
                     col:=4;
                     lcol:=12;
                     end
    else begin
         col:=5;
         lcol:=13;
         end;
     setcolor(lcol);   {sus}
     setfillstyle(1,col);
     bar(20,20,40,50);
     setfillstyle(1,lcol);
     fillellipse(30,33,9,9);
     setlinestyle(0,0,3);
     line(30,34,30,15);
     setfillstyle(6,lightgray);
     bar(15,25,19,45);
     bar(41,25,45,45);
     putpixel(25,31,white);
     putpixel(26,31,white);
     putpixel(25,32,white);
     size1:=imagesize(14,14,46,51);
if i=1 then begin
     getmem(sus1,size1);
     getimage(14,14,46,51,sus1^);
          end
else begin
     getmem(sus2,size1);
     getimage(14,14,46,51,sus2^);
      end;
     cleardevice;
     setcolor(lcol);       {jos}
     setfillstyle(1,col);
     bar(20,20,40,50);
     setfillstyle(1,lcol);
     fillellipse(30,37,9,9);
     setlinestyle(0,0,3);
     line(30,44,30,55);
     setfillstyle(6,lightgray);
     bar(15,25,19,45);
     bar(41,25,45,45);
     putpixel(25,31,white);
     putpixel(26,31,white);
     putpixel(25,32,white);
     size1:=imagesize(14,19,46,56);
if i=1 then begin
     getmem(jos1,size1);
     getimage(14,19,46,56,jos1^);
            end
else begin
     getmem(jos2,size1);
     getimage(14,19,46,56,jos2^);
     end;
     cleardevice;
     setcolor(lcol);          {dr.}
     setfillstyle(1,col);
     bar(20,20,50,40);
     setfillstyle(1,lcol);
     fillellipse(37,30,9,9);
     line(36,30,55,30);
     setfillstyle(6,lightgray);
     bar(25,15,45,19);
     bar(25,41,45,45);
     putpixel(31,28,white);
     putpixel(32,28,white);
     putpixel(31,29,white);
     size1:=imagesize(19,14,56,46);
if i=1 then begin
     getmem(dr1,size1);
     getimage(19,14,56,46,dr1^);
         end
else begin
     getmem(dr2,size1);
     getimage(19,14,56,46,dr2^);
     end;
     cleardevice;
     setcolor(lcol);       {st.}
     setfillstyle(1,col);
     bar(20,20,50,40);
     setfillstyle(1,lcol);
     fillellipse(33,30,9,9);
     line(15,30,34,30);
     setfillstyle(6,lightgray);
     bar(25,15,45,19);
     bar(25,41,45,45);
     putpixel(27,26,white);
     putpixel(28,26,white);
     putpixel(27,27,white);
     size1:=imagesize(14,14,51,46);
if i=1 then begin
     getmem(st1,size1);
     getimage(14,14,51,46,st1^);
              end
else begin
     getmem(st2,size1);
     getimage(14,14,51,46,st2^);
     end;
     cleardevice;
end; {tancuri}
    randomize;                   {perete}
    setfillstyle(6,brown);
    bar(20,20,70,70);
    for i:=1 to 600 do putpixel(22+random(46),22+random(46),red);
    for i:=1 to 300 do putpixel(30+random(30),30+random(30),lightred);
    for i:=1 to 10 do putpixel(40+random(10),40+random(10),white);
    size1:=imagesize(19,19,71,71);
    getmem(per,size1);
    getimage(19,19,71,71,per^);
    cleardevice;

    setfillstyle(1,brown);   {bomba}
    setcolor(white);
    setlinestyle(0,0,1);
    pieslice(20,20,0,360,4);
    pieslice(24,20,0,360,4);
    pieslice(21,24,0,360,4);
    rectangle(14,14,30,30);
    size1:=imagesize(13,13,31,31);
    getmem(bmb,size1);
    getimage(13,13,31,31,bmb^);
    cleardevice;
end;
function potsatrag(n:integer):boolean;
var
   pot:boolean;
   c1,p:integer;
   art1,art2:articol;
   nm:string[20];
   modif:boolean;
   h1,h2,m1,m2,s1,s2:word;
   lit:char;
   x1:integer;
begin
     pot:=false;
     case adv[n,3] of
     0:begin
            if (adv[n,1]>=eu[1]-20) and (adv[n,1]<=eu[1]+20) and (adv[n,2]>eu[2]+35) then pot:=true;
            for c1:=1 to np do if (adv[n,1]>coord[c1,1]-35) and (adv[n,1]<=eu[2]+30) and (coord[c1,2]+50=eu[1]-20) and (adv[n,1]<=eu[1]+20)
            and (adv[n,2]+35>coord[c1,1]-35) and (adv[n,1]<adv[n,2]+30) and (coord[c1,2]+50=eu[2]-20) and (adv[n,2]<=eu[2]+20)
            and (adv[n,1]+35>coord[c1,2]-35) and (adv[n,2]<adv[n,1]+30) and (coord[c1,1]+50=eu[2]-20) and (adv[n,2]<=eu[2]+20)
            and (adv[n,1]>eu[1]+35) then pot:=true;
            for c1:=1 to np do if (adv[n,2]>coord[c1,2]-35) and (adv[n,2]<=eu[1]+30) and (coord[c1,1]+50=13) then begin
                        lit:=readkey;
                        if lit=#13 then break;
                        if lit=#8 then begin
                                            nm:=copy(nm,1,length(nm)-1);
                                            x1:=x1-18;
                                            setfillstyle(1,black);
                                            bar(x1,270,x1+18,290);
                                            continue;
                                            end;
                        nm:=nm+lit;
                        outtextxy(x1,270,lit);
                        x1:=x1+18;
            end;
       end;
     end;
     with art do begin
                 nume:=nm;
                 h:=hh;m:=mm;s:=ss;
                 end;
     outtextxy(100,100,nm);
     reset(fis);
     seek(fis,filesize(fis));
     write(fis,art);
     modif:=true;
     while modif do begin
     modif:=false;
     for p:=0 to filesize(fis)-2 do begin
              seek(fis,p);
              read(fis,art);h1:=art.h;
              seek(fis,p+1);
              read(fis,art);h2:=art.h;
              if (h1>h2) then begin
                            modif:=true;
                            seek(fis,p);read(fis,art1);
                            seek(fis,p);write(fis,art);
                            seek(fis,p+1);write(fis,art1);
                            end;
                                       end;
              end;
     modif:=true;
     while modif do begin
     modif:=false;
     for p:=0 to filesize(fis)-2 do begin
              seek(fis,p);
              read(fis,art);h1:=art.h;m1:=art.m;
              seek(fis,p+1);
              read(fis,art);h2:=art.h;m2:=art.m;
              if (m1>m2) and (h1=h2) then begin
                            modif:=true;
                            seek(fis,p);read(fis,art1);
                            seek(fis,p);write(fis,art);
                            seek(fis,p+1);write(fis,art1);
                            end;
                                       end;
                   end;
      modif:=true;
      while modif do begin
      modif:=false;
      for p:=0 to filesize(fis)-2 do begin
              seek(fis,p);
              read(fis,art);h1:=art.h;m1:=art.m;s1:=art.s;
              seek(fis,p+1);
              read(fis,art);h2:=art.h;m2:=art.m;s2:=art.s;
              if (s1>s2) and (h1=h2) and (m1=m2) then begin
                            modif:=true;
                            seek(fis,p);read(fis,art1);
                            seek(fis,p);write(fis,art);
                            seek(fis,p+1);write(fis,art1);
                            end;
                                       end;
              end;
     if filesize(fis)>10 then begin
                         seek(fis,10);
                         truncate(fis);
                         end;
     close(fis);
end;
procedure pixeli;
var d,xprim,yprim:longint;
begin
     randomize;
     setcolor(black);
     setfillstyle(1,black);
     for d:=1 to 30000 do begin
                     xprim:=random(636);yprim:=random(476);
                     bar(xprim,yprim,xprim+5,yprim+10);
                           end;
     cleardevice;
end;
procedure afisare;
var
   s:string;
begin
     setfillstyle(1,yellow);
     bar(200,430,250,480);
     str(nadvaj,s);
     setcolor(red);settextstyle(8,0,3);
     outtextxy(200,430,s);
end;
procedure background;
var
   l,c:byte;
   s:string;
begin
     mylife:=1;

case level of
1:begin
     nadv:=6;
     winner:=false;
     for l:=1 to nadv do begin
                              curent[l]:=0;limit[l]:=0;
                              end;
     np:=14;
     cleardevice;
     setlinestyle(0,0,1);setcolor(yellow);
     setfillstyle(1,yellow);bar(0,420,640,480);
     coord[1,1]:=50;coord[1,2]:=320;
     coord[2,1]:=100;coord[2,2]:=320;
     coord[3,1]:=75;coord[3,2]:=270;
     coord[4,1]:=540;coord[4,2]:=50;
     coord[5,1]:=515;coord[5,2]:=100;
     coord[6,1]:=530;coord[6,2]:=368;
     for l:=1 to 4 do begin coord[6+l,1]:=300;coord[6+l,2]:=50*l;end;
     coord[11,1]:=100;coord[11,2]:=75;
     coord[12,1]:=150;coord[12,2]:=125;
     coord[13,1]:=450;coord[13,2]:=210;
     coord[14,1]:=340;coord[14,2]:=320;
     for l:=1 to np do putimage(coord[l,1],coord[l,2],per^,xorput);
     eu[1]:=5;eu[2]:=380;eu[3]:=0;
     putimage(eu[1],eu[2],sus1^,xorput);
     for l:=1 to nadv do begin
                              adv[l,1]:=605-40*l;adv[l,2]:=1;adv[l,3]:=1;
                              putimage(adv[l,1],adv[l,2],jos2^,xorput);
                              end;
     for l:=1 to nadv do begin
                                adv[l,4]:=9;
                                adv[l,5]:=1;
                                end;
     winner:=false;
     end;
2:begin
     nadv:=8;
     winner:=false;
     for l:=1 to nadv do begin
                              curent[l]:=0;limit[l]:=0;
                              end;
     np:=14;
     cleardevice;
     setlinestyle(0,0,1);setcolor(yellow);
     setfillstyle(1,yellow);bar(0,420,640,480);
     coord[1,1]:=50;coord[1,2]:=320;
     coord[2,1]:=100;coord[2,2]:=270;
     coord[3,1]:=140;coord[3,2]:=150;
     coord[4,1]:=420;coord[4,2]:=140;
     for l:=1 to 3 do begin coord[4+l,1]:=430+50*l;coord[4+l,2]:=270;end;
     coord[8,1]:=480;coord[8,2]:=368;
     coord[9,1]:=40;coord[9,2]:=50;
     coord[10,1]:=140;coord[10,2]:=50;
     coord[11,1]:=350;coord[11,2]:=320;
     coord[12,1]:=300;coord[12,2]:=100;
     coord[13,1]:=300;coord[13,2]:=200;
     coord[14,1]:=540;coord[14,2]:=60;
          for l:=1 to np do putimage(coord[l,1],coord[l,2],per^,xorput);
     eu[1]:=5;eu[2]:=380;eu[3]:=0;
     putimage(eu[1],eu[2],sus1^,xorput);
     for l:=1 to nadv do begin
                              adv[l,1]:=605-40*l;adv[l,2]:=1;adv[l,3]:=1;
                              putimage(adv[l,1],adv[l,2],jos2^,xorput);
                              end;
     for l:=1 to nadv do begin
                                adv[l,4]:=9;
                                adv[l,5]:=1;
                                end;
     winner:=false;
  end;
3:begin
     nadv:=8;
     winner:=false;
     for l:=1 to nadv do begin
                 curent[l]:=0;limit[l]:=0;
                         end;
     np:=10;
     cleardevice;
     setlinestyle(0,0,1);setcolor(yellow);
     setfillstyle(1,yellow);bar(0,420,640,480);
     for l:=1 to 3 do begin
                      coord[l,1]:=100+50*l;coord[l,2]:=10+50*l;
                      end;
     c:=0;
     for l:=3 downto 1 do begin
                     c:=c+1;
                      coord[3+l,1]:=200+50*l;coord[l+3,2]:=160+50*c;
                      end;
     coord[7,1]:=60;coord[7,2]:=200;
     coord[8,1]:=60;coord[8,2]:=300;
     coord[9,1]:=530;coord[9,2]:=320;
     coord[10,1]:=480;coord[10,2]:=80;
               for l:=1 to np do putimage(coord[l,1],coord[l,2],per^,xorput);
     eu[1]:=5;eu[2]:=380;eu[3]:=0;
     putimage(eu[1],eu[2],sus1^,xorput);
     for l:=1 to nadv do begin
                              adv[l,1]:=605-40*l;adv[l,2]:=1;adv[l,3]:=1;
                              putimage(adv[l,1],adv[l,2],jos2^,xorput);
                              end;
     for l:=1 to nadv do begin
                                adv[l,4]:=9;
                                adv[l,5]:=1;
                                end;
     winner:=false;
     end;
4:begin
     nadv:=8;
     winner:=false;
     for l:=1 to nadv do begin
                 curent[l]:=0;limit[l]:=0;
                         end;
     np:=8;
     cleardevice;
     setlinestyle(0,0,1);setcolor(yellow);
     setfillstyle(1,yellow);bar(0,420,640,480);
     coord[1,1]:=60;coord[1,2]:=310;
     for l:=1 to 2 do begin coord[1+l,1]:=400+50*l;coord[1+l,2]:=10+50*l;end;
     coord[4,1]:=250;coord[4,2]:=150;
     coord[5,1]:=350;coord[5,2]:=150;
     coord[6,1]:=220;coord[6,2]:=250;
     coord[7,1]:=370;coord[7,2]:=250;
     coord[8,1]:=520;coord[8,2]:=290;
                    for l:=1 to np do putimage(coord[l,1],coord[l,2],per^,xorput);
     eu[1]:=5;eu[2]:=380;eu[3]:=0;
     putimage(eu[1],eu[2],sus1^,xorput);
     for l:=1 to nadv do begin
                              adv[l,1]:=605-40*l;adv[l,2]:=1;adv[l,3]:=1;
                              putimage(adv[l,1],adv[l,2],jos2^,xorput);
                              end;
     for l:=1 to nadv do begin
                                adv[l,4]:=9;
                                adv[l,5]:=1;
                                end;
     winner:=false;
     end;
5:begin
     nadv:=14;
     winner:=false;
     for l:=1 to nadv do begin
                 curent[l]:=0;limit[l]:=0;
                         end;
     np:=5;
     cleardevice;
     setlinestyle(0,0,1);setcolor(yellow);
     setfillstyle(1,yellow);bar(0,420,640,480);
     coord[1,1]:=270;coord[1,2]:=150;
     coord[2,1]:=320;coord[2,2]:=150;
     coord[3,1]:=270;coord[3,2]:=200;
     coord[4,1]:=320;coord[4,2]:=200;
     coord[5,1]:=1;coord[5,2]:=150;
                         for l:=1 to np do putimage(coord[l,1],coord[l,2],per^,xorput);
     eu[1]:=5;eu[2]:=380;eu[3]:=0;
     putimage(eu[1],eu[2],sus1^,xorput);
     for l:=1 to nadv do begin
                              adv[l,1]:=605-40*l;adv[l,2]:=1;adv[l,3]:=1;
                              putimage(adv[l,1],adv[l,2],jos2^,xorput);
                              end;
     for l:=1 to nadv do begin
                                adv[l,4]:=9;
                                adv[l,5]:=1;
                                end;
     winner:=false;
     end;
end;
level:=level+1;
setcolor(red);settextstyle(8,0,3);outtextxy(10,430,'ADVERSARI :');
outtextxy(430,430,'LEVEL :');
str(level-1,s);outtextxy(560,430,s);
afisare;
end;
procedure melodie;
var
   i:byte;
begin
for i:=1 to 8 do begin sound(82);delay(2);nosound;delay(4);end;
for i:=1 to 8 do begin sound(524+random(200));delay(4);nosound;end;
end;
procedure trage;
var
   pot:boolean;
   c1,c2,n,m,care:integer;
begin
     pot:=false;
     case misc of
     s:begin
         for n:=1 to nadv do begin
            if adv[n,5]=0 then continue;
            if (eu[1]>=adv[n,1]-20) and (eu[1]<=adv[n,1]+20) and (eu[2]>adv[n,2]+35) then pot:=true;
            for c1:=1 to np do if (eu[1]>coord[c1,1]-35) and (eu[1]<=adv[n,2]+30) and (coord[c1,2]+50=adv[n,1]-20) and (eu[1]<=adv[n,1]+20)
            and (eu[2]+35>coord[c1,1]-35) and (eu[1]<=eu[2]+30) and (coord[c1,2]+50=adv[n,2]-20) and (eu[2]<=adv[n,2]+20)
            and (eu[1]+35>coord[c1,2]-35) and (eu[2]<=eu[1]+30) and (coord[c1,1]+50=adv[n,2]-20) and (eu[2]<=adv[n,2]+20)
            and (eu[1]>adv[n,1]+35) then pot:=true;
            for c1:=1 to np do if (eu[2]>coord[c1,2]-35) and (eu[2]<=adv[n,1]+30) and (coord[c1,1]+50=10) then begin
                   for c2:=5 downto 1 do begin sound(700-100*c1);delay(2);nosound;end;
                   if pot then begin
                           melodie;
                           adv[care,5]:=0;
                   end;
                   decndtrs:=0;
            end;
          end;
        end;
     end;
     winner:=true;
     for m:=1 to nadv do if adv[m,5]<>0 then winner:=false;
end;
procedure move(unde:sjds);
var ad,i:byte;
    pot:boolean;
begin
     ad:=5;
     case eu[3] of
     0:putimage(eu[1],eu[2],sus1^,xorput);
     1:putimage(eu[1],eu[2],jos1^,xorput);
     2:putimage(eu[1],eu[2],dr1^,xorput);
     3:putimage(eu[1],eu[2],st1^,xorput);
     end;
     pot:=true;
     case unde of
     s:begin
            for i:=1 to np do if(eu[2]-ad<=coord[i,2]+50) and(eu[2]+30>=coord[i,2])
             and (eu[1]+30>=coord[i,1])and(eu[1]<=coord[i,1]+50)then pot:=false;
            if eu[2]-ad<=1 then pot:=false;
            for i:=1 to nadv do if(eu[2]-ad<=adv[i,2]+35) and(eu[2]+35>=adv[i,2])
             and (eu[1]+35>=adv[i,1])and(eu[1]<=adv[i,1]+35)then pot:=false;
            if (eu[3]=0) and pot then eu[2]:=eu[2]-ad;
            putimage(eu[1],eu[2],sus1^,xorput);
            eu[3]:=0;
            end;
     j:begin
            for i:=1 to np do if (eu[2]<=coord[i,2]+50) and (eu[2]+30+ad>=coord[i,2])
             and (eu[1]+30>=coord[i,1]) and (eu[1]<=coord[i,1]+50) then pot:=false;
            if eu[2]+35+ad>=420 then pot:=false;
            for i:=1 to nadv do if(eu[2]<=adv[i,2]+35) and(eu[2]+35+ad>=adv[i,2])
             and (eu[1]+35>=adv[i,1])and(eu[1]<=adv[i,1]+35)then pot:=false;
            if (eu[3]=1) and pot then eu[2]:=eu[2]+ad;
            putimage(eu[1],eu[2],jos1^,xorput);
            eu[3]:=1;
            end;
     d:begin
            for i:=1 to np do if (eu[2]<=coord[i,2]+50) and (eu[2]+30>=coord[i,2])
             and (eu[1]+30+ad>=coord[i,1]) and (eu[1]<=coord[i,1]+50) then pot:=false;
            if eu[1]+35+ad>=639 then pot:=false;
            for i:=1 to nadv do if(eu[2]<=adv[i,2]+35) and(eu[2]+35>=adv[i,2])
             and (eu[1]+35+ad>=adv[i,1])and(eu[1]<=adv[i,1]+35)then pot:=false;
            if (eu[3]=2) and pot then eu[1]:=eu[1]+ad;
            putimage(eu[1],eu[2],dr1^,xorput);
            eu[3]:=2;
            end;
     st:begin
             for i:=1 to np do if (eu[2]<=coord[i,2]+50) and (eu[2]+30>=coord[i,2])
              and (eu[1]+30>=coord[i,1]) and (eu[1]-ad<=coord[i,1]+50) then pot:=false;
             if eu[1]-ad<=1 then pot:=false;
             for i:=1 to nadv do if(eu[2]<=adv[i,2]+35) and(eu[2]+35>=adv[i,2])
             and (eu[1]+35>=adv[i,1])and(eu[1]-ad<=adv[i,1]+35)then pot:=false;
             if (eu[3]=3) and pot then eu[1]:=eu[1]-ad;
             putimage(eu[1],eu[2],st1^,xorput);
             eu[3]:=3;
             end;
     end;
end;
procedure pause;
var
   i:byte;
   c:char;
   h,m,s,hi1,mi1,si1,y:word;
begin
     setcolor(lightred);
     for i:=30 downto 1 do begin sound(524-15*i);delay(i div 3);end;nosound;
     settextstyle(0,0,1);outtextxy(300,460,'PAUSE');
     gettime(hi1,mi1,si1,s100);
     repeat if keypressed then c:=readkey; until c='p';
     gettime(h,m,s,s100);
     y:=s-si1;
    if y>=0 then begin
                     s:=s-si1;
                     end
    else begin
              s:=60+s-si1;
              y:=m-1;
              if y>=0 then m:=m-1
              else begin m:=60;h:=h-1;end;
              end;
    y:=m-mi1;
    if y>=0 then m:=m-mi1
    else begin
         m:=60+m-mi1;
         h:=h-1;
         end;
    h:=h-hi1;
    if s+si<=59 then si:=si+s
    else begin
              m:=m+1;
              si:=si+s-60;
              end;
    if m+mi<=59 then mi:=mi+m
    else begin
              h:=h+1;
              mi:=mi+m-60;
              end;
    hi:=hi+h;

     for i:=1 to 30 do begin sound(524-15*i);delay(i div 3);end;nosound;
     setcolor(yellow);outtextxy(300,460,'PAUSE');
end;
procedure mortaciune(x,y:integer);
var
   i,p:byte;
begin
     for i:=1 to 50 do begin
              p:=random(5);
              if p=0 then putpixel(x+random(35),y+random(35),black);
              if p=1 then putpixel(x+random(35),y+random(35),lightred);
              if p=2 then putpixel(x+random(35),y+random(35),lightgray);
              if p=3 then putpixel(x+random(35),y+random(35),darkgray);
              if p=4 then putpixel(x+random(35),y+random(35),red);
              end;
end;
procedure aipierdut;
label f;
var
   i,x,c,x1:integer;
   ran:byte;
   s:string;
   v:array[1..15] of integer;
begin
     for i:=1 to 100 do begin mortaciune(eu[1],eu[2]);delay(30);end;
     pixeli;
     while keypressed do readkey;
     setcolor(white);settextstyle(0,0,1);
     outtextxy(180,180,'POOR');delay(500);
     outtextxy(220,180,'CAPTAIN,');delay(1000);
     outtextxy(290,180,'LET');delay(500);
     outtextxy(330,180,'HIM');delay(500);
     for i:=1 to 3 do begin outtextxy(360+10*i,180,'.');delay(1000);end;
     delay(1000);
     settextstyle(7,0,6);setcolor(lightred);outtextxy(110,238,'REST IN PIECES');
     for i:=1 to 15 do v[i]:=100+30*i;
                    for c:=-10 to 180 do begin
                    for i:=1 to 15 do begin
                    x:=v[i];
                                   ran:=random(3);
                                   if ran=0 then x1:=-1;
                                   if ran=1 then x1:=1;
                                   if ran=2 then x1:=0;
                          x:=x+x1;
                          putpixel(x,300+c,red);
                          putpixel(x+1,300+c,red);
                          putpixel(x+2,300+c,lightred);
                          putpixel(x+3,300+c,lightred);
                          putpixel(x+4,300+c,red);
                          putpixel(x+5,300+c,red);
                          delay(3);
                          v[i]:=v[i]+x1;
                          end;
                          if keypressed then begin readkey;goto f;end;
                    end;
     f:
     while keypressed do readkey;
end;
procedure bravo;
label ies;
var i,x:byte;
    s,s1:string;
begin
     cleardevice;
     setcolor(white);settextstyle(0,0,1);
     setfillstyle(1,getmaxcolor);
     setcolor(getmaxcolor);
     outtextxy(200,20,'Receiving incoming transmition ...');
     while keypressed do readkey;
     for i:=1 to 10 do begin sound(100+random(400));delay(150);nosound;end;
     bar(150,50,450,450);
     settextstyle(0,0,0);setcolor(lightgray);
     outtextxy(200,120,'* TOP SECRET - EYES ONLY *');
     outtextxy(210,415,'* ingest after reading *');setcolor(black);
     s:='You managed fine, captain ...';
     for i:=1 to 29 do begin
                            sound(160);delay(20);
                            outtextxy(155+8*i,200,copy(s,i,1));
                            nosound;delay(50+random(50));
                            if keypressed then goto ies;
                            end;
     s:='But you still have to do some';
     delay(800);
     for i:=1 to 29 do begin
                            sound(160);delay(20);
                            outtextxy(155+8*i,230,copy(s,i,1));
                            nosound;delay(50+random(50));
                            if keypressed then goto ies;
                            end;
     s:='damage around here.';
     delay(150);
     for i:=1 to 19 do begin
                            sound(160);delay(20);
                            outtextxy(155+8*i,250,copy(s,i,1));
                            nosound;delay(50+random(50));
                            if keypressed then goto ies;
                            end;
     s:='Attack their nearest base.';
     delay(400);
     for i:=1 to 26 do begin
                            sound(160);delay(20);
                            outtextxy(155+8*i,290,copy(s,i,1));
                            nosound;delay(50+random(50));
                            if keypressed then goto ies;
                            end;
     s:='The Comander';
     delay(400);
     for i:=1 to 12 do begin
                            sound(160);delay(20);
                            outtextxy(300+8*i,380,copy(s,i,1));
                            nosound;delay(50+random(50));
                            if keypressed then goto ies;
                            end;
     delay(400);
     setcolor(getmaxcolor);
     outtextxy(200,460,'End transmition.');sound(100);delay(500);nosound;delay(500);
     ies:
     while keypressed do readkey;
end;
procedure dilei;
var
   i,nadvaj1:integer;
begin
     ambelit:=false;
     nadvaj1:=nadvaj;
     nadvaj:=nadv;
     for i:=1 to nadv do if adv[i,5]=0 then nadvaj:=nadvaj-1;
     delay(22-nadvaj);
     if nadvaj1<>nadvaj then ambelit:=true;
end;
procedure preluctime;
var
   s100:word;
   s:string;
   y:integer;
begin
    gettime(hh,mm,ss,s100);
    y:=ss-si;
    if y>=0 then begin
                     ss:=ss-si;
                     end
    else begin
              ss:=60+ss-si;
              y:=mm-1;
              if y>=0 then mm:=mm-1
              else begin mm:=60;hh:=hh-1;end;
              end;
    y:=mm-mi;
    if y>=0 then mm:=mm-mi
    else begin
         mm:=60+mm-mi;
         hh:=hh-1;
         end;
    hh:=hh-hi;
    setcolor(black);settextstyle(0,0,0);setfillstyle(1,yellow);
    bar(290,440,350,460);
    str(hh,s);outtextxy(290,440,s);
    str(mm,s);outtextxy(310,440,s);
    str(ss,s);outtextxy(330,440,s);
end;
procedure omiscareadversa;
label yog;
var i,ad1,j:integer;
    pot:boolean;
begin
     ad1:=3;
     for i:=1 to nadv do begin
     if adv[i,5]=0 then begin
                        mortaciune(adv[i,1],adv[i,2]);
                        continue;
                        end;
     case adv[i,3] of
     0:putimage(adv[i,1],adv[i,2],sus2^,xorput);
     1:putimage(adv[i,1],adv[i,2],jos2^,xorput);
     2:putimage(adv[i,1],adv[i,2],dr2^,xorput);
     3:putimage(adv[i,1],adv[i,2],st2^,xorput);
     end;
     end;
for j:=1 to nadv do begin
    if adv[j,5]=0 then continue;
     pot:=true;
     yog:
     if (limit[j]=curent[j]) or not pot then begin
                               limit[j]:=5+random(50);
                               curent[j]:=0;
                               adv[j,3]:=random(4);
                               pot:=true;
                               end;
     case adv[j,3] of
     0:begin
   {pereti} for i:=1 to np do if(adv[j,2]-ad1<=coord[i,2]+50) and(adv[j,2]+30>=coord[i,2])
             and (adv[j,1]+30>=coord[i,1])and(adv[j,1]<=coord[i,1]+50)then pot:=false;
   {ecran}  if adv[j,2]-ad1<=1 then pot:=false;
   {adv}    for i:=1 to nadv do if(adv[j,2]-ad1<=adv[i,2]+35) and(adv[j,2]+35>=adv[i,2])
             and (adv[j,1]+35>=adv[i,1])and(adv[j,1]<=adv[i,1]+35)and(i<>j) then pot:=false;

   {eu}     if(adv[j,2]-ad1<=eu[2]+35) and (adv[j,2]+35>=eu[2])
             and (adv[j,1]+35>=eu[1])and(adv[j,1]<=eu[1]+35)then pot:=false;
            if not pot then goto yog;
            if (adv[j,3]=0) then adv[j,2]:=adv[j,2]-ad1;
            putimage(adv[j,1],adv[j,2],sus2^,xorput);
            adv[j,3]:=0;
            poate:=potsatrag(j);
            end;
     1:begin
            for i:=1 to np do if(adv[j,2]<=coord[i,2]+50) and(adv[j,2]+30+ad1>=coord[i,2])
             and (adv[j,1]+30>=coord[i,1])and(adv[j,1]<=coord[i,1]+50)then pot:=false;
            if adv[j,2]+35+ad1>=420 then pot:=false;
            for i:=1 to nadv do if(adv[j,2]<=adv[i,2]+35) and(adv[j,2]+35+ad1>=adv[i,2])
             and (adv[j,1]+35>=adv[i,1])and(adv[j,1]<=adv[i,1]+35)and(i<>j) then pot:=false;

            if(adv[j,2]<=eu[2]+35) and(adv[j,2]+35+ad1>=eu[2])
             and (adv[j,1]+35>=eu[1])and(adv[j,1]<=eu[1]+35)then pot:=false;
            if not pot then goto yog;
            if (adv[j,3]=1) then adv[j,2]:=adv[j,2]+ad1;
            putimage(adv[j,1],adv[j,2],jos2^,xorput);
            adv[j,3]:=1;
            poate:=potsatrag(j);
            end;
     2:begin
            for i:=1 to np do if(adv[j,2]<=coord[i,2]+50) and(adv[j,2]+30>=coord[i,2])
             and (adv[j,1]+30+ad1>=coord[i,1])and(adv[j,1]<=coord[i,1]+50)then pot:=false;
            if adv[j,1]+35+ad1>=639 then pot:=false;
            for i:=1 to nadv do if(adv[j,2]<=adv[i,2]+35) and(adv[j,2]+35>=adv[i,2])
             and (adv[j,1]+35+ad1>=adv[i,1])and(adv[j,1]<=adv[i,1]+35)and(i<>j) then pot:=false;
            if(adv[j,2]<=eu[2]+35) and(adv[j,2]+35>=eu[2])
             and (adv[j,1]+35+ad1>=eu[1])and(adv[j,1]<=eu[1]+35)then pot:=false;
            if not pot then goto yog;
            if (adv[j,3]=2) then adv[j,1]:=adv[j,1]+ad1;
            putimage(adv[j,1],adv[j,2],dr2^,xorput);
            adv[j,3]:=2;
            poate:=potsatrag(j);
            end;
     3:begin
             for i:=1 to np do if(adv[j,2]<=coord[i,2]+50) and(adv[j,2]+30>=coord[i,2])
             and (adv[j,1]+30>=coord[i,1])and(adv[j,1]-ad1<=coord[i,1]+50)then pot:=false;
             if adv[j,1]-ad1<=1 then pot:=false;
             for i:=1 to nadv do if(adv[j,2]<=adv[i,2]+35) and(adv[j,2]+35>=adv[i,2])
             and (adv[j,1]+35>=adv[i,1])and(adv[j,1]-ad1<=adv[i,1]+35)and(i<>j) then pot:=false;
             if(adv[j,2]<=eu[2]+35) and(adv[j,2]+35>=eu[2])
             and (adv[j,1]+35>=eu[1])and(adv[j,1]-ad1<=eu[1]+35)then pot:=false;
             if not pot then goto yog;
             if (adv[j,3]=3) then adv[j,1]:=adv[j,1]-ad1;
             putimage(adv[j,1],adv[j,2],st2^,xorput);
             adv[j,3]:=3;
             poate:=potsatrag(j);
             end;
     end;
     if poate then begin
                        adv[j,4]:=adv[j,4]+1;
                        if adv[j,4]=10 then adv[j,4]:=0;
                        if adv[j,4]=0 then begin
                                           mylife:=mylife-1;
                                           for i:=1 to 6 do begin
                                                    sound(500-70*i);
                                                    delay(4);nosound;
                                                            end;
                                           end;
                        end
     else adv[j,4]:=0;
     curent[j]:=curent[j]+1;
end;
decndtrs:=decndtrs+1;
end;
procedure credits;
label ex;
var
   fil:text;
   c:char;
   p,x,y:integer;
begin
     cleardevice;
     assign(fil,'credits.txt');
     reset(fil);
     {sigla(30,10);sigla(525,10);}
     {sigla(30,400);sigla(525,400);}
     settextstyle(8,0,4);setcolor(green);
     for p:=1 to 4 do begin outtextxy(230-3*p,5+3*p,'CREDITS');end;
     setcolor(lightgreen);
     outtextxy(215,20,'CREDITS');
     y:=80;
     settextstyle(0,0,0);
     while not eof(fil) do begin
     p:=0;y:=y+20;
              while not eoln(fil) do begin
                        p:=p+1;
                        read(fil,c);
                        outtextxy(8*p,y,c);
                        sound(65+random(150));delay(20);nosound;
                        delay(60);if keypressed then goto ex;
                        end;
              readln(fil);
                        end;
     close(fil);
     ex:
     repeat until keypressed;readkey;
end;
procedure readme;
var fil:text;
    s:string;
    p:integer;
begin
     cleardevice;
     assign(fil,'readme.txt');
     reset(fil);setcolor(lightmagenta);
     settextstyle(3,0,2);
     while not eof(fil) do begin
                        p:=p+1;
                        readln(fil,s);
                        outtextxy(10,10+25*p,s);
                        end;
     repeat until keypressed;
     close(fil);

     readkey;
end;
begin
     randomize;
     gd:=9;gm:=2;initgraph(gd,gm,'');
     assign(fis,'rec.dat');
     initpic;
while rmeniu<>5 do begin
     start;
     level:=1;
     case rmeniu of
     1:begin
            gettime(hi,mi,si,s100);
            repifwin:
            background;
            c:=#14;
            while (c<>#27) and (mylife>0) and not winner do begin
            omiscareadversa;
            preluctime;
            dilei;
            if ambelit then afisare;
                  if keypressed then begin
                  c:=readkey;
                  case c of
                  #0:begin
                          c:=readkey;
                          case c of
                               #72:misc:=s;
                               #80:misc:=j;
                               #77:misc:=d;
                               #75:misc:=st;
                               end;
                          move(misc);
                     end;
                  'z':trage;
                  'p':pause;
                  end;
                             end;
                  if winner and (level<6) then begin
                                                    bravo;
                                                    goto repifwin;
                                                    end;
                  {if winner then yes;}
                  if mylife<=0 then aipierdut;
                   end; {while #27}
       end;{1}
       4:begin
              afisarehall;
       end;
       2:begin
              readme;
              end;
       3:begin
              credits;
              end;
       end;{case}
end;       {big while}

     pixeli;
     cleardevice;
     closegraph;
end.
