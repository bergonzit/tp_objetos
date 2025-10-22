
class Boton{
    var sprite = ["boton.png","boton_hover.png"]
    var property posicion = game.center()
    method position() = posicion 
    var hover = false
    method image() = sprite.get(if (hover) 1 else 0)
    
    //method press()
    method cambiarHover(){
        hover = !hover
    }

}