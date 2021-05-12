class Chef
  def initialize(id)
    @id = id
  end

  def make_sandwich(pantry)
    puts "#{@id}: wants pb"
    pantry.with_pb do |pb|
      puts "#{@id}: has pb"
      sleep(0.0001)
      puts "#{@id}: wants jelly"
      pantry.with_jelly do |jelly|
        puts "#{@id}: has jelly"
        sleep(0.0001)
      end
      puts "#{@id}: returned jelly"
    end
    puts "#{@id}: returned pb"
  end
end
