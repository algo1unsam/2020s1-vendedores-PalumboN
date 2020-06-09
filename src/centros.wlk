import vendedores.*

class CentroDeDistribucion {
	var property ciudad
	var property vendedores
	
	method vendedorEstrella() { return vendedores.max { vend => vend.puntajeTotalCertificaciones()} }
	
	method agregarVendedor(vend) {
		if (vendedores.contains(vend)) {
			self.error("El vendedor ya está registrado en este centro")
		}
		vendedores.add(vend)
	}
	
	method puedeCubrir(unaCiudad) { return vendedores.any { vend => vend.puedeTrabajar(unaCiudad) } }
	method vendedoresGenericos() { return vendedores.filter { vend => vend.tieneCertificacionGenerica() } }
	method esRobusto() { return vendedores.count { vend => vend.esFirme() } >= 3 }
	method repartirCertificacion(cert) {
		vendedores.forEach { vend => vend.agregarCertificacion(cert) }
	}
	
	method esCandidato(vend) { return vend.esVersatil() and vend.tieneAfinidadCon(self) }
}


class Empresa {
	var property centros
	method equipoEstelar() { return centros.map { centro => centro.vendedorEstrella() }}
}
