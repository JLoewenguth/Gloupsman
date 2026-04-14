program gloups;

{{
v 3.0
score max: 181 points par tableau, 724 max}}

uses crt;

const maxx=21;
maxy=18;

var tabl,tabl2: array[1..maxx,1..maxy] of char;
a:char;					//commande
i,j,v,w,v2,w2,v3,w3,posx,posy,score,scoremax,topscore,IDfantome,vie,niveau:integer;	//ij(trace du cadre) vw (fantomeA) v2w2 (fantomeB) px py(pacman)
stop,nogum,nogumB,nogumC,Amoved,Bmoved,Cmoved:boolean;		//nogum(passage fantome sur gum), gestion du mouvement
UserFile:text;		//stockage du topscore
Label Again,Finish,Incorrect;

procedure init(taillex,tailley:integer);
var i,j:integer;
begin
	textcolor(lightgray);
	for i:=2 to tailley-1 do
		for j:=2 to taillex-1 do
			tabl[j,i]:='.';
	textcolor(yellow);
	tabl[11,9]:=#2;
	textcolor(lightgray);
end;

procedure vide_terrain(taillex,tailley:integer);
var i,j:integer;
begin
        for i:=1 to taillex do
        for j:=1 to tailley do
                tabl[i,j]:=' ';
end;

procedure dessine_cadre(taillex,tailley:integer);
var i,j:integer;
begin
    clrscr;
    for i:=2 to taillex-1 do
    begin
        tabl[i,1]:=#205;
	tabl[i,tailley]:=#205;
    end;
    for i:=2 to tailley-1 do
    begin
        tabl[1,i]:=#186;
        tabl[taillex,i]:=#186;
    end;
    tabl[1,1]:=#201;		//coins
    tabl[1,tailley]:=#200;
    tabl[taillex,1]:=#187;
    tabl[taillex,tailley]:=#188;
    for i:=1 to tailley do
    begin
        for j:=1 to taillex do
        write(tabl[j,i]);
        writeln;
    end;
end;


