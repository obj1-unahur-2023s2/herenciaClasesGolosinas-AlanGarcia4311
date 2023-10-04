/*
 * Los sabores
 */
object frutilla { }
object chocolate { }
object vainilla { }
object naranja { }
object limon { }


class Golosina {
	var peso
	var precio
	var sabor
	
	method esLibreDeGluten() = true
	method peso() = peso
	method precio() = precio
	method sabor() = sabor
}

class Bombon inherits Golosina(peso=15, precio=5, sabor=frutilla){

	method recibirMordizco() { peso = peso * 0.8 - 1}
}

class BombonDuro inherits Bombon {
	override method recibirMordizco() { peso -= 1}
	method gradoDeDureza() = if (peso > 12) 3 else if (peso.between(8, 12)) 2 else 1 	
}

class Alfajor inherits Golosina(peso= 300, precio=12, sabor=chocolate){
	
	override method esLibreDeGluten() = false
	method recibirMordizco() { peso = peso * 0.8}
}

class Caramelo inherits Golosina(peso=5, precio=12, sabor=frutilla) {
	
	method recibirMordizco() { peso = peso - 1 }
}

class CarameloRelleno inherits Caramelo(precio=13){
	override method recibirMordizco() { 
		peso = peso - 1 
		sabor = chocolate
	}
}

class Chupetin inherits Golosina(peso=7, precio=2, sabor=naranja){

	method recibirMordizco() { 
		if (peso >= 2) {
			peso = peso * 0.9
		}
	}
}

class Oblea inherits Golosina(peso=250, precio=5, sabor=vainilla){

	method recibirMordizco() {
		if (peso >= 70) {
			// el peso pasa a ser la mitad
			peso = peso * 0.5
		} else { 
			// pierde el 25% del peso
			peso = peso - (peso * 0.25)
		}
	}	
	override method esLibreDeGluten() { return false }
}

class ObleaCrujiente inherits Oblea{
	var mordidas = 0
	
	override method recibirMordizco() {
		mordidas += 1
		if (peso >= 70) {
			// el peso pasa a ser la mitad
			peso = peso * 0.5
		} else { 
			// pierde el 25% del peso
			peso = peso - (peso * 0.25)
		} 
		if(mordidas <= 3) peso -= 3
	}
	method estaDebil() { return mordidas > 3}
}

class Chocolatin inherits Golosina{
	// hay que acordarse de *dos* cosas, el peso inicial y el peso actual
	// el precio se calcula a partir del precio inicial
	// el mordisco afecta al peso actual
	var pesoInicial
	var comido = 0
	
	method pesoInicial(unPeso) { pesoInicial = unPeso }
	override method precio() { return pesoInicial * 0.50 }
	override method peso() { return (pesoInicial - comido).max(0) }
	method recibirMordizco() { comido = comido + 2 }
	override method sabor() { return chocolate }
	override method esLibreDeGluten() { return false }

}

class GolosinaBaniada inherits Golosina{
	var golosinaInterior
	var pesoBanio = 4
	
	method golosinaInterior(unaGolosina) { golosinaInterior = unaGolosina }
	override method precio() { return golosinaInterior.precio() + 2 }
	override method peso() { return golosinaInterior.peso() + pesoBanio }
	method recibirMordizco() {
		golosinaInterior.recibirMordizco()
		pesoBanio = (pesoBanio - 2).max(0) 
	}	
	override method sabor() { return golosinaInterior.sabor() }
	override method esLibreDeGluten() { return golosinaInterior.libreGluten() }	
}


class Tuttifrutti inherits Golosina(peso=5){
	var property esLibreDeGluten
	const sabores = [frutilla, chocolate, naranja]
	var saborActual = 0
	
	method recibirMordizco() { saborActual += 1 }	
	override method sabor() { return sabores.get(saborActual % 3) }	
	override method precio() { return (if(self.esLibreDeGluten()) 7 else 10) }
}

