import GUI
var start, finish, diff, RandV, Split, score, lives, destroyed, extralife : int
Split := 0
score := 0
lives := 3
destroyed := 0
extralife := 0
var font : int := Font.New("Fixedsys:20")
var scoreStr, livesStr : string
%Ship values
var x, y, accx, accy, a, safex, safey, d, r : real
d := 22.5 %Angle of rotation
x := 300
y := 200
accx := 0 %x Velocity
accy := 0 %y Velocity
a := 1 %Movement delay
safex := 200
safey := 100

%Ship values 2
var shipPic, shipHeight, shipWidth : int
shipPic := Pic.FileNew ("Spaceship1.bmp")
shipHeight := Pic.Height (shipPic)
shipWidth := Pic.Width (shipPic)
shipHeight := round (y)
shipWidth := round (x)
var ship : boolean := true
var angle : array 1 .. 16 of int
var shipTurn : int

%Bullet values
var bullet : array 1 .. 2 of boolean
var bulletx, bullety, bulletxvel, bulletyvel : array 1 .. 2 of real
var range : array 1 .. 2 of int
range (1) := 50
range (2) := 50
var trigger : real := 0

%UFO values
var UFOPic, RareUFOPic, UFOLimit, RareUFOLimit : int
UFOPic := Pic.FileNew ('UFO.bmp')
RareUFOPic := Pic.FileNew ('UFORare.bmp')
UFOLimit := 0
RareUFOLimit := 0
var UFOx, UFOy, RareUFOx, RareUFOy, UFOVelx, UFOVely, RUFOVelx, RUFOVely, UFODelay : real
UFOx:= 0
UFOy:= 0
RareUFOx:= 0
RareUFOy:= 0
UFOVely:= 0
RUFOVely:= 0
var UFO, RareUFO : boolean := false

%Crash Variables
var RareUFOCrash, UFOCrash, ShipCrash : boolean := false
var BulletHit : array 1..2 of boolean
BulletHit(1) := false
BulletHit(2) := false
%Store asteroid pictures
var AsteroidPics : array 1 .. 4 of int
AsteroidPics (1) := Pic.FileNew ('Asteroid1.bmp')
AsteroidPics (2) := Pic.FileNew ('Asteroid2.bmp')
AsteroidPics (3) := Pic.FileNew ('Asteroid3.bmp')
AsteroidPics (4) := Pic.FileNew ('Asteroid4.bmp')
var xl, yl, xlvelocity, ylvelocity : array 1 .. 8 of real
var xm, ym, xmvelocity, ymvelocity, xs, ys, xsvelocity, ysvelocity : array 1 .. 16 of real
var Asteroids : array 1..16 of int

%Set asteroid values
for i : 1 .. 16
    Asteroids (i) := 0
    xm (i) := -100
    ym (i) := -100
    xs (i) := -100
    ys (i) := -100
end for

%store the different rotation pictures
for i : 1 .. 16
    r := i * d - 22.5
    angle (i) := Pic.Rotate (shipPic, round(r), 7, 9)
end for

%displays the picture
procedure move
    if round (a) = 1 then
	accy := accy + 0.05
    elsif round (a) = 2 then
	accy := accy + 0.05 * 0.92
	accx := accx - 0.05 * 0.38
    elsif round (a) = 3 then
	accy := accy + 0.05 * 0.71
	accx := accx - 0.05 * 0.71
    elsif round (a) = 4 then
	accy := accy + 0.05 * 0.38
	accx := accx - 0.05 * 0.92
    elsif round (a) = 5 then
	accx := accx - 0.05
    elsif round (a) = 6 then
	accy := accy - 0.05 * 0.38
	accx := accx - 0.05 * 0.92
    elsif round (a) = 7 then
	accy := accy - 0.05 * 0.71
	accx := accx - 0.05 * 0.71
    elsif round (a) = 8 then
	accy := accy - 0.05 * 0.92
	accx := accx - 0.05 * 0.38
    elsif round (a) = 9 then
	accy := accy - 0.05
    elsif round (a) = 10 then
	accy := accy - 0.05 * 0.92
	accx := accx + 0.05 * 0.38
    elsif round (a) = 11 then
	accy := accy - 0.05 * 0.71
	accx := accx + 0.05 * 0.71
    elsif round (a) = 12 then
	accy := accy - 0.05 * 0.38
	accx := accx + 0.05 * 0.92
    elsif round (a) = 13 then
	accx := accx + 0.05
    elsif round (a) = 14 then
	accy := accy + 0.05 * 0.38
	accx := accx + 0.05 * 0.92 
    elsif round (a) = 15 then
	accy := accy + 0.05 * 0.71
	accx := accx + 0.05 * 0.71
    elsif round (a) = 16 then
	accy := accy + 0.05 * 0.92
	accx := accx + 0.05 * 0.38
    end if
