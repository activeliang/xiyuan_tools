class Analyze < ApplicationRecord
  before_create :check_domain
  belongs_to :number


  private
  def check_domain
    url = self.domain
    unless url.scan(/http:\/\//)
      self.domain = "http://" << url
    end
  end

end
