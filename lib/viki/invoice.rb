class Viki::Invoice < Viki::Core::Base
  cacheable
  path '/invoices'
  path '/users/:user_id/invoices'
end