end move
%Shots fired
procedure fire
    if bullet (1) = true & bullet (2) = false & range (2) = 0 & range (1) = 26 then
	bullet (2) := true
	if round (a) = 1 then
	    bulletyvel(2) := bulletyvel(2) + 7 + accy
	elsif round (a) = 2 then
	    bulletyvel(2) := bulletyvel(2) + 7 * 0.92 + accy
	    bulletxvel(2) := bulletxvel(2) - 7 * 0.38 + accx
	elsif round (a) = 3 then
	    bulletyvel(2) := bulletyvel(2) + 7 * 0.71 + accy
	    bulletxvel(2) := bulletxvel(2) - 7 * 0.71 + accx
	elsif round (a) = 4 then
	    bulletyvel(2) := bulletyvel(2) + 7 * 0.38 + accy
	    bulletxvel(2) := bulletxvel(2) - 7 * 0.92 + accx 
	elsif round (a) = 5 then
	    bulletxvel(2) := bulletxvel(2) - 7 + accx
	elsif round (a) = 6 then
	    bulletyvel(2) := bulletyvel(2) - 7 * 0.38 + accy
	    bulletxvel(2) := bulletxvel(2) - 7 * 0.92 + accx 
	elsif round (a) = 7 then
	    bulletyvel(2) := bulletyvel(2) - 7 * 0.71 + accy
	    bulletxvel(2) := bulletxvel(2) - 7 * 0.71 + accx
	elsif round (a) = 8 then
	    bulletyvel(2) := bulletyvel(2) - 7 * 0.92 + accy
	    bulletxvel(2) := bulletxvel(2) - 7 * 0.38 + accx
	elsif round (a) = 9 then
	    bulletyvel(2) := bulletyvel(2) - 7 + accy
	elsif round (a) = 10 then
	    bulletyvel(2) := bulletyvel(2) - 7 * 0.92 + accy
	    bulletxvel(2) := bulletxvel(2) + 7 * 0.38 + accx
	elsif round (a) = 11 then
	    bulletyvel(2) := bulletyvel(2) - 7 * 0.71 + accy
	    bulletxvel(2) := bulletxvel(2) + 7 * 0.71 + accx
	elsif round (a) = 12 then
	    bulletyvel(2) := bulletyvel(2) - 7 * 0.38 + accy
	    bulletxvel(2) := bulletxvel(2) + 7 * 0.92 + accx 
	elsif round (a) = 13 then
	    bulletxvel(2) := bulletxvel(2) + 7 + accx
	elsif round (a) = 14 then
	    bulletyvel(2) := bulletyvel(2) + 7 * 0.38 + accy
	    bulletxvel(2) := bulletxvel(2) + 7 * 0.92 + accx 
	elsif round (a) = 15 then
	    bulletyvel(2) := bulletyvel(2) + 7 * 0.71 + accy
	    bulletxvel(2) := bulletxvel(2) + 7 * 0.71 + accx
	elsif round (a) = 16 then
	    bulletyvel(2) := bulletyvel(2) + 7 * 0.92 + accy
	    bulletxvel(2) := bulletxvel(2) + 7 * 0.38 + accx
    end if
    elsif bullet (1) = false & bullet (2) = false & range (1) = 0 then
	bullet (1) := true
	if round (a) = 1 then
	    bulletyvel(1) := bulletyvel(1) + 7 + accy
	elsif round (a) = 2 then
	    bulletyvel(1) := bulletyvel(1) + 7 * 0.92 + accy
	    bulletxvel(1) := bulletxvel(1) - 7 * 0.38 + accx
	elsif round (a) = 3 then
	    bulletyvel(1) := bulletyvel(1) + 7 * 0.71 + accy
	    bulletxvel(1) := bulletxvel(1) - 7 * 0.71 + accx
	elsif round (a) = 4 then
	    bulletyvel(1) := bulletyvel(1) + 7 * 0.38 + accy
	    bulletxvel(1) := bulletxvel(1) - 7 * 0.92 + accx 
	elsif round (a) = 5 then
	    bulletxvel(1) := bulletxvel(1) - 7 + accx
	elsif round (a) = 6 then
	    bulletyvel(1) := bulletyvel(1) - 7 * 0.38 + accy
	    bulletxvel(1) := bulletxvel(1) - 7 * 0.92 + accx 
	elsif round (a) = 7 then
	    bulletyvel(1) := bulletyvel(1) - 7 * 0.71 + accy
	    bulletxvel(1) := bulletxvel(1) - 7 * 0.71 + accx
	elsif round (a) = 8 then
	    bulletyvel(1) := bulletyvel(1) - 7 * 0.92 + accy
	    bulletxvel(1) := bulletxvel(1) - 7 * 0.38 + accx
	elsif round (a) = 9 then
	    bulletyvel(1) := bulletyvel(1) - 7 + accy
	elsif round (a) = 10 then
	    bulletyvel(1) := bulletyvel(1) - 7 * 0.92 + accy
	    bulletxvel(1) := bulletxvel(1) + 7 * 0.38 + accx
	elsif round (a) = 11 then
	    bulletyvel(1) := bulletyvel(1) - 7 * 0.71 + accy
	    bulletxvel(1) := bulletxvel(1) + 7 * 0.71 + accx
	elsif round (a) = 12 then
	    bulletyvel(1) := bulletyvel(1) - 7 * 0.38 + accy
	    bulletxvel(1) := bulletxvel(1) + 7 * 0.92 + accx 
	elsif round (a) = 13 then
	    bulletxvel(1) := bulletxvel(1) + 7 + accx
	elsif round (a) = 14 then
	    bulletyvel(1) := bulletyvel(1) + 7 * 0.38 + accy
	    bulletxvel(1) := bulletxvel(1) + 7 * 0.92 + accx 
	elsif round (a) = 15 then
	    bulletyvel(1) := bulletyvel(1) + 7 * 0.71 + accy
	    bulletxvel(1) := bulletxvel(1) + 7 * 0.71 + accx
	elsif round (a) = 16 then
	    bulletyvel(1) := bulletyvel(1) + 7 * 0.92 + accy
	    bulletxvel(1) := bulletxvel(1) + 7 * 0.38 + accx
    end if
    end if
