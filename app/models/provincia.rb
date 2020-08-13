class Provincia < ApplicationRecord
    has_many :departamentos

    def self.carga_prov
        require 'net/http'
        require 'uri'
        prov= Net::HTTP.get URI('https://apis.datos.gob.ar/georef/api/provincias')
        #res= Net::HTTP.get URI('https://apis.datos.gob.ar/georef/api/localidades?provincia=jujuy&max=200')
        #res= Net::HTTP.get URI('https://apis.datos.gob.ar/georef/api/departamentos?provincia=jujuy&max=16')
        result = JSON.parse(prov)
        result["provincias"].each do |p|
            Provincia.create(nombre: p['nombre'])
        end
          
    end

    def self.carga_dto
        require 'net/http'
        require 'uri'
        dto= Net::HTTP.get URI('https://apis.datos.gob.ar/georef/api/departamentos?provincia=salta&campos=id,nombre&max=100')
       
        result = JSON.parse(dto)
        result["departamentos"].each do |d|
            iddto = d['id']
            nuevodto = Departamento.new(nombre: d['nombre'], provincia_id: 18)
            if nuevodto.save
                loc= Net::HTTP.get URI('https://apis.datos.gob.ar/georef/api/localidades?departamento='+iddto+'&campos=nombre&max=100')
                
                resultl = JSON.parse(loc)
                resultl["localidades"].each do |l|
                Localidad.create(nombre: l['nombre'], departamento_id: nuevodto.id, provincia_id: 18)
                end
            end
         
        end
          
    end
end
