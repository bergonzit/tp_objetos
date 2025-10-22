import pantallaMenu.*
object gestorPantallas{
    var actual = pantallaMenu
    method position() = game.center()
    method run(){
        actual.run()
    }
}