end fire
%x and y locations of asteroid
procedure DrawAsteroids
    for I : 1 .. 8
	RandV := Rand.Int (1, 2)
	if RandV = 1 then
	    xl (I) := Rand.Int (1, round (safex))
	    yl (I) := Rand.Int (1, maxy)
	else
	    xl (I) := Rand.Int (round (safex + 200), maxx)
	    yl (I) := Rand.Int (1, maxy)
	end if
	RandV := Rand.Int (1, 4)
	if RandV = 1 then
	    xlvelocity (I) := 0.4
	    ylvelocity (I) := 2
	elsif RandV = 2 then
	    xlvelocity (I) := 0.4
	    ylvelocity (I) := -2
	elsif RandV = 3 then
	    xlvelocity (I) := -0.4
	    ylvelocity (I) := -2
	elsif RandV = 4 then
	    xlvelocity (I) := -0.4
	    ylvelocity (I) := 2
	end if
	RandV := Rand.Int (1, 2)
	if RandV = 1 then
	    Asteroids (I) := Sprite.New (AsteroidPics (1))
	    Sprite.Show (Asteroids (I))
	    Sprite.SetPosition (Asteroids (I), round(xl (I)), round(yl (I)), false)
	else
	    Asteroids (I) := Sprite.New (AsteroidPics (2))
	    Sprite.Show (Asteroids (I))
	    Sprite.SetPosition (Asteroids (I), round(xl (I)), round(yl (I)), false)
	end if
    end for
end DrawAsteroids

%Procedure for making UFO location
procedure MakeUFO
    RandV:= Rand.Int (1,3)
    if RandV = 1 then
	UFOy:= 20
	UFOVelx:= 2 * 0.7
	UFOVely:= 2 * -0.7
    elsif RandV = 2 then
	UFOy:= 200
	UFOVelx := 2
    else
	UFOy:= 380
	UFOVelx:= 2 * 0.7
	UFOVely:= 2 * 0.7
    end if
end MakeUFO
%Procedure for making Rare UFO location
procedure MakeRareUFO
    RandV:= Rand.Int (1,3)
    if RandV = 1 then
	RareUFOy:= 20
	RUFOVelx:= 3 * 0.7
	RUFOVely:= 3 * -0.7
    elsif RandV = 2 then
	RareUFOy:= 200
	RUFOVelx := 3
    else
	RareUFOy:= 380
	RUFOVelx:= 3 * 0.7
	RUFOVely:= 3 * 0.7
    end if
end MakeRareUFO

var chars : array char of boolean

