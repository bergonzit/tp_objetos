class Texto{
    var limite //Que tanto se puede extender el texto de longitud en celdas. Si se excede continua hacia abajo
    var property caracteres = []
    var property texto = ""
    var diccionario = new Dictionary()
    const desplazamientoPromedio = 4
    const desplazamientoEspacio = 3
    var posicion
    //Variables para metodos
    var x = 0
    var y = 0
    var index = 0
    var longitud = 0 //Sirve para poder centrar el texto
    
    method mostrarTexto(){
        self.limpiarTexto()
        self.resetearVariables()
        var listasCaracteres = self.separarCaracteres() //[[l,i,s,t,a,s],[d,e],[c,a,r,a,c,t,e,r,e,s]]
        listasCaracteres.forEach({listaCaracteres => self.agregarCaracteres(listaCaracteres)})
    }

    method limpiarTexto(){
        longitud = 0
        caracteres.forEach({
            letra => 
            game.removeVisual(letra)
            caracteres.remove(letra)
        })
    }

    method resetearVariables(){
        x = 0
        y = 0
        index = 0
    }

    method separarCaracteres(){
        return self.separarPalabras().map({palabra => palabra.split("")})
    }

    method separarPalabras(){
        return texto.split(" ")
    }

    method agregarCaracteres(lista){ // [l,i,s,t,a,s]
        self.revisionExcesoDeLimite(lista)
        lista.forEach({caracter => self.agregarCaracter(caracter)})
        x += desplazamientoEspacio
    }

    method revisionExcesoDeLimite(lista){
        if ((lista.size() * desplazamientoPromedio + x) > limite){
            y -= 8
            self.reemplazarLongitud() //Si x supera a longitud, longitud = x
            x = 0
        }
    }

    method reemplazarLongitud(){
        if (x > longitud){
            longitud = x
        }
    }

    method agregarCaracter(caracter){ // l
        //Obtener atributos del caracter
        const imagen = diccionario.get(caracter).get(0) //Imagen del caracter
        const desplazamiento = diccionario.get(caracter).get(1) //Espacio que deja en casillas
        const correccionAltura = diccionario.get(caracter).get(2) //Correccion de altura en casillas
        //Agrega caracter
        caracteres.add(new Caracter(imagen = imagen, posicion = self.ubicacionCaracter(correccionAltura)))
        game.addVisual(caracteres.get(index))
        x += desplazamiento
        index += 1
    }

    method ubicacionCaracter(variacionY){
        return game.at(posicion.x() + x,posicion.y() + y - variacionY)
    }

    //Mantener metodo oculto para tener paz mental
    method inicializar(){
        diccionario.put("A", ["A.png", 6, 0])
        diccionario.put("B", ["B.png", 5, 0])
        diccionario.put("C", ["C.png", 5, 0])
        diccionario.put("D", ["D.png", 4, 0])
        diccionario.put("E", ["E.png", 5, 0])
        diccionario.put("F", ["F.png", 4, 0])
        diccionario.put("G", ["G.png", 5, 2])
        diccionario.put("H", ["H.png", 5, 1])
        diccionario.put("I", ["I.png", 2, 0])
        diccionario.put("J", ["J.png", 5, 0])
        diccionario.put("K", ["K.png", 4, 0])
        diccionario.put("L", ["L.png", 5, 0])
        diccionario.put("M", ["M.png", 5, 1])
        diccionario.put("N", ["N.png", 5, 0])
        diccionario.put("Ñ", ["Ñ.png", 4, 0])
        diccionario.put("O", ["O.png", 5, 0])
        diccionario.put("P", ["P.png", 5, 0])
        diccionario.put("Q", ["Q.png", 5, 1])
        diccionario.put("R", ["R.png", 5, 0])
        diccionario.put("S", ["S.png", 5, 0])
        diccionario.put("T", ["T.png", 5, 0])
        diccionario.put("U", ["U.png", 4, 0])
        diccionario.put("V", ["V.png", 5, 0])
        diccionario.put("W", ["W.png", 5, 0])
        diccionario.put("X", ["X.png", 5, 0])
        diccionario.put("Y", ["Y.png", 5, 0])
        diccionario.put("Z", ["Z.png", 5, 0])
        diccionario.put("a", ["aa.png", 4, 0])
        diccionario.put("b", ["bb.png", 4, 0])
        diccionario.put("c", ["cc.png", 4, 0])
        diccionario.put("d", ["dd.png", 4, 0])
        diccionario.put("e", ["ee.png", 4, 0])
        diccionario.put("f", ["ff.png", 4, 0])
        diccionario.put("g", ["gg.png", 5, 0])
        diccionario.put("h", ["hh.png", 4, 0])
        diccionario.put("i", ["ii.png", 2, 0])
        diccionario.put("j", ["jj.png", 3, 0])
        diccionario.put("k", ["kk.png", 4, 0])
        diccionario.put("l", ["I.png", 2, 0])
        diccionario.put("m", ["mm.png", 5, 0])
        diccionario.put("n", ["nn.png", 4, 0])
        diccionario.put("ñ", ["ññ.png", 4, 0])
        diccionario.put("o", ["oo.png", 4, 0])
        diccionario.put("p", ["pp.png", 4, 0])
        diccionario.put("q", ["qq.png", 4, 2])
        diccionario.put("r", ["rr.png", 3, 0])
        diccionario.put("s", ["ss.png", 4, 0])
        diccionario.put("t", ["tt.png", 3, 0])
        diccionario.put("u", ["uu.png", 4, 0])
        diccionario.put("v", ["vv.png", 4, 0])
        diccionario.put("w", ["ww.png", 5, 0])
        diccionario.put("x", ["xx.png", 4, 0])
        diccionario.put("y", ["yy.png", 4, 2])
        diccionario.put("z", ["zz.png", 5, 0])
        diccionario.put("1", ["1.png", 3, 0])
        diccionario.put("2", ["2.png", 4, 0])
        diccionario.put("3", ["3.png", 5, 0])
        diccionario.put("4", ["4.png", 4, 0])
        diccionario.put("5", ["5.png", 4, 0])
        diccionario.put("6", ["6.png", 4, 0])
        diccionario.put("7", ["7.png", 4, 0])
        diccionario.put("8", ["8.png", 4, 0])
        diccionario.put("9", ["9.png", 4, 0])
        diccionario.put("0", ["0.png", 4, 0])
        diccionario.put(".", ["punto.png", 3, 0])
        diccionario.put(",", ["coma.png", 3, 0])
        diccionario.put(";", ["punto y coma.png", 3, 0])
        diccionario.put(":", ["dos puntos.png", 3, 0])
        diccionario.put("?", ["pregunta.png", 4, 0])
        diccionario.put("!", ["exclamacion.png", 3, 0])
    }
}

class Caracter{
    var imagen
    var posicion
    method image() = imagen
    method position() = posicion
}