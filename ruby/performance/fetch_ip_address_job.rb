class FetchIpAddressJob
  attr_reader :id

  def initialize(id)
    @id = id
  end

  def perform
    sleep(rand(0.05..0.1))
    '127.0.0.1'
  end
end
