//l vendedor estrella, que es el que tiene mayor puntaje total por certificaciones.
//si puede cubrir, o no, una ciudad dada. La condición es que al menos uno de los vendedores registrados pueda trabajar en esa ciudad.
//la colección de vendedores genéricos registrados. Un vendedor se considera genérico si tiene al menos una certificación que no es de productos.
//si es robusto, la condición es que al menos 3 de sus vendedores registrados sea firme.


import vendedores.*

class CentroDistribucion {
	const property ciudad
	const vendedores = []
	
	method agregarVendedor(vendedor) {
		self.validarNuevoVendedor(vendedor)
		vendedores.add(vendedor)
	}
	
	method validarNuevoVendedor(vendedor) {
		if (vendedores.contains(vendedor)) {
			self.error("El vendedor ya se encuentra en el centro")
		} 
	}
	
	method vendedorEstrella() {
		return vendedores.max({ vendedor => vendedor.puntajeTotal() })
	}
	
	method puedeCubrir(_ciudad) {
		return vendedores.any({ vendedor => vendedor.puedeTrabajar(_ciudad) })
	}
	
	method vendedoresGenericos() {
		return vendedores.filter({ vendedor => vendedor.esGenerico() })
	}
	
	method esRobusto() {
		return vendedores.count({ vendedor => vendedor.esFirme() }) >= 3
	}
	

//	method esRobusto() {
//		return self.vendedoresFirmes().size() >= 3
//	}
//	
//    method vendedoresFirmes(){
//        return vendedores.filter({vendedor => vendedor.esFirme()})
//    }

	method repartirCertificacion(certificacion) {
		vendedores.forEach({ vendedor => vendedor.agregarCertificacion(certificacion) })
	}

}