procedure KeyMove
if chars ('w') then
	move
    elsif chars (KEY_UP_ARROW) then
	move
    end if
    if chars ('d') then
	a := a - 0.2
    elsif chars (KEY_RIGHT_ARROW) then
	a := a - 0.2
    end if
    if chars ('a') then
	a := a + 0.2
    elsif chars (KEY_LEFT_ARROW) then
	a := a + 0.2
    end if
    if chars ('s') then
	delay (500)
	y := Rand.Int (0, 390)
	x := Rand.Int (0, 630)
	accx := 0
	accy := 0
	for i : 1..16
	if ((xs(i) > x - 10 & xs(i) < x + 24) & (ys(i) > y - 10 & ys(i) < y + 28)) | ((xs(i) + 13 > x - 10 & xs(i) + 13 < x + 24) & (ys(i) > y - 10 & ys(i) < y + 28)) | ((xs(i) > x - 10 & xs(i) < x + 24) & (ys(i) + 13 > y - 10 & ys(i) + 13 < y + 28)) | ((xs(i) + 13 > x - 10 & xs(i)+13 < x + 24) & (ys(i) + 13 > y - 10 & ys(i) + 13 < y + 28)) then
	    for I : 1..16
	    if ((x - 10 > xm(I) & x - 10 < xm(I) + 19) & (y - 10 > ym(I) & y - 10 < ym(I) + 19)) | ((x + 24 > xm(I) & x + 24 < xm(I) + 19) & (y - 10 > ym(I) & y - 10 < ym(I) + 19)) | ((x - 10 > xm(I) & x - 10 < xm(I) + 19) & (y + 28 > ym(I) & y + 28 < ym(I) + 19)) | ((x + 24 > xm(I) & x+24 < xm(I) + 19) & (y + 28 > ym(I) & y + 28 < ym(I) + 19)) then
		for j : 1..8
		if ((x - 10 > xl(j) & x - 10 < xl(j) + 35) & (y - 10 > yl(j) & y - 10 < yl(j) + 35)) | ((x + 24 > xl(j) & x + 24 < xl(j) + 35) & (y - 10 > yl(j) & y - 10 < yl(j) + 35)) | ((x - 10 > xl(j) & x - 10 < xl(j) + 35) & (y + 28 > yl(j) & y + 28 < yl(j) + 35)) | ((x + 24 > xl(j) & x + 24 < xl(j) + 35) & (y + 28 > yl(j) & y + 28 < yl(j) + 35)) then
		    KeyMove
		end if
		end for
	    end if
	    end for
	end if
	end for
    elsif chars (KEY_DOWN_ARROW) then
	delay (500)
	y := Rand.Int (0, 390)
	x := Rand.Int (0, 630)
	accx := 0
	accy := 0
	for i : 1..16
	if ((xs(i) > x - 10 & xs(i) < x + 24) & (ys(i) > y - 10 & ys(i) < y + 28)) | ((xs(i) + 13 > x - 10 & xs(i) + 13 < x + 24) & (ys(i) > y - 10 & ys(i) < y + 28)) | ((xs(i) > x - 10 & xs(i) < x + 24) & (ys(i) + 13 > y - 10 & ys(i) + 13 < y + 28)) | ((xs(i) + 13 > x - 10 & xs(i)+13 < x + 24) & (ys(i) + 13 > y - 10 & ys(i) + 13 < y + 28)) then
	    for I : 1..16
	    if ((x - 10 > xm(I) & x - 10 < xm(I) + 19) & (y - 10 > ym(I) & y - 10 < ym(I) + 19)) | ((x + 24 > xm(I) & x + 24 < xm(I) + 19) & (y - 10 > ym(I) & y - 10 < ym(I) + 19)) | ((x - 10 > xm(I) & x - 10 < xm(I) + 19) & (y + 28 > ym(I) & y + 28 < ym(I) + 19)) | ((x + 24 > xm(I) & x+24 < xm(I) + 19) & (y + 28 > ym(I) & y + 28 < ym(I) + 19)) then
		for j : 1..8
		if ((x - 10 > xl(j) & x - 10 < xl(j) + 35) & (y - 10 > yl(j) & y - 10 < yl(j) + 35)) | ((x + 24 > xl(j) & x + 24 < xl(j) + 35) & (y - 10 > yl(j) & y - 10 < yl(j) + 35)) | ((x - 10 > xl(j) & x - 10 < xl(j) + 35) & (y + 28 > yl(j) & y + 28 < yl(j) + 35)) | ((x + 24 > xl(j) & x + 24 < xl(j) + 35) & (y + 28 > yl(j) & y + 28 < yl(j) + 35)) then
		    KeyMove
		end if
		end for
	    end if
	    end for
	end if
	end for
    end if
    end KeyMove

DrawAsteroids

