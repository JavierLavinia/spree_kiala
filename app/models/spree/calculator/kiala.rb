module Spree
  class Calculator::Kiala < Calculator
    preference :dspid,             :string,  :default => 'demo_dsp'
    preference :kiala_service_url, :string,  :default => 'https://locateandselect.kiala.com/search'
    preference :private_area_url,  :string
    preference :tracking_url,      :string
    preference :preparationdelay,  :integer, :default => 1
    preference :lower_boundry,     :decimal, :default => 0.0
    preference :upper_boundry,     :decimal, :default => 50.0
    preference :amount,            :decimal, :default => 5.0

    attr_accessible :preferred_private_area_url, :preferred_tracking_url,
                    :preferred_dspid, :preferred_kiala_service_url, :preferred_preparationdelay,
                    :preferred_lower_boundry, :preferred_upper_boundry, :preferred_amount

    alias_method :amount, :preferred_amount

    def self.description
      I18n.t(:kiala_shipping)
    end

    def service_url(callback)
      "#{preferred_kiala_service_url}?country=ES&language=es&dspid=#{preferred_dspid}&bckUrl=#{callback}&preparationdelay=#{preferred_preparationdelay}&target=_parent"
    end

    def compute(object)
      sum = 0
      item_total = object.line_items.map(&:amount).sum
      if (item_total >= self.preferred_lower_boundry && item_total <= self.preferred_upper_boundry)
        return self.preferred_amount
      else
        return 0.0
      end
    end

  end
end