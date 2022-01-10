namespace :fix do
    desc 'Fix status comercios plan'
    task status_comercioplan: :environment do
        comercioplanes = Comercioplan.activos.joins(:comercio).where('hasta <= ?', Date.today).where(comercios:{activo: true})
        comercioplanes.each do |cp|
          if cp.comercio.no_plan_vigente?
            nuevo_cp = Comercioplan.new(servicio_anterior_id: cp.tipo_servicio_id, tipo_servicio_id: TipoServicio::GRATUITO, 
                                        meses: 1, pagado: true, formapago_id: Formapago::GRATUITO, estado: :aprobado,
                                        usuario: cp.usuario, comercio: cp.comercio)
            if nuevo_cp.save
              cp.update(estado: :vencido)
              cp.comercio.update(estado: :default, tipo_servicio_id: nuevo_cp.tipo_servicio_id)
            else
              puts nuevo_cp.errors.full_messages
            end
          end
        end    
         
    end
end