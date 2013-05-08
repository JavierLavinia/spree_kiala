Spree::Address.class_eval do
  
  def self.new_from_kiala_point(kpoint, bill_address)
    addr = bill_address.clone
    addr.update_attributes( :address1 => kpoint.kpname,
                            :address2 => kpoint.street,
                            :zipcode  => kpoint.zip,
                            :city     => kpoint.city )
    addr
  end
end
