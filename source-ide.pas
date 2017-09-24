Program devineca;
uses wincrt;
var
choix : string;
xx : integer;
npes : integer;
njou , essai : integer;
vernum, ver : boolean;
njch , npch : string;
v, c : integer;
o : char;

{for presentation}
procedure presentation (var choix : string);
begin
writeln ('************************Bienvenue sur Devine Ca!************************');
writeln (' ');
writeln ('Production de Ahmed Debbech      ***     Tous les droits sont réservés 2017(c)');
writeln ('Inspiré de jeu "Vache-Taureau". Ahmed Debbech éleve 4eme SC de linformatique');
writeln (' ');
writeln ('            Pour demarrer le jeu vous devez écrir "jouer"');
writeln ('            Si vous ne savez pas comment jouer, écrivez "aide"');
writeln ('Votre choix:');
readln (choix);

end;

{for help case}
function aide : string ;
begin
writeln ('***********COMMENT JOUER!***********');
writeln ('Le principe de jeu est simple:');
writeln ('L"Ordinateur a choisi un nombre de 3 chiffres aléatoires, votre role est de le trouver');
writeln ('Il faut d"abord entrer un nombre composé de 3 chifres SEULEMENT.');
writeln ('N.B: vous pouvez répeter un chiffre deux ou trois fois.');
writeln ('Aprés la comparaison de votre nombre et le nombre de l"orinateur, l"ordinateur va afficher des lettres:');
writeln ('-S"il affiche la lettre "V" sa veut dire que LE NOMBRE EST CORRECT ET DANS SA PALACE.');
writeln ('-S"il affiche la lettre "C" sa veut dire que LE NOMBRE EST CORRECT MAIS IL N"EST PAS DANS SA PLACE.');
writeln ('Les nombres avec les lettres sont les indicateurs de répetition. Par exemple:');
writeln ('C2+V1 : "C2" indique qu"il ya deux nombres n"ont pas la place correcte et il faut changer de places');
writeln (' et "V1" indique qu"il ya un nombre correct et dans sa place et on ne le touche pas.');
writeln ('En cas ou l"ordinateur affiche "C0+V0" ca veut dire il n"ya aucun nombre correct');
writeln ('Grace a votre resultats précédentes il faut deviner le nombre correct');
writeln ('Si l"ordinateur affiche "V3+C0" VOUS AVEZ GAGNER et Trouvé le nombre correct!');
writeln (' Amusez-vous bien! --- pour jouer écrivez "jouer"');
repeat
if (choix <> 'jouer') then
begin
readln (choix);
 writeln ('SVP écrivez "jouer".');
end;
until (choix = 'jouer');
aide := choix;
end;

{pc picks a nummber randomly}
function penseord : integer;
var
ii : integer;
begin
randomize;
ii := random(899)+101;
npes := ii;
penseord := npes;
end;

{the enter of user}
procedure saisie (var njou : integer; var essai : integer);
begin
essai := essai + 1 ;
if (essai = 1) then
begin
writeln ('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
writeln ('Essai no',essai,': Ecrivez votre nombre pour deviner le nombre correct');
writeln ('(N.B: le nombre doit etre comopser de 3 chiffres seulement! pas de lettres!)');
readln( njou); 
end
else
begin
 writeln ('Essai no',essai,' Ecrivez votre nombre:');
 readln (njou);
end;
end;

{checking num of user for compatibility}
function check (njou : integer) : boolean;
var
 i : integer;
begin
 if (100 > njou) or (njou > 999) then
 begin 
  writeln ('Incorrect!');
  vernum := false;
  if (essai <> essai-1) then
  begin
   essai := essai - 1;
  end;
 end
 else
 begin
  vernum := true;
 end;
check := vernum;;
end;

{convert to ch to simplify the engin module}
procedure conv (njou, npes : integer; var npch, njch : string);
begin
 str(njou, njch);
 str(npes, npch);
end;

{the hard work------ comparison of numbers}
procedure moteur (var v, c : integer; njch, npch: string);
var
i, j ,test : integer;
begin
v := 0;
c := 0;
j := 1; i := 1;
test := 0;
while (i <= 3) do
begin
 j := i;
 if njch[i] = npch[j] then
 begin
  v := v + 1;
  i := i + 1;
 end
 else
  begin
   j := 1;
   test := 0;
   while (j <= 3) and (test < 1) do
   begin
    if (njch[i] = npch[j]) and (i<>j) then
    begin
     c := c + 1;
     test := test + 1;
    end
    else
    begin
       j := j + 1 ;
      end;
    end;
   i := i + 1 ;
  end;
 end;
 end;

{----------------------------}
{monitoring the results}
procedure affichage (v,c : integer);
var
b : integer;
begin
 if (v=2) and (c=1) then
 begin
  writeln ('v',v,'+c0');
  writeln ('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
 end
 else
 begin
  b := 1;
  if (njch[b]=njch[b+1]) and (njch[b]=njch[b+2]) then
    begin
     writeln ('v',v,'+c0');
      writeln ('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
    end
   else
   begin
     if ((njch[b]=njch[b+1]) or (njch[b]=njch[b+2])) and (c=3) then
      begin
       writeln ('v0','+c',c-1);
       writeln ('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
      end
    else
    begin
     writeln('v',v,'+c',c);
      writeln ('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
    end;
   end;
  end;
  if (v=3) then
begin
 writeln ('VOUS AVEZ GAGNEZ!!');
 Writeln ('Le nombre correct est: ',npch);
 writeln ('Vous avez trouver le nombre à partir du ',essai,' essais');
end;
 end;

{end of game ask continue}
function finjeu : char;
begin
 writeln ('Si vous voulez répeter le jeu appuiez sur "n" et "entrer"');
 readln (o);
 if (o = 'n') then
 begin
  ClrScr;
  finjeu := o;
 end;
end;

{principale}
begin
repeat
essai := 0;
presentation (choix);
repeat
if (choix = 'aide') then
begin
 aide;
 xx := 1;
 end
 else
 begin
 if (choix = 'jouer') then
 begin
  xx := 1;
 end
 else
 begin
  writeln ('SVP écrivez "jouer" ou "aide".');
  readln (choix);
  end;
end;
until (choix = 'jouer') or (xx = 1);
if (choix = 'jouer') then
begin
{the work starts}
  penseord;
  writeln('     ');
while (njou <> npes) do
begin
  repeat
  saisie (njou,essai);
  until (check(njou) = true);
  conv (npes,njou,npch,njch);
  moteur (v,c,njch,npch);
  affichage(v,c);
end;
end;
 if (finjeu = 'n') then
 begin
  ver := true;
 end;
until (ver = false);

{end of everything.}
end.