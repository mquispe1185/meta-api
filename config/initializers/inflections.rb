# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

ActiveSupport::Inflector.inflections(:en) do |inflect|
   
    inflect.irregular 'ciudad', 'ciudades'
    inflect.irregular 'provincia', 'provincias'
    inflect.irregular 'departamento', 'departamentos'
    inflect.irregular 'localidad', 'localidades'
    inflect.irregular 'rol', 'roles'
    inflect.irregular 'contacto', 'contactos'
    inflect.irregular 'comercio', 'comercios'
    inflect.irregular 'referencia', 'referencias'
    inflect.irregular 'rubro', 'rubros'
    inflect.irregular 'horario', 'horarios'
    inflect.irregular 'promocion', 'promociones'
    inflect.irregular 'formapago', 'formapagos'
    inflect.irregular 'comercioplan', 'comercioplanes'
    inflect.irregular 'tipo_servicio', 'tipo_servicios'
end
