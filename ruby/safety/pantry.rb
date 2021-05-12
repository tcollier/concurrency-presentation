class Pantry
  def initialize
    @pb = Object.new
    @pb_lock = Mutex.new

    @jelly = Object.new
    @jelly_lock = Mutex.new
  end

  def with_pb(&block)
    @pb_lock.synchronize do
      yield @pb
    end
  end

  def with_jelly(&block)
    @jelly_lock.synchronize do
      yield @jelly
    end
  end
end
