class FactorizeJob
  attr_reader :id

  def initialize(id)
    @id = id
  end

  def perform
    factorize(34810745584024514125737)
  end

  private

  def factorize(n, factors=[])
    sqrt_n = Math.sqrt(n).floor
    (2..sqrt_n).each do |f|
      return factorize(n / f, factors + [f]) if n % f == 0
    end
    factors + [n]
  end
end
