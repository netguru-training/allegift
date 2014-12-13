class Gift < ActiveRecord::Base

  belongs_to :user
  validates :name, presence: true
  validates :allegro_link, presence: true
  validates :user_id, presence: true


  def fetch_id_from_link
    parts = allegro_link.split('i');
    self.allegro_id = parts.last.split('.').first;
  end


  def exec 
    allegro_client = Savon.client(wsdl: 'https://webapi.allegro.pl/service.php?wsdl')
      binding.pry
     localVersion = allegro_client.call(
       :do_query_sys_status, 
       message: {
         sysvar: 3,
         countryId: 1,
         webapiKey: 'aa501091',
       }
     )

end
end
