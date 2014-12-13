class AllegroApiService

	def exec
    allegro_client = Savon.client(wsdl: 'https://webapi.allegro.pl/service.php?wsdl')
    binding.pry
    allegro_client.call(:do_query_sys_status, message: { sysvar: 3, countryId: 1, webapiKey:  ENV['ALLEGRO_KEY']})
  end

end
