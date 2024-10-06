Move-operation (Advanced Visual Moving)
========================================

This idea sparked because of mini.move plugin which had basic moving of visual selection up down left and right.  
I have more complex and sophisticated use case for this operation with every possible motion in normal mode but in this mode. 
It is like completely new mode inside visual mode. I probably can complete this mode using hydra.nvim but
I want this plugin to be able to work with any kind of motion like i", a( t, f, T, F, to jump around.
I need all webtf0^$%g_ge motion to work. and it is rather complicated to do by simply keybind.
          JUMP  CLONE
            ▲     ▲
            └──┬──┘
        ┌──►MOVE MODE──┐        
        │              │    
        └──VISUAL MODE◄┘    
1. Jump:  simply moves the selection to anywhere anywhere with cursor motion. 
2. Clone: clones the selection and places to the cursor motion or like the substitute command.
*cursor motion:* w,e,b,W,E,B,ge,gE,0,^,$,%,(,),{,},[[,]],mouse-click etc
*commandsclone :* clone-left, clone-right


``` python
print("hello wrold!"
)```


``` html
<html>
</html>
```
