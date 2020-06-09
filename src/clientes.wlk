class ClienteInseguro {
	method puedeSerAtendidoPor(vend) { return vend.esVersatil() and vend.esFirme() }	
}

class ClienteDetallista {
	method puedeSerAtendidoPor(vend) { return vend.certificacionesSobreProductos().size() >= 3 }	
}

class ClienteHumanista {
	method puedeSerAtendidoPor(vend) { return vend.esPersonaFisica() }	
}
