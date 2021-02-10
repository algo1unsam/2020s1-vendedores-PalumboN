//Vendedor fijo: se sabe en qué ciudad vive.
//Viajante: cada viajante está habilitado para trabajar en algunas provincias, se sabe cuáles son.
//Comercio corresponsal: son comercios que tienen sucursales en distintas ciudades. Se sabe, para cada comercio corresponsal, en qué ciudades tiene sucursales.

//si un vendedor es versátil. Las condiciones son: que tenga al menos tres certificaciones, que tenga al menos una sobre productos, y al menos una que no sea sobre productos.

class Vendedor {
	const certificaciones = []
	
	method esVersatil() {
		return self.masDe3Certificaciones() and self.algunaCertificacionDeProductos() and self.algunaCertificacionDeOtras() 
	}
	
	method masDe3Certificaciones() { 
		return certificaciones.size() > 3
	}
	
	method algunaCertificacionDeProductos() {
		return certificaciones.any({ certificacion => certificacion.esDeProducto() }) 
	}
	
	method algunaCertificacionDeOtras() {
		return certificaciones.any({ certificacion => not certificacion.esDeProducto() }) 
	}
	
	
	method esFirme() {
		return self.puntajeTotal() >= 30
	}
	
	method puntajeTotal() {
		return certificaciones.sum({ certificacion => certificacion.puntos() }) 
	}
	
	method esGenerico() { return self.algunaCertificacionDeOtras() }
	
	method agregarCertificacion(certificacion) { certificaciones.add(certificacion) }
	
	method tieneAfinidad(centroDeDistribucion) { return self.puedeTrabajar(centroDeDistribucion.ciudad()) }
	
	method puedeTrabajar(ciudad)
	
	method esCandidato(centroDeDistribucion) { return self.esVersatil() and self.tieneAfinidad(centroDeDistribucion) }
	
	method esHumano() { return true }
}

class VendedorFijo inherits Vendedor {
	const ciudad
	
	override method puedeTrabajar(_ciudad) {
		return _ciudad == ciudad
	}
	
	method esInfluyente() { return false }
}

class VendedorViajante inherits Vendedor {
	const provinciasDondePuedeTrabajar = []
	
	override method puedeTrabajar(ciudad) {
		return provinciasDondePuedeTrabajar.contains(ciudad.provincia())
	}
	
	method esInfluyente() { 
		return self.poblacionTotal() >= 10
	}
	
	method poblacionTotal() {
		return provinciasDondePuedeTrabajar.sum({ provincia => provincia.poblacion() })
	}	
}

class ComercioCorresponsal inherits Vendedor {
	const ciudadesConSucursales = []
	
	override method puedeTrabajar(ciudad) {
		return ciudadesConSucursales.contains(ciudad)
	}
	
	method esInfluyente() { 
		return self.tieneMuchasSucursales() or self.estaEnVariasProvincias()
	}
	
	method tieneMuchasSucursales() {
		return ciudadesConSucursales.size() >= 5 
	}
	
	method estaEnVariasProvincias() {
		return self.provinciasConSucursales().size() >= 3 
	}
	
	method provinciasConSucursales() {
		return ciudadesConSucursales.map({ ciudad => ciudad.provincia() }).asSet() 
	}
	
	override method tieneAfinidad(centroDeDistribucion){ 
		return super(centroDeDistribucion) and 
		ciudadesConSucursales.any({ ciudad => not centroDeDistribucion.puedeCubrir(ciudad) })
    }
    
    override method esHumano() { return false }
    
} 




class Certificacion {
	const property puntos
	const property esDeProducto = false
}




class Ciudad {
	const property provincia
}

class Provincia {
	const property poblacion
}