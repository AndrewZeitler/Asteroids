var x, y, button, Gridx, Gridy: int

View.Set("nobuttonbar")

loop
    Mouse.Where(x, y, button)
    
    Gridx := x div 10
    Gridy := y div 10
    
    if Gridx = 60 & Gridy = 60 then
	exit
    end if 
    
end loop

put "Alright"
    
