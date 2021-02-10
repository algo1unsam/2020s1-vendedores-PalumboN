class ClienteInseguro {
    method puedeSerAtendidoPor(vendedor) = vendedor.esVersatil() and vendedor.esFirme()
}

class ClienteDetallista {
    method puedeSerAtendidoPor(vendedor) = vendedor.masDe3Certificaciones()
}

class ClienteHumanista {
    method puedeSerAtendidoPor(vendedor) = vendedor.esHumano()
}