procedure AsteroidHitCheck
%If small asteroid is crashed
	for i : 1 .. 16
	    if ((xs(i) > x & xs(i) < x + 14) & (ys(i) > y & ys(i) < y + 18)) | ((xs(i) + 13 > x & xs(i) + 13 < x + 14) & (ys(i) > y & ys(i) < y + 18)) | ((xs(i) > x & xs(i) < x + 14) & (ys(i) + 13 > y & ys(i) + 13 < y + 18)) | ((xs(i) + 13 > x & xs(i)+13 < x + 14) & (ys(i) + 13 > y & ys(i) + 13 < y + 18)) then
		ShipCrash := true
		ship := false
	    elsif ((xs(i) > UFOx & xs(i) < UFOx + 19) & (ys(i) > UFOy & ys(i) < UFOy + 15)) | ((xs(i) + 13 > UFOx & xs(i) + 13 < UFOx + 19) & (ys(i) > UFOy & ys(i) < UFOy + 15)) | ((xs(i) > UFOx & xs(i) < UFOx + 19) & (ys(i) + 13 > UFOy & ys(i) + 13 < UFOy + 15)) | ((xs(i) + 13 > UFOx & xs(i)+13 < UFOx + 19) & (ys(i) + 13 > UFOy & ys(i) + 13 < UFOy + 15)) then
		UFOCrash:= true
		UFO := false
		UFOx := -500
		UFOy := -500
	    elsif ((xs(i) > RareUFOx & xs(i) < RareUFOx + 19) & (ys(i) > RareUFOy & ys(i) < RareUFOy + 15)) | ((xs(i) + 13 > RareUFOx & xs(i) + 13 < RareUFOx + 19) & (ys(i) > RareUFOy & ys(i) < RareUFOy + 15)) | ((xs(i) > RareUFOx & xs(i) < RareUFOx + 19) & (ys(i) + 13 > RareUFOy & ys(i) + 13 < RareUFOy + 15)) | ((xs(i) + 13 > RareUFOx & xs(i)+13 < RareUFOx + 19) & (ys(i) + 13 > RareUFOy & ys(i) + 13 < RareUFOy + 15)) then
		RareUFOCrash:= true
		RareUFO := false
		RareUFOx := -500
		RareUFOy := -500
	    end if
	    for m : 1..2
		if ((bulletx (m) > round(xs (i)) & bulletx (m) < round (xs (i)) + 13) & (bullety (m) > round(ys (i)) & bullety (m) < round (ys (i)) + 13)) then
		    BulletHit(m) := true
		    bullet(m) := false
		    range(m) := 50
		end if
	    end for
	    if ShipCrash = true | UFOCrash = true | RareUFOCrash = true | BulletHit(1) = true | BulletHit(2) = true then
		Sprite.Free (Asteroids (i))
		Asteroids (i) := 0
		xs (i) := -100
		ys (i) := -100
		destroyed := destroyed + 1
		if ShipCrash = true then
		    lives := lives - 1
		elsif BulletHit(1) = true | BulletHit(2) = true then
		    score := score + 20
		    extralife := extralife + 20
		end if
		ShipCrash := false
		UFOCrash := false
		RareUFOCrash := false
		BulletHit(1) := false
		BulletHit(2) := false
	    end if
	end for
	    %If a medium asteroid is crashed
	for i : 1 .. 16
	    if ((x > xm(i) & x < xm(i) + 19) & (y > ym(i) & y < ym(i) + 19)) | ((x + 14 > xm(i) & x + 14 < xm(i) + 19) & (y > ym(i) & y < ym(i) + 19)) | ((x > xm(i) & x < xm(i) + 19) & (y + 18 > ym(i) & y + 18 < ym(i) + 19)) | ((x + 14 > xm(i) & x+14 < xm(i) + 19) & (y + 18 > ym(i) & y + 18 < ym(i) + 19)) then
		ShipCrash := true
		ship := false
	    elsif ((UFOx > xm(i) & UFOx < xm(i) + 19) & (UFOy > ym(i) & UFOy < ym(i) + 19)) | ((UFOx + 19 > xm(i) & UFOx + 19 < xm(i) + 19) & (UFOy > ym(i) & UFOy < ym(i) + 19)) | ((UFOx > xm(i) & UFOx < xm(i) + 19) & (UFOy + 15 > ym(i) & UFOy + 15 < ym(i) + 19)) | ((UFOx + 19 > xm(i) & UFOx + 19 < xm(i) + 19) & (UFOy + 15 > ym(i) & UFOy + 15 < ym(i) + 19)) then
		UFOCrash:= true
		UFO := false
		UFOx := -500
		UFOy := -500
	    elsif ((RareUFOx > xm(i) & RareUFOx < xm(i) + 19) & (RareUFOy > ym(i) & RareUFOy < ym(i) + 19)) | ((RareUFOx + 19 > xm(i) & RareUFOx + 19 < xm(i) + 19) & (RareUFOy > ym(i) & RareUFOy < ym(i) + 19)) | ((RareUFOx > xm(i) & RareUFOx < xm(i) + 19) & (RareUFOy + 15 > ym(i) & RareUFOy + 15 < ym(i) + 19)) | ((RareUFOx + 19 > xm(i) & RareUFOx + 19 < xm(i) + 19) & (RareUFOy + 15 > ym(i) & RareUFOy + 15 < ym(i) + 19)) then
		RareUFOCrash:= true
		RareUFO := false
		RareUFOx := -500
		RareUFOy := -500
	    end if
	    for m : 1..2
		if ((bulletx (m) > round(xm (i)) & bulletx (m) < round (xm (i)) + 19) & (bullety (m) > round(ym (i)) & bullety (m) < round (ym (i)) + 19)) then
		    BulletHit(m) := true
		    bullet(m) := false
		    range(m) := 50
		end if
	    end for
	    if ShipCrash = true | UFOCrash = true | RareUFOCrash = true | BulletHit(1) = true | BulletHit(2) = true then
		Sprite.Free (Asteroids (i))
		Asteroids (i) := 0
		xs (i) := Rand.Int (round(xm (i)), round (xm (i)) + 19)
		ys (i) := Rand.Int (round (ym (i)), round(ym (i)) + 19)
		xm (i) := -100
		ym (i) := -100
		RandV := Rand.Int (1, 4)
		if RandV = 1 then
		    xsvelocity (i) := 0.4
		    ysvelocity (i) := 2
		elsif RandV = 2 then
		    xsvelocity (i) := 0.4
		    ysvelocity (i) := -2
		elsif RandV = 3 then
		    xsvelocity (i) := -0.4
		    ysvelocity (i) := -2
		elsif RandV = 4 then
		    xsvelocity (i) := -0.4
		    ysvelocity (i) := 2
		end if
		Asteroids (i) := Sprite.New (AsteroidPics (4))
		Sprite.Show (Asteroids (i))
		Sprite.SetPosition (Asteroids (i), round(xs (i)), round (ys (i)), false)
		if ShipCrash = true then
		    lives := lives - 1
		elsif BulletHit(1) = true | BulletHit(2) = true then
		    score := score + 50
		    extralife := extralife + 50
		end if
		ShipCrash := false
		UFOCrash := false
		RareUFOCrash := false
		BulletHit(1) := false
		BulletHit(2) := false            
	    end if
	end for
	    %If large asteroid is crashed in to ship
	    for j : 1..8
		if ((x > xl(j) & x < xl(j) + 35) & (y > yl(j) & y < yl(j) + 35)) | ((x + 14 > xl(j) & x + 14 < xl(j) + 35) & (y > yl(j) & y < yl(j) + 35)) | ((x > xl(j) & x < xl(j) + 35) & (y + 18 > yl(j) & y + 18 < yl(j) + 35)) | ((x + 14 > xl(j) & x+14 < xl(j) + 35) & (y + 18 > yl(j) & y + 18 < yl(j) + 35)) then
		    ShipCrash := true
		    ship := false
		elsif ((UFOx > xl(j) & UFOx < xl(j) + 35) & (UFOy > yl(j) & UFOy < yl(j) + 35)) | ((UFOx + 19 > xl(j) & UFOx + 19 < xl(j) + 35) & (UFOy > yl(j) & UFOy < yl(j) + 35)) | ((UFOx > xl(j) & UFOx < xl(j) + 35) & (UFOy + 15 > yl(j) & UFOy + 15 < yl(j) + 35)) | ((UFOx + 19 > xl(j) & UFOx + 19 < xl(j) + 35) & (UFOy + 15 > yl(j) & UFOy + 15 < yl(j) + 35)) then
		    UFOCrash:= true
		    UFO := false
		    UFOx := -500
		    UFOy := -500
		elsif ((RareUFOx > xl(j) & RareUFOx < xl(j) + 35) & (RareUFOy > yl(j) & RareUFOy < yl(j) + 35)) | ((RareUFOx + 19 > xl(j) & RareUFOx + 19 < xl(j) + 35) & (RareUFOy > yl(j) & RareUFOy < yl(j) + 35)) | ((RareUFOx > xl(j) & RareUFOx < xl(j) + 35) & (RareUFOy + 15 > yl(j) & RareUFOy + 15 < yl(j) + 35)) | ((RareUFOx + 19 > xl(j) & RareUFOx + 19 < xl(j) + 35) & (RareUFOy + 15 > yl(j) & RareUFOy + 15 < yl(j) + 35)) then
		    RareUFOCrash:= true
		    RareUFO := false
		    RareUFOx := -500
		    RareUFOy := -500
		end if
	    for m : 1..2
		if ((bulletx (m) > round(xl (j)) & bulletx (m) < round (xl (j)) + 35) & (bullety (m) > round(yl (j)) & bullety (m) < round (yl (j)) + 35)) then
		    BulletHit(m) := true
		    bullet(m) := false
		    range(m) := 50
		end if
	    end for
	    if ShipCrash = true | UFOCrash = true | RareUFOCrash = true | BulletHit(1) = true | BulletHit(2) = true then
		    Sprite.Free (Asteroids (j))
		    Asteroids (j) := 0
		    for i : 1 .. 16
			if Asteroids (i) = 0 then
			    Split := Split + 1
			    xm (i) := Rand.Int (round(xl (j)),round (xl (j)) + 35)
			    ym (i) := Rand.Int (round(yl (j)), round(yl (j)) + 35)
			    RandV := Rand.Int (1, 4)
			    if RandV = 1 then
				xmvelocity (i) := 0.4
				ymvelocity (i) := 2
			    elsif RandV = 2 then
				xmvelocity (i) := 0.4
				ymvelocity (i) := -2
			    elsif RandV = 3 then
				xmvelocity (i) := -0.4
				ymvelocity (i) := -2
			    elsif RandV = 4 then
				xmvelocity (i) := -0.4
				ymvelocity (i) := 2
			    end if
			    Asteroids (i) := Sprite.New (AsteroidPics (3))
			    Sprite.Show (Asteroids (i))
			    Sprite.SetPosition (Asteroids (i), round(xm (i)), round(ym (i)), false)
			end if
			if Split = 2 then
			    Split := 0
			    xl (j) := -100
			    yl (j) := -100
			    if ShipCrash = true then
				lives := lives - 1
			    elsif BulletHit(1) = true | BulletHit(2) = true then
				score := score + 100
				extralife := extralife + 100
			    end if
			    ShipCrash := false
			    UFOCrash := false
			    RareUFOCrash := false
			    BulletHit(1) := false
			    BulletHit(2) := false
			    exit
			end if
		    end for
		end if
	    end for
    end AsteroidHitCheck

    %Asteroid Movement
    procedure AsteroidMovement
    for h : 1 .. 8
	if xl (h) > -100 then
	    xl (h) := xl (h) + xlvelocity (h)
	    yl (h) := yl (h) + ylvelocity (h)
	    Sprite.SetPosition (Asteroids (h), round(xl (h)), round(yl (h)), false)
	    if xl (h) < 0 & xl (h) > -100 then
		xl (h) := maxx
	    elsif xl (h) > maxx then
		xl (h) := 0
	    elsif yl (h) < 0 then
		yl (h) := maxy
	    elsif yl (h) > maxy then
		yl (h) := 0
	    end if
	end if
    end for
    for i : 1 .. 16
	if xm (i) > -100 then
	    xm (i) := xm (i) + xmvelocity (i)
	    ym (i) := ym (i) + ymvelocity (i)
	    Sprite.SetPosition (Asteroids (i), round(xm (i)), round (ym (i)), false)
	    if xm (i) < 0 & xm (i) > -100 then
		xm (i) := maxx
	    elsif xm (i) > maxx then
		xm (i) := 0
	    elsif ym (i) < 0 then
		ym (i) := maxy
	    elsif ym (i) > maxy then
		ym (i) := 0
	    end if
	end if
    end for
    for i : 1 .. 16
	if xs (i) > -100 then
	    xs (i) := xs (i) + xsvelocity (i)
	    ys (i) := ys (i) + ysvelocity (i)
	    Sprite.SetPosition (Asteroids (i), round (xs (i)), round (ys (i)), false)
	    if xs (i) < 0 & xs (i) > -100 then
		xs (i) := maxx
	    elsif xs (i) > maxx then
		xs (i) := 0
	    elsif ys (i) < 0 then
		ys (i) := maxy
	    elsif ys (i) > maxy then
		ys (i) := 0
	    end if
	end if
    end for
    end AsteroidMovement
    
    %Creating the UFO
    procedure CreateUFOs
	RandV:= Rand.Int (1,1000)
	    if RandV= 1 & UFO = false & RareUFO = false & UFOLimit< 2 then
		UFO:= true
		MakeUFO
		UFOLimit := UFOLimit + 1
	    end if
	RandV:= Rand.Int(1,2000)
	if RandV= 2 & RareUFO = false & UFO = false & RareUFOLimit < 1 then
	    RareUFO := true
	    MakeRareUFO
	    RareUFOLimit := RareUFOLimit + 1
	end if
    end CreateUFOs
    
    %If UFO is hit | shot
    procedure CheckUFOs
	for u : 1..2
	    if bulletx(u) > UFOx & bulletx(u) < UFOx+19 & bullety(u) > UFOy & bullety(u) < UFOy+15 then
		bullet (u) := false
		range(u) := 50
		UFO:= false
		UFOx:=0
		score := score + 500
		extralife := extralife + 500
	    elsif bulletx(u) > RareUFOx & bulletx(u) < RareUFOx+19 & bullety(u) > RareUFOy & bullety(u) < RareUFOy+15 then
		bullet (u) := false
		range(u) := 50
		RareUFO:= false
		RareUFOx:= 0
		score := score + 2000
		extralife := extralife + 2000
	    elsif ((UFOx > x & UFOx < x + 14) & (UFOy > y & UFOy < y + 18)) | ((UFOx + 19 > x & UFOx + 19 < x + 14) & (UFOy > y & UFOy < y + 18)) | ((UFOx > x & UFOx < x + 14) & (UFOy + 15 > y & UFOy + 15 < y + 18)) | ((UFOx + 19 > x & UFOx + 19 < x + 14) & (UFOy + 15 > y & UFOy + 15 < y + 18)) then
		ship := false
		UFO := false
		UFOx := 0 
		lives := lives - 1
	    elsif ((RareUFOx > x & RareUFOx < x + 14) & (RareUFOy > y & RareUFOy < y + 18)) | ((RareUFOx + 19 > x & RareUFOx + 19 < x + 14) & (RareUFOy > y & RareUFOy < y + 18)) | ((RareUFOx > x & RareUFOx < x + 14) & (RareUFOy + 15 > y & RareUFOy + 15 < y + 18)) | ((RareUFOx + 19 > x & RareUFOx + 19 < x + 14) & (RareUFOy + 15 > y & RareUFOy + 15 < y + 18)) then
		ship := false
		RareUFO := false
		RareUFOx := 0
		lives := lives - 1 
	    end if
	end for
    end CheckUFOs
    
    %UFOMovement
    procedure MoveUFOs
	if UFO = true then
	    Pic.Draw (UFOPic, round(UFOx), round(UFOy), picMerge)
	    UFOx:= UFOx+UFOVelx
	    UFOy:= UFOy+UFOVely
	end if
    
	if RareUFO = true then
	    Pic.Draw (RareUFOPic, round(RareUFOx), round(RareUFOy), picMerge)
	    RareUFOx := RareUFOx+RUFOVelx
	    RareUFOy := RareUFOy+RUFOVely
	end if
    end MoveUFOs

