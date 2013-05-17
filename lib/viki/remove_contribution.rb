module Viki
  class RemoveContribution < Core::Base
    path 'v4/users/:user_id/contributions/delete_all.json'

    def self.remove_user_contributions(user_id, &block)
      self.destroy({user_id: user_id}, &block)
    end
  end
end