procedure dessine_laby(taillex,tailley:integer);
var i,j:integer;
begin
    tabl[1,9]:=' ';
    tabl[21,9]:=' ';
    tabl[3,3]:=#201;	   //ile NordOuest
    tabl[3,4]:=#200;
    tabl[5,3]:=#187;
    tabl[5,4]:=#188;
    tabl[4,3]:=#205;
    tabl[4,4]:=#205;       //fin ile NO
    tabl[7,3]:=#201;	   //ile NO 2
    tabl[7,4]:=#200;
    tabl[9,3]:=#187;
    tabl[9,4]:=#188;
    tabl[8,3]:=#205;
    tabl[8,4]:=#205;	   //fin ile NO 2
    tabl[11,1]:=#203;	   //mur nord
    tabl[11,2]:=#186;
    tabl[11,3]:=#186;
    tabl[11,4]:=#186;	   //fin mur N
    tabl[13,3]:=#201;	   //ile NordEst
    tabl[13,4]:=#200;
    tabl[15,3]:=#187;
    tabl[15,4]:=#188;
    tabl[14,3]:=#205;
    tabl[14,4]:=#205;      //fin ile NE
    tabl[17,3]:=#201;	   //ile NE 2
    tabl[17,4]:=#200;
    tabl[19,3]:=#187;
    tabl[19,4]:=#188;
    tabl[18,3]:=#205;
    tabl[18,4]:=#205;      //fin ile NE 2
    tabl[11,6]:=#203;	   //centre haut
    tabl[11,7]:=#186;
    tabl[11,8]:=#186;
    tabl[13,6]:=#205;
    tabl[10,6]:=#205;
    tabl[9,6]:=#205;
    tabl[12,6]:=#205;      //fin centre haut
    tabl[3,6]:=#205;	   //mur NO
    tabl[4,6]:=#205;
    tabl[5,6]:=#205;	   //fin mur NO
    tabl[17,6]:=#205;	   //mur NE
    tabl[18,6]:=#205;
    tabl[19,6]:=#205;	   //fin mur NE
    tabl[7,6]:=#186;	   //T NO
    tabl[7,7]:=#186;
    tabl[7,8]:=#204;
    tabl[7,9]:=#186;
    tabl[7,10]:=#186;
    tabl[8,8]:=#205;
    tabl[9,8]:=#205;	   //fin T NO
    tabl[15,6]:=#186;	   //T NE
    tabl[15,7]:=#186;
    tabl[15,8]:=#185;
    tabl[15,9]:=#186;
    tabl[15,10]:=#186;
    tabl[14,8]:=#205;
    tabl[13,8]:=#205;	   //fin T NE
    tabl[9,10]:=#201;	   //centre
    tabl[13,10]:=#187;
    tabl[9,11]:=#200;
    tabl[13,11]:=#188;
    tabl[10,10]:=#205;
    tabl[12,10]:=#205;
    tabl[11,10]:=#205;
    tabl[10,11]:=#205;
    tabl[12,11]:=#205;
    tabl[11,11]:=#205;     //fin centre
    tabl[7,12]:=#186;	   //mur O
    tabl[7,13]:=#186;
    tabl[7,14]:=#204;
    tabl[8,14]:=#205;      //fin mur O
    tabl[7,15]:=#186;
    tabl[7,16]:=#186;
    tabl[15,12]:=#186;	   //mur E
    tabl[15,13]:=#186;
    tabl[15,14]:=#185;
    tabl[14,14]:=#205;	   //fin mur E
    tabl[15,15]:=#186;
    tabl[15,16]:=#186;             //modif
    tabl[2,8]:=#205;       //sorties
    tabl[3,8]:=#205;
    tabl[4,8]:=#205;
    tabl[5,8]:=#205;
    tabl[20,8]:=#205;
    tabl[19,8]:=#205;
    tabl[18,8]:=#205;
    tabl[17,8]:=#205;
    tabl[1,8]:=#200;
    tabl[21,8]:=#188;
    tabl[2,10]:=#205;
    tabl[3,10]:=#205;
    tabl[4,10]:=#205;
    tabl[5,10]:=#205;
    tabl[20,10]:=#205;
    tabl[19,10]:=#205;
    tabl[18,10]:=#205;
    tabl[17,10]:=#205;
    tabl[1,10]:=#201;
    tabl[21,10]:=#187;	   //fin sorties
    tabl[5,12]:=#187;	   //L SO
    tabl[5,13]:=#186;
    tabl[5,14]:=#186;
    tabl[4,12]:=#205;
    tabl[3,12]:=#205;	   //fin L SO
    tabl[17,12]:=#201;	   //L SE
    tabl[17,13]:=#186;
    tabl[17,14]:=#186;
    tabl[18,12]:=#205;
    tabl[19,12]:=#205;	   //fin L SE
    tabl[1,14]:=#204;           //muret SO
    tabl[2,14]:=#205;
    tabl[3,14]:=#205;      //fin muret SO       //muret SE
    tabl[21,14]:=#185;   //muret SE
    tabl[20,14]:=#205;
    tabl[19,14]:=#205;	   //fin muret SE
    tabl[19,12]:=#205;	   //fin muret SE
    tabl[10,13]:=#205;	   //T sud
    tabl[11,13]:=#203;
    tabl[12,13]:=#205;
    tabl[11,14]:=#186;	   //fin T sud
    tabl[3,16]:=#205;
    tabl[4,16]:=#205;
    tabl[5,16]:=#205;
    tabl[9,16]:=#205;
    tabl[10,16]:=#205;
    tabl[11,16]:=#205;
    tabl[12,16]:=#205;
    tabl[13,16]:=#205;
    tabl[17,16]:=#205;
    tabl[18,16]:=#205;
    tabl[19,16]:=#205;    //fin lignes sud
  //  tabl[6,16]:=#186;
  //  tabl[6,17]:=#186;
  //  tabl[16,16]:=#186;
  //  tabl[16,17]:=#186;
    gotoxy(1,1);
    for i:=1 to tailley do
    begin
        for j:=1 to taillex do
        write(tabl[j,i]);
        writeln;
    end;
        gotoxy(2,21);
	writeln('Commencez a courir!');
end;

