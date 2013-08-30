class Viki::Invoice < Viki::Core::Base
  cacheable
  path '/users/:user_id/invoices'
end
