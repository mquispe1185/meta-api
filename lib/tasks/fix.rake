namespace :fix do
  desc 'Fix comercios plan'
  task comercioplan: :environment do
	Comercio.all.each do |c|
	  Comercioplan.create(comercio: c, tipo_servicio: c.tipo_servicio, formapago: Formapago.first,
						            estado: :aprobado, desde: Time.now, hasta: 30.days.from_now,
						            importe: 0, usuario: c.usuario, meses: 1, pagado: true)
	end
  end

  desc 'Fix comercios'
  task comercio: :environment do
    Comercio.all.each do |c|
      c.update(tipo_servicio_id: TipoServicio::ESTANDAR)
    end
    Comercioplan.update(tipo_servicio_id: TipoServicio::ESTANDAR)
  end
end
