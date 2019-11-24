unit Unit2pir;
 {
24.11.2019
головоломка которую легко собрать
конвеер заглушен, упирается в стену
  }
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.Menus;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Image1: TImage;
    MainMenu1: TMainMenu;
    StatusBar1: TStatusBar;
    here1: TMenuItem;
    Game1: TMenuItem;
    New1: TMenuItem;
    View1: TMenuItem;
    AlCombos1: TMenuItem;
    procedure Button1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure Button1MouseLeave(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure here1Click(Sender: TObject);
    procedure New1Click(Sender: TObject);
    procedure AlCombos1Click(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure vw; // вид
  end;
const ese: array[0..5] of string=('123','132','213','231','312','321');
const det: array[0..26]of string=('000','001','002','010','011','012','020','021','022',
                                  '100','101','102','110','111','112','120','121','122',
                                  '200','201','202','210','211','212','220','221','222'
                                  );
const n4: array[0..2] of integer=(1,2,0); // разводка схема один
const n5: array[0..2] of integer=(1,0,2); // разводка два
const cc: array[0..4] of tcolor=(clred,claqua,clyellow,cllime,clfuchsia);
type trixx=array[0..2]of byte;
var poz: trixx=(1,2,3);
var spn: trixx=(0,0,0);
coo: array[0..2,0..2]of tpoint; // знакоместа фигур
mp: array[0..26,0..5]of byte; // матрица комб
maxb: integer=0; // максимальная сложность
maxz: array[0..5]of integer=(0,0,0,0,0,0); // сложности
c4: array [0..4,0..1] of string=(('231','222'),('123','200'),('123','210'),('123','010'),('312','111'));
hand: integer;// раздача
var
  Form1: TForm1;
  r: array[0..2] of trect; // ректы подсветки
implementation

{$R *.dfm}

procedure sww(x,y: byte; z: byte); // ось и спин в спин
begin
spn[x]:=(6-spn[x]-z) mod 3;
spn[y]:=(6-spn[y]-z) mod 3;
end;

procedure men(x,y: byte); // обмен элементов и спинов
var i: byte;
begin
i:=poz[x];
poz[x]:=poz[y]; poz[y]:=i;
i:=spn[x];
spn[x]:=spn[y]; spn[y]:=i;
end;

procedure acty(x: integer);  // мувы
var i,j,k: integer; s,d: string;
begin
case x of
  0:begin men(0,1); sww(0,1,x); end;
  1:begin men(1,2); sww(1,2,x); end;
  2:begin men(0,2); sww(0,2,x); end;
end;
s:=''; d:='';
for i:=0 to 2 do
  begin
    s:=s+inttostr(poz[i]);
    d:=d+inttostr(spn[i]);
  end;
with form1 do
  begin
    statusbar1.Panels[1].Text:=s+'          '+d;
  end;
end;

function poztostr(x: integer): string;
begin
  result:='666';
  if x in [0..5] then result:=ese[x];
end;

function strtopoz(x: string): byte; // установить позицию
var i: integer;
begin
result:=66;
for i:=0 to high(ese) do
  if ese[i]=x then result:=i;
end;

function getpoz: byte;  // получить позицию
var s: string;
begin
s:=format('%d%d%d',[poz[0],poz[1],poz[2]]);
result:=strtopoz(s);
end;

function spntostr(x: integer): string;
begin
  result:='666';
  if x in [0..26] then result:=det[x];
end;

function strtospn(x: string): byte; // строку в спин
var i: integer;
begin
result:=66;
for i:=0 to high(det) do
  if det[i]=x then result:=i;
end;

function getspn: byte; // получить номер спина
begin
result:=spn[0]*3*3+spn[1]*3+spn[2];
end;


procedure setcombo(poo,soo: string); // установка
var i,j,k: integer;
begin
poz[0]:=strtoint(poo[1]);
poz[1]:=strtoint(poo[2]);
poz[2]:=strtoint(poo[3]);
spn[0]:=strtoint(soo[1]);
spn[1]:=strtoint(soo[2]);
spn[2]:=strtoint(soo[3]);
end;

procedure mozg; // расчет всех комб, забивание в матрицу
const n999=9999;
var i,j,k,xx,yy: integer; p: tpoint;
    run,fin: integer;
    a: array[0..n999]of tpoint;
    b: array[0..n999]of integer;
    s,d: string;

    procedure addy(x: tpoint;y: integer);
    label ho;
    begin
      if not(x.X in [0..high(mp)]) then goto ho;
      if not(x.y in [0..high(mp[0])]) then goto ho;
      a[run]:=x;
      b[run]:=y;
      if y>maxb then maxb:=y;
      if run<n999 then
        begin
        inc(run);
        end
        else
        begin
        showmessage('runda');
        end;
      exit;
      ho:
      showmessage('sup');
    end;
begin
p:=point(0,0);
run:=1;
fin:=0;
a[fin]:=p;
b[fin]:=0;
while fin<>run do
  begin
    p:=a[fin];
    if mp[p.X,p.y]=111 then
      begin
        mp[p.X,p.y]:=b[fin];
        s:=spntostr(p.x);
        d:=poztostr(p.y);
        if poz[0]=6 then
        showmessage('frukt');
        setcombo(d,s);
        acty(0);
        xx:=getspn;
        yy:=getpoz;
        if mp[xx,yy]=111 then addy(point(xx,yy),b[fin]+1);
        s:=spntostr(p.x);
        d:=poztostr(p.y);
        if poz[0]=6 then
        showmessage('frukt');

        setcombo(d,s);
        acty(1);
        xx:=getspn;
        yy:=getpoz;
        if mp[xx,yy]=111 then addy(point(xx,yy),b[fin]+1);
        s:=spntostr(p.x);
        d:=poztostr(p.y);
        setcombo(d,s);
        acty(2);
        xx:=getspn;
        yy:=getpoz;
        if mp[xx,yy]=111 then addy(point(xx,yy),b[fin]+1);
      end;
    inc(fin);
    if fin>n999 then begin showmessage('finda'); break; end;
  end;

  for i:=0 to high(mp) do
    for j:=0 to high(mp[0]) do
      if mp[i,j]in[0..5] then
        inc(maxz[mp[i,j]]); // количество сложностей  // 1,3,6,9,5,0
end;

{   учебный отладочный пример
procedure mozg;
var i,j,k: integer; p: tpoint;
    run,fin: integer;
    a: array[0..999]of tpoint;
    b: array[0..999]of integer;

    procedure addy(x: tpoint;y: integer);
    begin
      if not(x.X in [0..high(mp)]) then exit;
      if not(x.y in [0..high(mp[0])]) then exit;
      a[run]:=x;
      b[run]:=y;
      if run<999 then inc(run);
    end;
begin
p:=point(10,3);
run:=1;
fin:=0;
a[fin]:=p;
b[fin]:=0;
while fin<>run do
  begin
    p:=a[fin];
    if mp[p.X,p.y]=111 then
      begin
        mp[p.X,p.y]:=b[fin];
        addy(point(p.x+1,p.Y),b[fin]+1);  //вправо
        addy(point(p.x+1,p.Y+1),b[fin]+1); // вправо-вниз
      end;
    inc(fin);
    if fin>999 then break;
  end;
end;
}

function zero: boolean; // факт собранности
begin
result:=(getpoz=0)and(getspn=0);
end;

procedure bud; // матрица комб
var i,j,k: integer;
begin
for i:=0 to 26 do
  for j:=0 to 5 do
    mp[i,j]:=111; // 'не занято'
///---------------------------
mozg; // постройка матрицы комб
end;

procedure TForm1.AlCombos1Click(Sender: TObject);
begin
alcombos1.Checked:=not alcombos1.Checked;
vw;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
acty(0); // мув ноль
statusbar1.Panels[0].Text:=inttostr(mp[getspn,getpoz]);
end;

procedure TForm1.Button1MouseLeave(Sender: TObject);
var i: integer;
begin
i:=(sender as tbutton).tag;
with image1.Canvas do  // убрать подсветку
  begin
    brush.Color:=clwhite;
    fillrect(cliprect);
  end;
//---------------
vw;
end;

procedure TForm1.Button1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var i,j,k,kk: integer; p: tpoint;
begin
kk:=22;
i:=(sender as tbutton).tag;
with image1.Canvas do // подсветка меняемых слоев
  begin
    brush.Color:=clyellow;//cc[2];//cc[i];//clwhite;//
    fillrect(cliprect);
    brush.Color:=clwhite;//cc[i];//
    fillrect(r[i]);
  end;
vw;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
acty(1); // мув один
statusbar1.Panels[0].Text:=inttostr(mp[getspn,getpoz]);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
acty(2);  // мув два
statusbar1.Panels[0].Text:=inttostr(mp[getspn,getpoz]);
end;

procedure cooma; /// расчет чекпоинтов
var i,j,k: integer; s,d: single;
begin
with form1 do
  begin
    s:=image1.Width/6;
    d:=image1.Height/6;
    for i:=0 to 2 do
      for j:=0 to 2 do
        coo[j,n5[i]]:=point(round(s*i*2+s),round(d*j*2+d));
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var i: integer; t: trect;
begin
form1.Color:=5275647; // коралловый цвет
cooma; // рачет чекпоинтов
bud; //
button1.Tag:=0;
button2.Tag:=1;
button3.Tag:=2;
button2.OnMouseMove:=button1.OnMouseMove;
button3.OnMouseMove:=button1.OnMouseMove;
Button2.onMouseLeave:=Button1.onMouseLeave;
Button3 .onMouseLeave:=Button1.onMouseLeave;
for i:=0 to 2 do // фон подсветки свопа
  with image1.canvas do
    begin
      t:=cliprect;
      t.Top:=i*(t.bottom div 3);
      t.Bottom:=(i+1)*(t.Bottom div 3)+2;
      r[n4[i]]:=t;
    end;
//----------
randomize;
i:=random(5); // выбор стартовой комбы из списка
hand:=i;
setcombo(c4[i,0],c4[i,1]);
vw;
end;

procedure TForm1.here1Click(Sender: TObject); // путь к файлу
begin
showmessage(paramstr(0));
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
statusbar1.Panels[2].Text:=format('   x%d    y%d',[x,y]);
end;

procedure TForm1.New1Click(Sender: TObject); // новая игра
var i: integer;
begin
with form1.Image1.Canvas do
  begin
    brush.Color:=clwhite;
    fillrect(cliprect);
  end;
repeat
i:=random(5);  // генерация новой комбы из списка сложных
until hand<>i;
hand:=i;  // заданая комба
setcombo(c4[i,0],c4[i,1]);
vw;
end;

procedure TForm1.vw;
var p,m1,m2,m3: tpoint;  i,j,k7,k,kk,xx,yy: integer;
begin
m1:=coo[0,0]; m2:=coo[1,0]; m3:=coo[2,0]; // центральный столб
kk:=22; k:=40;  k7:=50; // коэф-ы построения фигур
with image1.Canvas do
  begin
    for j:=0 to 2 do
      begin
        p:=coo[j,spn[j]];
        brush.Style:=bsclear;    //  конечные места для фигур
        case poz[j] of
          1: polyline([point(m1.x,-k7+m1.y),point(k7+m1.x,k7+m1.y-10),point(-k7+m1.x,k7+m1.y-10),point(m1.x,-k7+m1.y)]);
          2: ellipse(k+m2.x,k+m2.y,-k+m2.x,-k+m2.y);
          3: rectangle(k+m3.x,k+m3.y,-k+m3.x,-k+m3.y);
        end;

        brush.style:=bssolid;// собственно фигуры
        brush.Color:=clolive;
        case poz[j] of
          1: polygon([point(p.x,-kk+p.y),point(kk+p.x,kk+p.y),point(-kk+p.x,kk+p.y)]);
          2: ellipse(kk+p.x,kk+p.y,-kk+p.x,-kk+p.y);
          3: rectangle(kk+p.x,kk+p.y,-kk+p.x,-kk+p.y);
        end;
      end;
    if alcombos1.Checked then  // матрица всех комбинаций
      begin
        brush.Color:=clred;
        xx:=25+getspn*15;
        yy:=25+getpoz*15;
        ellipse(xx,yy,xx+15,yy+15);
        for i:=0 to 26 do
        for j:=0 to high(mp[i]) do
        begin
          case mp[i,j] of
            111: brush.Color:=rgb(250,250,250);//clsilver;//clwhite;//clfuchsia;//
            else brush.Color:=cc[mp[i,j]mod 5];//clsilver;
          end;
          fillrect(rect(30+i*15,30+j*15,30+i*15+5,30+j*15+5));
        end;
      end;
    if zero then
      begin
        brush.color:=clblue;  // краска
        floodfill(300,100, clblack, fsBorder);
        floodfill(300,64, clblack, fsBorder);
        floodfill(263,192, clblack, fsBorder);
        floodfill(263,135, clblack, fsBorder);
        floodfill(263,71, clblack, fsBorder);
        floodfill(263,71, clblack, fsBorder);

      end;
  end;
statusbar1.Panels[0].Text:=inttostr(mp[getspn,getpoz]);
end;

end.
