object tom {
    // var property energia = 40
    // property -> nos genera setter y getter 
    var property energia = 40


    method velocidad() = 5 + (energia/10) 
    
    method energia(UnaEnergia){
        energia = UnaEnergia 
    }

    method atrapa(raton) = self.velocidad() > raton.velocidad()
    
}

object jerry {
    var peso = 5

    method velocidad() = 10 - peso

     method energia(UnPeso){
        peso = UnPeso
    }
  
}

object robotRaton {

    method velocidad() = 8
}

object bulldogVito {
    var energia = 100

    method velocidad() = (9 + energia) * 2
}