class Certificacion {
	var property puntos = 0
	var property esSobreProductos = false	
}

class Vendedor {
	const property certificaciones = #{}
	
	method agregarCertificacion(cert) { certificaciones.add(cert) }
	method esVersatil() { 
		return certificaciones.size() >= 3 
			and certificaciones.any { cert => cert.esSobreProductos() } 
			and certificaciones.any { cert => not cert.esSobreProductos() } 
	}
	
	method esFirme() { return self.puntajeTotalCertificaciones() >= 30 }
	
	method puntajeTotalCertificaciones() { 
		return certificaciones.sum { cert => cert.puntos() }
	}
	
	method tieneCertificacionGenerica() { return certificaciones.any { cert => not cert.esSobreProductos() } }
	method certificacionesSobreProductos() { return certificaciones.filter { cert => cert.esSobreProductos() } }
	method tieneAfinidadCon(centro) { return self.puedeTrabajar(centro.ciudad()) }
	
	method puedeTrabajar(ciudad)
}

class VendedorFijo inherits Vendedor {
	var property ciudadResidencia
	
	override method puedeTrabajar(ciudad) { return ciudad == ciudadResidencia }
	method esInfluyente() { return false }
	method esPersonaFisica() { return true }
}

class Viajante inherits Vendedor {
	const property provinciasHabilitadas = #{}
	 
	override method puedeTrabajar(ciudad) { return provinciasHabilitadas.contains(ciudad.provincia()) }
	method esInfluyente() {
		var poblacionAlcanzada = provinciasHabilitadas.sum { prov => prov.poblacion() } 
		return poblacionAlcanzada > 10000000
	}
	method esPersonaFisica() { return true }
}

class ComercioCorresponsal inherits Vendedor {
	const property ciudadesConSucursales = #{}
	
	override method puedeTrabajar(ciudad) { return ciudadesConSucursales.contains(ciudad) }
	method provinciasConSucursales() { return ciudadesConSucursales.map {ciud => ciud.provincia()} .asSet() }
	method esInfluyente() { return ciudadesConSucursales.size() >= 5 or self.provinciasConSucursales().size() >= 3 }
	method esPersonaFisica() { return false }
	override method tieneAfinidadCon(centro) { 
		return super(centro) and ciudadesConSucursales.any { ciud => not centro.puedeCubrir(ciud) }
	}
}































