class Hit < ActiveRecord::Base
  attr_accessible :agent, :code, :ip, :referrer
end