procedure dessine_terrain(taillex,tailley:integer);
var i,j:integer;
begin
   textcolor(yellow);
   tabl[posx,posy]:=#2;
   for i:=2 to tailley-1 do
	   for j:=2 to taillex do
			if tabl[j,i]<>tabl2[j,i] then
			begin
				gotoxy(j,i);
				write(tabl[j,i]);
	   end;
   if (posx=11) and (posy=9) then               //fix affichage pos neutre
        begin
                gotoxy(11,9);
                write(#2);
        end;
   textcolor(lightgray);
end;

procedure text;
begin
        gotoxy(24,2);
        textcolor(white);
        write(#24+' '+#25+' '+#26+' '+#27+' : faire un pas');
        gotoxy(24,6);
        textcolor(lightgray);
        write('Aidez Gloupsman ');
        textcolor(yellow);
        write(#2);
        textcolor(lightgray);
        write(' a manger les 181 pitits points dans chaque niveau.');
        gotoxy(24,7);
        write('Prenez garde aux villains ');
        textcolor(lightred);
        write('A ');
        textcolor(lightmagenta);
        write('B ');
        textcolor(lightgray);
        write('et ');
        textcolor(11);
        write('C');
        textcolor(lightgray);
        gotoxy(24,12);
        write('Reflechissez bien avant chaque pas, vous n''avez que 3 vies !');
end;


function peut_bouger(x,y:integer):boolean;		//collisions pacman ou fantomes
begin
	peut_bouger:=((tabl[x,y]=' ') or (tabl[x,y]='.'));
end;

function fpeut_bouger(x,y:integer):boolean;		//collisions pacman ou fantomes
begin
	fpeut_bouger:=((tabl[x,y]=' ') or (tabl[x,y]='.') or (tabl[x,y]=#2));
end;

procedure f;		//fantomeA
begin
    gotoxy(v,w);
	if nogum=false then		//remplacement du gum si il y en avait un
		write ('.')
	else
		write (' ');
    if Amoved=false then                //si A n a pas encore bouge ce tour ci
        if fpeut_bouger(v+1,w) then
                if posx>v then
                        if ((v+1)<>v2) or (w<>w2) then          //evit B
                                if ((v+1)<>v3) or (w<>w3) then  //evit C
                                        begin
			                        v:=(v+1);       //va a droite
                                                Amoved:=true;   //A a bouge
		                        end;
    if Amoved=false then
        if fpeut_bouger(v,w+1) then
                if posy>w then
                        if (v<>v2) or ((w+1)<>w2) then
                                if (v<>v3) or ((w+1)<>w3) then
		                        begin
                                                Amoved:=true;
				                w:=w+1;         //va en bas
			                end;
    if Amoved=false then
        if fpeut_bouger(v-1,w) then
                if posx<v then
                        if ((v-1)<>v2) or (w<>w2) then
                                if ((v-1)<>v3) or (w<>w3) then
		                        begin
                                                Amoved:=true;
				                v:=v-1;         //va a gauche
		                        end;
    if Amoved=false then
        if fpeut_bouger(v,w-1) then
                if posy<w then
                        if (v<>v2) or ((w-1)<>w2) then
                                if (v<>v3) or ((w-1)<>w3) then
		                        begin
                                                Amoved:=true;
				                w:=w-1;         //va en haut
		                        end;
    gotoxy(v,w);
	if (tabl[v,w]='.') then		//affectation de nogum
		nogum:=false
	else
		nogum:=true;
	textcolor(lightred);
    write ('A');
	textcolor(lightgray);
    Amoved:=false;                      //Amoved reinit
end;

procedure f2;		//fantomeB
begin
    gotoxy(v2,w2);
	if nogumB=false then
		write ('.')
	else
		write (' ');
    if Bmoved=false then
        if fpeut_bouger(v2-1,w2) then
                if posx<v2 then
                        if ((v2-1)<>v) or (w2<>w) then
                                if ((v2-1)<>v3) or (w2<>w3) then
                                        begin
			                        v2:=(v2-1);
                                                Bmoved:=true;
                                        end;
    if Bmoved=false then
        if fpeut_bouger(v2+1,w2) then
		if posx>v2 then
                        if ((v2+1)<>v) or (w2<>w) then
                                if ((v2+1)<>v3) or (w2<>w3) then
                                        begin
				                v2:=(v2+1);
                                                Bmoved:=true;
                                        end;
    if Bmoved=false then
        if fpeut_bouger(v2,w2-1) then
		if posy<w2 then
                        if (v2<>v) or ((w2-1)<>w) then
                                if (v2<>v3) or ((w2-1)<>w3) then
                                        begin
				                w2:=(w2-1);
                                                Bmoved:=true;
                                        end;
    if Bmoved=false then
        if fpeut_bouger(v2,w2+1) then
		if posy>w2 then
                        if (v2<>v) or ((w2+1)<>w) then
                                if (v2<>v3) or ((w2+1)<>w3) then
                                        begin
				                w2:=(w2+1);
                                                Bmoved:=true;
                                        end;
    gotoxy(v2,w2);
	if (tabl[v2,w2]='.') then
		nogumB:=false
	else
		nogumB:=true;
	textcolor(lightmagenta);
    write ('B');
	textcolor(lightgray);
    Bmoved:=false;
end;

procedure f3;		//fantomeC
begin
    gotoxy(v3,w3);
	if nogumC=false then
		write ('.')
	else
		write (' ');
    if Cmoved=false then
        if fpeut_bouger(v3-1,w3) then
                if posx<v3 then
                        if ((v3-1)<>v) or (w3<>w) then
                                if ((v3-1)<>v2) or (w3<>w2) then
                                        begin
			                        v3:=(v3-1);
                                                Cmoved:=true;
                                        end;
    if Cmoved=false then
        if fpeut_bouger(v3+1,w3) then
		if posx>v3 then
                        if ((v3+1)<>v) or (w3<>w) then
                                if ((v3+1)<>v2) or (w3<>w2) then
                                        begin
				                v3:=(v3+1);
                                                Cmoved:=true;
                                        end;
    if Cmoved=false then
        if fpeut_bouger(v3,w3-1) then
		if posy<w3 then
                        if (v3<>v) or ((w3-1)<>w) then
                                if (v3<>v2) or ((w3-1)<>w2) then
                                        begin
				                w3:=(w3-1);
                                                Cmoved:=true;
                                        end;
    if Cmoved=false then
        if fpeut_bouger(v3,w3+1) then
		if posy>w3 then
                        if (v3<>v) or ((w3+1)<>w) then
                                if (v3<>v2) or ((w3+1)<>w2) then
                                        begin
				                w3:=(w3+1);
                                                Cmoved:=true;
                                        end;
    gotoxy(v3,w3);
	if (tabl[v3,w3]='.') then
		nogumC:=false
	else
		nogumC:=true;
    textcolor(11);
    write ('C');
	textcolor(lightgray);
    Cmoved:=false;
end;

procedure dessine_f;            //redessine les f (apres une mort)
begin
        gotoxy(v,w);
        textcolor(lightred);
        write ('A');
        gotoxy(v2,w2);
        textcolor(lightmagenta);
        write ('B');
        gotoxy(v3,w3);
        textcolor(11);
        write ('C');
        textcolor(lightgray);
end;


procedure nextlevel;		//charge le niveau suivant
begin
		nogum:=false;
                nogumB:=false;
                nogumC:=false;
        Amoved:=false;
                Bmoved:=false;
                Cmoved:=false;
		posx:=11;		//centrage de pacman
        posy:=9;
        dessine_cadre(maxx,maxy);
        init(maxx,maxy);
        v:=(2);		//pos fantomeA
        w:=(2);
		v2:=(20);	//pos fantomeB
		w2:=(17);
                v3:=(20);       //pos fantomeC
                w3:=(2);
        dessine_laby(maxx,maxy);
		text;
		textcolor(lightgray);
		gotoxy(18,19);
		write(score);
		gotoxy(18,20);
        write(scoremax);
		dessine_f;
		gotoxy(3,19);
		textcolor(yellow);
		write(#2);
		textcolor(lightgray);		
end;

procedure gameover;             //id du fantome tuant gloupsman, ou victoire
begin
        if (tabl[posx,posy]=tabl[v,w]) then
                begin
                        tabl[posx,posy]:=(' ');
                        posx:=11;
                        posy:=9;
                        IDfantome:=1;
                        vie:=vie-1;
                        dessine_terrain(maxx,maxy);
                        dessine_f;
                end;
        if (tabl[posx,posy]=tabl[v2,w2]) then
                begin
                        tabl[posx,posy]:=(' ');
                        posx:=11;
                        posy:=9;
                        IDfantome:=2;
                        vie:=vie-1;
                        dessine_terrain(maxx,maxy);
                        dessine_f;
                end;
        if (tabl[posx,posy]=tabl[v3,w3]) then
                begin
                        tabl[posx,posy]:=(' ');
                        posx:=11;
                        posy:=9;
                        IDfantome:=3;
                        vie:=vie-1;
                        dessine_terrain(maxx,maxy);
                        dessine_f;
                end;
	if (score=181) or (score=363) or (score=545) then	//niveau suivant
	        begin
		        niveau:=niveau+1;
			score:=score+1;
			nextlevel;
		end;
	if (score=726) then				//niveau max, fin
	        begin
		        IDfantome:=0;
			stop:=true;
		end;
        if vie<1 then stop:=true;
end;

procedure smax;                         //record
begin
        if score>scoremax then
        scoremax:=score;
        gotoxy(18,20);
        write(scoremax);
end;


BEGIN
    scoremax:=0;
    Again:                              //nouvelle partie
	{Assign(UserFile,'D:\Gloupstop.txt');		enregistrement du score max
	Reset(UserFile);
	readln(UserFile,topscore);
	Close(UserFile);}
    textcolor(lightgray);
    clrscr;
    cursoroff;
    niveau:=1;
    vie:=3;
    stop:=false;
    nogum:=false;
	nogumB:=false;
        nogumC:=false;
    Amoved:=false;
        Bmoved:=false;
        Cmoved:=false;
    IDfantome:=0;
    posx:=11;		//centrage de pacman
    posy:=9;
    dessine_cadre(maxx,maxy);
	gotoxy(6,4);                    //ecran titre
	textcolor(yellow);
	write('Gloupsman!!');
	gotoxy(4,6);
	textcolor(lightgray);
	
	gotoxy(3,8);
	write('Jerome Loewenguth');
    gotoxy(9,9);
    write('2026');
	gotoxy(2,12);
        textcolor(white);
	write('Appuyez sur entrer.');
        gotoxy(7,17);
        textcolor(red);
        write('v. 3.0');
        text;
	textcolor(white);
	gotoxy(2,20);
	write('Record absolu : ');
	write(topscore);
	readln;
	clrscr;
	gotoxy(3,17);                   //ecran de jeu
	textcolor(yellow);
	write(#2);
    init(maxx,maxy);
    v:=(2);		//pos fantomeA
    w:=(2);
	v2:=(20);	//pos fantomeB
	w2:=(17);
        v3:=(20);       //pos fantomeC
        w3:=(2);
    score:=0;
    dessine_cadre(maxx,maxy);
    dessine_laby(maxx,maxy);
	dessine_f;
    text;
    a:=readkey;
    tabl2:=tabl;
    while (a<>#27) and (stop=false) do		//quitter la partie
    begin
        gotoxy(2,21);
        write('                   ');
		gotoxy(3,20);
		write('niv ');
		write(niveau);
        gotoxy(4,19);
        write(' x ');
        write(vie);
        gotoxy(12,19);
        write('score');
        gotoxy(11,20);
        write('record');
        a:=readkey;
        gotoxy(18,20);
        write(scoremax);
        if a=#77 then		//aller a droite
			begin
			if peut_bouger(posx+1,posy) then
				begin
					tabl[posx,posy]:=' ';
					posx:=posx+1;
					if tabl[posx,posy]='.' then score:=score+1;
					if (((posx=20) or (posx=21)) and (posy=9)) then		//porte droite
					begin
						tabl[20,9]:=' ';
						posx:=2;
						posy:=9;
					end;
					dessine_terrain(maxx,maxy);
					gotoxy(18,19);
					write(score);
                                        smax;
				end;
                        //gameover;
			f;
			f2;
                        f3;
			end;
        if a=#75 then		//aller a gauche
			begin
			if peut_bouger(posx-1,posy) then
				begin
					tabl[posx,posy]:=' ';
					posx:=posx-1;
					if tabl[posx,posy]='.' then score:=score+1;
					if (((posx=2) or (posx=1)) and (posy=9)) then			//porte gauche
					begin
						tabl[2,9]:=' ';
						posx:=20;
						posy:=9;
					end;
					dessine_terrain(maxx,maxy);
					gotoxy(18,19);
					write(score);
                                        smax;
				end;
                        //gameover;
			f;
			f2;
                        f3;
			end;
        if a=#72 then		//descendre
			begin
			if peut_bouger(posx,posy-1) then
				begin
					tabl[posx,posy]:=' ';
					posy:=posy-1;
					if tabl[posx,posy]='.' then score:=score+1;
					dessine_terrain(maxx,maxy);
					gotoxy(18,19);
					write(score);
                                        smax;
				end;
                        //gameover;
			f;
			f2;
                        f3;
			end;
        if a=#80 then		//monter
			begin
			if peut_bouger(posx,posy+1) then
				begin
					tabl[posx,posy]:=' ';
					posy:=posy+1;
					if tabl[posx,posy]='.' then score:=score+1;
					dessine_terrain(maxx,maxy);
					gotoxy(18,19);
					write(score);
                                        smax;
				end;
                        //gameover;
			f;
			f2;
                        f3;
			end;
		gotoxy(3,19);
		textcolor(yellow);
		write(#2);
		textcolor(lightgray);
                gameover;
    end;
	clrscr;
		if score>topscore then
			begin
				topscore:=score;
				{Assign(UserFile,'D:\Gloupstop.txt');
				Rewrite(UserFile);
				Writeln(UserFile,topscore);
				Close(UserFile);}
			end;
        textcolor(lightgray);
        vide_terrain(maxx,maxy);
        dessine_cadre(maxx,maxy);
        if IDfantome=1 then             //fantome ayant tue gloupsman
                begin
                        gotoxy(2,4);
                        textcolor(lightred);
                        write('A');
                        textcolor(lightgray);
                        write(' vous a gloups !!');
                end;
        if IDfantome=2 then
                begin
                        gotoxy(2,4);
                        textcolor(lightmagenta);
                        write('B');
                        textcolor(lightgray);
                        write(' vous a gloups !!');
                end;
        if IDfantome=3 then
                begin
                        gotoxy(2,4);
                        textcolor(11);
                        write('C');
                        textcolor(lightgray);
                        write(' vous a gloups !!');
                end;
        if IDfantome=0 then                      //victoire
                begin
                        gotoxy(7,4);
                        textcolor(yellow);
                        write('Gloups !!');
                        textcolor(lightgray);
                end;
	gotoxy(3,7);
	write('Vous avez gloups');
	gotoxy(3,8);
	textcolor(white);
	write(score);
	textcolor(lightgray);
	write(' petits points');
	if score < 40 then    //fins en fonction du score
	begin
		gotoxy(8,10);
		write('(-_-")');	//flavour text en fonction du score
	end;
	if (score < 90) and (score>=40) then
	begin
		gotoxy(7,10);
		write('(noob...)');
	end;
        if (score > 110) and (score <= 190) then
        begin
                gotoxy(7,10);
                write('(Pas mal...)');
        end;
	if (score > 190) and (score <= 290) then
	begin
		gotoxy(7,10);
		write('(Bieeeen !)');
	end;
	if score > 290 then
	begin
		gotoxy(3,10);
		write('(T TRO FOR)');
	end;
    gotoxy(3,14);
    textcolor(red);
    write('Nouvelle partie ?');
    gotoxy(8,15);
    write('(O/N)');
	textcolor(lightgray);
	gotoxy(24,2);
	write('Record de session : ');
	write(scoremax);
	textcolor(white);
	gotoxy(24,4);
	write('Record absolu : ');
	write(topscore);
	Incorrect:
    a:=readkey;
    case (a) of
        'o':goto Again;                 //nouvelle partie
        'n':goto Finish
    else goto Incorrect;                //autres input ignores
    end;
    Finish:
END.