loop
    clock (start)
    Pic.ScreenLoad ("Space.bmp", 0, 0, picCopy)
    
    View.Set("offscreenonly")
    
    if ship = true then
    Pic.Draw (angle (round (a)), round (x), round (y), picMerge)
    end if

    Input.KeyDown (chars)

    KeyMove
    
    %Movement acceleration
    x := x + accx
    y := y + accy
    %Reset bullet to right position
    for b : 1 .. 2
	if range (b) >= 50 | range(b) = 0 then
	    bulletx (b) := x + accx + 7
	    bullety (b) := y + accy + 9
	    bulletxvel (b) := 0
	    bulletyvel (b) := 0
	    range (b) := 0
	    bullet (b) := false
	end if
    end for
    if chars (' ') then
	fire
    end if
    if chars ('p') then
	Font.Draw("Press Any Key To Continue...", 105, 190, font, red)
	Input.Pause
    end if
    %Bullet movement
    for b : 1 .. 2
	if bullet (b) = true then
	    bulletx (b) := bulletx (b) + bulletxvel (b) + accx
	    bullety (b) := bullety (b) + bulletyvel (b) + accy
	    drawfillbox (round (bulletx (b)), round (bullety (b)), round (bulletx (b)) + 2, round (bullety (b)) + 2, grey)
	    range (b) := range (b) + 2
	end if
    end for

    if round (a) = 17 then
	a := 1
    elsif round (a) = 0 then
	a := 16
    end if

    %Top speed boundaries
    if accx > 4 then
	accx := 4
    elsif accx < -4 then
	accx := -4
    end if
    if accy > 4 then
	accy := 4
    elsif accy < -4 then
	accy := -4
    end if
    %Out of bounds
    if x < 0 then
	x := maxx
    elsif x > maxx then
	x := 0
    elsif y < 0 then
	y := maxy
    elsif y > maxy then
	y := 0
    end if
    for B : 1 .. 2
	if bulletx (B) < 0 then
	    bulletx (B) := maxx
	elsif bulletx (B) > maxx then
	    bulletx (B) := 0
	elsif bullety (B) < 0 then
	    bullety (B) := maxy
	elsif bullety (B) > maxy then
	    bullety (B) := 0
	end if
    end for
    
     %If you lose all lives
    if lives = 0 then
	exit
    end if
    
    %Respawn
    if ship = false then
	x := -200
	y := -200
	accx := 0
	accy := 0
	bulletx(1) := -200
	bulletx(2) := -200
	bullety(1) := -200
	bullety(2) := -200
	Font.Draw("Press R To Continue...", 140, 190, font, red)
	if chars('r') then
	    ship := true
	    x := 300
	    y := 200
	end if
    end if
    
    AsteroidHitCheck
    AsteroidMovement
    
    CreateUFOs
    MoveUFOs
    CheckUFOs
    
    %If UFO goes out of bounds
    if UFO=true then
	if UFOy+15 > maxy | UFOy< 0 then
	    UFOVely := -UFOVely
	elsif UFOx> maxx then
	    UFO := false
	    UFOx := 0
	end if
    end if
    
    if RareUFO= true then
	if RareUFOy+15 > maxy | RareUFOy< 0 then
	    RUFOVely := -RUFOVely
	elsif RareUFOx> maxx then
	    RareUFO := false
	    RareUFOx:= 0
	end if
    end if
    
    %Score and live counter
    scoreStr := intstr(score)
    livesStr := intstr(lives)
    Font.Draw(scoreStr, 215, 380, font, blue)
    Font.Draw(livesStr, 430, 380, font, red)
    
    if extralife >= 5000 then
    lives := lives + 1
    extralife := extralife - 5000
    end if
    
    %Draw asteroids again if they are all destroyed
    if destroyed = 16 then
	DrawAsteroids
	destroyed := 0
    end if 
    
    View.Update
    
    clock (finish)
    diff := finish - start
    if diff < 30 then
	delay (20 - diff)
    end if
end loop

Font.Draw("You Lost!", 280, 190, font, red)
Font.Draw(scoreStr, 215, 380, font, blue)
Font.Draw(livesStr, 430, 380, font, red)
